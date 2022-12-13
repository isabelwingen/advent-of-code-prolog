:- use_module(util, [read_input_as_lines/2, split_list_by/3, partition/3, drop_last/2, transform/2, remove/3, replace1/4]).

parse_line(["$", "cd", "/"], cd(dir(root))) :- !.
parse_line(["$", "cd", ".."], cd(back)) :- !.
parse_line(["$", "cd", A], cd(dir(A))) :- !.
parse_line(["$", "ls"], ls) :- !.
parse_line(["dir", B], dir(B)) :- !.
parse_line([A, B], file(AA, B)) :-
    number_string(AA, A).

split_at_space(S, R) :-
    split_string(S, " ", "", R).

read_input(Result) :-
    read_input_as_lines("resources/day7.txt", R),
    maplist(split_at_space, R, S),
    maplist(parse_line, S, Result).

:- dynamic contains/2.

build_tree([], _) :- !.
build_tree([cd(dir(root))|Commands], _) :-
    build_tree(Commands, dir(root)).
build_tree([cd(dir(A))|Commands], CWD) :-
    assert(contains(CWD, dir(A)/CWD)),
    build_tree(Commands, dir(A)/CWD).
build_tree([cd(back)|Commands], CWD) :-
    contains(Parent, CWD),
    build_tree(Commands, Parent).
build_tree([dir(A)|Commands], CWD) :-
    assert(contains(CWD, dir(A)/CWD)),
    build_tree(Commands, CWD).
build_tree([file(A,B)|Commands], CWD) :-
    assert(contains(CWD, file(A,B)/CWD)),
    build_tree(Commands, CWD).
build_tree([_|Commands], CWD) :-
    build_tree(Commands, CWD).
build_tree(X) :- build_tree(X, _), !.

dirs(Dirs) :-
    findall(D, contains(D, _), Ds),
    sort(Ds, Dirs).

size(file(A,_)/_, A) :- !.
size(dir(root), Size) :- !,
    findall(C, contains(dir(root), C), Cs),
    sort(Cs, Children),
    size(Children, Size).
size(dir(X)/Y, Size) :- !,
    findall(C, contains(dir(X)/Y, C), Cs),
    sort(Cs, Children),
    size(Children, Size).
size(Children, Size) :-
    maplist(size, Children, Sizes),
    sumlist(Sizes, Size).
lower_than_100000(X) :-
    X =< 100000.

solve_part_1(Result) :-
    read_input(X),
    build_tree(X),
    dirs(Dirs),
    maplist(size, Dirs, Sizes),
    include(lower_than_100000, Sizes, Low),
    sumlist(Low, Result).

total_space(70000000).
unused_space_needed(30000000).
currently_empty(L) :-
    size(dir(root), K),
    total_space(X),
    L is X - K.

dir_size_pairs(Dir, Size/Dir) :-
    size(Dir, Size).

to_be_deleted(Z) :-
    unused_space_needed(X),
    currently_empty(Y),
    Z is X-Y.

below(X/_) :-
    to_be_deleted(T),
    X < T.

solve_part_2(Result) :-
    read_input(X),
    build_tree(X),
    dirs(Dirs),
    maplist(dir_size_pairs, Dirs, P),
    sort(P, Q),
    exclude(below, Q, [Result/_|_]).
