%Punto 1

destino(dodain, pehuensia).
destino(dodain, sanMartin).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).

destino(alf, bariloche).
destino(alf, sanMartin).
destino(alf, elBolson).

destino(nico, marDelPlata).

destino(vale, calafate).
destino(vale, elBolson).

destino(martu, Lugar):- destino(nico, Lugar).
destino(martu, Lugar):- destino(alf, Lugar).

%COMO juan no sabe, no podemos poner un destino fijo --> No lo ponemos
%carlos no se va de vacaciones --> No lo ponemos
%============================================================================
%PUNTO 2

atraccion(pehuensia, cerro(bateaMahuida, 2000)).
atraccion(pehuensia, cuerpoDeAgua(moquehue, sePuedePescar, 14)).
atraccion(pehuensia, cuerpoDeAgua(alumine, sePuedePescar, 19)).
atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).

atraccion(sanMartin, parqueNacional(lanin)).
atraccion(sanMartin, cerro(catedral, 2100)).
atraccion(sanMartin, cuerpoDeAgua(traful, noSePuedePescar, 16)).
atraccion(sanMartin, cuerpoDeAgua(meliquina, sePuedePescar, 22)).
atraccion(sanMartin, excursion(cerroFitzRoy)).
atraccion(sarmiento, parqueNacional(laFitzRoy)).
atraccion(camarones, cuerpoDeAgua(camarones, noSePuedePescar, 18)).

/*Una opcion, pero no la mejor por tema de diseño
vacacionesCopadas(Persona):-
    destino(Persona, Lugar), %Genero los lugares a los que va la persona
    atraccion(Lugar, Atraccion), %Genero las atracciones del lugar que estoy
    esAtraccionCopada(Atraccion),%Me fijo si la atraccion es copada
    not((destino(Persona, OtroLugar), OtroLugar \= Lugar, %Para que no compare el mismo lugar
         not((atraccion(OtroLugar, OtraAtraccion), %Si encuentro una atraccion copada en el otro lugar, todo bien
              esAtraccionCopada(OtraAtraccion))))). %Si no encuentro ninguna atraccion copada en el otro lugar, falla
*/

vacacionesCopadas(Persona):-
    destino(Persona, _),  % asegura que la persona tenga destinos y ademas hace el predicado inversible
    forall(
        destino(Persona, Lugar), %Genero los lugares a los que va la persona
        (   atraccion(Lugar, Atraccion), %Genero las atracciones del lugar que estoy
            esAtraccionCopada(Atraccion) %Me fijo si la atraccion es copada si todo lugar tiene al menos una atraccion copada, todo bien
        )
    ).
/*LOGICA DEL FORALL 
se debe cumplir todo los lugares a los que va la persona
por cada lugar, debe existir al menos una atraccion copada
si algun lugar no tiene atraccion copada, falla

"Queremos saber qué vacaciones fueron copadas para una persona. Esto ocurre cuando 
todos los lugares a visitar tienen por lo menos una atracción copada. 
"
Recorda que forall(Condicion, Accion) se lee como "para todo elemento que cumple Condicion, 
se cumple Accion". En este caso, la Condicion es que el lugar sea un destino de la persona,
y la Accion es que exista al menos una atraccion copada en ese lugar.

*/

/* ES IMPORTANTE PONER atraccion(Lugar, Atraccion) DENTRO DEL PARENTESIS DEL FORALL
SI NO, NO FUNCIONA BIEN EL PREDICADO, PORQUE SI PONEMOS atraccion(Lugar, Atraccion) FUERA DEL FORALL
ESTAMOS GENERANDO TODAS LAS ATRACCIONES DE TODOS LOS LUGARES, Y NO NOS FIJAMOS SI CADA LUGAR TIENE
AL MENOS UNA ATRACCION COPADA
*/


esAtraccionCopada(parqueNacional(_)). %Todo parque nacional es copado
esAtraccionCopada(cerro(_, Altura)):-
    Altura > 2000.
esAtraccionCopada(cuerpoDeAgua(_, sePuedePescar, _)). %Si se puede pescar, es copado
esAtraccionCopada(cuerpoDeAgua(_, noSePuedePescar, Temperatura)):-
    Temperatura > 20.
esAtraccionCopada(playa(DiferenciaMareas)):-
    DiferenciaMareas < 5.
esAtraccionCopada(excursion(Nombre)):-
    atom_length(Nombre, CantidadLetras),
    CantidadLetras > 7.
%============================================================================
%PUNTO 3
noSeCruzaron(Persona1, Persona2) :-
    destino(Persona1, _),     % generador
    destino(Persona2, _),     % generador
    Persona1 \= Persona2,     % que no sea la misma persona
    not((destino(Persona1, LugarComun), destino(Persona2, LugarComun))). % no tienen ningun destino en comun 
%Osea no existe un LugarComun que sea destino de ambas personas

/*  Ejemplos de consultas:
?- noSeCruzaron(dodain, nico).
true.
consultas existenciales:
?- noSeCruzaron(dodain, Persona).
Persona = nico ; Persona = vale ; false.
*/
%============================================================================
%PUNTO 4
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuensia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(calafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona):-
    destino(Persona, _), %generador
    forall(destino(Persona, Lugar), %para todos los lugares a los que va la persona
        (costoDeVida(Lugar, Costo), Costo < 160)). %debe cumplirse que el costo de vida sea menor a 160

%============================================================================
%PUNTO 5
/*nQueremos conocer todas las formas de armar el itinerario de un viaje para una persona sin importar el recorrido. Para eso todos los destinos tienen que aparecer en la solución (no pueden quedar destinos sin visitar).

Por ejemplo, para Alf las opciones son
[bariloche, sanMartin, elBolson]
[bariloche, elBolson, sanMartin]
[sanMartin, bariloche, elBolson]
[sanMartin, elBolson, bariloche]
[elBolson, bariloche, sanMartin]
[elBolson, sanMartin, bariloche]

(claramente no es lo mismo ir primero a El Bolsón y después a Bariloche que primero a Bariloche y luego a El Bolsón, pero el itinerario tiene que incluir los 3 destinos a los que quiere ir Alf).

*/

/*combinacion([], []).
combinacion([Primero | Resto]), [Primero | CombinacionResto]) :-
    combinacion(Resto, CombinacionResto).
combinacion([_ | Resto], CombinacionResto) :-
    combinacion(Resto, CombinacionResto).

NO corresponde, es combinacion   A, B, C  --> [], [A], [B], [A, B]*/


/*      ?- itinerario(alf, Itinerario).
            Itinerario = [bariloche, elBolson, sanMartin] ;
            Itinerario = [sanMartin, bariloche, elBolson] ;
            Itinerario = [sanMartin, elBolson, bariloche] ;
            Itinerario = [elBolson, bariloche, sanMartin] ;
            Itinerario = [elBolson, sanMartin, bariloche].

*/
itinerario(Persona, Itinerario) :-
    findall(Lugar, destino(Persona, Lugar), Destinos), % obtengo todos los destinos de la persona
    Destinos \= [],                                    % me aseguro que la persona tenga destinos
    permutacion(Destinos, Itinerario).    % genero todas las permutaciones de los destinos
%Ahora dames todas las permutaciones de la lista de destinos (osea lo que me va a devolver en Itinerario)

permutacion([], []).

permutacion(ListaOriginal, [Elemento | ListaPermutada]) :-
    sacar(Elemento, ListaOriginal, ListaRestante),
    permutacion(ListaRestante, ListaPermutada).

sacar(Elemento, [Elemento | Resto], Resto).
sacar(Elemento, [Cabeza | Resto], [Cabeza | RestoSinElemento]) :-
    sacar(Elemento, Resto, RestoSinElemento).