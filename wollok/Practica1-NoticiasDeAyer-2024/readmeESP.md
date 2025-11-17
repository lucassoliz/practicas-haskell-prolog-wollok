# Noticias de ayer, extra! extra!

Una importante red multimedios quiere modernizar su diario digital, para lo cual luego de un relevamiento surgieron los siguientes requerimientos que deben implementar en el paradigma de objetos.

![wollok_resto_banner](https://images.impresa.pt/sicnot/2021-09-23-SIMPSONS.jpg-95326601-2)
---

## Punto 1) Chocolate por la noticia (4 puntos)

Toda noticia o artículo tiene una fecha de publicación, la persona que lo publica, su grado de importancia medido en un número que va de 1 a 10, el título y el desarrollo de la noticia. Hay tres estilos de noticia o artículo:

- los artículos comunes pueden tener links a otras noticias
- hay noticias que son en realidad publicidad encubierta (lo que en la jerga periodística se conoce como “chivo”). Promocionan un producto y sabemos la plata que se paga para que la noticia se publique.
- los reportajes se hacen a alguien (ej: “María Becerra” o a “Los Auténticos Decadentes”)
- y por último tenemos a una cobertura, que también incluye una serie de noticias que están relacionadas.

Queremos saber si una noticia es copada: en general tiene que ser una noticia importante (su grado de importancia debe ser $\ge 8$), haberse publicado hace menos de 3 días y:

- para los artículos comunes tener al menos 2 links a otras noticias
- para los chivos, tiene que haberse pagado más de 2M
- los reportajes son copados si a quien entrevistan tienen una cantidad de letra impar (ej: “Los Auténticos Decadentes” tiene 25 letras, es un reportaje copado)
- y las coberturas son copadas si todas las noticias relacionadas son copadas

---

## Punto 2) El informe pelícano (3 puntos)

Como dijimos antes, las noticias o artículos son publicadas por periodistas, del cual conocemos su fecha de ingreso y sus preferencias:

- algunos quieren publicar noticias copadas
- otros quieren publicar noticias que sean sensacionalistas: esto implica que tengan la palabra “espectacular”, “increíble”, o “grandioso” en el título y en el caso de los reportajes deben ser también a “Dibu Martínez”
- están los vagos, que quieren publicar solo chivos o noticias cuyo desarrollo tenga menos de 100 palabras.
- y está José De Zer, quien disfruta de publicar noticias cuyo título comience con la letra “T”

---

## Punto 3) Primera plana (3 puntos)

Queremos publicar una noticia nueva, para lo cual:

- un periodista no puede publicar por día más de 2 noticias que no prefiere. Por ejemplo: si un periodista quiere publicar noticias copadas, solo puede publicar 2 noticias no copadas ese día.

una noticia bien escrita debe tener:
- un título que tenga 2 ó más palabras
- debe tener desarrollo

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y en caso de no cumplir alguna regla defina de qué manera debe responder.

---

## Punto 4) El cuarto poder (2 puntos)

Queremos poder determinar cuáles son los periodistas recientes que publicaron una noticia en la última semana. Los periodistas recientes ingresaron hace un año o menos al multimedio. Se considerará explícitamente la delegación y la implementación de soluciones declarativas.

---

## Nota final

| Puntuación | Nota |
| :--- | :--- |
| 11,50 a 12 | 10 |
| 10 a 11,50 | 9 |
| 9 a 10 | 8 |
| 8 a 9 | 7 |
| 7 a 8 | 6 |
| 6 a 7 | Revisión |
| < 6 | Desaprobado |