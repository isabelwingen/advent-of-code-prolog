:- use_module(util, [read_input_as_lines/2]).

% Facts
result([rock,rock],draw).
result([paper,paper],draw).
result([scissors,scissors],draw).
result([rock,scissors],lost).
result([scissors,paper],lost).
result([paper,rock],lost).
result([rock,paper],won).
result([paper,scissors],won).
result([scissors,rock],won).

points(rock,1).
points(paper,2).
points(scissors,3).
points(won,6).
points(draw,3).
points(lost,0).

matching1("A",rock).
matching1("B",paper).
matching1("C",scissors).
matching1("X",rock).
matching1("Y",paper).
matching1("Z",scissors).

matching2("X",lost).
matching2("Y",draw).
matching2("Z",won).

% Read Input
split_pair(X,Y) :- split_string(X," ","",Y).

read_input(P) :-
    read_input_as_lines("resources/day2.txt", Lines),
    maplist(split_pair,Lines,P).

% Part 1
roundInPart1([ABC,XYZ],Score) :-
    matching1(ABC,Opponent),
    matching1(XYZ,Me),
    result([Opponent,Me],Result),
    points(Result,P2),
    points(Me, P1),
    Score is P1 + P2.

solve_part_1(S) :-
    read_input(Input),
    maplist(roundInPart1,Input,Scores),
    sumlist(Scores,S).

% Part 2
roundInPart2([ABC,XYZ],Score) :-
    matching1(ABC,Opponent),
    matching2(XYZ,Result),
    result([Opponent,MyDraw],Result),
    points(Result,P2),
    points(MyDraw, P1),
    Score is P1 + P2.

solve_part_2(S) :-
    read_input(Input),
    maplist(roundInPart2,Input,Scores),
    sumlist(Scores,S).
