¡Vacaciones!

¡Ah! ¡Qué lindo es estar de vacaciones!
Bueno, mientras viajamos mentalmente, nos pidieron modelar e implementar los siguientes requerimientos utilizando los conceptos del paradigma de objetos.

Punto 1: Lugares (3 puntos)

Existen diferentes tipos de lugares:
- ciudades: tienen una cierta cantidad de habitantes, atracciones turísticas (ej: "Obelisco", "Cabildo", "Rosedal", "Caminito") y sabemos la cantidad de decibeles promedio que tiene.
- pueblos: nos interesa la extensión en km², cuándo se fundó y en qué provincia se ubica.
- balnearios: son una categoría especial, conocemos los metros de playa promedio que tienen, si el mar es peligroso y si tiene peatonal.

Queremos saber qué lugares son divertidos. Para todos los lugares, esto se da si tiene una cantidad par de letras. Además, para las ciudades, si tienen más de 3 atracciones turísticas y más de 100.000 habitantes. En el caso de los pueblos, debemos considerar además si se fundaron antes de 1800 o si son del Litoral ("Entre Ríos", "Corrientes" o "Misiones"). Y en el caso de los balnearios habrá que considerar si tiene más de 300 metros de playa y si el mar es peligroso.

Punto 2: Personas (4 puntos)

Las personas tienen preferencias para irse de vacaciones:
- algunos quieren tranquilidad, entonces el lugar al que se van debe ser tranquilo: para una ciudad esto significa que tenga menos de 20 decibeles, para un pueblo que esté en la provincia de La Pampa y para un balneario que no tenga peatonal
- otros quieren diversión, así que el lugar al que se van debe ser divertido
- están los que quieren irse a lugares raros: son aquellos cuyo nombre tiene más de 10 letras (por ejemplo "Saldungaray")
- y por último aquellos que combinan varios criterios (con que alguno de los criterios acepte entonces decide ir a ese lugar)

Nos interesa que una persona pueda cambiar su preferencia en forma simple, así como agregar nuevas preferencias a futuro.

Queremos saber si una persona se iría de vacaciones a un lugar en base a su preferencia.

Punto 3: Tour (4 puntos)

Queremos establecer el siguiente flujo para un tour:
- Inicialmente definimos una fecha de salida, la cantidad de personas requerida, una lista de lugares a recorrer y el monto a pagar por persona
- Luego agregamos a una persona, para lo cual
  o el monto a pagar debe ser adecuado para la persona: cada persona define un presupuesto máximo para irse de vacaciones
  o todos los lugares deben ser adecuados para la persona, según lo definido en el punto anterior
  o en caso contrario la persona no puede incorporarse al tour
- cuando llegamos a la cantidad de personas requerida, el tour se confirma y no se permite incorporar más gente, a menos de que alguna persona se quiera bajar (ud. debe implementar la forma de lograr ésto)

Punto 4: Reportes (3 puntos)

Queremos saber:
- Qué tours están pendientes de confirmación: son los que tienen menos cantidad de personas anotadas de las que el tour requiere.
- Cuál es el total de los tours que salen este año, considerando el monto por persona * la cantidad de personas.

Se considerará explícitamente la delegación y la implementación de soluciones declarativas.

NOTA:
13,25 - 14 => 10,
12,25 - <13,25 => 9,
11,50 - < 12,25 => 8,
10,50 - < 11,50 => 7,
9 - < 10,50 => 6,
8 - 9 Revisión,
5 - < 8 => 4,
< 5 => 2.