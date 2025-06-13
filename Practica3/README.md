# Parcial Funcional: HaskellRestó

![haskell_resto_banner](https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80)

---

## Disclaimer

En este parcial se evaluarán los conceptos de **aplicación parcial, composición, reutilización, recursividad y orden superior** para el modelado del mismo. La ausencia de estos conceptos puede significar descuentos en la nota.

---

Vamos a modelar el sistema de gestión de **mesas y pedidos de un restaurante**.  
El sistema debe permitir a los mozos abrir y cerrar mesas, tomar pedidos con comentarios especiales, aplicar cupones, y gestionar facturación y promociones.

---

## Punto 1: ¡Mesa lista, chef! (2 puntos)

Modelá el proceso de **apertura y cierre de una mesa**:

- Al abrir la mesa, se registra la cantidad de comensales.
- Al cerrar la mesa, el sistema calcula la cantidad de cubiertos a cobrar.
- Si se presenta un cupón, debe validarse su código y fecha de vencimiento. Si es válido, se registra el tipo de beneficio (descuento, bonificación, regalo, etc.) para aplicar en la facturación.

---

## Punto 2: ¡Comanda explosiva! (4 puntos)

Implementá la lógica para que un mozo pueda:

1. Seleccionar una mesa abierta. Si no lo está, el sistema rechaza la operación con el mensaje “¡Abrí la mesa primero!”.
2. Ver el menú y agregar uno o más platos, indicando cantidad y comentarios del cliente (ej: “sin salsa”, “muy rápido”).
3. Confirmar o cancelar el pedido. Si confirma, la comanda se registra y se envía a cocina; si cancela, la mesa se cierra.

---

## Punto 3: ¡Promomanía y platos legendarios! (3 puntos)

- **Cupón consagrado:**  
  Un cupón es consagrado si tiene un código aceptado y la fecha de vencimiento es posterior a la fecha actual.

- **Plato legendario:**  
  Un plato es legendario si fue pedido más de 5 veces en el último mes.

- **Restó de élite:**  
  El restaurante es de élite si todos los platos con nombre de más de 7 letras fueron pedidos al menos una vez en el último mes.  
  _En este punto no pueden usarse funciones auxiliares ni recursividad, solo composición y aplicación parcial_.

---

## Punto 4: ¡Descuento en cadena! (2 puntos)

Un pedido es **descuento en cadena** si cada vez que se le aplica un beneficio (cupón o promoción), el total a pagar desciende respecto al beneficio anterior.  
_Resolvés exclusivamente con recursividad._

---

## Punto 5: El pasaplatos funcional (2 puntos)

Modelá una función que **procese todos los pedidos pendientes de una mesa**, aplicando los beneficios válidos en orden y devolviendo el monto final a cobrar.  
_No uses recursividad; utilizá composición y orden superior._

---

## Punto 6: Mesa sin fondo (1 punto)

¿Qué sucede si una mesa tiene una cantidad infinita de pedidos o beneficios pendientes?  
¿Sería posible calcular el total a pagar?  
Justificá tu respuesta usando conceptos de evaluación perezosa y recursividad.

---
