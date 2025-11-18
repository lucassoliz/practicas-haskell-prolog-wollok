vuelo(aRG845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(mH101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(dLH470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(aAL1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),
escala(paris,0)]).

vuelo(bLE849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo(nPO556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo(dSM3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

%1
tiempoTotalVuelo(CodigoVuelo, Tiempo):-
    vuelo(CodigoVuelo, _, Destino),
    calcular(Destino, Tiempo).

calcular([], 0).
calcular([Destino | Resto], TiempoTotal):-
    calculoIndividual(Destino, Calculo),
    calcular(Resto, Tiempo),
    TiempoTotal is Tiempo + Calculo.

calculoIndividual(escala(_, Tiempo), Tiempo).
calculoIndividual(tramo(Tiempo), Tiempo).

%2
esEscala(escala(_, _)).
escalaAburrida(CodigoVuelo, Tramo):-
    esEscala(Tramo),
    vuelo(CodigoVuelo, _, Destinos),
    member(Tramo, Destinos),
    calculoIndividual(Tramo, Tiempo),
    Tiempo > 3.

%3
ciudadesAburridas(CodigoVuelo, Ciudades):-
    vuelo(CodigoVuelo, _, _),
    findall(Ciudad, escalaAburrida(CodigoVuelo, escala(Ciudad, _)), Ciudades).

%4
calcularTramo([], 0).
calcularTramo([escala(_, _) | Resto], TiempoFinal):- calcularTramo(Resto, TiempoFinal).
calcularTramo([Tramo | Resto], TiempoFinal):-
    calculoIndividual(Tramo, Calculo),
    calcularTramo(Resto, Tiempo),
    TiempoFinal is Tiempo + Calculo.

vueloLargo(CodigoVuelo):-
    vuelo(CodigoVuelo, _, Destino),
    calcularTramo(Destino, TiempoFinal),
    TiempoFinal >= 10.

conectados(CodigoVuelo1, CodigoVuelo2):-
    vuelo(CodigoVuelo1, _, Destino1),
    vuelo(CodigoVuelo2, _, Destino2),
    CodigoVuelo1 \= CodigoVuelo2,
    member(escala(Ciudad, _), Destino1),
    member(escala(Ciudad, _), Destino2).

%5
bandaDeTres(CodigoVuelo1, CodigoVuelo2, CodigoVuelo3):-
    CodigoVuelo1 \= CodigoVuelo2,
    CodigoVuelo2 \= CodigoVuelo3,
    CodigoVuelo1 \= CodigoVuelo3,
    conectados(CodigoVuelo1, CodigoVuelo2),
    conectados(CodigoVuelo2, CodigoVuelo3).

%6
distanciaEnEscalas(Ciudad1, Ciudad2, Distancia):-
    vuelo(_, _, Destino),
    nth1(Posicion1, Destino, escala(Ciudad1, _)),
    nth1(Posicion2, Destino, escala(Ciudad2, _)),
    Distancia is abs(Posicion1 *2 - Posicion2).

%7
vueloLento(CodigoVuelo):-
    vuelo(CodigoVuelo, _, _),
    not(vueloLargo(CodigoVuelo)),
    escalaAburrida(CodigoVuelo, _).