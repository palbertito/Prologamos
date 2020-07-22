%Nuestros datos
alumno_prode(Alvarez,Benavente,Alejandro,160319).
alumno_prode(Pascual,Cristobal,David,160336).
alumno_prode(Aparicio,Doncel,Alberto,160364).   %PORTAVOZ
%-------------------------------------------

% practica1.pl

% Números de Peano

% nat/1(num_peano) true si N es un número de peano
nat(0).
nat(s(N)) :-
    nat(s(N)).

%grt_eq/2(num_peano1,num_peano2) true si N>=M
grt_eq(_, 0).				% 0 es el número de peano más pequeño
grt_eq(s(N), s(M)):-				% a > b => (a + 1) > (b + 1)
	grt_eq(N, M).

%grt/2(num_peano1,num_peano2) true si N>M
grt(N, 0):-	N \= 0.				% 0 es el número de peano más pequeño
grt(s(N), s(M)):-				% a > b => (a + 1) > (b + 1)
	grt(N, M), N \= M.

%lst_eq/2(num_peano1,num_peano2) true si N<M
lst_eq(0, _).					    % 0 es el número de peano más pequeño
lst_eq(s(N), s(M)):-				% a < b => (a + 1) < (b + 1)
	lst_eq(N, M).

%lst/2(num_peano1,num_peano2) true si N<=M
lst(0, N):- N \= 0.  			% 0 es el número de peano más pequeño
lst(s(N), s(M)):-				% a < b => (a + 1) < (b + 1)
	lst(N, M), N \= M.

%sum/3(num_peano1,num_peano2,num_peano3)
%true si todos son números de peano
%suma A y B y lo pone en C
sum(0, A, A).
sum(s(A), B, s(C)) :-
    sum(A, B, C).

%my_member/2(elemento,lista)
%implementacion personal de la función built-in member de prolog
%true si X es miembro del segundo argumento, siendo esta una lista, si no es lista también falla
my_member(X, [X|_]).
my_member(X, [_|Ys]) :-
    my_member(X, Ys).

%my_append/3(lista1,lista2,lista3)
%implementacion personal de la funcion built-in append de prolog
%true si todos los argumentos son listas
%junta las dos primeras listas y almacena el resultado en L3 (L1|L2)->L3
my_append([], L, L).
my_append([H|T], L2, [H|L3]) :-
    my_append(T, L2, L3).

%memberlistas/2(lista1,lista2)
%true si todos los miembros del primer argumento lista son miembros de la lista segundo argumento
memberlistas([], _).
memberlistas([X|Xs], Y) :-
    my_member(X, Y),
    memberlistas(Xs, Y).

%Primera Parte

%pieza(Ancho, Alto, Prof, Color).

%ancho/2(pieza, Ancho).
%alto/2(pieza, Alto).
%prof/2(pieza, Prof).
%color/2(pieza, Color).
%predicados auxiliares para sacar los diferentes parámetros de cada pieza
%true si primer argumento es una pieza
ancho(pieza(Ancho, _, _, _), Ancho).
alto(pieza(_, Alto, _, _), Alto).
prof(pieza(_, _, Prof, _), Prof).
color(pieza(_, _, _, Color), Color).

%peano_par/1(num_peano)
%true si X es un número de peano par
peano_par(0).
peano_par(s(s(X))) :-
    peano_par(X).

%esPieza/1(pieza)
%true si X es una pieza con dimensiones > 0
esPieza(X):-
    ancho(X, Value1),
    grt(Value1,0),
    alto(X,Value2),
    grt(Value2,0),
    prof(X, Value3),
    grt(Value3,0).


%esTorre(Construccion).


%esTorre/1(listapiezas)
%true si una lista de piezas es una torre

%true si el elemento único de una torre es una pieza
esTorre([X]):-
    esPieza(X).

%true si ancho y prof de la pieza cabeza es < que la otra
esTorre([X, Xs]) :-
    esPieza(X),
    ancho(X, Value1),
    ancho(Xs, Value2),
    prof(X, Value3),
    prof(Xs, Value4),
    lst_eq(Value1, Value2),
    lst_eq(Value3, Value4).

%true si ancho y prof de la pieza cabeza es < que la siguiente
esTorre([X, Xs|Y]) :-
    esPieza(X),
    ancho(X, Value1),
    ancho(Xs, Value2),
    prof(X, Value3),
    prof(Xs, Value4),
    lst_eq(Value1, Value2),
    lst_eq(Value3, Value4),
    esTorre([Xs|Y]).


%alturaTorre/2(Construccion,A).
%true si la altura de la construccion es torre y es igual al número de peano N

%true si es torre y además altura de la torre es = a N
alturaTorre([X|Xs], N) :-
    esTorre([X|Xs]),
    altura([X|Xs], N).

%predicado auxiliar implementado para comparar un numero de peano con la altura de una torre calculada
%calculando la altura sumando recursivamente la altura de cada pieza
%true si N es la altura de la torre primer argumento
altura([], 0).
altura([X|Xs], N) :-
    altura(Xs, B),
    alto(X, Value),
    sum(Value, B, N).


%coloresTorre/2(Construccion,Colores).
%true si la Construccion es una torre y su lista de colores es igual a Colores
coloresTorre([X|Xs], N) :-
    esTorre([X|Xs]),
    colores([X|Xs], N).

%colores/2(construccion,colores)
%true si una construcción vacía no tiene colores
colores([], []).
%true si N es la lista de colores de la torre
colores([X|Xs], N) :-
    colores(Xs, B),
    color(X, Value1),
    my_append([Value1], B, N).



%coloresIncluidos/2(Construccion1,Construccion2)
%true si ambas construcciones son torres y si todos los colores de la construcion1 estan en los de la construccion2
coloresIncluidos([X|Xs], [Y|Ys]) :-
    esTorre([X|Xs]),
    esTorre([Y|Ys]),
    coloresInc([X|Xs], [Y|Ys]).

%coloresInc/2(listacolores1,listacolores2)
%predicado auxiliar que devuelve true true si todos los elementos de N estan en M
coloresInc([X|Xs], [Y|Ys]) :-
    colores([X|Xs], N),
    colores([Y|Ys], M),
    memberlistas(N, M).


%Segunda Parte


%esEdificioPar/1(Construccion).

%determina si el ancho de cada nivel del edificio es par
%true si es un edificio con el ancho de todos los niveles par
esEdificioPar([X]):-
    esNivelPar(X).
esEdificioPar([X|Xs]):-
    esNivelPar(X),
    esEdificioPar(Xs).

%esNivelPar/1(nivel_edificio)
%predicado auxiliar para ver si el ancho del nivel es par
%true si es nivel par
esNivelPar(X):-
    anchoEdificio(X,N),
    peano_par(N).


%esEdificioPiramide/1(Construccion).

%calcula que cada nivel tiene un ancho inferior al nivel consecutivo
%true si el primer nivel es mas pequeño que el segundo
esEdificioPiramide([_]).
esEdificioPiramide([X, Xs]) :-
    anchoEdificio(X, N),
    anchoEdificio(Xs, M),
    lst(N, M).
esEdificioPiramide([X, Xs|Y]) :-
    anchoEdificio(X, N),
    anchoEdificio(Xs, M),
    lst(N, M),
    esEdificioPiramide([Xs|Y]).


%anchoEdificio/2(nivel_edificio,num_peano)
%predicado auxiliar para calcular el ancho del nivel de un edificio.
%suma recursivamente cada celda de la lista (en caso de que no sea una b)
%true si es un nivel y si el segundo argumento es su ancho
anchoEdificio([], 0).
anchoEdificio([X|Xs], N) :-
    anchoEdificio(Xs, B),
    clavo(X, C),
    sum(C, B, N).

%clavo/2(color,suma 0 o 1)
%predicado auxiliar para determinar si hay un clavo o una b
%en caso de no haber un clavo el arg1 es una b siendo el arg2 0 en cualquier otro caso es s(0)
%true si es blanco
clavo(b, 0).
%true si no es blanco
clavo(X, s(0)) :-  X \= b.
