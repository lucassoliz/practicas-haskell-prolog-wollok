//PUNTO 1
//estructura basica del enunciado general
class Videojuego {
    const property titulo //encapsulamiento 
    const property desarrolladora
    const property generos = #{} // conjunto de generos para que no se repitan claro
    const property anioLanzamiento
}


// Interfaz/Contrato para los criterios: le gusta(unVideojuego), cumple los criterio de Juan y Pedro
class CriterioFanatico {
    const desarrolladoraFavorita
    const generoFavorito

    method leGusta(videojuego) = 
        videojuego.desarrolladora() == desarrolladoraFavorita || 
        videojuego.generos().contains(generoFavorito)
}

//claramente para mayor flexibilidad deberia de tener otro nombre el objeto y no estar ligado a Maria, pero para una mejor compresion lo dejamos asi
object criterioMaria {
    method leGusta(videojuego) = videojuego.anioLanzamiento() > 2015 //obvio polimorfismo
}

class Jugador {
    var property criterio // Strategy: permite cambiar o asignar la forma de evaluar

    method evaluaPositivamente(videojuego) = criterio.leGusta(videojuego)
}
// PUNTO B el comite debe ser el encargado de filtrar los videojuegos

class Comite{
    const property integrantes = []

    method preferidosDelComite(videojuegos) = 
        videojuegos.filter({ juego => self.todosLoPrefieren(juego) })

    method todosLoPrefieren(videojuego) = 
        integrantes.all({ jugador => jugador.evaluaPositivamente(videojuego) })
}

// PUNTO C 
/*
RECEPTOR: El COMITE. Es el dueño de la coleccion de integrantes y quien tiene la responsabilidad de coordinar la evaluacion grupal

Parametros: Una coleccion de objetos Videojuego, coleccion para que no pueda haber repetidos
*/

//PUNTO D Jugador Flexible

/*
Si, es posible incorporarlo sin cambiar lo anterior
Esto se logra gracias al POLIMORFISMO, solo se necesita crear un nuevo objeto de criterio
que maneje una lista interna de otros criterios
*/
class CriterioFlexible {
    const criteriosPosibles = []
    
    // Le gusta si CUALQUIERA de sus criterios internos se cumple
    method leGusta(vj) = criteriosPosibles.any({ c => c.leGusta(vj) })
}
// PUNTO 2 ----------------------------------------------------
//Usaremos HERENCIA para reutilizar la logica de los integrantes (clave el "ADEMAS")
class ComiteExigente inherits Comite {
    const property generosDestacados = #{}

    override method todosLoPrefieren(videojuego) =
        super(videojuego) and self.cumpleGenerosDestacados(videojuego)
    

    method cumpleGenerosDestacados(videojuego) =
        videojuego.generos().filter({ gene => generosDestacados.contains(gene) }).size() >= 2
}

// PUNTO 3 ----------------------------------------------------
//Aclaraciones de conceptos usados:
/*
Polimorfismo: El Comite trata polimorficamente a sus integrantes
No le importa si el integrante evalua por año como Maria o ppr desarrolladora y genero como Juan o pedro
solo envia sin mas el mensaje "evaluaPositivamente(videojuego)" y confia en que el integrante lo entendera

Composicion y Strategy: El jugador no tiene el coddigo de evaluacion
sino que tiene un atributo "criterio" que es quien maneja la logica de evaluacion
Esto permite cambiar la forma de evaluar en tiempo de ejecucion

Encapsulamiento: El Comite no conoce los atributos internos de los jugadores ni como deciden que le gusta
Solo conoce la interfaz publica del metodo de evaluacion

Herencia: Se utilizo herencia en el ComiteExigente para especializar el comportamiento de 
todosLoPrefieren() sin reescribir toda la logica del Comite base

*/