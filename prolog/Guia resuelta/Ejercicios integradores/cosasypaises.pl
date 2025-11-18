tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).

habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).

capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

%1
destinoPosible(Persona, Ciudad):-
    nivelActual(Persona, Nivel),
    tarea(Nivel, buscar(_, Ciudad)).

idiomaUtil(Persona, Idioma):-
    destinoPosible(Persona, Ciudad),
    idioma(Ciudad, Idioma).

%2
excelenteCompaniero(P2, P1):-
    habla(P2, Idioma),
    idiomaUtil(P1, Idioma),
    P1 \= P2.

%3
estaVivo(arbol).
estaVivo(perro).
estaVivo(flor).

interesante(Nivel):-
    tarea(Nivel, buscar(Elemento, _)),
    estaVivo(Elemento).

interesante(Nivel):-
    destinoPosible(_, Ciudad),
    idioma(Ciudad, italiano).

interesante(Nivel):-
    nivelActual(_, Nivel),
    findall(Capital, (nivelActual(Persona, Nivel), capital(Persona, Capital)), Capitales),
    sum_list(Capitales, Total),
    Total > 1000.

%4
complicado(Persona):- not(idiomaUtil(Persona, Idioma)).

complicado(Persona):-
    nivelActual(Persona, Nivel),
    Nivel \= basico,
    capital(Persona, Capital),
    Capital < 1500.

complicado(Persona):-
    nivelActual(Persona, basico),
    capital(Persona, Capital),
    Capital < 500.

%5
homogeneo(Nivel):-
    nivelActual(_, Nivel),
    findall(Elemento, tarea(Nivel, buscar(Elemento, _)), Total),
    length(Total, CantidadTotal),
    list_to_set(Total, SinRepeticion),
    length(SinRepeticion, CantidadSinRepeticion),
    CantidadSinRepeticion \= CantidadTotal.

%6
poliglota(Persona):-
    nivelActual(Persona, _),
    findall(Idioma, habla(Persona, Idioma), Idiomas),
    length(Idiomas, Cantidad),
    Cantidad >= 3.