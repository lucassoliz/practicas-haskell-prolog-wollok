linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

%1
estaEn(Estacion, Linea):-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

%2
distancia(Estacion1, Estacion2, Distancia):-
    estaEn(Estacion1, Linea),
    estaEn(Estacion2, Linea),
    linea(Linea, Estaciones),
    nth1(Posicion1, Estaciones, Estacion1),
    nth1(Posicion2, Estaciones, Estacion2),
    Distancia is abs(Posicion1 - Posicion2).

%3
mismaAltura(Estacion1, Estacion2):-
    estaEn(Estacion1, Linea1),
    estaEn(Estacion2, Linea2),
    linea(Linea1, Estaciones1),
    linea(Linea2, Estaciones2),
    nth1(Posicion, Estaciones1, Estacion1),
    nth1(Posicion, Estaciones2, Estacion2).

%4
viajeFacil(Estacion1, Estacion2):-
    estaEn(Estacion1, Linea),
    estaEn(Estacion2, Linea).

viajeFacil(Estacion1, Estacion2):-
    estaEn(Estacion1, Linea1),
    estaEn(Estacion2, Linea2),
    Linea1 \= Linea2,
    combinacion(Combinacion),
    member(E1, Combinacion),
    member(E2, Combinacion),
    estaEn(E1, Linea1),
    estaEn(E2, Linea2).
