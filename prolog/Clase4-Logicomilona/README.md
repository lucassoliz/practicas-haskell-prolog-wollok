# Logicomilona (Simulacro de Parcial Lógico) - 04/08/2025

* [Enunciado](https://docs.google.com/document/d/1JbGxnZa6CWHImsjE9SWcx6Ki9vBqQlKRfVX29DQAe9U/edit?usp=sharing)
* [Link Bitácora](https://pdep-lunes.github.io/bitacora/2025/logico/clase-15/)

## Transcripción: Logicomilona 🍧

¿Nos sumamos a la ola de influencers de comida? 😎 Pero no sólo es comer gratis
y hacer reseñas, sino investigar sobre los platos 🍝, chefs 👩‍🍳👨‍🍳  y
restaurantes 🍴.

Por eso, con todo lo que sabés de Prolog y del paradigma lógico, te pedimos que
nos ayudes a terminar logicomilona, una aplicación que nos va a permitir llegar
al estrellato influencer. 🤩

En nuestra base de conocimientos contamos las recetas de los platos, qué chef
los elabora y en qué restaurante cocina. Te mostramos una reducción de la misma
(Si tenés que agregar nuevas cláusulas para probar tu código podés hacerlo.
Estos hechos están seleccionados a modo demostrativo):

```
% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hojaldre, huevo, mostaza]).
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
```

También sabemos el estilo de cocina de cada restaurante:

```
% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).
```

Los posibles estilos tienen la siguiente forma:

```
% italiano(CantidadDePastas)
% oriental(País)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)
```

A partir de estos hechos, definí los siguientes predicados teniendo en cuenta
que deben ser totalmente inversibles.

```
1. 😎esCrack/1: un o una chef es crack si trabaja en por lo menos dos
   restaurantes o cocina pad thai.
2. 🍙esOtaku/1: un o una chef es otaku cuando solo trabaja en restaurantes de
   comida japonesa. (Y le tiene que gustar Naruto, pero eso no lo vamos a
   modelar).
3. 🔥esTop/1: un plato es top si sólo lo elaboran chefs cracks.
4. 🤯esDificil/1: un plato es difícil cuando tiene una duración de más de dos
   horas o tiene trufa como ingrediente o es un soufflé de queso.
5. ⭐seMereceLaMichelin/1: un restaurante se merece la estrella Michelin cuando
   tiene un o una chef crack y su estilo de cocina es michelinero. Esto sucede
   cuando es un restaurante:
    a) de comida oriental de Tailandia,  
    b) un bodegón de Palermo,  
    c) italiano de más de 5 pastas,  
    d) mexicano que cocine, por lo menos, con ají habanero y rocoto,  
    e) los de comida rápida nunca serán michelineros.  
6. 🗒️tieneMayorRepertorio/2: según dos restaurantes, se cumple cuando el
   primero tiene un o una chef que elabora más platos que el o la chef del
   segundo.
7. 👍calificacionGastronomica/2: la calificación de un restaurante es 5 veces
   la cantidad de platos que elabora el o la chef de este restaurante. 
```
