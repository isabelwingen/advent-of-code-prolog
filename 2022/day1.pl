:- use_module(util, [read_input_as_lines/2, split_list_by/3]).

to_number("",nan) :- !.
to_number(S,N) :- number_string(N,S), !.

read_input(Y) :-
    read_input_as_lines("resources/day1.txt", X),
    maplist(to_number,X,Z),
    split_list_by(Z,nan,Y).

solve_part_1(Res) :-
    read_input(X),
    maplist(sumlist,X,Sums),
    max_list(Sums,Res).

solve_part_2(Res) :-
    read_input(X),
    maplist(sumlist,X,Sums),
    sort(Sums,SortedAsc),
    reverse(SortedAsc,[A,B,C|_]),
    Res is A+B+C.
