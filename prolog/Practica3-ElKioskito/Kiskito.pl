%PUNTO 1

%responsable(dodain, dias(lunes, miercoles, viernes), horario(9, 15)).
/*el tema que es poco flexible
    si agregamos mas dias a distintos enpleados, por ejemplo
    . . . dias/3  . . . dias/4 etc, sera un embole poir tema de aridad
    o tambien, imagina que los viernes tiene otro horari . . . 
    Ya no seria tan flexible, por lo que, lo mejor seria tipo:*/

responsable(dodain, lunes, 9, 15).
responsable(dodain, miercoles, 9, 15).
responsable(dodain, viernes, 9, 15).

responsable(lucas, martes, 10, 20).

responsable(juanC, sabados, 18, 22).
responsable(juanC, domingos, 18, 22).

responsable(juanFDS, jueves, 10, 20).
responsable(juanFDS, viernes, 12, 20).

responsable(leoC, lunes, 14, 18).
responsable(leoC, miercoles, 14, 18).

responsable(martu, miercoles, 23, 24).


%calentando motores . . .
/*Usamos atomos, para determinar solo para quien es valido y de quien estamos buscando
¿Que dias atiende valen?
-? responsable(vale, DiasQueAtiende, _, _).
DiasQueAtiende = lunes ;
DiasQueAtiende = miercoles 
DiasQueAtiende = viernes ;
false.
*/
responsable(vale, Dias, HorarioEntrada, HorarioSalida):-
    responsable(dodain, Dias, HorarioEntrada, HorarioSalida).
responsable(vale, Dias, HorarioEntrada, HorarioSalida):-
    responsable(juanC, Dias, HorarioEntrada, HorarioSalida).
/*
?- responsable(vale, DiasQueAtiende, HorarioEntrada, HorarioSalida).
DiasQueAtiende = lunes, HorarioEntrada = 9, HorarioSalida = 15 ;
DiasQueAtiende = miercoles, HorarioEntrada = 9, HorarioSalida = 15 ;
*/

%como nadie hace el mismo horario que leoC directamente ni lo pongo

%DESCONOCIDO ----> No se modela, mailu aun no sabe si lo va hacer
%por lo que, no hay que poner nada
%========================================================================================

%PUNTO 2
atiende(Persona, Dia, HorarioPuntual):-
  responsable(Persona, Dia, HorarioInicio, HorarioFinal),
    HorarioPuntual >= HorarioInicio,
    HorarioPuntual =< HorarioFinal. %Para que este dentro del rango

%?- atiende(dodain, lunes, 10).
% True
%?- atiende(Persona, Diaa, 10).
% Persona = dodain, Diaa = lunes ;
% Persona = lucas, Diaa = martes ;
% Persona = juanC, Diaa = sabados ;
    

%=========================================================================================
%PUNTO 3
foreverAlone(Persona, Dia, Hora):-
    atiende(Persona, Dia, Hora), %Al usar not, debo establecer un generador para la inversibilidad
    not((atiende(OtraPersona, Dia, Hora), %como genere todas las personas que atienden ese dia y hora, ahora de negarlo, me quedo con las que no atienden
        OtraPersona \= Persona)). 

%?- foreverAlone(Persona, Dia, 10).
% Persona = lucas, Dia = martes ;
% Persona = juanC, Dia = sabados ;

%?- foreverAlone(Persona, Dia, Hora).
% Persona = lucas, Dia = martes, Hora = 10 ;
% Persona = juanC, Dia = sabados, Hora = 18;

%=========================================================================================

%test

