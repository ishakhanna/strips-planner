%Top level Predicate for regression planner. Times out after 100 s.
plan_reg(State, Goals,Plan) :- catch(call_with_time_limit(100,plan(State, Goals, Plan)),_, write('Regression Planner Timed Out')).

% Base Case when all the goals are satisfied in the current state.
plan(State, Goals,[]) :- satisfied(State, Goals).


%Recursive plan: Selects and action and a goal from the Goals that is to be satisfied. Checks if the action can be applied with the current state. Apply the action and recurse on plane to achieve NewGoals which are the original goals plus the preconditions for the action applied.

plan(State, Goals, Plan) :- conc(PrePlan, [Action], Plan), select(State, Goals, Goal), achieves(Action, Goal),
can(Action, _Condition), preserves(Action, Goals), apply(Goals, Action, NewGoals),plan(State, NewGoals, PrePlan).


satisfied(State, Goals) :- delete_all(Goals, State, []).


select(_, Goals, Goal) :- member(Goal, Goals).


achieves(Action,Goal) :- adds(Action, Goals), member(Goal,Goals).

%Check if the action does not delete any goal that is to be preserved in order to reach the final state. Without this function, the planner will end up in infinite recursion since one action will achieve the goal and some other will delete it as its delete list.
preserves(Action, Goals) :- deletes(Action, Relations), not((member(Goal, Relations), member(Goal,Goals))).


%Applies the Action and comes up with NewGoals which are the preconditions for the action.
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
