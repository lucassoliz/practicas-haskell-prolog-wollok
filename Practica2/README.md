# Parcial Funcional: HaskellChef

![haskellchef_banner](https://i.pinimg.com/736x/66/cc/44/66cc44de3e40debee86d205b7b22f060.jpg)

---

## Disclaimer

En este parcial se evaluarán los conceptos de **aplicación parcial, composición, reutilización, recursividad y orden superior** para el modelado del mismo. La ausencia de estos conceptos puede significar descuentos en la nota.

---

Vamos a modelar una aplicación de **concursos de cocina**. Registramos recetas participantes, de las cuales conocemos su nombre, el tiempo de cocción en minutos, la cantidad mínima de ingredientes obligatorios, una lista de comentarios de los jueces (“original”, “repetitiva”, “picante”, “gourmet”, etc.) y si la receta está en revisión o no (lo cual indica si puede ser presentada al jurado). Un coordinador puede marcar una receta como “en revisión” cuando detecta algún problema. Cada tanto, los chefs asesores asignan ajustes a la receta, que tienen una duración estimada en días y describen el trabajo a realizar.

---

## Punto 1: ¡Qué receta tan top! (2 puntos)

Queremos determinar cuán destacada es una receta usando un sistema de puntaje especial:

- Si la receta tiene un tiempo de cocción prolongado (más de 60 minutos), vale **90 puntos**.
- Si no es así, pero tiene menos de 2 ajustes pendientes, el puntaje es **7 puntos por cada letra del nombre** más **4 puntos por cada comentario**.
- En caso contrario, el puntaje es **5 veces la cantidad mínima de ingredientes requeridos**.

---

## Punto 2: Ajustes de chef (4 puntos)

Los chefs pueden aplicar diferentes tipos de ajustes a las recetas. Tras cada ajuste **siempre ocurren dos cosas**:

1. Se elimina el ajuste más reciente de la lista.
2. Se verifica si quedan ajustes pendientes. Si hay, la receta sigue en revisión; si no, puede presentarse al jurado.

**Tipos de ajustes:**

- **mejoraDeSabor:** Aumenta el tiempo de cocción en 10 minutos por cada especia añadida, sin poder superar los 60 minutos.
- **reduccionDeIngredientes:** Disminuye la cantidad mínima de ingredientes en 1 por cada ingrediente prescindible detectado y agrega el comentario “más simple”.
- **comentarioDePresentacion:** Deja únicamente los dos primeros comentarios, eliminando los demás.
- **ajusteBasico:** Incluye una mejoraDeSabor con 2 especias y una reduccionDeIngredientes con 2 ingredientes prescindibles.

---

## Punto 3: ¿Este menú está bien? (3 puntos)

- **Es un “plato bomba”:**  
  Una receta es `platoBomba` si alguno de los ajustes asignados le toma más de 3 días en realizarse.

- **Receta fuera de concurso…:**  
  Se descarta una receta si la suma de los días de los ajustes pendientes es al menos 6 días.

- **Masterchef no esistis:**  
  Un concurso “masterchefNoEsistis” cuando **todas las recetas con nombres largos** (más de 10 letras) no tienen ajustes pendientes.  
  **En este punto no se pueden usar funciones auxiliares ni recursividad, solo composición y aplicación parcial.**

---

## Punto 4: Ajustes peolas (2 puntos)

Una receta tiene **ajustes peolas** si después de cada ajuste queda mejor puntuada que antes, es decir, el puntaje mejora tras cada aplicación.  
**Este punto debe resolverse de manera recursiva.**

---

## Punto 5: Manos en la masa (2 puntos)

Modela un proceso que **aplique sucesivamente los ajustes pendientes sobre una receta**. Además, muestra un ejemplo de evaluación por consola para alguna de las actividades anteriores.  
**En este punto NO se puede usar recursividad.**

---

## Punto 6: ¡No doy más! (1 punto)

¿Qué pasa si una receta tiene una cantidad infinita de ajustes pendientes? ¿Se podría computar el resultado para la función anterior? ¿Qué sucedería en el punto 4 con una lista infinita de ajustes? Justifica tu respuesta usando conceptos de la materia.

---
