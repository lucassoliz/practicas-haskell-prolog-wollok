// A.1. No es una clase abstracta porque no contiene métodos sin implementacíon

// A.2. La clase no es necesaria. Para garantizar el polimorfismo, alcanza con
// una Interfaz. La clase es redundante por ese motivo

// A.3. No se gana ni pierde declaratividad porque no hay detalle algorítmico
// que se exponga u oculte.

// B.1.
//
// * Cada vez que querramos agregar un Ataque en la solución 2, tendremos que
//   crear 2 clases: una para el ataque simple, y otra para el ataque potenciado;
//   lo cual no es necesario en la solución 1 porque la posibilidad de potenciar
//   el ataque se hereda de la superclase.
//
// * [????????????????] En la solución 1 no se aprovecha el polimorfismo con
//   los métodos potencia() y potenciaConKaioken(). Se rompe el encapsulamiento
//   porque siempre se puede acceder al método potencia() de cualquier objeto de
//   clase Ataque,  (???????????????????)
//
// * En la solución 2 no se puede efectuar un ataque no potenciado cuando se
// tiene un kaioken, entonces no se cumplen los requerimientos.

// * En la solución 1 hay una comparación innecesaria con null. El no tener
// kaioken se puede reemplazar por un nivelKaioken igual a 1

// * En la solución 2 se repite lógica en el método potencia()

class Ataque {
    var nivelKaioken = 1

    method potenciaConKaioken() = nivelKaioken * self.potencia()
    method potencia()
    method energia()
}

class Golpe inherits Ataque {
    const fuerzaGolpe
    override method potencia() = 7*fuerzaGolpe
    override method energia() = 9*fuerzaGolpe + 5
}

class Patada inherits Ataque {
    override method potencia() = 30
    override method energia() = 20
}
class KameHameHa inherits Ataque {
    override method potencia() = 200
    override method energia() = 200
}
/* ... */
