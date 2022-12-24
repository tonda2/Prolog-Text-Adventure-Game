:- use_module(library(lists)).

equal(X,X).
	
allSameLength([Row1, Row2]) :- 
	length(Row1, First),
	length(Row2, Second),
	equal(First, Second).
	
allSameLength([Row1, Row2|Rest]) :-
	length(Row1, First),
	length(Row2, Second),
	equal(First, Second),
	allSameLength([Row2|Rest]).

properSize(Sudoku, Goal) :- 
	length(Sudoku, Goal),
	nth0(0, Sudoku, FirstRow),
	length(FirstRow, Goal),
	allSameLength(Sudoku).

inInterval(List) :-
	member(X, List),
	between(1,1,X).

solve(Sudoku, Size):-
	properSize(Sudoku, Size),
	member(Row, Sudoku),
	inInterval(Row).
