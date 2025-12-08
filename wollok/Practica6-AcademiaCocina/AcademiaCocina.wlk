/*
si te sirve de guia o ayuda te dejon esto commo comentario:
Cocinero:
    - Estado: 
        * preparaciones (Lista de Comidas)
        * nivelAprendizaje (Strategy: Principiante, Experimentado, Chef)
    
    - Comportamiento:
        + experienciaAdquirida(): preparaciones.sum(comida -> comida.experiencia())
        
        + preparar(receta):
            1. Validar si puede preparar la receta (Delegar al nivel).
            2. Si puede:
                a. Determinar la calidad de la comida (Delegar al nivel).
                b. Instanciar nueva Comida(receta, calidad).
                c. Agregar a preparaciones.
                d. Chequear si sube de nivel (Delegar al nivel).
                
        + leSalenSimilarA(receta): 
            -> preparaciones.filter(c => c.esSimilarA(receta))
            
        + cantidadComidasDificiles(): 
            -> preparaciones.count(c => c.receta().esDificil())

Receta:
    - Estado: ingredientes (Lista), dificultad (Numero)
    - Comportamiento:
        + esDificil(): dificultad > 5 || ingredientes.size() > 10
        + experienciaBase(): ingredientes.size() * dificultad
        + esSimilarA(otraReceta): mismos ingredientes o diferencia dificultad <= 1

RecetaGourmet (Herencia de Receta):
    + esDificil(): true (siempre)
    + experienciaBase(): super() * 2

Comida (El resultado de cocinar):
    - Estado: receta, calidad (Strategy)
    - Comportamiento:
        + experiencia(): calidad.calcularExperiencia(receta)
        + esSimilarA(receta): receta.esSimilarA(self.receta)

Calidades (Strategy para calcular experiencia):
    1. Normal:
        + calcularExperiencia(receta): receta.experienciaBase()
    2. Pobre:
        - Estado global/configurable: experienciaMaximaPobre
        + calcularExperiencia(receta): min(receta.experienciaBase(), experienciaMaximaPobre)
    3. Superior:
        - Estado: plus (se calcula al momento de crearla)
        + calcularExperiencia(receta): receta.experienciaBase() + plus

Niveles de Aprendizaje (State/Strategy):
    1. Principiante:
        + puedePreparar(receta, cocinero): !receta.esDificil()
        + determinarCalidad(receta, cocinero): 
             -> si receta.ingredientes().size() < 4 ? Normal : Pobre
        + superaNivel(cocinero): cocinero.experienciaAdquirida() > 100
        + siguienteNivel(): Experimentado

    2. Experimentado:
        + puedePreparar(receta, cocinero): 
             -> !receta.esDificil() OR cocinero.leSalenSimilarA(receta).isNotEmpty()
        + determinarCalidad(receta, cocinero):
             -> si lograPerfeccionar(receta, cocinero) ? Superior(plus) : Normal
             -> logicaPerfeccionar: experiencia acumulada en similares > (3 * receta.experienciaBase())
             -> calculoPlus: cocinero.leSalenSimilarA(receta).size() / 10
        + superaNivel(cocinero): cocinero.cantidadComidasDificiles() > 5
        + siguienteNivel(): Chef

    3. Chef:
        + puedePreparar(receta, cocinero): true (Prepara todo)
        + determinarCalidad(receta, cocinero): Igual logica que Experimentado
        + superaNivel(cocinero): false (No hay mas niveles)

Academia:
    - Estado: estudiantes (Lista Cocineros), recetario (Lista Recetas)
    - Comportamiento:
        + entrenarEstudiantes():
            -> estudiantes.forEach(estudiante -> estudiante.entrenar(recetario))
        
        (En Cocinero):
        + entrenar(recetario):
            1. Filtrar recetario: recetas que puedo preparar.
            2. Elegir la que da mas experiencia BASE (recetarioFiltrado.max(r -> r.experienciaBase()))
            3. preparar(esaReceta)
*/

//RECETAS
class Receta {
    const property ingredientes = []
    const property dificultad 
    
    // Punto 1
    method experienciaBase() = ingredientes.size() * dificultad
    method esDificil() = dificultad > 5 || ingredientes.size() > 10
    method esSimilarA(otraReceta) = self.mismosIngredientes(otraReceta) || 
           otraReceta.dificultad().between(dificultad - 1, dificultad + 1)
    
    // asSet() convierte lista a conjunto para comparar sin importar orden
    method mismosIngredientes(otra) = ingredientes.asSet() == otra.ingredientes().asSet()
}

// Punto 4: Receta Gourmet
class RecetaGourmet inherits Receta {
    override method esDificil() = true
    override method experienciaBase() = super() * 2
}

//2) comida y calidades /Strategy para experiencia)
class Comida {
    const property receta
    const property calidad // Strategy (Pobre, Normal o Superior)
    
    method experiencia() = calidad.calcularExperiencia(receta)
    method esDificil() = receta.esDificil()
    method esSimilarA(otraReceta) = receta.esSimilarA(otraReceta)
}
//Estrategias de Calidad
object normal {
    method calcularExperiencia(receta) = receta.experienciaBase()
}
object pobre {
    var property experienciaMaxima = 4 //Configurable por la academia
    
    method calcularExperiencia(receta) = receta.experienciaBase().min(experienciaMaxima)
}
class Superior {
    const plus
    method calcularExperiencia(receta) = receta.experienciaBase() + plus
}

// 3. COCINERO (Clase Principal)
class Cocinero {
    const property preparaciones = []
    var property nivel = principiante // Strategy (Arranca como principiante)
    // Punto 1
    method experienciaAdquirida() = preparaciones.sum({ comida => comida.experiencia() })
    // Punto 3: Preparar Comida
    method preparar(receta) {
        // A. validar
        if (!nivel.puedePreparar(receta, self)) {
            throw new DomainException(message = "El cocinero no tiene nivel para esta receta")
        }
        // b. Crear cmida (el nivel decide la calidad)
        const calidad = nivel.determinarCalidad(receta, self) //variable local, solo vive aca nomas
        const comida = new Comida(receta = receta, calidad = calidad) //esto es para crear la comida 
        
        // C. Agregar
        preparaciones.add(comida)
        // D. Evolucionar
        if (nivel.superaNivel(self)) {
            nivel = nivel.siguienteNivel()
        }
    }
    
    //auxiliares para nivel
    
    method cantidadComidasDificiles() = preparaciones.count({ comida => comida.esDificil() })
    method preparacionesSimilaresA(receta) = preparaciones.filter({ comida => comida.esSimilarA(receta) })
    method experienciaEnSimilares(receta) = self.preparacionesSimilaresA(receta).sum({ com => com.experiencia() })

    // Punto 5: Entrenamiento
    method entrenar(recetario) {
        // Filtra las que puede hacer
        const recetasPosibles = recetario.filter({ recet => nivel.puedePreparar(recet, self) })
        
        if (recetasPosibles.isEmpty()) {
             throw new DomainException(message = "No puede practicar nada")
        }

        // Elige la que da maas experiencia BASE (segun enunciado xd)
        const recetaElegida = recetasPosibles.max({ recet => recet.experienciaBase() })
        
        self.preparar(recetaElegida)
    }
}

// 4 niceles de aprendizaje (State Pattern)

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
        // Logica compartida con Chef: intentar perfeccionar
        if (self.lograPerfeccionar(receta, cocinero)) {
            const plusLocalDeEsteIf = cocinero.preparacionesSimilaresA(receta).size() / 10 //variable local, solo vive aca
            return new Superior(plus = plusLocalDeEsteIf) //ACA estamos creando la calidad Superior 
        } else {
            return normal
        }
    }
    
    method lograPerfeccionar(receta, cocinero) = cocinero.experienciaEnSimilares(receta) > (3 * receta.experienciaBase())
    
    method superaNivel(cocinero) = cocinero.cantidadComidasDificiles() > 5
    method siguienteNivel() = chef
}
const experimentado = new Nivelexperimentado()

object chef inherits Nivelexperimentado { // Hereda para reutilizar determinarCalidad
    override method puedePreparar(receta, cocinero) = true // Puede todo
    
    override method superaNivel(cocinero) = false // Tope de carrera
    override method siguienteNivel() = self
}
//5. ACADEMIA
object academia {
    const property estudiantes = []
    const property recetario = []
    
    // recursividad)
    method entrenarEstudiantes() {
        self.entrenarRecursivo(estudiantes)
    } 

    method entrenarRecursivo(listaEstudiantes) {
        if (!listaEstudiantes.isEmpty()) {
            // 1. Entreno a la cabeza (el primero)
            listaEstudiantes.head().entrenar(recetario)
            // 2. Llamo recursivamente con la cola (el resto de la lista xd)
            self.entrenarRecursivo(listaEstudiantes.tail())
        }
    }
}


/*
object academia {
    const property estudiantes = []
    const property recetario = []
    
    method entrenarEstudiantes() {
        estudiantes.forEach({ estudiante => estudiante.entrenar(recetario) })
    }
}
*/