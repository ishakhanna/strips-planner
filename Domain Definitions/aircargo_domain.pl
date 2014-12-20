plane(p1).
plane(p2).
cargo(c1).
cargo(c2).
airport(jfk).
airport(sfo).
airport(atl).

object(X):-plane(X);cargo(X).


%Clauses for Progression Planner

act(load(Cargo,Plane,Airport),[at(Cargo, Airport),at(Plane, Airport)], [at(Cargo, Airport)],[in(Cargo,Plane)]):- cargo(Cargo),plane(Plane),airport(Airport).

act(fly(Plane,From,To),[at(Plane, From)],[at(Plane, From)], [at(Plane, To)]):- plane(Plane),airport(From),airport(To), To\==From.

act(unload(Cargo,Plane,Airport),[in(Cargo, Plane),at(Plane, Airport)],[in(Cargo,Plane)], [at(Cargo, Airport)]):- cargo(Cargo),plane(Plane),airport(Airport).



%Clauses for Regression Planner

adds(load(Cargo,Plane,_),[in(Cargo,Plane)]).
adds(unload(Cargo,_,Airport),[at(Cargo,Airport)]).
adds(fly(Plane,_,To),[at(Plane,To)]).

deletes(load(Cargo,_,Airport),[at(Cargo,Airport)]).
deletes(unload(Cargo,Plane,_),[in(Cargo,Plane)]).
deletes(fly(Plane,From,_),[at(Plane, From)]).

can(load(Cargo,Plane,Airport),[at(Cargo, Airport),at(Plane, Airport)]):- cargo(Cargo), plane(Plane), airport(Airport).
can(unload(Cargo,Plane,Airport),[in(Cargo, Plane),at(Plane, Airport)]):- cargo(Cargo), plane(Plane), airport(Airport).
can(fly(Plane,From,To),[at(Plane, From)]):- plane(Plane), airport(From), airport(To), To\==From.
