class Receta {
    const property ingredientes = []
    const property dificultad 
    
    method experienciaBase() = ingredientes.size() * dificultad
    method esDificil() = dificultad > 5 || ingredientes.size() > 10
    method esSimilarA(otraReceta) = self.mismosIngredientes(otraReceta) || 
           otraReceta.dificultad().between(dificultad - 1, dificultad + 1)
    method mismosIngredientes(otra) = ingredientes.asSet() == otra.ingredientes().asSet()
}
class RecetaGourmet inherits Receta {
    override method esDificil() = true
    override method experienciaBase() = super() * 2
}

class Comida {
    const property receta
    const property calidad
    
    method experiencia() = calidad.calcularExperiencia(receta)
    method esDificil() = receta.esDificil()
    method esSimilarA(otraReceta) = receta.esSimilarA(otraReceta)
}
object normal {
    method calcularExperiencia(receta) = receta.experienciaBase()
}
object pobre {
    var property experienciaMaxima = 4

    method calcularExperiencia(receta) = receta.experienciaBase().min(experienciaMaxima)
}
class Superior {
    const plus
    method calcularExperiencia(receta) = receta.experienciaBase() + plus
}
class Cocinero {
    const property preparaciones = []
    var property nivel = principiante 
    method experienciaAdquirida() = preparaciones.sum({ comida => comida.experiencia() })
    method preparar(receta) {
        if (!nivel.puedePreparar(receta, self)) {
            throw new DomainException(message = "El cocinero no tiene nivel para esta receta")
        }
        const calidad = nivel.determinarCalidad(receta, self)
        const comida = new Comida(receta = receta, calidad = calidad)

        preparaciones.add(comida)
        if (nivel.superaNivel(self)) {
            nivel = nivel.siguienteNivel()
        }
    }
    
    method cantidadComidasDificiles() = preparaciones.count({ comida => comida.esDificil() })
    method preparacionesSimilaresA(receta) = preparaciones.filter({ comida => comida.esSimilarA(receta) })     
    method experienciaEnSimilares(receta) = self.preparacionesSimilaresA(receta).sum({ com => com.experiencia() })
    method entrenar(recetario) {
        const recetasPosibles = recetario.filter({ recet => nivel.puedePreparar(recet, self) })
        if (recetasPosibles.isEmpty()) {
             throw new DomainException(message = "No puede practicar nada")
        }
        const recetaElegida = recetasPosibles.max({ recet => recet.experienciaBase() })
        self.preparar(recetaElegida)
    }
}


object principiante {
    method puedePreparar(receta, cocinero) = !receta.esDificil()
    
    method determinarCalidad(receta, cocinero) = if (receta.ingredientes().size() < 4) normal else pobre
    method superaNivel(cocinero) = cocinero.experienciaAdquirida() > 100
    method siguienteNivel() = experimentado
}

class Nivelexperimentado {
    method puedePreparar(receta, cocinero) = !receta.esDificil() || 
               !cocinero.preparacionesSimilaresA(receta).isEmpty()
    
    method determinarCalidad(receta, cocinero) {
        if (self.lograPerfeccionar(receta, cocinero)) {
            const plusLocalDeEsteIf = cocinero.preparacionesSimilaresA(receta).size() / 10 
            return new Superior(plus = plusLocalDeEsteIf) 
        } else {
            return normal
        }
    }
    
    method lograPerfeccionar(receta, cocinero) = cocinero.experienciaEnSimilares(receta) > (3 * receta.experienciaBase())
    method superaNivel(cocinero) = cocinero.cantidadComidasDificiles() > 5
    method siguienteNivel() = chef
}
const experimentado = new Nivelexperimentado()

object chef inherits Nivelexperimentado { 
    override method puedePreparar(receta, cocinero) = true 
    override method superaNivel(cocinero) = false 
    override method siguienteNivel() = self
}

object academia {
    const property estudiantes = []
    const property recetario = []
    
    method entrenarEstudiantes() {
        self.entrenarRecursivo(estudiantes)
    } 
    method entrenarRecursivo(listaEstudiantes) {
        if (!listaEstudiantes.isEmpty()) {
            listaEstudiantes.head().entrenar(recetario)
            self.entrenarRecursivo(listaEstudiantes.tail())
        }
    }
}