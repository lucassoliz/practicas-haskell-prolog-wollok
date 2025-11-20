# Clases de PdeP (Paradigma Lógico) - 30/06/2025 y 07/07/2025

Acá están mis apuntes de estas clases, y el código de ejemplo que mis profes
usaron para explicar los temas de la teoría de Lógico.

* ```clase12.pl```: Mis apuntes de la clase (el código funciona y tiene abundantes
  comentarios sobre la teoría :D)
* ```clase03.pl```: Resolución hecha por los profesores

Además, dejo ```quien_ayuda_al_rasta.pl```, un ejercicio práctico que dejaron
de tarea (pero nunca corrigieron >:V) (o sea, puede ser que lo haya hecho mal).

## Consignas (las que pude encontrar)

### Libros (clase teórica/práctica)

estaBuena/1 nos dice cuando una obra está buena.  
Esto sucede cuando:  
* Es una novela policial y tiene menos de 12 capítulos.
* Es una novela de terror.
* Los libros con más de 10 cuentos siempre son buenos.
* Es una obra científica de fisicaCuantica.
* Es un best seller y el precio por página es menor a $50.

cantidadDePaginas/2 relaciona a una obra con su cantidad de páginas:
* las novelas tienen 20 páginas por capítulo;  
* los libros de cuentos 5 páginas por cuento;  
* las obras científicas tienen siempre 1000 páginas;  
* de los best sellers ya sabemos su cantidad de páginas.  

Queremos saber el puntaje de un autor,  
% este se calcula como `3 * cantidad de obras best seller que escribió.  
% Recordemos que ya tenemos un predicado esBestSeller  

se incorpora un nuevo tipo de obra: fantastica(ElementosMágicos)  
queremos ver si la obra de tipo fantástica es copada. Esto ocurre cuando uno de sus elementos es un rubi.  
por ejemplo agregamos a nuestra base de conocimientos: esDeTipo(sandman, fantastica([yelmo, bolsaDeArena, rubi])).  

### ¿Quién Ayuda al Rasta?

###### [Hechos, reglas, predicados, generación, not]

![El Rasta](rasta.jpg)

Armar un programa Prolog que resuelva el siguiente problema lógico:

* Quien ayuda a otra persona es porque la quiere y no tiene menos suerte que
  ella. Además, quien ayuda está en el aula.
* Rasta, Polito y Santi son los únicos que están en el aula.
* Santi quiere a todos los que están en el aula, siempre que no los quiera el
  Rasta.
* Rasta quiere a todos los que están en el aula salvo a Polito.
* Quien está en el aula y no es querido por Polito, tiene menos suerte que el
  Rasta.
* Polito quiere a las mismas personas que quiere el Rasta.

a. El programa debe resolver el problema de quién ayuda al Rasta. (Pero debe
poder permitir saber en general quién ayuda a quién).

b. Dejar en un comentario en el código la consulta utilizada y la respuesta
obtenida.

a. Agregar los mínimos hechos y reglas necesarios para poder consultar:
- Si existe alguien que quiera a Milhouse.
- A quién quiere Santi.
- El nombre de quien quiera a Rasta.
- Todas las personas que se quieren.
- Si es cierto que Polito quiere a alguien.

b. Dejar en un comentario en el código las consultas utilizadas para conseguir
lo anterior, junto con las respuestas obtenidas.

## Links

* [Código de los profes (consignas incluidas)](https://github.com/pdep-lunes/pdep-clases-2023/blob/main/Logico/Clase03/clase03.pl)
* [Clase 2 (Bitácora)](https://pdep-lunes.github.io/bitacora/2025/logico/clase-13/)
* [Clase 3 (Bitácora)](https://pdep-lunes.github.io/bitacora/2025/logico/clase-14/)
* [¿Quién ayuda al Rasta?](https://docs.google.com/document/d/1JVjGLws_uPKNGgB5XuSC32IsScqSt4lHwiP_VrUwyog/edit#heading=h.oit40igazgjk)
