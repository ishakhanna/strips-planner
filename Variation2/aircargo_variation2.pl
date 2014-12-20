:- dynamic loaded_with/2, total_load/2, unloaded_with/2.

% Facts: plane, cargo and airport
plane(p1, 30).
plane(p2, 10).
plane(p3, 10).
cargo(c1, 10).
cargo(c2, 10).
cargo(c3, 10).
airport(jfk).
airport(sfo).
airport(atl).

%Default Dynamic predicates.
loaded_with(p1,[]).
loaded_with(p2,[]).
loaded_with(p3,[]).
total_load(p1, 0).
total_load(p2, 0).
total_load(p3, 0).

%Not needed for this heuristic. But needed for generic planner. So added to maintain uniformity.
object(X):-plane(X,_);cargo(X,_).

% Retract and Assert new dynamic predicates depending on the weights being loaded to a particular plane
apply_heuristic(Action) :-(Action=load(A,Plane,_)
-> (
(loaded_with(Plane,Cs), \+member(A,Cs))
->(total_load(Plane,W1),cargo(A,CargoWeight),Wnew is W1+CargoWeight,retract(total_load(Plane, _)),assert(total_load(Plane,Wnew)),conc([A],Cs,Cnew),retract(loaded_with(Plane,_)),assert(loaded_with(Plane, Cnew))
)
;
\+fail
)
;\+fail).

%Add List for each action
adds(load(Cargo,Plane,_),[in(Cargo,Plane)]).
adds(unload(Cargo,_Plane,Airport),[at(Cargo,Airport)]).
adds(fly(Plane,_,To),[at(Plane,To)]).

%Delete List for each action
deletes(load(Cargo,_Plane,Airport),[at(Cargo,Airport)]).
deletes(unload(Cargo,Plane,_),[in(Cargo,Plane)]).
deletes(fly(Plane,From,_),[at(Plane, From)]).

%Gives preconditions that should be satisfied for an action
can(load(Cargo,Plane,Airport),[at(Cargo, Airport),at(Plane, Airport)]):- cargo(Cargo,CargoWeight),plane(Plane,_),airport(Airport),\+((loaded_with(P, Css),P\=Plane,member(Cargo, Css))), ((loaded_with(Plane, Cs), member(Cargo, Cs));has_capacity(Plane, CargoWeight)).

can(unload(Cargo,Plane,Airport),[at(Plane, Airport), in(Cargo, Plane)]):- cargo(Cargo,_CargoWeight), plane(Plane,_), airport(Airport).%,\+((unloaded_with(P, Css),P\=Plane,member(Cargo, Css))),((unloaded_with(Plane, Cs), member(Cargo, Cs));has_capacity(Plane, CargoWeight)).
can(fly(Plane,From,To),[at(Plane, From)]):- plane(Plane,_), airport(From), airport(To), To\==From.

%Predicate to check what is the capacity left in all planes
left_capacity(A) :- findall(X, plane(_,X),CapacityList), findall(Y, total_load(_,Y),UsedCapacityList), list_sum(CapacityList, TotalCap),list_sum(UsedCapacityList, UsedCap), A is (TotalCap - UsedCap).

%Predicate to check what weight is left to be loaded
left_weight(W) :- findall(X, loaded_with(_,X), L), my_flatten(L, LoadedCargos),findall(Y, cargo(Y,_),AllCargos), subtract(AllCargos, LoadedCargos, UnloadedCargos), get_left_weight(UnloadedCargos, W).

if_possible:-left_capacity(LeftCap),left_weight(LeftWt),(LeftCap >= LeftWt).

%Checks if the plane has capacity for the given cargo weight
has_capacity(Plane, CargoWeight) :- plane(Plane, TotalCapacity), total_load(Plane, UsedCapacity), ((TotalCapacity - UsedCapacity) >= CargoWeight).


%General functions for applying the heuristic
list_sum([Item], Item).
list_sum([Item1|Tail], Total) :-
list_sum(Tail, Total1), Total is Total1+Item1, !.

get_left_weight([], 0).
get_left_weight([X|Xs], W) :- get_left_weight(Xs, W1), cargo(X,W2), W is (W1+W2).

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],Zs) :- my_flatten(X,Y), my_flatten(Xs,Ys), append(Y,Ys,Zs).