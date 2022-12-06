:- use_module(util, [read_input_as_lines/2, split_list_by/3, partition/3, drop_last/2, transform/2, remove/3, replace1/4]).

read_input(Input) :-
    read_input_as_lines("resources/day6.txt", [String|_]),
    string_chars(String, Input).

% checks if all elements in X are different
different(X) :-
    sort(X, Sorted),
    length(X, OriginalLength),
    length(Sorted, SortedLength),
    OriginalLength == SortedLength.

% Argument #0: Headlist
% Argument #1: Tail
% Argument #2: size to be checked
% Argument #3: Current Index
% Argument #4: Result
% If all element in Headlist are different, condition is met and the current index is returned
% If not, first element in Headlist is dropped and next element from Tail is appended.


% Base case to set up the predicate first_N_different/5
first_N_different([H|T], N, Result) :-
    first_N_different([H], T, N, 1, Result).

% Headlist to small, append next element and go on
first_N_different(HeadList, [T|Tail], N, Index, Result) :-
    length(HeadList, M),
    M < N, !,
    append(HeadList, [T], X),
    J is Index + 1,
    first_N_different(X, Tail, N, J, Result).
% all different in Headlist, return Index
first_N_different(HeadList, _, _, Index, Index) :-
    different(HeadList), !.
% not all different, drop Head, append next element, and go on.
first_N_different([_|Headlist], [T|Tail], N, Index, Result) :-
    append(Headlist, [T], X),
    J is Index + 1,
    first_N_different(X, Tail, N, J, Result).

solve_part_1(Result) :-
    read_input(S),
    first_N_different(S, 4, Result).

solve_part_2(Result) :-
    read_input(S),
    first_N_different(S, 14, Result).
