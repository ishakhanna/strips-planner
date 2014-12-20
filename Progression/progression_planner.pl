%Top level Predicate for forward progression planner. Times out after 100 s.
plan_fp(State, Goals,Plan) :- catch(call_with_time_limit(100,solve(State, Goals, [], Plan)),_, write('Progression Planner Timed Out')).

%Base case that checks if the Goals are already satisfied in the current state.
solve(State, Goals, Sofar, Plan):- subset(Goals, State),!, reverse(Sofar, Plan).


%Recursive Planner: Selects the action with act predicate, checks if the preconditions are satisfied in the current state and the action has not been used so far. Another check confirms if the goals are preserved after applying this action checking the delete list. Apply the delete and add list and recurse over solve with new state until we reach the final state.

solve(State, Goal, Sofar, Plan):-
act(Action, Precons, Delete, Add),
subset(Precons, State),
\+ member(Action, Sofar),
\+((member(G, Delete), member(G, Goal))),
delete_list(Delete, State, Remainder),
add_list(Add, Remainder, NewState),
solve(NewState, Goal, [Action|Sofar], Plan).


delete_list([H|T], Curstate, Newstate):-
remove(H, Curstate, Remainder),
delete_list(T, Remainder, Newstate).

delete_list([], Curstate, Curstate).

remove(X, [X|T], T).
remove(X, [H|T], [H|R]):- remove(X, T, R).

add_list([H|T], L1, [H|L2]):- add_list(T, L1, L2).

add_list([], L, L).

del(X,[X|Tail],Tail).

del(X,[Y|Tail],[Y|Tail1]):- del(X,Tail,Tail1).