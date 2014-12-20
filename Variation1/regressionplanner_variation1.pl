% Choosing planes with maximum fuel efficiency
:- dynamic fact/1.
:- dynamic plane/3.

plane(p1,10,400).
fact(10).

plan_min(State, Goals, Plan):-statistics(walltime, [_TimeSinceStart |[_TimeSinceLastCall]]),catch(call_with_time_limit(500,plan_m(State,Goals,Plan)),_,write('Regression Planner Timed Out')),statistics(walltime,[_NewTimeSinceStart | [ExecutionTime]]),nl,write('Regression Plannertook '), write(ExecutionTime), write(' ms.'), nl.

plan_m(State, Goals, Plan):- list_min(L),nb_setval(min_fuel,L),plan(State, Goals, Plan).
plan(State,Goals,[]):-satisfied(State,Goals).
plan(State,Goals,Plan):-
	conc(PrePlan,[Action],Plan),
	select(State,Goals,Goal),
	achieves(Action,Goal),
	can(Action,_),
	preserves(Action,Goals),
	regress(Goals,Action,RegressedGoals),
	plan(State,RegressedGoals,PrePlan),
	(   (Action=fly(Plane,From,To))-> (retract(plane(Plane,A,B)),!,distance(From,To,Dist),Q is A*Dist,R is (B-Q),assert(plane(Plane,A,R)));\+fail).

cargo(c1).
cargo(c2).
airport(jfk).
airport(sfo).
airport(a3).
distance(jfk, sfo, 10).
distance(sfo, jfk, 10).
distance(jfk, a3, 15).
distance(a3, jfk, 15).
distance(sfo, a3, 6).
distance(a3, sfo, 6).

conc([],Y,Y).
conc([X|Xs],Y,[X|Zs]):-conc(Xs,Y,Zs).

satisfied(State,Goals):-delete_all(Goals,State,[]).

select(_,Goals,Goal):-member(Goal,Goals).

achieves(Action,Goal):-adds(Action,Goals),member(Goal,Goals).

preserves(Action,Goals):-deletes(Action,Relations),
	not((member(Goal,Relations),member(Goal,Goals))).

regress(Goals,Action,RegressedGoals):-adds(Action,NewRelations),
	delete_all(Goals,NewRelations,RestGoals),can(Action,Condition),
	addnew(Condition,RestGoals,RegressedGoals).

addnew([],L,L).
addnew([X|L1],L2,L3):-member(X,L2),!,addnew(L1,L2,L3).
addnew([X|L1],L2,[X|L3]):-addnew(L1,L2,L3).

delete_all([],_,[]).
delete_all([X|L1],L2,Diff):-member(X,L2),!,delete_all(L1,L2,Diff).
delete_all([X|L1],L2,[X|Diff]):-delete_all(L1,L2,Diff).

adds(load(Cargo,Plane,_),[in(Cargo,Plane)]).
adds(unload(Cargo,_,Airport),[at(Cargo,Airport)]).
adds(fly(Plane,_,To),[at(Plane,To)]).

deletes(load(Cargo,_,Airport),[at(Cargo,Airport)]).
deletes(unload(Cargo,Plane,_),[in(Cargo,Plane)]).
deletes(fly(Plane,From,_),[at(Plane, From)]).

check(R,M,D):- M1 = (R*D), M1 =<  M.

can(load(Cargo,Plane,Airport),[at(Cargo,Airport),at(Plane,Airport)]):-cargo(Cargo),plane(Plane,X1,X2),airport(Airport),
	distance(Airport,_,D),check(X1,X2,D),nb_getval(min_fuel,X),X=Plane.
can(unload(Cargo,Plane,Airport),[at(Plane, Airport), in(Cargo, Plane)]):- cargo(Cargo), plane(Plane,_,_), airport(Airport).
can(fly(Plane,From,To),[at(Plane, From)]):- plane(Plane,X1,X2),airport(From), airport(To), To\==From,
	distance(From,To,D),check(X1,X2,D),nb_getval(min_fuel,X),X=Plane.

collect(L,W):-retract(fact(X)),!,(collect([X|L],W)).
collect(W,W).
find_list(L):-collect([],L).

find_min([],M,M).
find_min([L|Ls],M0,M):-M1 is min(L,M0),find_min(Ls,M1,M).
find_min([L|Ls],M):-find_min(Ls,L,M).
list_min(Pln):-find_list(L),find_min(L,M),plane(Pln,M,_).






