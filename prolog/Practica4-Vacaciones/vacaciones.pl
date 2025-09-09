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
