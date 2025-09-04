# Parcial 3 - Paradigma Lógico: El Kioskito

---
![prolog_resto_banner](https://th.bing.com/th/id/R.632aab350c938d507ee99fcd8f88c75b?rik=1MMekf9Yz5hWfQ&riu=http%3a%2f%2fvignette2.wikia.nocookie.net%2fsimpsons%2fimages%2fa%2faf%2fGirly_Edition_24.JPG%2frevision%2flatest%3fcb%3d20130723175034&ehk=O93LDUO%2fKYuoP5YJytWnW%2fEx%2fVffgJX6pzMsCCYWLsg%3d&risl=&pid=ImgRaw&r=0)

## Enunciado 2021

### **El Kioskito**

Son tiempos difíciles y además de dar clases, los profesores de Paradigmas abrimos un kioskito. Para poder atenderlo como se debe, establecimos un sistema de turnos donde cada persona se hace responsable. Por ejemplo:

- **dodain** atiende lunes, miércoles y viernes de 9 a 15.
- **lucas** atiende los martes de 10 a 20.
- **juanC** atiende los sábados y domingos de 18 a 22.
- **juanFdS** atiende los jueves de 10 a 20 y los viernes de 12 a 20.
- **leoC** atiende los lunes y los miércoles de 14 a 18.
- **martu** atiende los miércoles de 23 a 24.

Consideramos siempre la hora exacta, por ejemplo: 10, 14, 17. Está fuera del alcance del examen contemplar horarios como 10:15 ó 17:30.

---

### **Punto 1: Calentando motores (2 puntos)**

Definir la relación para asociar cada persona con el rango horario que cumple, e incorporar las siguientes cláusulas:

- **vale** atiende los mismos días y horarios que **dodain** y **juanC**.
- **nadie** hace el mismo horario que **leoC**.
- **maiu** está pensando si hace el horario de 0 a 8 los martes y miércoles.

En caso de no ser necesario hacer nada, explique qué concepto teórico está relacionado y justifique su respuesta.

---

### **Punto 2: Quién atiende el kiosko... (2 puntos)**

Definir un predicado que permita relacionar un día y hora con una persona, en la que dicha persona atiende el kiosko. Ejemplos:

- Si preguntamos quién atiende los lunes a las 14, son **dodain**, **leoC** y **vale**.
- Si preguntamos quién atiende los sábados a las 18, son **juanC** y **vale**.
- Si preguntamos si **juanFdS** atiende los jueves a las 11, nos debe decir que sí.
- Si preguntamos qué días a las 10 atiende **vale**, nos debe decir los lunes, miércoles y viernes.

El predicado debe ser inversible para relacionar personas y días.

---

### **Punto 3: Forever alone (2 puntos)**

Definir un predicado que permita saber si una persona en un día y horario determinado está atendiendo ella sola. Debe utilizar `not/1`, y debe ser inversible para relacionar personas.

Ejemplos:

- Si preguntamos quiénes están forever alone el martes a las 19, **lucas** es una respuesta posible.
- Si preguntamos quiénes están forever alone el jueves a las 10, **juanFdS** es una respuesta posible.
- Si preguntamos si **martu** está forever alone el miércoles a las 22, nos debe decir que no (martu hace un turno diferente).
- **martu** sí está forever alone el miércoles a las 23.
- El lunes a las 10 **dodain** no está forever alone, porque **vale** también está.

---

### **Punto 4: Posibilidades de atención (3 puntos / 1 punto)**

Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día. Ejemplo para el miércoles:

- nadie
- dodain solo
- dodain y leoC
- dodain, vale, martu y leoC
- vale y martu
- etc.

Queremos saber todas las posibilidades de atención de ese día. La única restricción es que la persona atienda ese día (no puede aparecer **lucas**, por ejemplo, porque no atiende el miércoles).

**Punto extra:** indique qué conceptos en conjunto permiten resolver este requerimiento, justificando su respuesta.

---

### **Punto 5: Ventas / Suertudas (4 puntos)**

En el kiosko tenemos por el momento tres ventas posibles:

- **Golosinas**: registramos el valor en plata.
- **Cigarrillos**: registramos todas las marcas de cigarrillos que se vendieron (ej: Marlboro y Particulares).
- **Bebidas**: registramos si son alcohólicas y la cantidad.

Agregar las siguientes cláusulas:

- **dodain** hizo las siguientes ventas el lunes 10 de agosto: golosinas por $1200, cigarrillos Jockey, golosinas por $50.
- **dodain** hizo las siguientes ventas el miércoles 12 de agosto: 8 bebidas alcohólicas, 1 bebida no-alcohólica, golosinas por $10.
- **martu** hizo las siguientes ventas el miércoles 12 de agosto: golosinas por $1000, cigarrillos Chesterfield, Colorado y Parisiennes.
- **lucas** hizo las siguientes ventas el martes 11 de agosto: golosinas por $600.
- **lucas** hizo las siguientes ventas el martes 18 de agosto: 2 bebidas no-alcohólicas y cigarrillos Derby.

Queremos saber si una persona vendedora es **suertuda**. Esto ocurre si para todos los días en los que vendió, la primera venta que hizo fue importante. Una venta es importante:

- En el caso de las golosinas, si supera los $100.
- En el caso de los cigarrillos, si tiene más de dos marcas.
- En el caso de las bebidas, si son alcohólicas o son más de 5.

El predicado debe ser inversible: **martu** y **dodain** son personas suertudas.

---

## Sistema de Puntuación

La nota del parcial se asigna sobre 14 puntos y se interpreta de la siguiente manera:

| Nota | Desempeño           | Resultado        |
|------|---------------------|------------------|
| 14   | Excelente           | Promociona       |
| 13,12| Muy bueno           | Promociona       |
| 11   | Bueno               | Aprueba          |
| 10   | Suficiente          | Aprueba          |
| 9,8  | Regular             | Aprueba          |
| 7    | Mínimo aceptable    | Aprueba          |
| 5-7  | Revisión            | Debe revisar     |
| <5   | Insuficiente        | No aprueba       |

**Reglas:**
- Con **7** o más la materia se aprueba.
- Con **12** o más, se promociona directamente.
- Menos de **7**, el parcial se considera desaprobado.

---