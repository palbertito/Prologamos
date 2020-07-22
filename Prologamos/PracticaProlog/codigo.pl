%Nuestros datos
alumno_prode('Benavente','Alvarez','Alejandro',160319). %PORTAVOZ
alumno_prode('Doncel','Aparicio','Alberto',160364).   
alumno_prode('Lin','Tsai','Alvin',160267).
%-------------------------------------------

% practica1.pl

% Números de Peano

% nat/1(num_peano) true si N es un número de peano
nat(0).
nat(s(N)) :-
    nat(N).

%grt_lst(num_peano1, num_peano2, result)
% if A=B  =>  C=0
grt_lst(_, 0 ,0).				% 0 es el número de peano más pequeño
grt_lst(0, _, s(0)).          %  si a > b => c (0)  |  b > a => c (s(0))
grt_lst(s(N), s(M),Z):-				% a > b => (a + 1) > (b + 1)
	grt_lst(N, M,Z).

%sum/3(num_peano1,num_peano2,num_peano3)
%suma A y B y lo pone en C
sum(0, A, A).
sum(s(A), B, s(C)) :-
    sum(A, B, C).

%diff/3(num_peano1,num_peano2,num_peano3) 
% resta A - B y lo pone en C
diff(A, 0, A).		         		% a - 0 = a
diff(A, s(B), C) :- 			   % If a - b = (c + 1) then a - (b + 1) = c
	diff(A, B, s(C)).	

%div/3(num_peano1,num_peano2,num_peano3)
% divide A entre B y lo pone en C
% el resultado es por truncamiento 
div(0, s(_D), 0).				% 0 / a = 0
div(A, B, s(C)) :- 				% If d = a - b and d / b = c then a / b = c + 1
	diff(A, B, D),				% => (a - b)/b = c => a/b - b/b = c 
    cmp(D, B, E),             % If B > D then E => 0 |   If D > B then E => D (truncamiento)
	div(E, B, C).				% => a/b - 1 = c => a/b = c + 1

%cmp/3 (num_peano1,num_peano2,num_peano3)
% cmp compara si A es mayor que B 
% si A > B then C => A, else C => 0
cmp(A,B,C) :-
    grt_lst(A, B, Z),                 %  si a > b => d (0)  |  b > a => d (s(0))
    cmp2(A, Z, C).

%cmp2(num_peano1,num_peano2,num_peano3)
cmp2(_, s(0), 0).           %  If  num_peano2 => s(0) thuen num_peano3 => 0
cmp2(A, 0, A).              %  If  num_peano2 => 0 thuen num_peano3 => num_peano1

%my_append/3(lista1,lista2,lista3)
%implementacion personal de la funcion built-in append de prolog
%true si todos los argumentos son listas
%junta las dos primeras listas y almacena el resultado en L3 (L1|L2)->L3
my_append([], L, L).
my_append([H|T], L2, [H|L3]) :-
    my_append(T, L2, L3).

%basic_building/1 (lista)
%true si es un edificio basico con al menos un nivel y una vivienda por nivel
basic_building([A]) :-
    checkLevel(A).       
basic_building([A|X]) :-
    checkLevel(A),
    basic_building(X).

%checkLevel/1 (lista)
%predicado auxiliar que comprueba que cada elemento de la lista (nivel) es un numero de peano
% true si es un nivel del edificio con al menos una vivienda
checkLevel([A]) :-
    nat(A).
checkLevel([A|X]) :-
    nat(A),
    checkLevel(X).

%building/1 (lista edificio)
%predicado que devuelve true si todos los pisos del edificio tienen el mismo numero de viviendas
building([X]):-
    basic_building([X]).
building([X,Y]):-
    comp_n_viv(X,Y),
    building([Y]).
building([X|[Y|Z]]):-
    building([Y|Z]),
    comp_n_viv(X,Y).

%comp_n_viv/2 (lista nivel1, lista nivel2)
%predicado auxiliar que devuelve true si los dos niveles tienen el mismo numero de viviendas
comp_n_viv([],[]).
comp_n_viv([X|Ys],[Z|Ts]):-
    nat(X),
    nat(Z),
    comp_n_viv(Ys,Ts).

%level/3 (Lista1, nº de peano, Lista2)
%true si C es el nivel N-ésimo del edificio X (la lista con todas las viviendasde ese nivel)
level(X,N,C):-
    building(X),
    getLevel(X,N,C).

%getLevel/3 (Lista1, nº de peano, Lista2)
%predicado auxiliar
% true si C es el nivel N-ésimo del edificio X (la lista con todas las viviendasde ese nivel)
getLevel([X|_],s(0),X).
getLevel([_|Ys],s(N),C) :-
    getLevel(Ys,N, C).

%column/3 (Edificio, num vivienda (peano), Lista Resultante)
%C es la lista formada por las viviendas N-ésimas de todos los niveles del edificio X.
column([X],N,C):-
    building([X]),
    append_vivienda(X,N,Z),
    my_append(Z,[],C).
column([X|Y],N,C):-
    building([X|Y]),
    column(Y,N,T),
    append_vivienda(X,N,Z),
    my_append(Z,T,C).

%append_vivienda/3 (Nivel(lista), num vivienda(peano), vivienda resultante)
%devuelve true si se consigue extraer la vivienda n del nivel correspondiente
append_vivienda([X|_],s(0),[X]).
append_vivienda([_|X],s(N),C):-
    append_vivienda(X,N,C).

%columns/3 (Edificio(lista), Columnas(lista))
%devuelve true si C es la lista de columnas de X
columns([X|Y],C):-
    building([X|Y]),
    cont_viv(X,0,N),
    rec_col([X|Y],s(0),C,N).

%cont_viv/3 (Nivel(lista), numero viv(numero peano), numero de viviendas(numero de peano))
%devuelve true si N es el numero de viviendas de Nivel
cont_viv([],S,S).
cont_viv([_|Y],S,N):-
    cont_viv(Y,s(S),N).

%rec_col/4(Edificio(lista), numero viv(numero de peano),
%lista columnas(lista), n viviendas por recorrer(numero peano))
%devuelve true si L es la lista con las columnas de X, siendo T numero de viviendas por nivel de X
rec_col(_,_,_,0).
rec_col(X,N,L,s(T)):-
    rec_col(X, s(N),Y,T),
    column(X,N,C),
    my_append([C|Y],[],L).
rec_col(X,N,L,s(0)):-
    rec_col(X, s(N),_,0),
    column(X,N,C),
    my_append(C,[],L).

%total_people/2 (list1, num_peano)
% true si X(lista1) es un edificio y si num_peano es el número total de personas que viven en el edificio X (list1)
total_people(X, Y) :-
    building(X), 
    totalPeople(X, Y).

%total_people/2 (list1, num_peano)
% num_peano es el número total de personas que viven en el edificio X (list1)
totalPeople([],0).
totalPeople([X|Ys],F) :-
    countPeople(X, Z),
    sum(Z,T,F),
    totalPeople(Ys,T).

% countPeople/2 (list1, num_peano)
% num_peano es el número total de personas que viven en el nivel X (list1)
countPeople([],0).
countPeople([X|Ys], F) :-
    sum(X, T, F),
    countPeople(Ys, T).   

% total_building/2 (list1, num_peano)
% num_peano es el número total de viviendas en el edificio X (list1)
% regla auxiliar para average/2
total_building([],0).
total_building([X|Ys],F) :-
    countBuilding(X, Z),
    sum(Z,T,F),
    total_building(Ys,T).

% countBuilding/2 (list1, num_peano)
% num_peano es el numero total de viviendas en el nivel X (list1)
countBuilding([],0).
countBuilding([_|Ys], s(F)) :-
    countBuilding(Ys, F).   

% average/2 (list1 , num_peano)
% num_peano es el numero medio de personas en cada vivienda
average(X,T) :-
    total_people(X, Y),         % total_people comprueba que X es un edificio con building (no hay necesidad de comprobarlo otra vez)
    total_building(X, Z),        
    div(Y, Z, T).
