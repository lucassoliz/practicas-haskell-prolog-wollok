% BASE DE CONOCIMIENTOS

escribio(elsaBornemann, socorro).
escribio(neilGaiman, sandman).
escribio(alanMoore, watchmen).
escribio(brianAzarello, cienBalas).
escribio(warrenEllis, planetary).
escribio(frankMiller, elCaballeroOscuroRegresa).
escribio(frankMiller, batmanAnioUno).
escribio(neilGaiman, americanGods).
escribio(neilGaiman, buenosPresagios).
escribio(terryPratchett, buenosPresagios).
escribio(isaacAsimov, fundacion).
escribio(isaacAsimov, yoRobot).
escribio(isaacAsimov, elFinDeLaEternidad).
escribio(isaacAsimov, laBusquedaDeLosElementos).
escribio(joseHernandez, martinFierro).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(stephenKing, carrie).
escribio(stephenKing, elJuegoDeGerald).
escribio(julioCortazar, rayuela).
escribio(jorgeLuisBorges, ficciones).
escribio(jorgeLuisBorges, elAleph).
escribio(horacioQuiroga, cuentosDeLaSelva).
escribio(horacioQuiroga, cuentosDeLocuraAmorYMuerte).

% Si es cierto que alguien escribió determinada obra.
% Quién/es escribieron una obra.
% Qué obra/s escribió cierta persona.
% Si es cierto que cierta persona escribió alguna obra, sin importar cuál.
% Si es cierto que cierta obra existe.

% Queremos agregar la información de cuáles de las obras son cómics. 
%Por ejemplo, quiero preguntar si sandman es un cómic.

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

% Queremos saber si alguien es artista del noveno arte: 
% lo es cuando escribió algún cómic.

/* esArtistaDelNovenoArte(neilGaiman).
esArtistaDelNovenoArte(alanMoore). */

% r <= p ^ q
esArtistaDelNovenoArte(Artista):-
    esComic(Obra),
    escribio(Artista,Obra).

  % Variable: libre.
  % Variable: ligada o unificada.

/*
1. Queremos saber si determinada obra es un best-seller, es decir, si tiene más de 50.000 copias vendidas.
2. Queremos saber si es reincidente un/a autor/a, que es cuando escribió más de una obra.
3.  Queremos saber si conviene contratar a un/a artista, que es cuando es reincidente o escribió un bestseller.
*/

% copiasVendidas(Obra,Cantidad)
copiasVendidas(socorro, 10000).
copiasVendidas(sandman, 20000).
copiasVendidas(watchmen, 30000).
copiasVendidas(cienBalas, 40000).
copiasVendidas(planetary, 50000).
copiasVendidas(elCaballeroOscuroRegresa, 60000).
copiasVendidas(batmanAnioUno, 70000).
copiasVendidas(americanGods, 80000).
copiasVendidas(buenosPresagios, 90000).
copiasVendidas(buenosPresagios, 10000).
copiasVendidas(fundacion, 20000).
copiasVendidas(yoRobot, 30000).
copiasVendidas(elFinDeLaEternidad, 30000).
copiasVendidas(laBusquedaDeLosElementos, 40000).
copiasVendidas(martinFierro, 50000).
copiasVendidas(it, 60000).
copiasVendidas(it, 70000).
copiasVendidas(misery, 70000).
copiasVendidas(carrie, 80000).
copiasVendidas(elJuegoDeGerald, 90000).
copiasVendidas(rayuela, 10000).
copiasVendidas(ficciones, 20000).
copiasVendidas(elAleph, 30000).
copiasVendidas(cuentosDeLaSelva, 40000).
copiasVendidas(cuentosDeLocuraAmorYMuerte, 50000).

esBestSeller(Obra) :-
    copiasVendidas(Obra, Cantidad),
    Cantidad > 50000.

esReincidente(Autore) :-
    escribio(Autore, UnaObra),
    escribio(Autore, OtraObra),
    UnaObra \= OtraObra.

convieneContratar(Artista) :-
    esReincidente(Artista).

convieneContratar(Artista) :-
    escribio(Artista, Obra),
    esBestSeller(Obra).

%% Acá termina lo de la profe Ro :D %%

%% Para el parcial y los TP todo tiene que ser inversible

leGustaA(gus, Obra) :- escribio(isaacAsimov, Obra).
leGustaA(gus, sandman).

% Para que no rompa xD
%nacionalidad(yo, argentina).

nacionalidad(elsaBornemann, argentina).
nacionalidad(jorgeLuisBorges, argentina).
nacionalidad(joseHernandez, argentina).
nacionalidad(julioCortazar, argentina).
nacionalidad(horacioQuiroga, uruguay).

% REPITE LÓGICA
%esRioplatense(Obra) :-
%    escribio(Autor, Obra),
%    nacionalidad(Autor, uruguay).
%
%esRioplatense(Obra) :-
%    escribio(Autor, Obra),
%    nacionalidad(Autor, argentina).

esRioplatense(Obra) :-
    escribio(Autor, Obra),
    autorEsRioplatense(Autor).

% RESUELVE LA REPETICIÓN DE LÓGICA
autorEsRioplatense(Autor) :-
    nacionalidad(Autor, argentina).
autorEsRioplatense(Autor) :-
    nacionalidad(Autor, uruguay).


esLibro(Obra) :-
    % escribio permite la inversibilidad de esLibro
    escribio(_, Obra),
    % not es un predicado de orden superior
    % ALTERNATIVA: \+ esComic(Obra).
    not(esComic(Obra)).

esComiquero(Artista):-
    % forall no es inversible, pero podemos hacer inversible a esComiquero con
    % escribio, que cumple la función de generar Artista
    escribio(Artista, _),

    forall(escribio(Artista, Obra), esComic(Obra)).

% forall( (), ).
% forall NO ES INVERSIBLE

%% FUNCTORES %%
% 
% Son individuos complejos / compuestos:
% novela(terror, 11)
% novela(fantasia, 0)

esDeGenero(it, novela(terror, 11)).
esDeGenero(buenosPresagios, novela(fantasia, 0)).

% novela(Tipo, Capitulos).
% libroDeCuentos(Cuentos).
% libroCientifico(Disciplina).
% bestSeller(Precio, Páginas).

% [CHAT GENERAL DISCORD]
%
% estaBuena/1 nos dice cuando una obra está buena.
% Esto sucede cuando:
% * Es una novela policial y tiene menos de 12 capítulos.
% * Es una novela de terror.
% * Los libros con más de 10 cuentos siempre son buenos.
% * Es una obra científica de fisicaCuantica.
% * Es un best seller y el precio por página es menor a $50.
%

% REPITE LOGICA
%estaBuena(Obra) :-
%    esDeGenero(Obra, novela(policial, Capitulos)),
%    Capitulos < 12.
%
%estaBuena(Obra) :-
%    esDeGenero(Obra, novela(terror, _)).
%
%estaBuena(Obra) :-
%    esDeGenero(Obra, libroDeCuentos(Cuentos)),
%    Cuentos > 10.
%
%estaBuena(Obra) :-
%    esDeGenero(Obra, libroCientifico(fisicaCuantica)).


% NO REPITE LÓGICA :D
esMacanudo(novela(terror, _)).

esMacanudo(novela(policial, Capitulos)) :-
    Capitulos < 12.

esMacanudo(libroCientifico(fisicaCuantica)).

esMacanudo(libroDeCuentos(policial, Cuentos)) :-
    Cuentos < 10.

esMacanudo(bestSeller(Precio, Paginas)) :-
    % Parece que es necesario el paréntesis
    (Precio / Paginas) < 50.

% Polimorfismo (ejercicio práctico con el mismo entra en el parcial)

estaBuena(Obra) :-
    esDeGenero(Obra, Genero),
    esMacanudo(Genero).

% CLASE 13

% Novelas: 20 por cap
% 5 por cuento
% 1000
% sabemos

cantidadDePaginas(Obra, Paginas) :-
    esDeGenero(Obra, Genero),
    % No puede ser de aridad 1, porque hay que relacionar el género con la
    % cantidad de páginas. En Prolog no existe un "return resultado;" :_(
    paginasPorGenero(Genero, Paginas).

paginasPorGenero(novela(_, Capitulos), Paginas) :-
    Paginas is 20 * Capitulos.

paginasPorGenero(libroDeCuentos(Cuentos), Paginas) :-
    Paginas is 5 * Cuentos.

paginasPorGenero(libroCientifico(_), 1000).

paginasPorGenero(bestSeller(_, Paginas), Paginas).

% :troll: esto venía acá

escribioBestSeller(Autor, Obra) :-
    escribio(Autor, Obra),
    esBestSeller(Obra).

% Puntaje de un autor = 3 * cantidad best sellers

puntajeDelAutor(Autor, Puntaje) :-
    cantidadDeBestSeller(Autor, Cantidad),
    Puntaje is 3 * Cantidad.

% listaDeObras(Autor, Lista) :-

bestSellerDeAutor(Autor, BestSellers) :-
    % Restringe el dominio a un Autor particular
    escribio(Autor, _),
    findall(Obra, escribioBestSeller(Autor, Obra), Lista).
    % ALT (podría ser más declarativo):
    % findall(Obra, (escribio(Autor, Obra), esBestSeller(Obra)), Lista).

cantidadDeBestSeller(Autor, Cantidad) :-
    bestSellerDeAutor(Autor, BestSellers),
    length(bestSellers, Cantidad).

    % listaDeObras(Autor, Lista),
    % findall(Autor, esBestSeller, Lista)

    %%escribio(Autor, Obra),
    %%length([esDeGenero(Autor, Obra)], Cantidad),
    %%Puntaje is 3 * Cantidad.

esDeGenero(sandman, fantastico([yelmo, bolsaDeArena, rubi]).
esDeGenero(percyJackson, fantastico([lapicera, zapatillas, mp3]).

esMacanudo(fantastico(Lista)) :-
    member(mp3, Lista).

% Lo escribieron como copiasVendidas, pero ya existía xD
% copiasVendidas(Obra,Cantidad)
% Lo cambiaron a copiasVendidasPorAutor
%listaCopiasVendidas(Autor, Copias) :-

listaCopiasVendidas(Autor, Lista) :-
    % Para que sea inversible
    escribio(Autor, _),
    findall(Copias, (escribio(Autor, Obra), copiasVendidas(Obra, Copias)), Lista).

    % ???
    %escribio(Autor, Obra),
    %findall(CantidadCopias, copiasVendidas(Obra, CantidadCopias), Copias).
    
    % findall(1, copiasVendidas(Obra, CantidadCopias), Lista).
    % => Lista es [1, 1, 1, 1, ..., n]


promedioCopiasVendidas(Autor, Promedio) :-
    %escribio(Autor, Obra),
    %findAll(Obra, copiasVendidas(Obra, Cantidad), CopiasPorObra),
    listaCopiasVendidas(Autor, Copias),
    sumlist(Copias, TotalDeCopiasVendidas),
    length(Copias, TotalDeObrasDelAutor),
    Promedio is TotalDeCopiasVendidas / TotalDeObrasDelAutor.

% sumList : sum.list :O
