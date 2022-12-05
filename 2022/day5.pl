:- use_module(util, [read_input_as_lines/2, split_list_by/3, partition/3, drop_last/2, transform/2, remove/3, replace1/4]).

% Parse upper part of file
get_second_elem(List, Elem) :-
    nth0(1, List, Elem).

single_stack_line(StackLine, Result) :-
    string_chars(StackLine, P),
    partition(P, 4, Q),
    maplist(get_second_elem, Q, Result).

get_number_of_stacks(NumberLine, NumberOfStacks) :-
    split_string(NumberLine, " ", "", X),
    reverse(X, [_, A|_]),
    number_string(NumberOfStacks, A).

remove_empty_slots(L, K) :-
    remove(L, ' ', K).

read_stacks(Strings, Stacks) :-
    drop_last(Strings, P),
    maplist(single_stack_line, P, Q),
    transform(Q, R),
    maplist(remove_empty_slots, R, Stacks).

% Parse second part of file

command(CommandString, AA/BB-CC) :-
    split_string(CommandString, " ", "", [_, A, _, B, _, C]),
    number_string(AA, A),
    number_string(BB, B),
    number_string(CC, C).

read_commands(CommandStrings, Commands) :-
    maplist(command, CommandStrings, Commands).

% Connect the two parts and read input
read_input(P, Commands) :-
    read_input_as_lines("resources/day5.txt", X),
    split_list_by(X, "", [Upper, Lower]),
    read_stacks(Upper, P),
    read_commands(Lower, Commands).

first([H|_], H).

reverse_or_not_reverse(A, A, 2).
reverse_or_not_reverse(A, ReversedA, 1) :-
    reverse(A,ReversedA).

solve(Stacks, [], Result, _) :- !,
    maplist(first, Stacks, R),
    string_chars(Result, R).
solve(Stacks, [Count/From-To|Commands], Result, Part) :-
    nth1(From, Stacks, StackFrom),
    nth1(To, Stacks, StackTo),
    append(A, NewFrom, StackFrom),
    length(A, Count),
    reverse_or_not_reverse(A, ReversedA, Part),
    append(ReversedA, StackTo, NewTo),
    replace1(Stacks, From, NewFrom, S1),
    replace1(S1, To, NewTo, S2),
    solve(S2, Commands, Result, Part).

solve_part_1(Result) :-
    read_input(Stacks, Commands),
    solve(Stacks, Commands, Result, 1).

solve_part_2(Result) :-
    read_input(Stacks, Commands),
    solve(Stacks, Commands, Result, 2).
