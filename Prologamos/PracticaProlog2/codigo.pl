:- module(_, _).

%Nuestros datos
alumno_prode('Benavente','Alvarez','Alejandro','Y160319'). %PORTAVOZ
alumno_prode('Doncel','Aparicio','Alberto','Y160364').   
alumno_prode('Lin','Tsai','Alvin','Y160267').
%-------------------------------------------

%eliminar_comodines/3 (Registros, RegistrosSinComodines, ListaSimbolos)
% predicado que devielve yes si RegistrosSinComodines es una estructura de tipo  reg/n, que resulta de sustituir los comodines que aparecen en el argumento  Registros/n por variables
%ListaSimbolos  es una lista que contiene todos los símbolos utilizados en el término Registros/n en el mismoorden en los que estos aparecen en los registros.
eliminar_comodines(Regs, R, L):-
    functor(Regs, _, N),                                       % calculamos la ariedad de Regs
    recorrerLista(Regs, R1, L, 1, N),
    R =.. [regs|R1].                                            %pasamos R a lista para poder operar

% recorrerLista/5 (Registros, RegistrosSinComodines, ListaSimbolos, contador, ariedadDeRegistros)
% predicado auxiliar que devuelve en Registros sin comodines la lista de elementos cambiando los comodines por _
%  ademas la devuelve ListaSimbolos el alfabeto utilizado por los registros
recorrerLista(Regs, [_], [], N ,N) :-
    arg(N, Regs, X1),
    comprobar_comodin(X1, B),
    B = comodin,                                        % si B es comodin el valor de R en la posicion N es _
    !.

recorrerLista(Regs, [X1],[X1], N ,N) :-
    arg(N, Regs, X1),
    comprobar_comodin(X1, B),
    B \= comodin,                                       % si B no es comodin el valor de R en la posicion N es X1 y se añade X1 a L
    !.

recorrerLista(Regs, [_|R],L, N1, N):-
	arg(N1, Regs, X1),
    N2 is N1 + 1,
    comprobar_comodin(X1, B),
    B = comodin,                                        % si B es comodin el valor de R en la posicion N es _ 
    recorrerLista(Regs, R, L,N2, N).

recorrerLista(Regs, [X1|R], [X1|L], N1, N):-
	arg(N1, Regs, X1),
    N2 is N1 + 1,
    comprobar_comodin(X1, B),
    B \= comodin,                                       % si B no es comodin el valor de R en la posicion N1 es X1 y se añade X1 a L
    recorrerLista(Regs, R, L, N2, N).

% devuelve en B comodin si A unifica con *
comprobar_comodin(A,B) :-
    A == *,
    B = comodin,
    !.
  
% devuelve A en caso de que no unifique 
comprobar_comodin(A,A). 

%ejecutar_instrucciones/3 (Registros, Instruccion, Resultado)
%predicado que devuelve true si Resultado es Registros tras haberse modificado por una Instruccion
ejecutar_instruccion(Regs,Ins,ES):- %caso swap
    ground(Regs),           %comprobamos que tanto Regs como Ins son variables inicializadas
    ground(Ins),
    Ins =.. [I,A,B],
    Regs =.. [R|L1],
    I == swap,
    functor(Regs, _, N),    %comprobamos que los número del swap no sobrepasen los límites de los registros 
    A =< N,
    B =< N,
    P1 is A-1,              %restamos uno debido a que en nuestra implementación de swap las lista empiezan en 0
    P2 is B-1,
    swap(L1, P1, P2, S),    %hacemos swap con las listas no con registros
    ES =.. [R|S].

ejecutar_instruccion(Regs,Ins,ES):-
    ground(Regs),           %comprobamos que tanto Regs como Ins son variables inicializadas
    ground(Ins),
    Ins =.. [I,N],
    Regs =.. [R|L1],
    I == move,
    functor(Regs, _, M),    %comprobamos que los número del move no sobrepasen los límites de los registros
    N =< M,
    move(L1, N, 0, ES, M),  %hacemos move con las listas no con registros
    ES =.. [R|ES].

%swap/4 (ListaInicial, Posicion1, Posicion2,ListaResultante)
%predicado que devuelve true si ListaResultante es ListaInicial pero con los 
%elementos en Posicion1 y Posicion2 cambiados de lugar
swap( L, P1, P2, L ) :-         %caso en el que Posicion1 y Posicion2 son el mismo número
    P1 = P2.
swap( L, P1, P2, S ) :-           
    swap2( L, P1, P2, S, _, _ ).
swap( L, P1, P2, S ) :-
    swap2( L, P2, P1, S, _, _ ).

%swap/6 ((ListaInicial, Posicion1, Posicion2,ListaResultante, EstadoP1, EstadoP2)
%predicado homónimo a swap4 pero en el que guardamos los estados con lo que encontramos en P1 y P2 para
%modificar la lista cuando llegamos a dichas posiciones
swap2( L, _, 0, S, E_P1, E_P2 ) :-  %caso en el que llegamos a P2=0 y realizamos el cambio de números
    L = [E_P2|Ls],
    S = [E_P1|Ls],
    !.
swap2( L, P1, P2, S, E_P1, E_P2 ) :-%caso en el que llegamos a P1=0 y guardamos el estado de los numeros que estaban en las posiciones correspondientes
    P1 = 0,
    L = [E_P1|Es],
    S = [E_P2|Rs],
    N1 is P1 - 1,
    N2 is P2 - 1,
    swap2( Es, N1, N2, Rs, E_P1, E_P2 ),
    !.
swap2( L, P1, P2, S, E_P1, E_P2 ) :-%recorremos la lista
    L = [E|Es],
    S = [E|Rs],
    N1 is P1 - 1,
    N2 is P2 - 1,
    swap2( Es, N1, N2, Rs, E_P1, E_P2 ).

%move/5(Lista, Numero a mover, contador, ListaResultante, TamañoLista)
%predicado que es true si produce una operación de move(descrita en el enunciado de la práctica) del numero 
%a mover introducido como argumento y generando como resultado ListaResultante que es Lista pero con la modificación
%anteriormente descrita.
%wip, no acabado
move([E|L], N, N, ES, N):-
    ES=[E|L],
    !.

move([E|L], N, N, ES, _):-
    ES=[E|L],
    !.

move([_|Ls], N, X, ES, M):-
    Xs is X+1,
    move(Ls, N, Xs, ES, M).

