block(a).
block(b).
block(c).
place(1).
place(2).
place(3).
place(4).

object(X):-place(X);block(X).


%Clauses for Progression Planner

act(move(Block,From,To), [clear(Block),clear(To),on(Block,From)], [on(X,From),clear(To)], [on(X,To),clear(From)]):-
block(Block),object(To),To\==Block,object(From),From\==To,Block\==From.


%Clauses for Regression Planner

can(move(Block,From,To),[clear(Block),clear(To),on(Block,From)]):-
block(Block),object(To),To\==Block,object(From),From\==To,Block\==From.

adds(move(X,From,To),[on(X,To),clear(From)]).
deletes(move(X,From,To),[on(X,From),clear(To)]).