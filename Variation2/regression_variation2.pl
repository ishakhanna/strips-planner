%Top level Planner with timout 100s.
plan_prob3(State, Goals,Plan) :- catch(call_with_time_limit(100,plan(State, Goals, Plan)),_, write('Planner Timed Out')).

plan(State, Goals,[]) :- satisfied(State, Goals).

%Basic Planner with additional apply_heuristic and if_possible predicate that is defined in aircargo_heuristic3.pl
plan(State, Goals, Plan) :- (if_possible->(conc(PrePlan, [Action], Plan), select(State, Goals, Goal), achieves(Action, Goal),can(Action, _Condition), preserves(Action, Goals), apply(Goals, Action, NewGoals),
apply_heuristic(Action), plan(State, NewGoals, PrePlan));!,fail).

satisfied(State, Goals) :- delete_all(Goals, State, []).


select(_, Goals, Goal) :- member(Goal, Goals).


achieves(Action,Goal) :- adds(Action, Goals), member(Goal,Goals).


preserves(Action, Goals) :- deletes(Action, Relations), not((member(Goal, Relations), member(Goal,Goals))).


apply(Goals, Action, NewGoals) :- adds(Action, NewRelations), delete_all(Goals, NewRelations, RestGoals),
can(Action, Condition), addnew(Condition, RestGoals, NewGoals).


addnew([],L,L).

addnew([X|L1],L2,L3) :- member(X,L2),!,addnew(L1,L2,L3).

addnew([X|L1],L2,[X|L3]) :- addnew(L1,L2,L3).


delete_all([],_,[]).

delete_all([X|L1], L2, Diff) :- member(X,L2), !, delete_all(L1,L2,Diff).

delete_all([X|L1], L2, [X|Diff]) :- delete_all(L1,L2,Diff).

conc([],Y,Y).
conc([X|Xs],Y,[X|Zs]):-conc(Xs,Y,Zs).