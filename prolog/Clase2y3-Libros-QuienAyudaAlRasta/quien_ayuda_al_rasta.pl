estaEnElAula(rasta).
estaEnElAula(polito).
estaEnElAula(santi).

ayudaA(Ayudado, Ayudante) :-
    quiereA(Ayudado, Ayudante),
    not(tieneMenosSuerteQue(Ayudado, Ayudante)),
    estaEnElAula(Ayudante).

quiereA(Querido, santi) :-
    estaEnElAula(Querido),
    not(quiereA(Querido, rasta)).

quiereA(Querido, rasta) :-
    estaEnElAula(Querido),
    Querido \= polito.

quiereA(Persona, polito) :-
    quiereA(Persona, rasta).

tieneMenosSuerteQue(rasta, Desafortunado) :-
    estaEnElAula(Desafortunado),
    not(quiereA(Desafortunado, polito)).

% 1. a.
%
% ?- ayudaA(rasta, Persona).
% Persona = rasta ;
% Persona = polito ;
% false.

% ?- ayudaA(polito, Persona).
% Persona = santi ;
% false.

% ?- ayudaA(santi, Persona).
% Persona = rasta ;
% Persona = polito ;
% false.

% ?- ayudaA(Ayudado, rasta).
% Ayudado = rasta ;
% Ayudado = santi.

% ?- ayudaA(Ayudado, polito).
% Ayudado = rasta ;
% Ayudado = santi.

% ?- ayudaA(Ayudado, santi).
% Ayudado = polito ;
% false.

% 2. a.
%
% - todos los quiereA y todos los estaEnElAula
% 
% - los dos primeros quiereA y todos los estaEnElAula
%
% -
