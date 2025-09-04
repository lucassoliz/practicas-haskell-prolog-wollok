# Parcial 4 - Paradigma Lógico: Vacaciones

![prolog_resto_banner](https://www.nacion.com/resizer/WUkLkPfxigc2GosUKQXfhmRGvIU=/1440x0/filters:format(jpg):quality(70)/cloudfront-us-east-1.images.arcpublishing.com/gruponacion/3437ZNOQZFDAVOQ2F3UAMSTTIU.jpeg)
---

## Enunciado

### **Vacaciones**

Llegó el momento de armar las valijas y emprender el hermoso viaje... ¡de programar en Lógico! Necesitamos modelar la información que se detalla a continuación.

---

### **Punto 1: El destino es así, lo sé... (2 puntos)**

- Dodain se va a Pehuenia, San Martín (de los Andes), Esquel, Sarmiento, Camarones y Playas Doradas.
- Alf se va a Bariloche, San Martín de los Andes y El Bolsón.
- Nico se va a Mar del Plata, como siempre.
- Vale se va para Calafate y El Bolsón.
- Martu se va donde vayan Nico y Alf.
- Juan no sabe si va a ir a Villa Gesell o a Federación.
- Carlos no se va a tomar vacaciones por ahora.

Definir los predicados correspondientes para modelar esta información y justificar las decisiones teóricas empleadas.

---

### **Punto 2: Vacaciones copadas (4 puntos)**

Se incorpora información sobre las **atracciones** de cada lugar. Las atracciones pueden ser:
- **Parque nacional**: nombre del parque.
- **Cerro**: nombre y altura.
- **Cuerpo de agua** (río, laguna, arroyo): se indica si se puede pescar y la temperatura promedio del agua.
- **Playa**: diferencia promedio entre marea baja y alta.
- **Excursión**: nombre.

**Ejemplos de modelado:**
- Esquel: parque nacional (Los Alerces) y excursiones (Trochita, Trevelin).
- Villa Pehuenia: cerro (Batea Mahuida, 2000 m) y cuerpos de agua (Moquehue, se puede pescar, 14°; Aluminé, se puede pescar, 19°).

**Vacaciones copadas:** Una persona tuvo vacaciones copadas si todos los lugares a visitar tienen al menos una atracción copada.
- Un cerro es copado si tiene más de 2000 metros.
- Un cuerpo de agua es copado si se puede pescar o la temperatura es mayor a 20°.
- Una playa es copada si la diferencia de mareas es menor a 5.
- Una excursión es copada si el nombre tiene más de 7 letras.
- Todo parque nacional es copado.

El predicado debe ser inversible.

---

### **Punto 3: Ni se me cruzó por la cabeza (2 puntos)**

Cuando dos personas distintas no coinciden en ningún destino, decimos que no se cruzaron. Ejemplos:
- Dodain no se cruzó con Nico ni con Vale (sí con Alf en San Martín de los Andes).
- Vale no se cruzó con Dodain ni con Nico (sí con Alf en El Bolsón).

El predicado debe ser completamente inversible.

---

### **Punto 4: Vacaciones gasoleras (2 puntos)**

Se incorpora el **costo de vida** de cada destino:

| Destino                  | Costo de vida |
|--------------------------|--------------|
| Sarmiento                | 100          |
| Esquel                   | 150          |
| Pehuenia                 | 180          |
| San Martín de los Andes  | 150          |
| Camarones                | 135          |
| Playas Doradas           | 170          |
| Bariloche                | 140          |
| El Calafate              | 240          |
| El Bolsón                | 145          |
| Mar del Plata            | 140          |

**Vacaciones gasoleras:** Una persona hizo vacaciones gasoleras si todos los destinos tienen un costo de vida menor a 160.

Ejemplo: Alf, Nico y Martu hicieron vacaciones gasoleras.

El predicado debe ser inversible.

---

### **Punto 5: Itinerarios posibles (3 puntos)**

Queremos conocer todas las formas de armar el itinerario de un viaje para una persona, sin importar el orden del recorrido. Para esto, todos los destinos deben aparecer en la solución (no pueden quedar destinos sin visitar).

**Ejemplo para Alf:**  
Opciones:
- [bariloche, sanMartin, elBolson]
- [bariloche, elBolson, sanMartin]
- [sanMartin, bariloche, elBolson]
- [sanMartin, elBolson, bariloche]
- [elBolson, bariloche, sanMartin]
- [elBolson, sanMartin, bariloche]

El predicado debe ser inversible y debe devolver todas las combinaciones posibles.

---

## Sistema de Puntuación

La nota del parcial se asigna sobre 13 puntos y se interpreta de la siguiente manera:

| Nota                  | Resultado        |
|-----------------------|------------------|
| 12,50 - 13            | 10 (Promociona)  |
| 11,50 - <12,50        | 9 (Promociona)   |
| 10 - <11,50           | 8 (Aprueba)      |
| 9 - <10               | 7 (Aprueba)      |
| 8 - <9                | 6 (Aprueba)      |
| 7 - <8                | Revisión         |
| 4 - <7                | 4 (No aprueba)   |
| menos de 4            | 2 (No aprueba)   |

**Reglas:**
- Con **6** o más la materia se aprueba.
- Con **9** o más, se promociona directamente.
- Menos de **6**, el parcial se considera desaprobado.

---