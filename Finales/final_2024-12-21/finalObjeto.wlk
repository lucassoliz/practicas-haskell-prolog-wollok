/*
PUNTO A 
PUNTO 1 VERDADERO O FALSO
---------------------------------------
a. Sin modificar los métodos existentes, puede agregarse fácilmente un nuevo tipo de cuenta...

FALSO: La solucion actual no respeta el principio de "Abierto/Cerrado"  
Como la logica depende de condicionales explicitos (if (tipo == "Básica")... else if...),
para agregar una cuenta "Pro" estarias obligado a modifciar todos los metodos existentes
(estado, reproducirContenido, descargarContenido) agregando nuevos else if

-------------------------------------------

b. Si se agrega un método transferirContenido... Si una de las cuentas no tiene espacio, 
no se afecta el estado de la otra.

FALSO: El metodo propuesto no es transaccional y el codigo original no maneja errores correctamente
(devuelve strings en lugar de lanzar Excepciones)

1. Se ejecuta cuenta1.descargarContenido(-5), lo que resta espacio consumido a la 
cuenta 1 (libera espacio)

2. Luego se ejecuta cuenta2.descargarContenido(5). Si falla (por falta de espacio), el método 
original solo retorna el string "No hay suficiente espacio.", pero no deshace 
la liberación de espacio de la cuenta1

Resultado: La cuenta1 quedó con espacio liberado "mágicamente" sin que la cuenta2 lo 
recibiera. El sistema queda inconsistente

*/

//PUNTO 2

class Cuenta {
 // PATRÓN STRATEGY: Delegamos el comportamiento en un objeto polimórfico
    // Usamos var para permitir el cambio dinámico de estrategia en tiempo de ejecución
    var property tipo 
    
    const property usuarioPrincipal
    var property horasConsumidas = 0
    var property espacioConsumido = 0
    
    // Mantenemos los perfiles en la cuenta para que no se pierdan al cambiar de plan
    // (cumple requisito: "conservando sus datos relevantes")
    const property perfiles = [] 

    // Delegamos todo el comportamiento al Estado
    method estado() {
        return "Tipo: " + tipo.nombre() + ", Usuario: " + usuarioPrincipal + ", " + 
               tipo.infoEspecifica(self)
    }

    method reproducirContenido(horas) {
        tipo.reproducir(self, horas)
    }

    method descargarContenido(gb) {
        tipo.descargar(self, gb)
    }
    
    // Método auxiliar para cambiar de plan fácilmente
    method cambiarPlan(nuevoTipo) {
        tipo = nuevoTipo
    }
}

//ESTADOS (Tipos de Cuenta)--------------------

class Basica {
    const limiteHoras
    
    method nombre() = "Básica"
    method infoEspecifica(cuenta) {
        return "Horas restantes: " + (limiteHoras - cuenta.horasConsumidas())
    }

    method reproducir(cuenta, horas) {
        if (cuenta.horasConsumidas() + horas > limiteHoras) {
            //Usamos Excepciones, no return string
            throw new DomainException(message = "No podés reproducir más contenido")
        }
        cuenta.horasConsumidas(cuenta.horasConsumidas() + horas)
    }

    method descargar(cuenta, gb) {
        throw new DomainException(message = "Tu plan no permite descargas")
    }
}

class Premium {
    const limiteEspacio
    
    method nombre() = "Premium"
    
    method infoEspecifica(cuenta) {
        return "Espacio disponible: " + (limiteEspacio - cuenta.espacioConsumido()) + "GB"
    }

    method reproducir(cuenta, horas) {
        // No tiene límite, solo registra
        cuenta.horasConsumidas(cuenta.horasConsumidas() + horas)
    }

    method descargar(cuenta, gb) {
        if (cuenta.espacioConsumido() + gb > limiteEspacio) {
            throw new DomainException(message = "No hay suficiente espacio")
        }
        // Acepta negativos para liberar espacio (necesario para el punto 1.b corregido)
        cuenta.espacioConsumido(cuenta.espacioConsumido() + gb)
    }
}

// Herencia: Familiar "Es como una cuenta Premium"
class Familiar inherits Premium {
    
    override method nombre() = "Familiar"
    override method infoEspecifica(cuenta) {
        // Reutilizamos la lógica de espacio de Premium y agregamos perfiles
        return super(cuenta) + ", Perfiles: " + cuenta.perfiles().size()
    }
}

/*
Si te fijas... teneemos:
Polimorfismo:  La clase Cuenta no tiene ni un solo if. Trata a todos los tipos por igual
enviando mensajes (reproducir, descargar)
Extensibilidad: Si queres agregar la cuenta Pro , solo creas una class Pro inherits Premium (o lo que corresponda)
y listo. No tocas el codigo de Cuenta ni de Baisoc
Manejo de errores: Al usar DomainException, si falla una descarga en una transferencia
el proceso se interrumpe inmediatamente, evitando estados inconsistentes

Consistencia de Datos: Al guardar horasConsumidas y perfiles en la clase Cuenta, un
usuario puede pasar de Familiar a Básica sin perder sus datos relevantes y luego volver a Familiar

*/