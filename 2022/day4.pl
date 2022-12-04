 :- use_module(util, [read_input_as_lines/2]).

string_ranges_to_number_ranges(String,C1-C2/D1-D2) :-
    split_string(String,",","",[A,B]),
    split_string(A,"-","",[A1,A2]),
    split_string(B,"-","",[B1,B2]),
    number_string(C1,A1),
    number_string(C2,A2),
    number_string(D1,B1),
    number_string(D2,B2).

read_input(Strings) :-
    read_input_as_lines("resources/day4.txt", Lines),
    maplist(string_ranges_to_number_ranges,Lines,Strings).

fully_contained(A1-A2/B1-B2,1) :-
    between(A1,A2,B1),
    between(A1,A2,B2),!.
fully_contained(A1-A2/B1-B2,1) :-
    between(B1,B2,A1),
    between(B1,B2,A2),!.
fully_contained(_,0) :- !.

solve_part_1(X) :-
    read_input(Strings),
    maplist(fully_contained,Strings,Y),
    sumlist(Y,X).

overlap(A1-A2/B1-_,1) :-
    between(A1,A2,B1), !.
overlap(A1-A2/_-B2,1) :-
    between(A1,A2,B2), !.
overlap(A1-_/B1-B2,1) :-
    between(B1,B2,A1), !.
overlap(_-A2/B1-B2,1) :-
    between(B1,B2,A2), !.
overlap(_, 0) :- !.

solve_part_2(X) :-
    read_input(Strings),
    maplist(overlap,Strings,Y),
    sumlist(Y,X).
