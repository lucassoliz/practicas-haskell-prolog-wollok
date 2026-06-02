/*
codos(color).
canios(color, longitud).
canilla(color, ancho, tipo).
*/

%1
precio([], 0).

precio(codo(_), 5).
precio(canio(_, Longitud), Precio):- Precio is Longitud * 3.
precio(canilla(_, _, "triangular"), 20).
precio(canilla(_, Ancho, _), 12):- Ancho < 5. 
precio(canilla(_, Ancho, _), 15):- Ancho >= 5.

precio([Pieza | Resto], Precio):-
    precio(Pieza, PrecioPieza),
    precio(Resto, PrecioResto),
    Precio is PrecioResto + PrecioPieza.

%2
color(codo(Color), Color).
color(canio(Color, _), Color).
color(canilla(Color, _, _), Color).
color(extremo(Color, _), Color).

puedoEnchufar(P1, P2):-
    color(P1, Color),
    color(P2, Color),
    confirmarExtremos(P1, P2).

puedoEnchufar(P1, P2):-
    color(P1, azul),
    color(P2, rojo),
    confirmarExtremos(P1, P2).

puedoEnchufar(P1, P2):-
    color(P1, rojo),
    color(P2, negro),
    confirmarExtremos(P1, P2).

%3
puedoEnchufar(Canieria, Pieza):-
    last(Canieria, Ultimo),
    puedoEnchufar(Ultimo, Pieza).

puedoEnchufar(Pieza, [Primero | _]):- puedoEnchufar(Pieza, Primero).

%4
canieriaBienArmada([_]).

canieriaBienArmada([Pieza | Piezas]):-
    puedoEnchufar(Pieza, Piezas),
    canieriaBienArmada(Piezas).

%5
confirmarExtremos(P1, P2):-
    P1 \= extremo(_, derecho),
    P2 \= extremo(_, izquierdo).

%6 Ya lo cumple puedo enchufar.

%7
canieriasLegales(Piezas, Canieria):-
    permutation(Piezas, Canieria),
    canieriaBienArmada(Canieria). 