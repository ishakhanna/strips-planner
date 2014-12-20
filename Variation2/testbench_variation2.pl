plan_prob3([at(p1,jfk),at(c1,jfk),at(p2,jfk),at(c2,jfk)], [at(c1,sfo),at(c2,sfo)],Plan)
plan_prob3([at(p1,jfk),at(p2,jfk),at(c1,jfk),at(c2,jfk)], [at(c1,sfo),at(c2,sfo)],Plan)

%Query: plan_prob3([at(p1,jfk),at(p2,jfk),at(c1,jfk),at(c2,jfk)], [at(c1,sfo),at(c2,sfo)],Plan).
plane(p1, 30).
plane(p2, 20).
cargo(c1, 10).
cargo(c2, 20).

%Query: plan_prob3([at(p1,jfk),at(p2,jfk),at(c1,jfk),at(c2,jfk)], [at(c1,sfo),at(c2,sfo)],Plan).
plane(p1, 20).
plane(p2, 20).
cargo(c1, 10).
cargo(c2, 20).

%Query: plan_prob3([at(p1,jfk),at(p2,jfk),at(c1,jfk),at(c2,jfk)], [at(c2,sfo),at(c1,sfo)],Plan).
plane(p1, 20).
plane(p2, 10).
cargo(c2, 20).
cargo(c1, 10).

%Query plan_prob3([at(p1,jfk),at(p2,jfk),at(c1,jfk),at(c2,jfk),at(c3,jfk)], [at(c2,sfo),at(c1,sfo),at(c3,sfo)],Plan)
plane(p1, 20).
plane(p2, 10).
cargo(c1, 10).
cargo(c2, 10).
cargo(c3, 10).

%Query plan_prob3([at(p1,jfk),at(p2,jfk),at(c1,jfk),at(c2,jfk)], [at(c2,sfo),at(c1,sfo)],Plan)
plane(p1, 20).
plane(p2, 10).
cargo(c1, 20).
cargo(c2, 10).

%Query:
% plan_prob3([at(p1, jfk),at(p2, jfk),at(p3, jfk),at(c1, jfk), at(c2, jfk), at(c3, jfk)], [at(c1, sfo), at(c2,sfo), at(c3,atl)],Plan).
% plan_prob3([at(p1, jfk),at(p2, jfk),at(p3, jfk),at(c1, jfk), at(c2, jfk), at(c3, jfk)], [at(c1, sfo), at(c2,sfo), at(c3,sfo)],Plan)

plane(p1, 20).
plane(p2, 10).
plane(p3, 10).
cargo(c1, 10).
cargo(c2, 10).
cargo(c3, 10).

%Query:
% plan_prob3([at(p1, jfk),at(p2, jfk),at(p3, jfk),at(c1, jfk), at(c2, jfk), at(c3, jfk)], [at(c1, sfo), at(c2,sfo), at(c3,atl)],Plan).
% plan_prob3([at(p1, jfk),at(p2, jfk),at(p3, jfk),at(c1, jfk), at(c2, jfk), at(c3, jfk)], [at(c1, sfo), at(c2,sfo), at(c3,sfo)],Plan)
plane(p1, 30).
plane(p2, 20).
plane(p3, 10).
cargo(c1, 10).
cargo(c2, 10).
cargo(c3, 10).