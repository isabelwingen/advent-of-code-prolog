:- use_module(util, [read_input_as_lines/2]).

read_input(Rucksacks) :-
    read_input_as_lines("resources/day3.txt", Strings),
    maplist(string_chars,Strings,Rucksacks).

find_element_in_boths(Rucksack, InBoth) :-
    append(A, B, Rucksack),
    length(A, N),
    length(B, N),
    member(InBoth, A),
    member(InBoth, B), !.

priority(Char, Prio) :-
    char_code(Char, Code),
    Code < 91, !,
    Prio is Code - 38.

priority(Char, Prio) :-
    char_code(Char, Code),
    Prio is Code - 96.

solve_part_1(Result) :-
    read_input(Rucksacks),
    maplist(find_element_in_boths,Rucksacks,InBoth),
    maplist(priority,InBoth,Prios),
    sumlist(Prios,Result).

split_in_groups_of_three([], []).
split_in_groups_of_three([A,B,C|T], [[A,B,C]|S]) :-
    split_in_groups_of_three(T,S).

find_priority_of_badge([A,B,C],BadgePrio) :-
    member(Badge,A),
    member(Badge,B),
    member(Badge,C),
    priority(Badge,BadgePrio), !.

solve_part_2(Result) :-
    read_input(Rucksacks),
    split_in_groups_of_three(Rucksacks, Groups),
    maplist(find_priority_of_badge,Groups,BadgePrios),
    sumlist(BadgePrios,Result).
