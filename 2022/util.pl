:- module(util, [read_input_as_lines/2]).

drop_last([_], []).
drop_last([H|T], [H|S]) :-
    drop_last(T,S).

read_input_as_lines(Path, Strings) :-
    read_file_to_string(Path,S,[]),
    split_string(S,"\n","",L),
    drop_last(L,Strings).
