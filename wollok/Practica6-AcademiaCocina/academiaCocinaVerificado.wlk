// Revisado: 11.12.2025
//Solucion de un Profe / Ayudante - Academia de Cocina Wollok
// Cocineros

class Cocinero {
  const comidasPreparadas = [] // List[Comida]
  var nivelDeAprendizaje = principiante // NivelDeAprendizaje

  // Punto 1
  method experiencia() = comidasPreparadas.sum{ c => c.experienciaQueAporta()}

  // Punto 2
  method superoSuNivel() = nivelDeAprendizaje.fueSuperado(self)

  method cantComidasDificilesPreparadas() = 
    comidasPreparadas.filter{c => c.esDificil()}.size()

  // Punto 3
  method prepararComida(unaReceta) {
    if(!self.puedePreparar(unaReceta)) {
      throw new NivelInsuficienteException()
    } else {
      const comida = new Comida(receta = unaReceta, 
                                calidad = nivelDeAprendizaje.calidadQueConsigue(unaReceta, self))
      comidasPreparadas.add(comida)
      if(self.superoSuNivel()) {
        nivelDeAprendizaje = nivelDeAprendizaje.nivelSiguiente()
      }
    }
  }

  method puedePreparar(receta) = nivelDeAprendizaje.puedePreparar(receta, self)

  method preparoRecetaSimilar(receta) = comidasPreparadas.any{c => c.tieneRecetaSimilar(receta)}

  method comidasConRecetaSimilar(receta) = comidasPreparadas.filter{c => c.tieneRecetaSimilar(receta)}

  method experienciaEnRecetasSimilares(receta) = 
    self.comidasConRecetaSimilar(receta).sum{c => c.experienciaQueAporta()}

  method perfeccionoReceta(receta) = 
     self.experienciaEnRecetasSimilares(receta) > 3 * receta.experienciaQueAporta()

  method cantComidasConRecetaSimilar(receta) = self.comidasConRecetaSimilar(receta).size()
}

// Niveles de Aprendizaje

class NivelDeCocinero { // abstract class
  method puedePreparar(receta, cocinero) = !receta.esDificil() 
  method calidadQueConsigue(receta, cocinero) 
  method fueSuperado(cocinero)
  method nivelSiguiente()
}

class NivelAvanzado inherits NivelDeCocinero { // abstract class
  override method calidadQueConsigue(receta, cocinero) {
    if(cocinero.perfeccionoReceta(receta)) 
      return new Superior(plusDeExp = cocinero.cantComidasConRecetaSimilar(receta) / 10)
    else 
      return normal
  }
}

object principiante inherits NivelDeCocinero {
  override method calidadQueConsigue(receta, cocinero) = if(receta.cantIngredientes() < 4) normal else pobre
  override method fueSuperado(cocinero) = cocinero.experiencia() > 100
  override method nivelSiguiente() = experimentado
}

object experimentado inherits NivelAvanzado {
  override method puedePreparar(receta, cocinero) = 
    super(receta, cocinero) || cocinero.preparoRecetaSimilar(receta)
  override method fueSuperado(cocinero) = cocinero.cantComidasDificilesPreparadas() > 5
  override method nivelSiguiente() = chef
}

object chef inherits NivelAvanzado {
  override method puedePreparar(receta, cocinero) = true
  override method fueSuperado(cocinero) = false
  override method nivelSiguiente() = throw new NivelSiguienteException()
}

// Recetas

class Receta {
  // Inmutable
  const ingredientes // List[String]
  const nivelDificultad // Number

  method experienciaQueAporta() = self.cantIngredientes() * nivelDificultad

  method esDificil() = nivelDificultad > 5 || self.cantIngredientes() > 10

  method esSimilar(otraReceta) = 
    otraReceta.tieneMismosIngredientes(ingredientes) || otraReceta.tieneNivelCercano(nivelDificultad)

  method tieneMismosIngredientes(otrosIngredientes) = ingredientes == otrosIngredientes

  method tieneNivelCercano(otroNivelDificultad) = (otroNivelDificultad - nivelDificultad).abs() <= 1

  method cantIngredientes() = ingredientes.size()
}

// Punto 4
class RecetaGourmet inherits Receta{
  override method experienciaQueAporta() = super() * 2
  override method esDificil() = true
}

// Comidas

class Comida {
  // Inmutable
  const receta // Receta
  const calidad // Calidad

  method experienciaQueAporta() = 
    calidad.experienciaQueAporta(receta.experienciaQueAporta())

  method esDificil() = receta.esDificil()

  method tieneRecetaSimilar(otraReceta) = receta.esSimilar(otraReceta)
}

// Calidades

object normal {
  method experienciaQueAporta(experienciaReceta) = experienciaReceta
}

object pobre {
  var property topeDeExp = 999 // Number
  method experienciaQueAporta(experienciaReceta) = experienciaReceta.min(topeDeExp)
}

class Superior {
  const plusDeExp // Number
  method experienciaQueAporta(experienciaReceta) = experienciaReceta + plusDeExp
}

// Academia

object academiaDeCocina {
  const estudiantes = [] // List[Cocinero]
  const recetasDisponibles = [] // List[Receta]

  // Punto 5
  method entrenarEstudiantes() { estudiantes.forEach{est => self.entrenarEstudiante(est)} }

  method entrenarEstudiante(est) {
    const recetasPreparables = recetasDisponibles.filter{rec => est.puedePreparar(rec)}
    if(recetasPreparables.isEmpty()) throw new EntrenamientoException()
    const recetaDeMayorExp = recetasPreparables.max{rec => rec.experienciaQueAporta()}
    est.prepararComida(recetaDeMayorExp)
  }
}

// Excepciones

class NivelInsuficienteException inherits Exception (
  message = "El cocinero no tiene nivel suficiente para preparar la receta"
) {}

class NivelSiguienteException inherits Exception (
  message = "El cocinero no tiene nivel siguiente, ya esta al maximo"
) {}

class EntrenamientoException inherits Exception (
  message = "No hay recetas disponibles que pueda preparar el cocinero"
) {}