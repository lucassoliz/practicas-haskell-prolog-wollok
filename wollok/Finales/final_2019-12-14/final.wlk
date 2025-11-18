// Interfaz Tela: factorTiempo()
//class Tela {
//    const tiempo
//    const factorTiempo
//    const tiempoExtra
//
//    method tiempo()
//}
//
//class Lycra inherits Tela {
//    method factorTiempo() = 1.2
//}
//class Denim {
//    method factorTiempo() = 1.2
//}

//class Falda {
//    method tiempo() = 120
//}
//
//class Blusa {
//    var cantBotones
//    method tiempo() = 200 + 5*cantBotones
//}
//
//class Short {
//    var tiempo
//    method tiempo() = tiempo
//    // sin setter porque rompería el encapsulamiento (¿no?)
//}

//class ShortLycra inherits Short {
//    override method tiempo() = super() * 1.2
//}

//class Tela inherits {
//
//
//}

//class Tela {
//    method tiempoPrenda()
//    method tiempo()
//}
// Interfaz Tela

//class Modal {
//    method tiempoPrenda()
//    method tiempo() = 1.2 * tiempoPrenda()
//}

// Interfaz Tela: tiempo(tiempoBase)
object Lycra {
    method tiempo(tiempoBase) = tiempoBase * 1.2
}
object Denim {
    method tiempo(tiempoBase) = tiempoBase + 25
}
object Modal {
    method tiempo(tiempoBase) = tiempoBase
}


// Interfaz Prenda: tiempo()
class Falda {
    const tela
    method tiempo() = tela.tiempo(120)
}

class Blusa {
    const tela
    var cantBotones
    method tiempo() = tela.tiempo(200 + 5*cantBotones)
}

class Short {
    const tela
    var tiempoNecesario
    method tiempo() = tela.tiempo(tiempoNecesario)
}

// Pedido puede ser un WKO, salvo que en un futuro agreguemos más pedidos de la misma clase
object pedido {
    // Se tratan polimórficamente las faldas, blusas y shorts
    const prendas = []

    // sum({ x => x.msj() }) es más declarativo que forEach({ x => total += x.msj() })
    method tiempoDeConfeccion() = prendas.sum({ prenda => prenda.tiempo() })
}

// 1. a. VERDADERO. Porque la clase Pedido está tratando a faldas, blusas y
// shorts como objetos de distinta interfaz, pero éstos tienen la misma porque
// se le envían los mismos mensajes.

// 1. b. FALSO. Se repite el valor 120 que se puede abstraer. (?)

// 1. c. FALSO. Para las telas es necesaria la composición dentro de Prenda
// porque usar la herencia nos limitaría a una tela por prenda (class Prenda inherits Tela, pero qué tela?)

// 1. d. VERDADERO. No se oculta el detalle algorítmico de los demás objetos en
// ningún objeto. Esto también implica (??) que se está rompiendo el
// encapsulamiento.
