:- module(util, [read_input_as_lines/2, split_list_by/3]).

drop_last([_], []).
drop_last([H|T], [H|S]) :-
    drop_last(T,S).

read_input_as_lines(Path, Strings) :-
    read_file_to_string(Path,S,[]),
    split_string(S,"\n","",L),
    drop_last(L,Strings).

split_list_by(L,SplitItem,[L]) :-
    \+ member(SplitItem,L), !.
split_list_by(ListToBeSplitted,SplitItem,[A|T]) :-
    append(A,[SplitItem|B],ListToBeSplitted),
    \+ member(SplitItem,A),
    split_list_by(B,SplitItem,T).
