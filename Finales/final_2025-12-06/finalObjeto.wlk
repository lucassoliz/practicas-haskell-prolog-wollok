//Clase tal cual del enunciado:
class Pollo {
    var peso = 100
    var estaSano = false
    var descripcion = "cocó"

    method sanar() {
        estaSano = true
    }

    method aumentarPeso(incremento) {
        peso += incremento
    }

    method agregarDescripcion(agregado) {
        descripcion = agregado + descripcion
    }
}

/* MEDICAMENTOS
   Usamos Polimorfismo: todos entienden el mensaje 'aplicarA(pollo)'
*/

// La vacuna es siempre igual (sin estado), así que usamos un object
object vacuna {
    method aplicarA(pollo) {
        pollo.sanar()
        pollo.aumentarPeso(10)
    }
}

// El antibiótico depende de la dosis, así que usamos una clase para instanciarlo
class Antibiotico {
    const dosis
    
    method aplicarA(pollo) {
        pollo.sanar()
        // Disminuye peso según dosis. Usamos negativo porque aumentarPeso suma
        pollo.aumentarPeso(-dosis) 
    }
}

// La pastilla depende del color, usamos una clase para instanciarlo
class Pastilla {
    const color
    
    method aplicarA(pollo) {
        // "agrega el color... al principio de la descripción"
        pollo.agregarDescripcion(color + " ") 
    }
}

/* EL SISTEMA (CRIADERO)
*/
object criadero {
    const pollos = [] // Asumimos que ya tiene pollos cargados
    
    method agregarPollo(unPollo) {
        pollos.add(unPollo)
    }

    // Punto clave: Trata a todos los medicamentos igual (Polimorfismo)
    method suministrar(medicamento) {
        pollos.forEach({ pollo => medicamento.aplicarA(pollo) })
    }
}

/*
3)B ejemplos de invocacion de los casos tipicos 

------SUMINISTRAR A TODOS LOS POLLOS UNA VACUNA

criadero.suministrar(vacuna)

------SUMINISTRAR A TODOS LOS POLLOS UNA PASTILLA VERDE

criadero.suministrar(new Pastilla(color = "verde"))

------SUMINISTRAR A TODOS LOS POLLOS UN ANTIBIOTICO CON DOSIS 5

criadero.suministrar(new Antibiotico(dosis = 5))

=================================================================
PUNTO 4
POLIMORFISMO:
    Donde se uso: En el metodo suministrar(medicamento) del objeto criadero

    VENTAJA: El criadero no necesita preguntar con un if que tipo de medicamento es (si es vacuna, pastilla, etc...)
    Simplemente le envia el mensaje aplicarA(pollo) y confia en que el objeto lo entendera
    Esto permite agregar nuevos medicamentos en el futuro sin tener que modificar el criadero

ENCAPSULAMIENTO
    Donde se uso: En la clase Pollo, los atributos peso, estaSano y descripcion son privados
    Solo se pueden modificar a traves de los metodos sanar(), aumentarPeso() y agregarDescripcion()

    VENTAJA: Esto protege el estado interno del pollo, evitando que otros objetos modifiquen sus atributos directamente
    Garantiza que cualquier cambio en el estado del pollo pase por las reglas definidas en sus metodos


CLASES VS OBJETOS (INSTANCIAS)
    Donde se uso: 
        - Clases: Pollo, Antibiotico, Pastilla (se usan para crear instancias con estado propio)
        - Objetos: vacuna, criadero (son singletones sin estado propio o con estado compartido)

    VENTAJA: Usar clases permite crear multiples instancias con diferentes estados (ej: varios pollos, distintos antibioticos y pastillas)
    Usar objetos permite definir comportamientos compartidos o sin estado (ej: vacuna, criadero)
    objetos cuando el comportamiento es fijo y único (la vacuna siempre hace lo mismo), ahorrando memoria y código
    
*/