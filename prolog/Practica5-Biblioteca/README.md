# Parcial 5 - Paradigma Lógico: La Biblioteca Lógica


![prolog_resto_banner](https://thfvnext.bing.com/th/id/OIP.mYubwsYDBZyamdcogOlhegHaEK?r=0&cb=thfvnext&rs=1&pid=ImgDetMain&o=7&rm=3)

## Enunciado

### **La Biblioteca Lógica**

En la ciudad, la biblioteca central se ha convertido en el centro de los fanáticos de la lectura y los eventos culturales. Para su correcto funcionamiento, debemos modelar distintos aspectos y relaciones lógicas de la biblioteca.

---

### **Punto 1: Libros y Lectores (2 puntos)**

En la biblioteca hay diferentes tipos de libros y lectores. Cada libro tiene un título, autor, género (novela, ciencia ficción, ensayo, poesía, etc.), y año de publicación.

Los lectores tienen nombre, edad, y preferencia de géneros literarios.

Modelar los siguientes hechos:
- Ana (35 años, prefiere novela y poesía) leyó “Cien años de soledad” (novela, Gabriel García Márquez, 1967).
- Bruno (20 años, prefiere ciencia ficción) leyó “Fundación” (ciencia ficción, Isaac Asimov, 1951).
- Carla (42 años, prefiere ensayo y novela) leyó “Sapiens” (ensayo, Yuval Noah Harari, 2011) y “Cien años de soledad”.
- Damián (28 años, prefiere poesía) leyó “Veinte poemas de amor” (poesía, Pablo Neruda, 1924).
- El libro “El Principito” (novela, Antoine de Saint-Exupéry, 1943) fue leído por Ana y por Bruno.

Justificar si algún concepto teórico interviene en este diseño.

---

### **Punto 2: Recomendaciones Lógicas (2 puntos)**

Queremos saber qué libros se recomiendan a cada lector. Se recomienda un libro si:
- El género del libro está entre las preferencias del lector.
- El lector aún no ha leído ese libro.

Ejemplo: a Bruno se le recomienda “Sapiens” si le gusta el ensayo (y no lo leyó), pero no “Fundación” porque ya lo leyó.

El predicado debe ser inversible.

---

### **Punto 3: Préstamos y Devoluciones (2 puntos)**

En la biblioteca se registran los préstamos y devoluciones de los libros. Cada préstamo tiene fecha de inicio y fecha de devolución (si ya fue devuelto). Un lector puede tener varios préstamos activos.

Modelar estos hechos:
- Ana prestó “Sapiens” el 1/7/2025, aún no lo devolvió.
- Bruno prestó “El Principito” el 5/6/2025 y lo devolvió el 25/6/2025.
- Carla prestó “Cien años de soledad” el 12/8/2025, aún no lo devolvió.
- Damián prestó “Veinte poemas de amor” el 20/7/2025 y lo devolvió el 28/7/2025.

Definir un predicado para saber qué lectores tienen préstamos activos (no devueltos) y cuál es su libro pendiente. El predicado debe ser inversible.

---

### **Punto 4: Eventos y Participación (2 puntos)**

La biblioteca organiza eventos literarios. Cada evento tiene una temática y fecha. Los lectores pueden participar si cumplen al menos uno de estos requisitos:
- Han leído algún libro del autor principal del evento.
- Su género preferido coincide con la temática del evento.

Modelar estos hechos:
- Evento “Noche de García Márquez”, temática novela, 14/9/2025 (autor principal: Gabriel García Márquez).
- Evento “Encuentro de Poesía”, temática poesía, 22/9/2025 (autor principal: Pablo Neruda).
- Evento “Ciencia Ficción en la Biblioteca”, temática ciencia ficción, 30/9/2025 (autor principal: Isaac Asimov).

Ejemplo: Ana puede participar en “Noche de García Márquez” porque leyó “Cien años de soledad” (autor principal) y le gusta la novela.

El predicado debe ser inversible.

---

### **Punto 5: Empleados y Turnos (2 puntos)**

La biblioteca cuenta con empleados que atienden en distintos turnos y días. Cada empleado tiene nombre y rango horario (día y horas).

Modelar estos hechos:
- Laura atiende lunes y miércoles de 8 a 14.
- Pedro atiende martes y jueves de 12 a 18.
- Sofía atiende viernes de 10 a 20.
- Tomás atiende sábados y domingos de 14 a 20.

Definir un predicado para consultar quién atiende en un día y hora dada, y para saber si algún empleado está atendiendo solo en ese horario (“forever alone”). El predicado debe ser inversible.

---

## Sistema de Puntuación

La nota del parcial se asigna sobre 10 puntos y se interpreta de la siguiente manera:

| Nota | Desempeño           | Resultado        |
|------|---------------------|------------------|
| 10   | Excelente           | Promociona       |
| 9    | Muy bueno           | Promociona       |
| 8    | Bueno               | Aprueba          |
| 7    | Suficiente          | Aprueba          |
| 6    | Mínimo aceptable    | Aprueba          |
| 5    | Revisión            | Debe revisar     |
| <5   | Insuficiente        | No aprueba       |

**Reglas:**
- Con **6** o más la materia se aprueba.
- Con **9** o más, se promociona directamente.
- Menos de **6**, el parcial se considera desaprobado.

---

## Nota

La estructura, criterios de evaluación y el uso del paradigma lógico son similares a los anteriores parciales.

---