/* =================== 1) ==================
Persona:
    - elementosCercanos: lista de cosas cerca (sal, aceite, cuchillo, etc.)
    - comidas: lista de comidas ingeridas
    - criterioParaDarElemento: estrategia de cómo pasar un elemento a otro comensal
    - posiciones: historial de posiciones de la persona en la mesa
    - criterioDeComida: estrategia para decidir si comer o no

    Cada persona puede:
    - pedir un elemento a otra
    - comer una comida si su criterio lo permite
    - saber si está pipón (alguna comida > 500 calorías)
    - saber si la está pasando bien según criterios propios
    - cambiar dinámicamente criterios de comida y de pasar elementos

    Polimorfismo: método lapasaBienPersonalmente(), comportamiento distinto según cada persona
    Composición: cada Persona tiene un criterioDeComida y criterioParaDarElemento
*/
class Persona {

    const property elementosCercanos = []  // elementos que tiene a mano
    const property comidas = []            // registro de comidas ingeridas
    var property criterioParaDarElemento = sordo  // estrategia para pasar elementos
    const posiciones = []                  // historial de posiciones
    var property criterioDeComida = vegetariano  // estrategia para decidir si comer

    // =================== 1.1 Posición ==================
    method posicion(nuevaPosicion) {
        posiciones.add(nuevaPosicion)  // agregamos la nueva posición a la lista
    }
    method posicion() = posiciones.last()  // devuelve la última posición ocupada

    // =================== 1.2 Elementos ==================
    method tieneElemento(elemento) = elementosCercanos.contains(elemento)

    method agregarElementos(elementos) {
        elementosCercanos.addAll(elementos)  // agregamos elementos a la lista
    }

    method darElemento(elemento, personaQuePide) {
        if (!self.tieneElemento(elemento)) {
            throw new DomainException(message = "No tengo cerca el elemento " + elemento)
        }
        // Delegamos en el criterio actual cómo pasar el elemento
        criterioParaDarElemento.pasarElemento(elemento, self, personaQuePide)
    }

    method quitarElementos(elementos) {
        elementosCercanos.removeAllSuchThat { elementoCercano => elementos.contains(elementoCercano) }
    }

    method primerElementoCercano() = elementosCercanos.head() // devuelve el primer elemento disponible

    // =================== 1.3 Comida ==================
    method comer(comida) {
        if (criterioDeComida.acepta(comida)) {  // delegamos la decisión al criterio de comida
            comidas.add(comida)
        }
    }

    // =================== 1.4 Estado ==================
    method estaPipon() = comidas.any { comida => comida.esPesada() } // True si alguna comida > 500 calorías
    method comioAlgo() = !comidas.isEmpty()
    method laPasaBien() = self.comioAlgo() && self.lapasaBienPersonalmente() // delega el criterio individual
    method lapasaBienPersonalmente()  // primitiva, polimorfismo
}

/* =================== 2) ==================
Objetos Persona específicos con criterios individuales
- Osky: siempre la pasa bien
- Moni: la pasa bien si se sentó en la posición 1
- Facu: la pasa bien si comió carne
- Vero: la pasa bien si tiene ≤ 3 elementos cerca
Polimorfismo: lapasaBienPersonalmente() redefine el comportamiento para cada persona
*/
object osky inherits Persona {
    override method lapasaBienPersonalmente() = true
}

object moni inherits Persona {
    override method lapasaBienPersonalmente() = posiciones.contains(game.at(1,1))
}

object facu inherits Persona {
    override method lapasaBienPersonalmente() = comidas.any { comida => comida.esCarne() }
}

object vero inherits Persona {
    override method lapasaBienPersonalmente() = elementosCercanos.size() <= 3
}

/* =================== 3) ==================
Clase Comida:
    - calorias: cantidad de calorías
    - esCarne: booleano
    - esPesada(): > 500 calorías
*/
class Comida {
    const property calorias = 100
    const property esCarne = false

    method esPesada() = calorias > 500
}

/* =================== 4) ==================
Criterios para pasar elementos:
- Sordo: pasa solo el primer elemento
- Irritable: pasa todos los elementos
- Movedizo: intercambia posiciones con quien pide
- Obediente: pasa exactamente el elemento pedido
Polimorfismo: pasarElemento() se comporta distinto según el criterio
Composición: Persona tiene un criterio que delega cómo pasar elementos
*/
class CriterioAPasarElementos {
    method pasarElemento(elemento, personaQueDa, personaQueRecibe) {
        const elementosAPasar = self.elementosAPasar(elemento, personaQueDa)
        personaQueRecibe.agregarElementos(elementosAPasar)
        personaQueDa.quitarElementos(elementosAPasar)
    }
    method elementosAPasar(elemento, personaQueDa)  // primitiva
}

object sordo inherits CriterioAPasarElementos {
    override method elementosAPasar(elemento, personaQueDa) = [personaQueDa.primerElementoCercano()]
}

object irritable inherits CriterioAPasarElementos {
    override method elementosAPasar(elemento, personaQueDa) = personaQueDa.elementosCercanos()
}

object movedizo { // intercambia posiciones, no hereda porque la lógica es distinta
    method pasarElemento(elemento, personaQueDa, personaQuePide) {
        const posicionDeLaQuePide = personaQuePide.posicion()
        personaQuePide.posicion(personaQueDa.posicion())
        personaQueDa.posicion(posicionDeLaQuePide)
    }
}

object obediente inherits CriterioAPasarElementos {
    override method elementosAPasar(elemento, personaQueDa) = [elemento]
}

/* =================== 5) ==================
Criterios de comida:
- vegetariano: solo come lo que no es carne
- dietético: calorías < 500
- alternado: acepta/rechaza alternadamente
- combinada: todas las condiciones deben cumplirse
Polimorfismo: acepta() se comporta distinto según criterio
*/
object vegetariano {
    method acepta(comida) = not comida.esCarne()
}

object dietetico {
    var property limiteDeCalorias = 500
    method acepta(comida) = comida.calorias() < limiteDeCalorias
}

class Alternado {
    var quiero = false
    method acepta(comida) {
        quiero = !quiero
        return not quiero
    }
}

class AceptacionCombinada {
    const property criteriosDeAceptacion = []
    method agregarCriterios(criterios) = criteriosDeAceptacion.addAll(criterios)
    method acepta(comida) = criteriosDeAceptacion.all { criterio => criterio.acepta(comida) }
}

/* =================== 6) ==================
Resumen general:
- Polimorfismo: lapasaBienPersonalmente(), pasarElemento(), acepta()
- Herencia: Persona -> osky, moni, facu, vero; CriterioAPasarElementos -> sordo, irritable, obediente
- Composición: Persona tiene elementos, comidas, criterios
- Estrategias: criterios de comida y de dar elementos
- Delegación: Persona delega a su criterio la acción de pasar elementos
*/
