//me gusto mas como quedo la otra version, dejo esta version un poco rebuscada pero funcional
/*
LOS JUGADORES
-- PUNTO 1
Malaa asignacion de responsabilidad
    El problema esta que la clase Pregunta tiene una referencia que apunta a Jugador
    Esto significa que la pregunta comoce a todos los jugadores que la saben????????
    No tiene sentido que una pregunta conozca a los jugadores, mas bien deberia saber 
    lo que le corresponde a ella (texto,categoria), acaso la pregunta va a tener una lista de 
    1 millon de personas??? Es ineficiente.

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
/*
PUNTO 2
PROBKEMAS:
    Usa Herencia, pero el enunciado dice que LOS JUGADORES "PUEDEN IR EVOLUCIONANDO"
    Por que esta mal?? una instancia NO PUEDE CAMBIAR DE CLASE EN TIEMPO DE EJECUCION
    un jugadorNormal no puede transformarse en JugadorHabitue porque son clases distintas

    Solucion: Hay que usar Composicion (Patron Strategy), el jugador debe tener un atributo
    variable (ej: estilo o rango) que cambie dinamicamente segun los puntos que tenga

Problema minimo, en forEach le faltaba parentesis, error de sintaxis 

+ agregamos codigo de evolucion de nivel
*/
class Jugador {
	var puntos = 0
	var property categoriaPreferida
	
	//En lugar de herencia, usamos una variable para el tipo
	// Arranca siendo un objeto JugadorNormal (lo definimos abajo xd
	var tipoDeJugador = jugadorNormal 
	method jugarRonda(unaRonda) {
		unaRonda.preguntas().forEach({ pregunta => self.contestar(pregunta) })
	}
	method contestar(pregunta) {
		if (self.sabe(pregunta)) {
			puntos += pregunta.puntos()
		} else {
			puntos -= pregunta.puntos()
		}
		// Agregamos esto para cumplir con "pueden ir evolucionando"
		self.actualizarNivel()
	}

	// Delegamos la pregunta al "tipo" actual
	method sabe(pregunta) = tipoDeJugador.sabe(pregunta, self)

	method actualizarNivel() {
		//caso1 Es crack (> 5000) -> Se hace TryHard
		if (puntos > 5000) {
			tipoDeJugador = jugadorTryHard
		} 
		//caso2 Nivel intermedio (> 1500 y <= 5000) -> Se hace Habitué
		else if (puntos > 1500) {
			if (tipoDeJugador == jugadorNormal || tipoDeJugador == jugadorTryHard) {
				tipoDeJugador = new JugadorHabitue(segundaCategoria = "Deportes") 
			}
		} 
		// caso3 Pocos puntos (<= 1500) -> Vuelve a Normal (Retroceso)
		else {
			tipoDeJugador = jugadorNormal
		}
	}
}

// tipos de jugadores

object jugadorNormal {
	method sabe(pregunta, jugador) {
		return pregunta.esFacil() || 
			   (pregunta.esDeCategoria(jugador.categoriaPreferida()) && !pregunta.esExperta())
	}
}

class JugadorHabitue { // Ya no "inherits Jugador", es una clase aparte para el estado
	const segundaCategoria
	
	method sabe(pregunta, jugador) {
		const esDeSusCategorias = 
			pregunta.esDeCategoria(jugador.categoriaPreferida()) || 
			pregunta.esDeCategoria(segundaCategoria)

		return pregunta.esFacil() || 
			   (esDeSusCategorias && !pregunta.esFacil()) 
	}
}

object jugadorTryHard {
	method sabe(pregunta, jugador) {
		return pregunta.nadieLaRespondioCorrectamente()
	}
}

//PUNTO 3

class Sabelotodo inherits JugadorHabitue {
	
	override method sabe(pregunta, jugador) = pregunta.esMedia() || super(pregunta, jugador)
		// "super" ya chequea: Fáciles O (Expertas/Medias de sus categorías).
		// Nosotros le agregamos: O Medias (todas).

}

//PUNTO 4

/*
Sobre RondaSubita: 

*/


class Ronda {
	method preguntas()
	method dificultad() 
}

// RondaNormal y RondaSubita quedan igual porque su diseño es correcto.

class RondaRapida inherits Ronda {
	// CAMBIO: Definimos las preguntas como un atributo fijo al iniciar.
	// Esto desacopla la lógica de la fuente global en cada llamada.
	const preguntas 
	
	// Opción A: Pasarlas en el constructor (Inyección de Dependencia)
	// new RondaRapida(preguntas = repositorio.preguntasCortas().take(5))
	
	// Opción B (Si queremos mantener el default pero hacerlo testeable):
	// Inicializamos en el atributo, pero permitimos cambiarlo si fuera necesario
	// o simplemente calculamos "take(5)" una sola vez al nacer el objeto.
	
	override method preguntas() = preguntas
	
	override method dificultad() = 3
}