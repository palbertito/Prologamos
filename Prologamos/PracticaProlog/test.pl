%TEST PROLOG

% basic_building()

basic_building([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ]).
      yes
basic_building([[0]]).
      yes
basic_building([[0], [0], [s(0), s(0)]]).
      yes
basic_building([[],[]]).
      no
basic_building([]).
      no
basic_building([ [ s(0), s(s(s(0))), a ], [ 0, s(s(0)) ] ]).
      no
basic_building([ [ s(0), s(s(s(0))), [ 0, s(0) ] ], [ 0, s(s(0)) ] ]).
      no

% building()

building([]).
      no
building([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ]).
      yes
building([[]]).
      no
building([ [ s(0), s(s(s(0))), 0 ], [ 0, s(s(0)) ] ]).
      no
building([[],[]]).
      no
building([[0], [0], [s(0), s(0)]]).
      no
building([ [ s(0), s(s(s(0))), 0 ], [ 0, s(s(0)), 0 ] ]).
      yes
building([ [ s(0) ], [ s(s(0)) ] ]).
      yes
building([ [ s(0) ], [] ]).
      no
building([ [ a ], [ a ] ]).
      no

% level()

level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0), [ s(0), s(s(s(0))) ]).
      yes
level([[0, 0], [0, 0], [s(0), s(0)]], s(s(s(0))), [s(0), s(0)]).
      yes
level([[0]], s(0), [0]).
      yes
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0), [ 0, s(s(0)) ]).
      no
level([[],[]], s(0), []).
      no
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], 0, [ s(0), s(s(s(0))) ]).
      no
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], [], [ s(0), s(s(s(0))) ]).
      no
level([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0), a).
      no

% column()

column([],s(0),[]).
      no
column([[0]],0,[0]).
      no
column([[s(0)]],s(0),[s(0)]).
      yes
column([[s(0),s(s(s(0)))],[0,s(s(0))],[0,0]],s(0),[s(0), 0, 0]).
      yes
column([[s(0),s(s(s(0)))],[0,s(s(0))],[0,0]],s(s(0)),[s(s(s(0))), s(s(0)), 0]).
      yes
column([[s(0),s(s(s(0)))],[s(s(0))],[0]],s(s(0)),[s(s(s(0))), s(s(0)), 0]).
      no
column([[s(0),s(s(s(0)))],[s(s(0))],[0,0]],s(0),[s(0), 0, 0]).
      no
column([[s(0),s(s(s(0)))],[s(s(0))],[0,0]],0,[s(0), 0, 0]).
      no
column([[a]],s(0),[a]).
      no

% columns()

columns([[s(0),s(s(s(0)))],[0,s(s(0))],[0,0]],[[s(0), 0, 0], [s(s(s(0))), s(s(0)), 0]]).
      yes
columns([],[]).
      no
columns([[s(0),s(s(s(0)))],[0,s(s(0))],[0]],[[s(0), 0, 0], [s(s(s(0))), s(s(0))]]).
      no
columns([[0]],[0])
      yes
columns([[s(0),s(s(s(0))),s(0)],[0,s(s(0)),0]],[[s(0), 0], [s(s(s(0))), s(s(0))], [s(0), 0]]).
      yes
columns([[],[0]],[0]).
      no
columns([[a,s(0)],[s(0),0]],[[a,s(0)],[s(0),0]]).
      no
% total_people()

total_people([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(s(s(s(s(s(0))))))).
      yes 
total_people([[0, 0], [0, 0], [s(0), s(0)]], s(s(0))). 
      yes 
total_people([[0]], 0) 
      yes 
total_people([[],[]], 0).
      no
total_people([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(s(s(s(0)))) )
      no
total_people([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], a).
      no

% average()

average([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(0)).
      yes 
average([[0, 0], [0, 0], [s(0), s(0)]], 0).
      yes 
average([[0]], 0).
      yes
average([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ], [s(s(s(0))), s(s(s(0)))] ], s(s(0))).
      yes
average([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], s(s(0))).
      no
average([[],[]], 0).
      no
average([ [ s(0), s(s(s(0))) ], [ 0, s(s(0)) ] ], a).
      no

