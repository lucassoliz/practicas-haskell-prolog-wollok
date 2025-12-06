# Academia de Cocina
Queremos modelar el comportamiento de los cocineros que estudian en una academia de cocina. Sabemos que los cocineros mejoran sus habilidades culinarias al preparar comidas a partir de las recetas que se enseñan en la academia.

De cada receta sabemos cuáles son los ingredientes que tiene y cuál es el nivel de dificultad de su preparación. Cada vez que un cocinero prepara exitosamente una comida, la misma se incorpora a sus preparaciones, a partir de las cuales podremos determinar la experiencia que tiene cada cocinero en todo momento.

Dependiendo de la experiencia que haya adquirido el cocinero al momento de preparar la receta indicada, será capaz de producir una comida de distinta calidad: pobre, normal o superior. Las comidas de más calidad aportan más experiencia, permitiendo que el cocinero mejore sus capacidades para preparar comidas más complejas a futuro.

En la academia se identificaron los siguientes niveles de aprendizaje que pueden tener los cocineros:
- Principiante: Sólo pueden preparar recetas que no sean difíciles (son difíciles si tienen dificultad de preparación mayor a 5 o con más de 10 ingredientes), que es lo que un cocinero de cualquier nivel puede hacer, y como mucho consiguen elaborar comidas de calidad normal. Todos los cocineros que ingresan a la academia lo hacen con este nivel.
- Experimentado: También pueden preparar recetas que sean similares a alguna que ya hayan preparado (por tener los mismos ingredientes o una dificultad de no más de un punto de diferencia). Dependiendo de la cantidad de experiencia que hayan adquirido son capaces de elaborar comidas de calidad normal o superior.
- Chef: Los cocineros de este nivel son similares a los de nivel experimentado, pero son capaces de preparar cualquier receta.

Se pide desarrollar la lógica necesaria para resolver los siguientes requerimientos aplicando las ideas del paradigma orientado a objetos, e indicar en forma de comentario cuál es el punto de entrada elegido para cada uno:

1. Saber cuánta experiencia adquirió un cocinero, que es la suma de experiencia que le aportan las comidas que preparó, teniendo en cuenta que esto depende de la receta y la calidad de la comida preparada.

La experiencia que aporta normalmente una comida preparada a partir de una receta equivale a la cantidad de ingredientes de la misma multiplicada por su nivel de dificultad, pero si la calidad de la comida es pobre o superior, la experiencia final puede diferir:
- Cuando la calidad de la comida es pobre, la experiencia que aporta es el mínimo entre lo que aporta la receta normalmente y un valor de experiencia máxima que es igual para todas las comidas con esta calidad, el cual la academia quiere poder ajustar fácilmente.
- Cuando la calidad de la comida es superior, aporta la experiencia correspondiente a la receta más un plus que se determina al momento de la preparación de esa comida.

Por ejemplo, si el cocinero sólo preparó una comida con calidad normal cuya receta tiene 3 ingredientes y dificultad 2, y otra comida con la misma receta pero calidad superior y un plus de 10 puntos, su experiencia debería ser 3* 2 + (3*2 + 10) => 22.

Si también hubiese preparado dos comidas con esa misma receta pero con calidad pobre, y se configura que como máximo las comidas pobres den 4 puntos de experiencia, la experiencia adquirida por el cocinero sería 3* 2 + (3* 2 + 10) + 4 + 4 = 30. Si luego se decidiera ajustar ese valor máximo a 7 puntos, su experiencia sería 3* 2 + (3* 2 + 10) + 3* 2 + 3*2 => 34

2. Saber si un cocinero superó un nivel de aprendizaje. Sabemos que un cocinero supera el nivel principiante si su experiencia es mayor a 100, y que supera el nivel experimentado si preparó más de 5 comidas difíciles. El nivel de chef es el más avanzado, por ende no hay forma de superarlo.

3. Hacer que un cocinero prepare una comida a partir de una receta, asegurando que esa receta sea acorde a lo que su nivel le permite preparar como se explicó anteriormente. En caso de que la preparación sea exitosa, la comida resultante debe incorporarse a las preparaciones del cocinero y el mismo es evaluado para pasar al siguiente nivel de aprendizaje si supera su nivel actual.

Respecto a la comida que es capaz de preparar dependiendo del nivel que tenga, sabemos que:
- La calidad de la comida preparada por un cocinero principiante es normal si la receta tiene menos de 4 ingredientes, de lo contrario es pobre.

- Un cocinero experimentado que logró perfeccionar la receta a preparar, produce una comida de calidad superior con un plus equivalente a la cantidad de comidas con recetas similares que haya preparado / 10. Si no logró perfeccionar la receta a preparar, la comida le sale normal. Lo mismo aplica para los chefs.

Para perfeccionar una receta el cocinero debe haber adquirido suficiente experiencia preparando comidas con recetas similares a ella. La cantidad de experiencia requerida para perfeccionar la receta es el triple de la experiencia que aporta (independientemente de cómo le saldría al cocinero).

4. Agregar al modelo a las recetas gourmet, que aportan el doble de experiencia que el resto de las recetas y siempre son difíciles.

5. Hacer que la academia de cocina entrene a todos sus estudiantes. La academia tiene un recetario con las recetas disponibles para que sus estudiantes entrenen. Al entrenar, el cocinero prepara la receta que más experiencia aporta de aquellas que puede preparar (más allá de cuál sea la calidad con la que es capaz de prepararla).