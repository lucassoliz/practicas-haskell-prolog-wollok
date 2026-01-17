% La solución va acá. Éxitos!

%=======================PUNTO 1===================================
cocinero(ana).
cocinero(bruno).
cocinero(carla).
cocinero(diego).
cocinero(jorge).
% Como Emma no participa, cocinero(emma) vincular un False.
% Y por el principio de universo cerrado, lo que no existe es false, por lo que si cocinero(emma) no existe en nuestra base de conocimientos, es False.

cocina(italiana).
cocina(japonesa).
cocina(argentina).

cocinaEn(ana, italiana).
cocinaEn(bruno, japonesa).
cocinaEn(carla, italiana).
cocinaEn(carla, argentina).
cocinaEn(diego, italiana).
cocinaEn(jorge, argentina).

tecnica(corteACuchillo).
tecnica(mezcla).
tecnica(marinado).
tecnica(horneado).
tecnica(fermentacion).
tecnica(manejoDeParrilla).


domina(ana, corteACuchillo).
domina(ana, mezcla).
domina(ana, marinado).
domina(ana, horneado).
domina(bruno, corteACuchillo).
domina(bruno, mezcla).
domina(bruno, fermentacion).
domina(carla, corteACuchillo).
domina(carla, manejoDeParrilla).
domina(diego, fermentacion).
domina(diego, corteACuchillo).
domina(diego, manejoDeParrilla).
domina(jorge, corteACuchillo).
domina(jorge, manejoDeParrilla).
domina(jorge, horneado).

%=======================PUNTO 2===================================
cocineroExperto(Cocinero):-
	cocinero(Cocinero),
	domina(Cocinero, corteACuchillo),
	domina(Cocinero, mezcla),
	condicionParticularCocineroExperto(Cocinero).

condicionParticularCocineroExperto(Cocinero):-
	domina(Cocinero, fermentacion).
condicionParticularCocineroExperto(Cocinero):-
	cocinaEn(Cocinero, italiana).

%=======================PUNTO 3===================================
% 3. (Integrante 1) cocinaPopular:- que se satisface para un tipo de cocina si más de un cocinero la elige.
cocinaPopular(Cocina):-
	cocina(Cocina),
	cocinaEn(UnCocinero, Cocina),
	cocinaEn(OtroCocinero, Cocina),
	UnCocinero \= OtroCocinero.

%=======================PUNTO 4===================================
%4. (Integrante 2)
tecnicaUniversal(Tecnica):-
	tecnica(Tecnica),
	forall(cocinero(Cocinero),
		domina(Cocinero, Tecnica)).

%=======================PUNTO 5===================================
% 5. (Integrante 3) cocinaDestacada: para toda tecnica debe haber al menos un cocinero de esa cocina que la domine.
cocinaDestacada(Cocina):-
	cocina(Cocina),
	forall(tecnica(Tecnica),
		(cocinaEn(Cocinero, Cocina),
			domina(Cocinero, Tecnica))).

%=======================PUNTO 6===================================
% parilla(animal).
% ensalada(es apta veganos, dificultad).
% pasta(calorias).
% sushi(numero piezas, incluye salsa de soja).
% ramen(diametro).

prepara(ana, pasta(400)).
prepara(ana, ensalada(si, 1)).
prepara(ana, ensalada(no, 2)).
prepara(bruno, sushi(8, si)).
prepara(bruno, ramen(20)).
prepara(bruno, ensalada(si, 1)).
prepara(carla, pasta(350)).
prepara(carla, parrilla(cerdo)).
prepara(carla, ensalada(no, 3)).
prepara(jorge, parrilla(cerdo)).
prepara(jorge, parrilla(res)).

% Diego no prepara platos => por principio de universo cerrado, todo lo que escape a mi base de conocimiento es falso.

%=======================PUNTO 7===================================
% 7. (Integrante 3)
complejidad(parrilla(res), 90).
complejidad(parrilla(cerdo), 80).
complejidad(ensalada(no, 1), 50).
complejidad(ensalada(no, 2), 65).
complejidad(ensalada(no, 3), 70).
complejidad(ensalada(si, Nivel), Nivel*40).
complejidad(sushi(Piezas, _), Piezas*10).
complejidad(ramen(Diametro), Diametro).
complejidad(pasta(Calorias), Calorias).

mejorPlato(Cocinero, MejorPlato):-
	cocinero(Cocinero),
	prepara(Cocinero, MejorPlato),
	complejidad(MejorPlato, Valor),
	forall((prepara(Cocinero, Plato),
			Plato \= MejorPlato),
		(complejidad(Plato, Valor2),
			Valor >= Valor2)).

%=======================PUNTO 8===================================

/*gana(parrilla(_), pasta(_)).
gana(pasta(_), sushi(_, _)).
gana(sushi(_, _), ensalada(_, _)).


platoGana(X, Y) :-
	gana(X, Y).% caso base: gana directo
platoGana(X, Y)  :- gana(X, Z),
	gana(Z, Y).

platoGana(Plato, OtroPlato) :-
	mismoTipo(Plato, OtroPlato),
	complejidad(Plato, ComplejidadPlato),
	complejidad(OtroPlato, ComplejidadOtroPlato),
	ComplejidadPlato > ComplejidadOtroPlato.

mismoTipo(parrilla(_), parrilla(_)).
mismoTipo(pasta(_), pasta(_)).
mismoTipo(sushi(_, _), sushi(_, _)).
mismoTipo(ramen(_), ramen(_)).
mismoTipo(ensalada(_, _), ensalada(_, _)). */


% 8. (Integrante 2)
jerarquiaTipo(parrilla(_), 5).
jerarquiaTipo(pasta(_), 4).
jerarquiaTipo(sushi(_, _), 3).
jerarquiaTipo(ensalada(_, _), 2).
jerarquiaTipo(ramen(_), 1).

% segun en su jerarquia
platoGana(PlatoGanador, PlatoPerdedor) :-
	prepara(_, PlatoGanador),
	prepara(_, PlatoPerdedor),
	jerarquiaTipo(PlatoGanador, JerarquiaGanador),
	jerarquiaTipo(PlatoPerdedor, JerarquiaPerdedor),
	JerarquiaGanador > JerarquiaPerdedor.

% segun en su complejidad
platoGana(PlatoGanador, PlatoPerdedor) :-
	prepara(_, PlatoGanador),
	prepara(_, PlatoPerdedor),
	jerarquiaTipo(PlatoGanador, Jerarquia),
	jerarquiaTipo(PlatoPerdedor, Jerarquia),
	complejidad(PlatoGanador, ComplejidadGanador),
	complejidad(PlatoPerdedor, ComplejidadPerdedor),
	ComplejidadGanador > ComplejidadPerdedor.


%=======================PUNTO 9=================================== (Integrante 1)
% atiendeVegetarianos se satisface para un cocinero si tiene más ensaladas vegetarianas que no vegetarianas.
atiendeVegetarianos(Cocinero):-
	cocinero(Cocinero),
	cuantasEnsaladas(Cocinero, si, CantidadVeganas),
	cuantasEnsaladas(Cocinero, no, CantidadNoVeganas),
	CantidadVeganas > CantidadNoVeganas.

cuantasEnsaladas(Cocinero, Criterio, CantidadEnsaladas):-
	findall(_,
		prepara(Cocinero,
			ensalada(Criterio, _)),
		Ensaladas),
	length(Ensaladas, CantidadEnsaladas).

/*atiendeVegetarianos(Cocinero) :-
	plato(Cocinero, _),
	aggregate_all(count, plato(Cocinero,
			ensalada(aptaParaVegetarianos, _)),
		EnsaladasVegetarianas),
	aggregate_all(count,
		plato(Cocinero,
			ensalada(not(aptaParaVegetarianos),
				_)),
		EnsaladasNoVegetarianas),
	EnsaladasVegetarianas > EnsaladasNoVegetarianas.
*/

%=======================PUNTO 10================================== (Integrante 1)
% Relaciona a un tipo de cocina y un cocinero con su lista de platos que puede ofrecerle. Tiene que evaluar todas las combinaciones posibles.
platoDeCocina(parrilla(_), argentina).
platoDeCocina(ensalada(_, _), argentina).
platoDeCocina(pasta(_), italiana).
platoDeCocina(sushi(_, _), japonesa).
platoDeCocina(ramen(_), japonesa).

platosPosibles(Cocinero, Cocina, CombinacionDePlatos):-
	cocinero(Cocinero),
	cocina(Cocina),
	platosDeCocina(Cocinero, Cocina, ListaDePlatos),
	generarUnaCombinacion(ListaDePlatos, CombinacionDePlatos).

platosDeCocina(Cocinero, Cocina, Platos) :-
	findall(Plato,
		(prepara(Cocinero, Plato),
			cocinaEn(Cocinero, Cocina)),
		Platos).

generarUnaCombinacion([], []).
generarUnaCombinacion([Primero|ListaRestante], [Primero|Combinacion]):-
	generarUnaCombinacion(ListaRestante, Combinacion).
generarUnaCombinacion([_|ListaRestante], Combinacion):-
	generarUnaCombinacion(ListaRestante, Combinacion).


%=======================PUNTO 11===================================
% 11. (Integrante 2)

platosACocinar(Cocinero, ComplejidadMaxima, PlatosElegidos) :-
	cocinero(Cocinero),
	findall(Plato,
		prepara(Cocinero, Plato),
		PlatosPosibles),
	generarUnaCombinacion(PlatosPosibles, PlatosElegidos),
	sumarComplejidades(PlatosElegidos, ComplejidadTotal),
	ComplejidadTotal =< ComplejidadMaxima.

sumarComplejidades([], 0).
sumarComplejidades([Plato|RestoPlatos], ComplejidadTotal) :-
	complejidad(Plato, ComplejidadPlato),
	sumarComplejidades(RestoPlatos, ComplejidadResto),
	ComplejidadTotal is ComplejidadPlato + ComplejidadResto.

/*sumarComplejidades([], 0).
sumarComplejidades([Plato|RestoPlatos], ComplejidadTotal+ComplejidadActual) :-
    complejidad(Plato, ComplejidadActual),
    sumarComplejidades(RestoPlatos, ComplejidadTotal).*/

%=======================PUNTO 12===================================
% 12. (Integrante 3) Armar una combinacion de cocineros que podrian participar de un concurso de una determinada cocina.

concurso(Cocina, CombinacionDeCocineros):-
	cocina(Cocina),
	findall(Cocinero,
		cocinaEn(Cocinero, Cocina),
		Cocineros),
	generarUnaCombinacion(Cocineros, CombinacionDeCocineros),
	CombinacionDeCocineros \= [].

%======================= TESTS ====================================
:- begin_tests(template).

%=======TEST PUNTO 2===============
test(es_cocinero_experto, set(Personas==[ana, bruno])):-
	cocineroExperto(Personas).
test(carla_no_es_cocinero_experto, [fail]):-
	cocineroExperto(carla).
test(diego_no_es_cocinero_experto, [fail]):-
	cocineroExperto(diego).
test(jorge_no_es_cocinero_experto, fail):-
	cocineroExperto(jorge).

%=======TEST PUNTO 3===============
test(cocinas_populares, set(Cocinas==[italiana, argentina])):-
	cocinaPopular(Cocinas).
test(italiana_es_popular, [nondet]):-
	cocinaPopular(italiana).
test(argentina_es_popular, [nondet]):-
	cocinaPopular(argentina).
test(japonesa_no_es_popular, [fail]):-
	cocinaPopular(japonesa).
%=======TEST PUNTO 4===============
test(tecnicas_universales, set(Tecnicas==[corteACuchillo])):-
	tecnicaUniversal(Tecnicas).
test(corteACuchillo_es_tecnica_universal, [nondet]):-
	tecnicaUniversal(corteACuchillo).
test(mezcla_no_es_tecnica_universal, [fail]):-
	tecnicaUniversal(mezcla).
test(fermentacion_no_es_tecnica_universal, [fail]):-
	tecnicaUniversal(fermentacion).

%=======TEST PUNTO 5===============
test(italiana_es_cocina_destacada, set(Cocina==[italiana])):-
	cocinaDestacada(Cocina).
test(argentina_no_es_cocina_destacada, [fail]):-
	cocinaDestacada(argentina).
test(japonesa_no__es_cocina_destacada, [fail]):-
	cocinaDestacada(japonesa).
%=======TEST PUNTO 7===============
test(mejor_plato_de_ana, [nondet]):-
	mejorPlato(ana,
		pasta(400)).
test(mejor_plato_de_jorge, [fail]):-
	mejorPlato(jorge,
		parrilla(cerdo)).

%=======TEST PUNTO 8===============
test(plato_gana_por_tipo, [nondet]):-
	platoGana(parrilla(res),
		pasta(400)).
test(plato_gana_por_complejidad, [nondet]):-
	platoGana(parrilla(res),
		parrilla(cerdo)).
test(ensalada_no_gana_a_pasta, [fail]):-
	platoGana(ensalada(si, 1),
		pasta(400)).
test(platos_que_ganan_a_sushi, set(Platos==[parrilla(cerdo), parrilla(res), pasta(350), pasta(400)])):-
	platoGana(Platos,
		sushi(8, si)).

%=======TEST PUNTO 9===============
test(atiende_vegetarianos, set(Cocineros==[bruno])):-
	atiendeVegetarianos(Cocineros).
test(bruno_atiende_vegetarianos):-
	atiendeVegetarianos(bruno).
test(ana_no_atiende_vegetarianos, [fail]) :-
	atiendeVegetarianos(ana).
test(carla_no_atiende_vegetarianos, [fail]) :-
	atiendeVegetarianos(carla).
test(diego_no_atiende_vegetarianos, [fail]) :-
	atiendeVegetarianos(diego).
test(jorge_no_atiende_vegetarianos, [fail]) :-
	atiendeVegetarianos(jorge).

%=======TEST PUNTO 10===============

test(platos_posibles_de_Diego_en_Italiana, set(PlatosPosibles==[[]])):-
	platosPosibles(diego, italiana, PlatosPosibles).
test(platos_posibles_de_Jorge_en_Argentina, set(PlatosPosibles==[[parrilla(cerdo), parrilla(res)], [parrilla(cerdo)], [parrilla(res)], []])):-
	platosPosibles(jorge, argentina, PlatosPosibles).
% test(platos_posibles_de_Ana_en_Italiana_son_8,
% set(PlatosPosibles == [[pasta(400), ensalada(si, 1), ensalada(no, 2)],
% [pasta(400), ensalada(si, 1)], [pasta(400), ensalada(no, 2)], [pasta(400)],
% [ensalada(si, 1), ensalada(no, 2)], [ensalada(si, 1)], [ensalada(no, 2)], []])):-
% platosPosibles(ana, italiana, PlatosPosibles),
% La consigna pide verificar que sean 8 combinaciones, no cuales son esas 8. De igual manera dejo comentado la manera de verificar las 8 combinaciones
test(platos_posibles_de_Ana_en_Italiana_son_8, true(CantindadCombinaciones==8)):-
	findall(UnaCombinacion,
		platosPosibles(ana, italiana, UnaCombinacion),
		PlatosPosibles),
	length(PlatosPosibles, CantindadCombinaciones).

%=======TEST PUNTO 11===============

test(platos_a_cocinar_ana_con_100, set(ListaDePlatos==[[ensalada(si, 1)], [ensalada(no, 2)], []])):-
	platosACocinar(ana, 100, ListaDePlatos).
test(platos_a_cocinar_ana_con_105, set(ListaDePlatos==[[ensalada(si, 1), ensalada(no, 2)], [ensalada(si, 1)], [ensalada(no, 2)], []])):-
	platosACocinar(ana, 105, ListaDePlatos).

%=======TEST PUNTO 12===============
test(ningun_concursante_en_japonesa, [fail]):-
	concurso(japonesa, []).
test(todos_los_concursantes_de_italiana, set(Concursantes==[[ana], [carla], [diego], [ana, carla], [ana, diego], [carla, diego], [ana, carla, diego]])):-
	concurso(italiana, Concursantes).

:- end_tests(template).