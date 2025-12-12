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
    var property puntosBase
    var property categoria
    var property nivel      // "facil" ,media,experta"
    var property quienesLaSaben = [] // (Para punto 7 si se mantiene la lógica original)

    // Necesario por JugadorTryHard (Para evitar que la pregunta conozca a todos los jugadores según corrección punto 1)
    var fueAcertada = false
    
    method esFacil() = nivel == "facil"
    method esMedia() = nivel == "media"
    method esExperta() = nivel == "experta"

    method esCategoria(cat) = categoria == cat
    
    method esMediaOFacil() = self.esFacil() or self.esMedia()

    method fueAcertada() = fueAcertada
    
    method marcarAcertada() {
        fueAcertada = true
    }
    // PUNTO 7
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
        return 0 // Default
    }
}
// puntos -= pregunta.puntos() restaba cuando acertaba, ahora se modifico y suma y si no la sabe y constea ahora resta bien
class Jugador {
    var puntos = 0
    var property categoriaPreferida
    
    // AGREGAMOS ESTO PARA QUE PUEDA EVOLUCIONAR (osea State Pattern)
    // Arranca siendo normal
    var estilo = normal 
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
    */
    method jugarRonda(unaRonda) {
        unaRonda.preguntas().forEach({ pregunta =>
            self.contestar(pregunta)
        })
        return self
    }

    method contestar(pregunta) {
        if(self.sabe(pregunta)) {
            puntos += pregunta.puntos()
            // Notificamos a la pregunta para el TryHard
            pregunta.marcarAcertada()
        } else { //La sintaxis estaba mal y mal ubicado
            puntos -= pregunta.puntos()
        }
        // Agregamos esto para cumplir con "pueden ir evolucionando"
        self.actualizarEstilo()
    }

    // Delegamos al estado (estilo) actual
    method sabe(pregunta) = estilo.sabe(pregunta, self)

    method actualizarEstilo() {
        if (puntos > 5000) {
            estilo = tryHard
        } else if (puntos > 1500) {
            // Solo cambiamos si no es ya un habitué (para no perder la 2da categoria)
            if (estilo == normal) {
                 // Asumimos una categoría por defecto o habría que pasarla
                 estilo = new Habitue(categoriaPreferida2 = "Deportes") 
            }
        } else {
            estilo = normal
        }
    }
}

//ESTADOS (Antes eran subclases, ahora son estrategias para permitir evolucion al jugador

object normal {
    method sabe(pregunta, jugador) {
        // Enunciado: "sabe sólo las fáciles... y las medias (y fáciles) de su categoría preferida"
        return pregunta.esFacil() or  
        (pregunta.esCategoria(jugador.categoriaPreferida()) and pregunta.esMedia()) 
    }
}

class Habitue { // falto de agregar este atributo (ahora en la clase estado)
    var categoriaPreferida2 

    method sabe(pregunta, jugador) {
        // Enunciado: "sabe todas las fáciles y las expertas (y medias) de dos categorias"
        return pregunta.esFacil() or
        ( (pregunta.esMedia() or pregunta.esExperta()) and 
            (pregunta.esCategoria(jugador.categoriaPreferida()) or 
             pregunta.esCategoria(categoriaPreferida2))
        )
    }
}

object tryHard {
    method sabe(pregunta, jugador) {
        // Sabe todas excepto las nunca acertadas por nadie
        return pregunta.fueAcertada()
    }
}

// PUNTO 3
// Sabelotodo: Se comporta como Habitué pero sabe TODAS las medias
class Sabelotodo inherits Habitue {
    override method sabe(pregunta, jugador) {
        return pregunta.esMedia() or super(pregunta, jugador)
    }
}


//punto 4

//wollok length no existe (no se si lo toma como bien), pero deberia ser size()
class RondaRapida inherits Ronda { 
    //PREGUNTAS CORTAS NO ESTA DEFINIDA EN NINGUN LADO -> Ahora la inyectamos para corregirlo
    const property preguntasCortas = []

    override method preguntas() = preguntasCortas.take(5)
    override method dificultad() = 3
}

class Ronda { // Clase abstracta necesaria para que compile lo anterior
    method preguntas()
    method dificultad()
}

// Clases del enunciado original para que el código esté completo
class RondaNormal inherits Ronda {
    const property preguntas = []
    override method dificultad() = 2 + self.dificultadPreguntas()
    method dificultadPreguntas() = preguntas.sum({ p => p.texto().size().div(10) }) // corregido length por size
    override method preguntas() = preguntas
}

class RondaSubita inherits Ronda {
    const pregunta
    override method preguntas() = [pregunta]
    override method dificultad() = pregunta.puntos()
}


//PUNTO 6 ======================================
object pregunta3 {
    method jugar(jugadores, ronda) {
        if (jugadores.size() < 2) {
            throw new DomainException(message = "No se puede empezar la ronda: se requieren al menos 2 jugadores")
        }
        return jugadores.map({ j => j.jugarRonda(ronda) })
    }
}
