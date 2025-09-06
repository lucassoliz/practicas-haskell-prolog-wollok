%PUNTO 1
jockey(valdivieso, 155, 52).
jockey(leguisamon, 161, 49).
jockey(lezcano, 149, 50).
jockey(beratucci, 153, 55).
jockey(falero, 157, 52).

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

caballeriza(valdivieso, elTute).
caballeriza(falero, elTute).
caballeriza(lezcano, lasHormigas).
caballeriza(baratucci, elCharabon).
caballeriza(leguisamos, elCharavon).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoDeOro).
gano(matBoy, granPremioCriadores).

prefiere(botafogo, Jockey):-
    jockey(Jockey, _ , Peso), %dame el peso de este jockey ¿Pesa menos de 53?
    Peso < 52.
prefiere(botafogo, baratussi). %¿Es baratucci?

prefiere(oldMan,Jockey):-
    jockey(Jockey, _ , _), %para hacer preguntas existenciales sobre los jockeys 
    atom_length(Jockey, CantidadLetras), %cuenta las letras del nombre atom_length 
    CantidadLetras > 7. 

prefiere(energica, Jockey):-
    jockey(Jockey, _, _), %generador
    not(prefiere(botafogo, Jockey)).

prefiere(matBoy, Jockey):-
    jockey(Jockey, Altura, _),
    Altura > 170.

%por universo cerrado, no hace falta agregar un predicado de prefiere para yatasto

%=======================================================================================
%PUNTO 2
prefiereMasDeUnJockey(Caballo):-
    prefiere(Caballo, Jockey1),
    prefiere(Caballo, Jockey2),
    Jockey1 \= Jockey2.
%prefiereMasDeUnJockey(Caballo)
%?- Caballo = botafogo ; Caballo = oldMan ; Caballo = energica.
%=======================================================================================
%PUNTO 3
%Osea ingreso el caballo y la caballeriza, y me dice los callos que no prefieren a ningun jokcye de esa caballeriza
aborrece(Caballo, Caballeriza):-
    caballo(Caballo), %generador
    caballeriza(_, Caballeriza), %generador
    not((prefiere(Caballo, Jockey), caballeriza(Jockey, Caballeriza))). %no existe ningun jockey que le guste al caballo y que trabaje en esa caballeriza
%Lectura: dame los jockeys que le gustan al caballo,  y   que trabajan en esa caballeriza ese jockey
%Si no existe ninguno, entonces el caballo aborrece esa caballeriza

%=======================================================================================
%PUNTO 4
%Queremos saber quiénes son les jockeys "piolines", que son las personas preferidas por todos los caballos que ganaron un premio importante. El Gran Premio Nacional y el Gran Premio República son premios importantes.

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

ganoPremioImportante(Caballo):-
    caballo(Caballo), %generador para inversibilidad
    gano(Caballo, Premio), %dame todos los premios que gano el caballo
    premioImportante(Premio). %si alguno de esos premios es importante, entonces el caballo gano un premio importante
    
%como se debe de cumplir para todos ----> forall
%forall/2 con forall(generador, condicion)
esPiolin(Jockey):-
    jockey(Jockey,_ , _), %generador para inversibilidad
    forall(ganoPremioImportante(Caballo), prefiere(Caballo, Jockey)).
%generame todos los caballos que ganaron un premio importante
%para cada uno de esos caballos, debe cumplirse que le guste ese jockey
%=======================================================================================
%PUNTO 5

%TENEMOS que usar functor dentro del argumento de la regla
%para que Prolog sepa que tipo de apuesta es 
%La regla va a servir para saber si realmente gano la apuesta, pero para
%saber que tipo de apuesta es, tenemos que usar functor

%Le paso una lista de las posiciones finales de la carrera
%Dependiendo de la posicion, y de la apuesta, se va a definir si gano o no

salioPrimero(Caballo, [Caballo | _ ]).
salioSegundo(Caballo, [_ , Caballo | _ ]).

apuestaGanadora(ganador(Caballo), Resultados):-
    salioPrimero(Caballo, Resultados).
%hizo una apusta de tipo ganador con el caballo X, y X salio primero

apustaGanadora(segundo(Caballo), Resultados):-
    salioPrimero(Caballo, Resultados).
apuestaGanadora(segundo(Caballo), Resultados):-
    salioSegundo(Caballo, Resultados).
%hizo una apusta de tipo segundo con el caballo X, y X salio primero o segundo

apuestaGanadora(exacta(Caballo1, Caballo2), Resultados):-
    salioPrimero(Caballo1, Resultados),
    salioSegundo(Caballo2, Resultados),
    Caballo1 \= Caballo2. %igual no puede ser el mismo caballo porque no puede salir primero y segundo a la vez

apuestaGanadora(imperfecta(Caballo1, Caballo2), Resultados):-
    salioPrimero(Caballo1, Resultados),
    salioSegundo(Caballo2, Resultados).
apuestaGanadora(imperfecta(Caballo1, Caballo2), Resultados):-
    salioSegundo(Caballo1, Resultados),
    salioPrimero(Caballo2, Resultados).
%hizo una apuesta de tipo imperfecta con los caballos X e Y, y X e Y salieron primero y segundo en cualquier orden

%=======================================================================================
%PUNTO 6
crin(botafogo, tordo).
crin(oldMan, alazan).
crin(energica, ratonero).
crin(matBoy, palomino).
crin(yatasto, pinto).

color(tordo, negro).
color(alazan, marron).
color(ratonero, gris).
color(ratonero, negro).
color(palomino, marron).
color(palomino, blanco).
color(pinto, blanco).
color(pinto, marron).


%El comprador puede elegir que color de caballo comprar, para ello, le debe mostrar todos los caballos
%posibles que puede comprar de ese color
%entiendo que le entrega una lista de cabalos, y pregunta que de esa lista, que caballos son de ese color

comprarCaballo(Color, CaballosElegir):-
    findall(Caballo , %variable
        (  crin(Caballo, Crin) , color(Crin, Color) ),  %condiciones a cumplir
/*Lectura: Te pido color marron, dame el Crin del caballo marron,
dame los caballos de ese crin // si cambiamos el orden de las condiciones no afecta */
        CaballosDeEseColor),
          combinar(CaballosPosibles, Caballos), %opciones a elegir
  Caballos \= []. %POR LO MENOS UN CABALLO ----> NO VACIO



%tipico combinatoria
combinar([], []).
combinar([Caballo|CaballosPosibles], [Caballo|Caballos]):-combinar(CaballosPosibles, Caballos).
combinar([_|CaballosPosibles], Caballos):-combinar(CaballosPosibles, Caballos).

