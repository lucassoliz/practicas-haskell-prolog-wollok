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
%PUNTO 4

%POSIBILIDADES   ---> COMBINATORIA
/*
generarUnaCombinacion([], []).
generarUnaCombinacion([Primero|ListaRestante], [Primero|Combinacion]):-
	generarUnaCombinacion(ListaRestante, Combinacion).
generarUnaCombinacion([_|ListaRestante], Combinacion):-
	generarUnaCombinacion(ListaRestante, Combinacion).
*/

%Quien atiende los miercoles
%En que momento esta atendiendo || NO CORRESPONDE
%en "algun momento de ese dia", NO en que momento ---> No usamos horarioPuntual
%que sea inversible

quienAtiende(Persona, Dia):-
    atiende(Persona, Dia, _), %generador
    findall(Persona, atiende(Persona, Dia, _), PersonaQueAtiende),
%generamos todas las personas que atienden ese dia, y lo ponemos en una lista, para
%hacer todas sus posibilidades (combinatoria)
    generarUnaCombinacion(PersonaQueAtiende, Persona).


  generarUnaCombinacion([], []).
generarUnaCombinacion([Primero|ListaRestante], [Primero|Combinacion]):-
	generarUnaCombinacion(ListaRestante, Combinacion).
generarUnaCombinacion([_|ListaRestante], Combinacion):-
	generarUnaCombinacion(ListaRestante, Combinacion).

% Qué conceptos en conjunto resuelven este requerimiento
% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles

%=========================================================================================
%PUNTO 5

%una solucion podria ser:
% Hechos corregidos: cigarrillos como lista
venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
venta(dodain, fecha(12, 8), [bebida(8, alcoholico), bebida(1, noAlcoholico), golosinas(10)]).

venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).

venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebida(2, noAlcoholico), cigarrillos([derby])]).

/*Lo podriamos haber puesto como functor, el problema, que despues se nos complica
a la hora de tomar la primera venta, por eso, vamos a trabajar con,listas

y la primera venta, sera el primer elemento de la lista, es decir:
        [PrimeraVenta | _ ]

Asi tomamos el primer elemento y analizamos si. . . 
    cumple alguna de las 3 condiciones  */

% suertuda: todas sus primeras ventas del día son importantes
esSuertuda(Persona) :-
    venta(Persona, _, _),   % generador,  me restringe mis opciones
    forall(venta(Persona, _, [PrimeraVenta|_]), %se lee como: para toda venta que hizo la persona,
    % debe cumplirse que la primera venta del dia
           esImportante(PrimeraVenta)).

% Importancia de ventas
esImportante(golosinas(Valor)) :-
    Valor > 100.

esImportante(cigarrillos(Marcas)) :-
    length(Marcas, Cantidad),
    Cantidad > 2. 

esImportante(bebida(_, alcoholico)).
esImportante(bebida(Cantidad, noAlcoholico)) :-
    Cantidad > 5.

%====================================================================
%PUNTO 6 EXTRA ~ para practicar un poco mas

/*Queremos saber si una persona vendedora es trabajólica. 
Esto ocurre si para todas las ventas que hizo, la cantidad de golosinas 
vendidas es mayor a la cantidad de bebidas vendidas 
(sin importar si son alcohólicas o no). 
El predicado debe ser inversible: dodain es trabajólico, lucas y martu no lo son.
*/

esTrabajolico(Persona):-
    venta(Persona, _, _), %generador
    forall(venta(Persona, _, VentasDelDia), %para todas las ventas del dia
        esMayorGolosinasQueBebidas(VentasDelDia)). %debe cumplirse que haya mas golosinas que bebidas

    esMayorGolosinasQueBebidas(VentasDelDia):-
        %sin usar sumlist, lo hacemos a mano
        contarGolosinasYBebidas(VentasDelDia, CantGolosinas,CantBebidas),
        CantGolosinas > CantBebidas.

    contarGolosinasYBebidas([], 0, 0). %caso base
    contarGolosinasYBebidas([golosinas(_)|Resto], CantGolosinas, CantBebidas):-
        contarGolosinasYBebidas(Resto, CantGolosinasResto, CantBebidas),
        CantGolosinas is CantGolosinasResto + 1.
    contarGolosinasYBebidas([bebida(_, _)|Resto], CantGolosinas, CantBebidas):-
        contarGolosinasYBebidas(Resto, CantGolosinas, CantBebidasResto),
        CantBebidas is CantBebidasResto + 1.

%contador generico 
contar([],0).
contar([_|Cola], Cantidad):-
    contar(Cola, CantidadCola),
    Cantidad is CantidadCola + 1.





%====================================================================
%PUNTO 7 EXTRA ~ para practicar un poco mas
/*Queremos saber si una persona vendedora es popular.
Esto ocurre si la cantidad de días distintos en los que vendió es mayor a 2
(sin importar la cantidad de ventas que haya hecho en cada día).
El predicado debe ser inversible: dodain y lucas son populares, martu no lo es.
sin usar list_to_set
*/

esPopular(Persona):-
    venta(Persona, _, _), %generador
    findall(Dia, venta(Persona, Dia, _), DiasVendidos), %generador + filtro
    eliminarRepetidos(DiasVendidos, DiasSinRepetidos), %filtro
    length(DiasSinRepetidos, CantidadDias), %cantidad de dias sin repetidos
    CantidadDias > 2. %filtro

eliminarRepetidos([], []). %caso base
eliminarRepetidos([Cabeza|Cola], [Cabeza|Resultado]) :-
    not(pertenece(Cabeza, Cola)), %si no pertenece a la cola, lo agrego al resultado
    eliminarRepetidos(Cola, Resultado).
eliminarRepetidos([Cabeza|Cola], Resultado) :-
    pertenece(Cabeza, Cola), %si pertenece a la cola, no lo agrego al resultado
    eliminarRepetidos(Cola, Resultado).
pertenece(Elem, [Elem|_]). %caso base
pertenece(Elem, [_|Cola]) :-
    pertenece(Elem, Cola).
%====================================================================
