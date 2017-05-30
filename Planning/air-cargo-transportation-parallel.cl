% DOMAIN 1 SIMPLE
% #const lastlev=2.
%
% cargo(c1;c2).
% plane(p1;p2).
% airport(a1;a2).
%
% holds(at(c1,a2),0).
% holds(at(c2,a1),0).
% holds(at(p1,a2),0).
% holds(at(p2,a1),0).
%
% % GOAL
% goal :- holds(at(c1,a1),lastlev+1),
%         holds(at(c2,a2),lastlev+1).
%
% :-not goal.

% DOMAIN 2
#const lastlev=3.

cargo(c1;c2;c3).
plane(p1;p2;p3).
airport(a1;a2;a3).

cargo(c1;c2).
plane(p1;p2).
airport(a1;a2).

holds(at(c1,a2),0).
holds(at(c2,a1),0).
holds(at(p1,a2),0).
holds(at(p2,a1),0).
holds(at(p3,a3),0).
holds(at(c3,a1),0).


% GOAL
goal :- holds(at(c1,a1),lastlev+1),
        holds(at(c2,a2),lastlev+1),
        holds(at(c3,a3),lastlev+1).

:-not goal.

level(0..lastlev).
state(0..lastlev+1).

% ACTIONS
action(load(C,P,A)) :- cargo(C), plane(P), airport(A).
action(unload(C,P,A)):- cargo(C), plane(P), airport(A).
action(fly(P,From,To)) :- plane(P), airport(From), airport(To), From!=To.

1 {occurs(A,S) : action(A)} :- level(S).

% FLUENTS
fluent(at(C,A)) :- cargo(C), airport(A).
fluent(at(P,A)) :- plane(P), airport(A).
fluent(in(C,P)) :- cargo(C), plane(P).

% EFFECTS
holds(in(C,P),S+1) :- occurs(load(C,P,A),S), level(S).
holds(at(C,A),S+1) :- occurs(unload(C,P,A),S), level(S).
holds(at(P,To),S+1) :- occurs(fly(P,From,To),S), level(S).

% PRECONDITIONS
:- occurs(load(C,P,A),S), not holds(at(P,A),S).
:- occurs(load(C,P,A),S), not holds(at(C,A),S).

:- occurs(load(C,_,_),S), holds(in(C,_),S).
:- occurs(load(_,P,_),S), holds(in(_,P),S).

:- occurs(unload(C,P,A2),S), holds(in(C,P),S), holds(at(P,A1),S), A1 != A2.
:- occurs(unload(C,P,_),S), not holds(in(C,P),S).
:- occurs(fly(P,From,To),S), not holds(at(P,From),S).

% parallel
:- occurs(load(C,P1,_),S), occurs(load(C,P2,_),S), P1 != P2.

:- occurs(load(_,P,_),S), occurs(unload(_,P,_),S).
:- occurs(load(_,P,_),S), occurs(fly(P,_,_),S).
:- occurs(unload(_,P,_),S), occurs(fly(P,_,_),S).
:- occurs(fly(P,_,To1),S), occurs(fly(P,_,To2),S), To1 != To2. % useful when there more then two airports

% PERSISTENCE
holds(F,S+1) :- fluent(F), state(S), holds(F,S), not -holds(F,S+1).

% CAUSAL RULES (to derive negatives fluents)
-holds(in(C,P1),S) :- holds(in(C,P2),S), state(S), plane(P1), P1 != P2.
-holds(at(C,A),S) :- holds(in(C,P),S), state(S), airport(A).
-holds(in(C,P),S) :- holds(at(C,A),S), state(S), plane(P).
-holds(at(C,A1),S) :- holds(at(C,A2),S), state(S), airport(A1), A1 != A2.

#show occurs/2.
%#show holds/2.
%#show -holds/2.
