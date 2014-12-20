% plan_min(InitialState,GoalState,Plan)
plan_min([at(p1,jfk),at(p2,jfk),at(c1,jfk)],[at(c1,sfo)],Plan)

% Scenario1: both p1 and p2 have enough fuel capacity but only p2 is chosen as it has minimum fuel consumption rate
% Query:plan_min([at(p1,jfk),at(p2,jfk),at(c1,jfk)],[at(c1,sfo)],Plan)
plane(p1,10,400).
plane(p2,5,400).
fact(10).
fact(5).

% Scenario2: p1 does not have enough fuel so p2 is chosen by the planner
% Query:plan_min([at(p1,jfk),at(p2,sfo),at(c1,jfk)],[at(c1,a3)],Plan)
plane(p1,10,90).
plane(p2,5,400).
fact(10).
fact(5).

% Scenario3: plane can carry cargo to 1st airport but not enough fuel to travel to 2nd airport
% Query:plan_min([at(p1,jfk),at(c1,jfk),at(c2,jfk)],[at(c1,sfo),at(c2,a3)],Plan)
plane(p1,10,100).
fact(10).

% Scenario4: 1 plane that has capacity to carry both cargoes to their respective destinations
% Query:plan_min([at(p1,jfk),at(c1,jfk),at(c2,jfk)],[at(c1,sfo),at(c2,a3)],Plan)
plane(p1,10,400).
fact(10).

% Scenario5: p1 has enough fuel to transfer c2 from sfo to jfk and p2 has enough to transfer c1 from jfk to sfo
% Query:plan_min([at(p1,sfo),at(p2,jfk),at(c1,jfk),at(c2,sfo)],[at(c1,a3),at(c2,jfk)],Plan)
plane(p1,10,400).
plane(p2,5,400).
fact(10).
fact(5).
