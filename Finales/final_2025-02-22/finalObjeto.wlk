/*
PUNTO 1 VERDADERO O FALSO
-----------------------------------------------
a. El método jugadoresBuenos() no produce efecto en el estado interno del Equipo luego de ejecutarse.

VERDADERO: El método crea una variable local var buenos = [ ] , le agrega
elementos y la devuelve (return). No moficia la lista original jugadores ni ningun
otro artributo del objeto Equipo 
------------------------------------------

b. La solución tiene problemas de declaratividad

VERDADERO: El codigo usa un forEach con multippkes if anidados para filtrar manualmente
Esto es imperativo y poco declarativo (le dice a la maquina como recorrer y filtrar paso a paso)
Una solucion declarativa diria que quiere obtener, usando mensajes de alto nivel como filter
------------------------------------------------

c. Para agregar un nuevo tipo de jugador (el delantero...), sólo debo modificar la clase Jugador.

FALSOO: Como el Equipo tiene logica de validacion hardcodeada con ifs para cada tipo de jugador
, si agregas un delantero, estas obligado a ir a la clase Equipo y agregar un nuevo if para contemplar
    ese nuevo tipo de jugador 
---------------------------------------------------------------------

d. La responsabilidad de saber si un jugador es bueno está mal asignada.

VERDADERP: El equipo esta "micro-gestionando" a los jugadores, preguntandoles que
posicion ocupa y chequeando sus atributps (atajaPenales, marcaMucho). Esto rompe el encapsulamiento
El objeto que tiene la informacion para saber si es bueno es el propio Jugador (o su posicion), no el equipo
--------------------------------------------------------------
*/

/*
PUNTO 2

Polimporfismo: necesito que el Equipo solo pregunte jugador.esBueno()
State/Strategy: Como el enunciado dice que "un jugador cambie de posicion en cualquier momento"
, la posicion no puede ser un Sting ni herencia. Debe ser un objeto (STRATEGY) asignado a una variable
*/
class Equipo {
    const jugadores = [] 

    // SOLUCIÓN DECLARATIVA Y POLIMÓRFICA
    method jugadoresBuenos() = jugadores.filter({ jugador => jugador.esBueno() })
}

class Jugador {
    // Atributos de estado
    var property porcentajeBuenosPases = 0
    var property penalesAtajados = 0 //DEBE ESTAR inicializado para que no sea NULL
    var property cantMarcas = 0 //Si es NULL daria problemas con los metodos 
    var property goles = 0 // Agregado para el Delantero
    
    // STRATEGYYYYYYYY: La posición es un objeto que puede cambiar
    var property posicion 

    // Delegamos la pregunta a la posición actual
    method esBueno() = posicion.esBueno(self)
    
    // Auxiliares para que las estrategias consulten los atributos
    method atajaPenales() = penalesAtajados > 2
    method marcaMucho() = cantMarcas > 2
    method pasaBien() = porcentajeBuenosPases > 0.75
    method hizoMuchosGoles() = goles > 10
}

// estrategias de posicion ----------------------

object arquero {
    method esBueno(jugador) = jugador.atajaPenales()
}

object defensor {
    method esBueno(jugador) = jugador.marcaMucho()
}

object mediocampista {
    method esBueno(jugador) {
        // "debe antes ser buen defensor" -> Reutilizamos la lógica del objeto defensor
        return defensor.esBueno(jugador) && jugador.pasaBien()
    }
}

//nuevo requerimiento del Punto 2
object delantero {
    method esBueno(jugador) = jugador.hizoMuchosGoles()
}