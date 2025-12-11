/*
PUNTO 1:
    Pregunta ----laSAben ---> Jugador  
        implica que una pregunta tiene una lista de jugadores que la saben, lo cual NO TIENE SENTIDO
        mas que nada porque:
            Un jugador decide si sabe la prehuna o no
        Por lo tanto, la relacion deberia ser al reves
        Una pregunta NO DEBE tener memoria de quien la sabe, no tiene sentido

   Solucion: Es mejor que la pregunta no conozca a los jugadores, sino que el jugador
    sepa que preguntas sabe. De esta manera la pregunta no tiene que tener una referencia
    a los jugadores, por lo tanto la flecha deberia ir al reves o simplemente no existir ahi (y modelarse tal vez en un historial)


Relaciones redundantes que rompe el POLIMORFISMO
    Mira, fijate que Pregunta tiene una flecha (referencia) hacia Jugador(CLASE PADRE), perooo
    tambien saca referencias especificas a JugadorHabitue y JugadorTryHard (CLASES HIJAS)
    Por que esta mal???
    Porque si Pregunta ya conoce a Jugador, automaticamente conoce a cualquier
    subclase de Jugador gracias al POLIMORFISMO. Entonces no es necesario que Pregunta
    conozca a las subclases de Jugador, ya que eso rompe el polimorfismo.

*/


//PUNTO 2

class Pregunta {
    const property categoria
    const property texto
    const property puntos
    const property dificultad  

    method esFacil() = dificultad == "facil"
    method esMedia() = dificultad == "media"
    method esDificil() = dificultad == "dificil"

    method esCategoria(cat) = categoria == cat

    // Necesario por JugadorTryHard
    var fueAcertada = false
    method marcarAcertada() {
        fueAcertada = true
    }
}

// puntos -= pregunta.puntos() restaba cuando acertaba, ahora se modifico y suma y si no la sabe y constea ahora resta bien
class Jugador {
    var puntos = 0
    var categoriaPreferida

    method jugarRonda(unaRonda) {
        unaRonda.preguntas().forEach({ pregunta =>
            self.contestar(pregunta)
        })
    }

    method contestar(pregunta) {
        if(self.sabe(pregunta)) {
            puntos += pregunta.puntos()
        } else { //La sintaxis estaba mal y mal ubicado
            puntos -= pregunta.puntos()
        }
    }

    method sabe(pregunta) {
        pregunta.esFacil() or  
        (pregunta.esCategoria(categoriaPreferida) and pregunta.esMedia())
    }
}

class JugadorHabitué inherits Jugador {
    var categoriaPreferida2 //falto de agregar este atributo

    override method sabe(pregunta) {
        pregunta.esFacil() or
        pregunta.esDificil() or //falto agregar esta linea
        (pregunta.esMedia() and 
            (pregunta.esCategoria(categoriaPreferida) or 
             pregunta.esCategoria(categoriaPreferida2)))
    }
}

class JugadorTryHard inherits Jugador {

    override method contestar(pregunta) {
        super.contestar(pregunta)
        if(self.sabe(pregunta)) {
            pregunta.marcarAcertada()
        }
    }

    override method sabe(pregunta) {
        // Sabe todas excepto las nunca acertadas por nadie
        return pregunta.fueAcertada()
    }
}


class JugadorSabelotodo inherits JugadorHabitué {

    override method sabe(pregunta) {
        pregunta.esFacil() or pregunta.esMedia()
    }
}


//punto 4


//wollok length no existe (no se si lo toma como bien), pero deberia ser size()
class RondaRapida inherits Ronda {
//PREGUNTAS CORTAS NO ESTA DEFINIDA EN NINGUN LADO
    const property preguntasCortas = []

    override method preguntas() = preguntasCortas.take(5)
    override method dificultad() = 3
}

//PUNTO 5
/*
test "Los jugadores suman puntos al contestar una ronda" {
    const jugadores = [mati, valen, martina]
    puntosOriginales = jugadores.sum({ j => j.puntos() })
    const nuevosJugadores = pregunta3.jugar(jugadores, rondaNormal)
    nuevosPuntos = jugadores.sum({ j => j.puntos() })
    assert.equals(puntosOriginales, nuevosPuntos)
}

object pregunta3 {
    method jugar(jugadores, ronda) {
        return jugadores.map({ j => j.jugarRonda(ronda) })
    }
}
*/
/*
PROBLEMA 1:
 NOSOTROS TENIAMOS en la clase de Jugador; 
    method jugarRonda(unaRonda) {
    unaRonda.preguntas().forEach({ pregunta =>
        self.contestar(pregunta)
    })
}

ESTO NO DEVUELVE NADA, DEVUELVE NULL, POR LO TANTO EN EL TEST 
const nuevosJugadores = pregunta3.jugar(jugadores, rondaNormal)
NOS DEVUELVE UNA LISTA DE NULLS, PORQUE CADA VEZ QUE UN JUGADOR JUEGA LA RONDA
NOS DEVUELVE NULL
SOLUCION:
DEBEMOS HACER QUE jugarRonda DEVUELVA SELF AL FINAL, ASI CUANDO HACEMOS
const nuevosJugadores = pregunta3.jugar(jugadores, rondaNormal)
NOS DEVUELVE LA LISTA DE JUGADORES CON SUS PUNTOS ACTUALIZADOS
    method jugarRonda(unaRonda) {
        unaRonda.preguntas().forEach({ pregunta =>
            self.contestar(pregunta)
        })
        return self
    }

*/

//PUNTO 6 =================================================
object pregunta3 {
    method jugar(jugadores, ronda) {
        if (jugadores.size() < 2) {
            throw new DomainException(message = "No se puede empezar la ronda: se requieren al menos 2 jugadores")
        }
        return jugadores.map({ j => j.jugarRonda(ronda) })
    }
}
//=========================================================

class Pregunta {
    var property puntosBase
    var property categoria
    var property nivel      // "facil" ,media,experta"
    var property quienesLaSaben = []

    method esFacil() = nivel == "facil"
    method esMedia() = nivel == "media"
    method esExperta() = nivel == "experta"

    method esMediaOFacil() = self.esFacil() or self.esMedia()

    method puntos() {
        if (self.esFacil()) {
            return puntosBase
        }

        if (self.esMedia()) {
            return puntosBase * 2
        }

        if (self.esExperta()) {
            if (quienesLaSaben.isEmpty()) {
                return 2000
            }
            return puntosBase * 50 / quienesLaSaben.size()
        }
    }
}

/*
otra alternativa deñ metodo de puntos sin usar tantos if es crear mas metodos con su propia logica
    method puntos() =
        if (self.esFacil()) then self.puntosFacil()
        else if (self.esMedia()) then self.puntosMedia()
        else self.puntosExperta()

    method puntosFacil() = puntosBase
    method puntosMedia() = puntosBase * 2
    method puntosExperta() =
        if (quienesLaSaben.isEmpty()) then 2000
        else puntosBase * 50 / quienesLaSaben.size()
*/