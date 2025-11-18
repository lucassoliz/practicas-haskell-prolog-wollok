puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

%1
puntajeCiertoSalto(Competidor, Salto, Puntaje):-
    puntajes(Competidor, Puntajes),
    nth1(Salto, Puntajes, Puntaje).

%2
descalificado(Competidor):-
    puntajes(Competidor, Puntajes),
    length(Puntajes, Saltos),
    Saltos > 5.

%3
clasificaAFinal(Competidor):-
    puntajes(Competidor, Puntajes),
    sum_list(Puntajes, Total),
    Total >= 28.

clasificaAFinal(Competidor):-
    puntajes(Competidor, Puntajes),
    findall(Saltos, (member(Saltos, Puntajes), Saltos >= 8), Total),
    length(Total, Cantidad),
    Cantidad >= 2.
    
    