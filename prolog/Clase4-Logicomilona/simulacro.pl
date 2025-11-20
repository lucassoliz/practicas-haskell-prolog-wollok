% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellingtom, 125, [lomo, hojaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainillas, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato)
elabora(guille, empanadaDeCarneFrita).
elabora(guille, empanadaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parrilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef)
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).

% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).

% italiano(CantidadDePastas)
% oriental(Pais)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)

% 1.

esCrack(Chef) :-
    cocinaEn(UnRestaurante, Chef),
    cocinaEn(OtroRestaurante, Chef),
    UnRestaurante \= OtroRestaurante.


esCrack(Chef) :-
    elabora(Chef, padThai).

% 2.

% El código comentado es lo que hice y estaba mal
%
%esOtaku(Chef) :-
%    forall(cocinaEn(Restaurante, Chef), tieneEstilo(Restaurante, oriental(japon))).

esOtaku(Chef) :-
    % para generar el Chef
    cocinaEn(_, Chef),
    forall(cocinaEn(Restaurante, Chef), tieneEstilo(Restaurante, oriental(japon))).

% 3.

%esTop(Plato) :-
%    % Chef
%    elabora(Chef, Plato),
%    esCrack(Chef).

esTop(Plato) :-
    elabora(_, Plato),
    forall(elabora(Chef, Plato), esCrack(Chef)).

% 4

esDificil(Plato) :-
    receta(Plato, Duracion, _),
    Duracion > 120.

esDificil(Plato) :-
    receta(Plato, _, Ingredientes),
    member(trufa, Ingredientes).

esDificil(souffleDeQueso).

% 5

%seMereceLaMichelin(Restaurante) :-
%    cocinaEn(Restaurante, Chef),
%    esCrack(Chef),
%    tieneEstiloMichelinero(Restaurante).
%
%%%% esMichelinero
%tieneEstiloMichelinero(Restaurante) :-
%    tieneEstilo(Restaurante, oriental(tailandia)).
%
%tieneEstiloMichelinero(Restaurante) :-
%    tieneEstilo(Restaurante, bodegon(palermo, _)).
%
%tieneEstiloMichelinero(Restaurante) :-
%    tieneEstilo(Restaurante, italiano(CantidadDePastas)),
%    CantidadDePastas > 5.
%
%tieneEstiloMichelinero(Restaurante) :-
%    tieneEstilo(Restaurante, mexicano(VariedadDeAjies)),
%    member(habanero, VariedadDeAjies),
%    member(rocoto, VariedadDeAjies).

seMereceLaMichelin(Restaurante) :-
    cocinaEn(Restaurante, Chef),
    esCrack(Chef),
    tieneEstilo(Restaurante, Estilo),
    esMichelinero(Estilo).

esMichelinero(oriental(tailandia)).
esMichelinero(bodegon(palermo, _)).

esMichelinero(italiano(CantidadDePastas)) :-
    CantidadDePastas > 5.

esMichelinero(mexicano(VariedadDeAjies)) :-
    member(habanero, VariedadDeAjies),
    member(rocoto, VariedadDeAjies).

% 6

%tieneMayorRepertorio(RestauranteMayor, RestauranteMenor) :-
%    cocinaEn(RestauranteMayor, ChefMayor),
%    cocinaEn(RestauranteMenor, ChefMenor),
%    cantidadDePlatos(ChefMayor, CantidadMayor),
%    cantidadDePlatos(ChefMenor, CantidadMenor),
%    CantidadMayor > CantidadMenor.

%cantidadDePlatos(Chef, Cantidad) :-
%    findall(Plato, elabora(Chef, Plato), Platos),
%    length(Platos, Cantidad).

tieneMayorRepertorio(RestauranteUno, RestauranteDos) :-
    cantidadDePlatos(RestauranteUno, CantidadUno),
    cantidadDePlatos(RestauranteDos, CantidadDos),
    CantidadUno > CantidadDos.

cantidadDePlatos(Restaurante, Cantidad) :-
    cocinaEn(Restaurante, Chef),
    findall(Plato, elabora(Chef, Plato), Platos),
    length(Platos, Cantidad).

%%%% Otra forma válida:
%
%
%cantidadDePlatos(Restaurante, Cantidad) :-
%    cocinaEn(Restaurante, Chef),
%    cantidadDePlatosQueConoce(Chef, Cantidad).
%
%cantidadDePlatosQueConoce(Chef, Cantidad) :-
%    findall(Plato, elabora(Chef, Plato), Platos),
%    length(Platos, Cantidad).

% 7

%calificacionGastronomica(Restaurante, Calificacion) :-
%    cocinaEn(Restaurante, Chef),
%    cantidadDePlatos(Chef, Cantidad),
%    Calificacion is 5 * Cantidad.

calificacionGastronomica(Restaurante, Calificacion) :-
    cantidadDePlatos(Restaurante, Cantidad),
    % ¿valen las dos formas? ni idea
    %Calificacion is 5 * Cantidad.
    Calificacion is Cantidad * 5.
