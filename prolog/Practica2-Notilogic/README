# Parcial 2 - Paradigma Lógico: Sistema de Noticias

![prolog_resto_banner](https://www.blogodisea.com/wp-content/uploads/2011/09/titulares-noticias-periodico-simpson-02.jpg)

## Enunciado

Se desea modelar un sistema de publicaciones de noticias en el ámbito deportivo, farandulero y político. Distintos autores publican artículos sobre personajes relevantes, cada uno con una cantidad de visitas. Existen reglas sobre cómo se publican, transforman y clasifican las noticias y los autores.

---

### **Punto 1: Modelado de Noticias y Transformaciones (2 puntos)**

Modelar los siguientes hechos:

- **Noticias originales**:  
  - Art Vandelay publicó una noticia con 25 visitas titulada "Nuevo título para Lloyd Braun", sobre el deportista Lloyd Braun (quien tiene 5 títulos).
  - Elaine Benes publicó una noticia con 16 visitas titulada "Primicia", sobre Jerry Seinfeld (farandula), en conflicto con Kenny Bania.
  - Elaine Benes también publicó una noticia de 150 visitas titulada "El dólar bajó! … de un arbolito", sobre Jerry Seinfeld (farandula), en conflicto con Newman.
  - Bob Sacamano publicó una noticia de 10 visitas titulada "No consigue ganar ni una carrera", sobre el deportista David Puddy (0 títulos).
  - Bob Sacamano publicó una noticia de 155 visitas titulada "Cosmo Kramer encabeza las elecciones", sobre el político Cosmo Kramer del partido "Los amigos del poder".

- **Noticias robadas y transformadas**:  
  - George Costanza roba las noticias de Bob Sacamano y Elaine Benes, obteniendo la misma cantidad de visitas, pero todas las noticias de farándula las transforma en noticias de política (el famoso involucrado como político del partido "Los amigos del poder").  
  - Las noticias robadas de farándula obtienen la mitad de las visitas de la original; las demás mantienen el mismo valor.
  - Ejemplo: George Costanza roba el artículo "Primicia" de Elaine Benes, lo transforma en noticia de política sobre Jerry Seinfeld y obtiene 8 visitas (la mitad de 16). Si roba "No consigue ganar ni una carrera", mantiene 10 visitas.

- Aplicar el principio de universo cerrado: todo lo que no se explicita es considerado falso.

---

### **Punto 2: Artículos Amarillistas (2 puntos)**

Definir cuándo un artículo es amarillista:

- Si su título es "Primicia".
- Si la persona involucrada está "complicada":
  - Deportistas con menos de tres títulos.
  - Personajes de farándula que tienen problemas con Jerry Seinfeld.
  - Todos los políticos.

---

### **Punto 3: Clasificación de Autores (2 puntos)**

Definir los siguientes conceptos sobre los autores:

**3.1 - Autor que no le importa nada:**  
Un autor no le importa nada si todas sus noticias muy visitadas (más de 15 visitas) son amarillistas.

**3.2 - Autor muy original:**  
Un autor es muy original si no existe otra noticia con el mismo título publicada por otro autor.

**3.3 - Autor con traspié:**  
Un autor tuvo un traspié si tiene al menos una noticia poco visitada (15 visitas o menos).

---

### **Punto 4: Edición Loca (2 puntos)**

Armar una "edición loca": un resumen de la semana con una combinación posible de artículos amarillistas, tal que el total de visitas de los artículos seleccionados no supere las 50 visitas. El predicado debe ser inversible (debe poder encontrar todas las combinaciones posibles).

---
