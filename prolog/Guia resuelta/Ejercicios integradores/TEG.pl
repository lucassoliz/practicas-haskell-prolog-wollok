/* distintos paises */
paisContinente(argentina, americaDelSur).
paisContinente(bolivia, americaDelSur).
paisContinente(brasil, americaDelSur).
paisContinente(chile, americaDelSur).
paisContinente(ecuador, americaDelSur).
paisContinente(alemania, europa).
paisContinente(espania, europa).
paisContinente(francia, europa).
paisContinente(inglaterra, europa).
paisContinente(aral, asia).
paisContinente(china, asia).
paisContinente(gobi, asia).
paisContinente(india, asia).
paisContinente(iran, asia).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes([argentina,brasil]).
limitrofes([bolivia,brasil]).
limitrofes([bolivia,argentina]).
limitrofes([argentina,chile]).
limitrofes([espania,francia]).
limitrofes([alemania,francia]).
limitrofes([nepal,india]).
limitrofes([china,india]).
limitrofes([nepal,china]).
limitrofes([afganistan,china]).
limitrofes([iran,afganistan]).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).

/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentina, bolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

%1
estaEnContinente(Jugador, Continente):-
    paisContinente(Pais, Continente),
    ocupa(Pais, Jugador, _).

%2
cantidadPaises(Jugador, Cantidad):-
    findall(Pais, ocupa(Pais, Jugador, _), Paises),
    length(Paises, Cantidad).

%3
ocupaContinente(Jugador, Continente):-
    paisContinente(_, Continente),
    ocupa(_, Jugador, _),
    forall(paisContinente(Pais, Continente), ocupa(Pais, Jugador, _)).

%4
leFaltaMucho(Jugador, Continente):-
    paisContinente(_, Continente),
    ocupa(_, Jugador, _),
    findall(Pais, (paisContinente(Pais, Continente) ,not(ocupa(Pais, Jugador, _))), Paises),
    length(Paises, Cantidad),
    Cantidad > 2.

%5
sonLimitrofes(Pais1, Pais2):-
    limitrofes(Paises),
    select(Pais1, Paises, RestoPaises),
    select(Pais2, RestoPaises, _).

%6
%a
esGroso(Jugador):-
    forall(ocupa(Pais, Jugador, _), paisImportante(Pais)).
%b
esGroso(Jugador):-
    cantidadPaises(Jugador, Cantidad),
    Cantidad > 10.
%c
esGroso(Jugador):-
    findall(Ejercito, ocupa(_, Jugador, Ejercito), TotalEjercitos),
    sum_list(TotalEjercitos, CantidadEjercito),
    CantidadEjercito > 50.

%7
estaEnElHorno(Pais1):-
    ocupa(Pais1, Jugador1, _),
    ocupa(Pais2, Jugador2, _),
    Jugador1 \= Jugador2,
    forall(sonLimitrofes(Pais1, Pais2), ocupa(Pais2, Jugador2)).

%8
esCaotico(Continente):-
    findall(Jugador, estaEnContinente(Jugador, Continente), Jugadores),
    list_to_set(Jugadores, SinRepetir),
    length(SinRepetir, Cantidad),
    Cantidad > 3.

%9
capoCannoniere(Jugador1):-
    cantidadPaises(Jugador1, Maximo),
    forall((cantidadPaises(Jugador2, Cantidad), Jugador1 \= Jugador2), Maximo > Cantidad).

%9
ocupaPais(_, []).
ocupaPais(Jugador, [Pais | Resto]):-
    ocupa(Pais, Jugador, _),
    ocupaPais(Jugador, Resto).

ganadooor(Jugador):-
    objetivo(Jugador, ocuparContinente(Continente)),
    ocupaContinente(Jugador, Continente).

ganadooor(Jugador):-
    objetivo(Jugador, ocuparPaises(Paises)),
    ocupaPais(Jugador, Paises).

ganadooor(Jugador):-
    objetivo(Jugador, destruirJugador(Jugador2)),
    not(ocupa(_, Jugador2, _)).
    