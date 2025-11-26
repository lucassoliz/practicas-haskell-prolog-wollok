/* =================== 1) ==================
Lugares:
    - Ciudades: habitantes, atracciones, decibeles promedio
    - Pueblos: extensión km², fecha fundación, provincia
    - Balnearios: metros de playa promedio, mar peligroso, peatonal

Criterio divertido:
    - Todos: nombre con cantidad par de letras
    - Ciudad: más de 3 atracciones y habitantes > 100.000
    - Pueblo: fundado antes de 1800 o del Litoral ("Entre Ríos", "Corrientes", "Misiones")
    - Balneario: más de 300 metros de playa y mar peligroso

Polimorfismo:
    Cada subclase define su propio `esDivertido()`, así evitamos usar `isKindOf` y delegamos la lógica.
*/

class Lugar {
    const property nombre

    // criterio común: todos los lugares deben tener nombre con cantidad par de letras
    method tieneNombrePar() = nombre.length().even()
    
    // cada subclase debe implementar su propio esDivertido
    method esDivertido()
}

class Ciudad inherits Lugar {
    const property habitantes
    const property atracciones
    const property decibeles

    override method esDivertido() =
        self.tieneNombrePar() &&
        habitantes > 100000 &&
        atracciones.size() > 3
}

class Pueblo inherits Lugar {
    const property anioFundacion
    const property provincia

    override method esDivertido() =
        self.tieneNombrePar() &&
        (anioFundacion < 1800 || ["Entre Ríos","Corrientes","Misiones"].contains(provincia))
}

class Balneario inherits Lugar {
    const property metrosPlaya
    const property marPeligroso
    const property tienePeatonal

    override method esDivertido() =
        self.tieneNombrePar() &&
        metrosPlaya > 300 &&
        marPeligroso
}

/* =================== 2) ==================
Personas:
    - Criterios de vacaciones:
        * tranquilidad
        * diversión
        * raro (nombre > 10 letras)
        * combinación de criterios (acepta si alguno acepta)
    
    - Polimorfismo: cada criterio sabe si acepta un lugar
*/

class CriterioVacaciones {
    method acepta(lugar) //primera versión, cada subclase lo define
}

object tranquilidad inherits CriterioVacaciones {
    method acepta(lugar) = lugar.esTranquilo()
}

object diversion inherits CriterioVacaciones {
    method acepta(lugar) = lugar.esDivertido()
}

object raro inherits CriterioVacaciones {
    method acepta(lugar) = lugar.nombre.length() > 10
}

class Combinado inherits CriterioVacaciones {
    const property criterios = []

    method agregar(criterio) = criterios.add(criterio)

    method acepta(lugar) = criterios.any(c -> c.acepta(lugar))
}

// Polimorfismo para cada tipo de lugar define qué es tranquilo
class Ciudad override method esTranquilo() = decibeles < 20
class Pueblo override method esTranquilo() = provincia == "La Pampa"
class Balneario override method esTranquilo() = not tienePeatonal

class Persona {
    const property nombre
    var property criterio = tranquilidad
    const property presupuesto

    method seIriaALugar(lugar) = criterio.acepta(lugar)

    // podemos cambiar criterio en cualquier momento
    method cambiarCriterio(nuevoCriterio) = criterio = nuevoCriterio
}

/* =================== 3) ==================
Tour:
    - fecha de salida
    - cantidad de personas requerida
    - lista de lugares
    - monto por persona

Reglas de incorporación:
    - presupuesto suficiente
    - todos los lugares aceptados por la persona
    - no exceder la cantidad de personas
*/

class Tour {
    const property fechaSalida
    const property cantidadPersonasRequerida
    const property lugares = []
    const property montoPorPersona
    var property personas = []

    method agregarPersona(persona) {
        if personas.size() >= cantidadPersonasRequerida {
            throw new DomainException( message: "Tour ya confirmado, no se puede agregar más gente" )
        }
        if persona.presupuesto < montoPorPersona {
            throw new DomainException( message: persona.nombre + " no tiene presupuesto suficiente" )
        }
        if lugares.any(lugar -> not persona.seIriaALugar(lugar)) {
            throw new DomainException( message: persona.nombre + " no acepta todos los lugares del tour" )
        }
        personas.add(persona)
    }

    method quitarPersona(persona) = personas.remove(persona)

    method tourConfirmado() = personas.size() == cantidadPersonasRequerida
}

/* =================== 4) ==================
Reportes:
    - Tours pendientes de confirmación
    - Total de tours del año: montoPorPersona * cantidad de personas
*/

object Agencia {
    const property tours = []

    method toursPendientes() = tours.filter(tour -> tour.personas.size() < tour.cantidadPersonasRequerida)

    method totalToursDelAnio(anio) = 
        tours
            .filter(tour -> tour.fechaSalida.year() == anio)
            .sum(tour -> tour.montoPorPersona * tour.personas.size())
}
