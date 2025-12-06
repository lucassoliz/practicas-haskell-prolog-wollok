El Torneo de Magos
Para un importante evento de magia, nos pidieron un sistema para llevar el control de los enfrentamientos mágicos en un reino. El software, por supuesto, debía estar listo para ayer.
___

# A. Enfrentamientos Mágicos

Los magos participan en enfrentamientos donde intentan vencer a sus oponentes usando sus habilidades mágicas.

El poder total de un mago se calcula como la sumatoria del poder que aportan los objetos mágicos que tenga equipados (varitas, túnicas y amuletos, por ahora) multiplicada por su poder innato (un índice de 1 a 10).

- La mayoría de los objetos mágicos aportan un valor base de poder y:
    
  - Las varitas aportan un 50% extra de ese poder si el nombre del mago tiene una cantidad par de letras, en caso contrario aporta el poder base.
   - Las túnicas comunes suman 2 unidades de poder por cada unidad de resistencia mágica que tiene el usuario.
  - Las túnicas épicas suman 2 unidades de poder por cada unidad de resistencia mágica que posee su usuario más 10 puntos fijos.
- Los amuletos, a diferencia del resto, no tienen un valor base, siempre aportan 200 unidades.
 - Y está la ojota, que es única e irrepetible. la ojota mágica aporta 10 unidades de poder por cada letra que tiene el nombre del mago

Cuando un mago desafía a otro, si lo vence, le roba una cierta cantidad de puntos de energía mágica, que almacena en su reserva personal. Si no lo vence, no pasa nada. Otro valor importante es la resistencia mágica que tiene un mago. Sin embargo, no todos los magos son igual de vulnerables.:

- Los magos aprendices sólo son vencidos si su resistencia mágica es menor que el poder total del atacante. Pierden la mitad de sus puntos de energía mágica actuales.
- Los magos veteranos no son vencidos fácilmente. Sólo ceden puntos si el poder total del atacante es al menos 1.5 veces su resistencia mágica. En ese caso, pierden un cuarto de sus puntos de energía mágica.
- Los magos inmortales nunca son vencidos.

Estas características dependen de la categoría que el mago tenga actualmente, la cual puede cambiar a lo largo del tiempo.

Por lo tanto se pide:

1. Calcular el poder total de un mago.
2. Hacer que un mago desafíe a otro, transfiriendo puntos de energía mágica si lo vence.
___

# B. Gremios de Magos

Los magos se organizan en gremios, que potencian su poder en conjunto. Sabemos que:

- El poder total de un gremio es la sumatoria de los poderes totales de sus miembros.
- La reserva de energía mágica del gremio es la sumatoria de las reservas individuales de sus miembros.
- Al igual que los magos individuales, los gremios pueden desafiar a otros magos o gremios. Sin embargo, los puntos de energía mágica obtenidos van a la reserva del líder del gremio. Para vencer a un gremio, se requiere que el poder total del atacante sea mayor a la resistencia mágica total del gremio más la de su líder (que suma doble, en definitiva, porque es parte de la resistencia total).
- El líder del gremio es el miembro con mayor poder total.

1. Dado un conjunto de magos, crear un gremio. Un gremio debe tener al menos dos miembros, por lo que la creación debe fallar si no se cumple esta restricción.
2. Hacer que un gremio desafíe a otro mago o gremio, transfiriendo puntos de energía mágica si lo vence.
3. Nos informan que ahora los gremios pueden estar compuestos por magos y otros gremios. El líder de un gremio sigue siendo el miembro más poderoso, pero si este es a su vez un gremio, el líder de este último es también el líder del primero. Si es necesario realizar algún cambio para soportar este requerimiento, hacerlo. De lo contrario, explicar por qué es posible.

1 Tener en cuenta: El método initialize() se ejecuta en el momento de la instanciación de una clase, aunque también se puede asignar la responsabilidad de crear el objeto a otra entidad.