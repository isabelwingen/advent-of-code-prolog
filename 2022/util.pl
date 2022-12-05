:- module(util, [read_input_as_lines/2, split_list_by/3, partition/3, drop_last/2, transform/2, remove/3, replace1/4]).

drop_last([_], []) :- !.
drop_last([H|T], [H|S]) :-
    drop_last(T, S).

read_input_as_lines(Path, Strings) :-
    read_file_to_string(Path, S, []),
    split_string(S, "\n", "", L),
    drop_last(L, Strings).

split_list_by(L,SplitItem,[L]) :-
    \+ member(SplitItem, L), !.
split_list_by(ListToBeSplitted, SplitItem, [A|T]) :-
    append(A, [SplitItem|B], ListToBeSplitted),
    \+ member(SplitItem, A),
    split_list_by(B, SplitItem, T).

partition(L,Size,Result) :-
    partition(L, Size, [], Result).

partition(L, Size, [], [L]) :-
    length(L, N),
    N < Size, !.
partition(L, Size, Store, [StoreReversed|T]) :-
    length(Store, Size), !,
    reverse(Store, StoreReversed),
    partition(L, Size, [], T).
partition([H|T], Size, Store, Result) :-
    partition(T, Size, [H|Store], Result).

first([H|_], H).
rest([_|T], T).

transform(L,[]) :-
    first(L,[]), !.
transform(L,[Q|Result]) :-
    maplist(first, L, Q),
    maplist(rest, L, P),
    transform(P,Result).

remove([], _, []) :- !.
remove([Elem|L], Elem, K) :-
    !, remove(L, Elem, K).
remove([H|L], Elem, [H|K]) :-
    remove(L, Elem, K).

replace0([_|L], 0, Elem, [Elem|L]) :- !.
replace0([H|List], Index, Elem, [H|NewList]) :-
    IndexMinus1 is Index-1,
    replace0(List, IndexMinus1, Elem, NewList).
replace1([_|L], 1, Elem, [Elem|L]) :- !.
replace1([H|List], Index, Elem, [H|NewList]) :-
    IndexMinus1 is Index-1,
    replace1(List, IndexMinus1, Elem, NewList).
