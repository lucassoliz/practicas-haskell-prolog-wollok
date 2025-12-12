/*
PARTE C
    PUNTO 1
a. Es necesario agregar una superclase Evento para que los distintos tipos de eventos sean polimórficos

    FALSO: Para que dos objetos sean polimorficos NO ES OBLIGATORIO que hereden de una superclase en comun
    Lo unico necesario es que entiendan los mismos mensajes (que tengan la misma interfaz) 
    Si ambos responden al mensaje que les envia el calendario, ya son polimorficos
    Sin necesidad de herencia 

b. Es posible agregar un nuevo tipo de evento: los de varios días 
(lista con todos los días que ocupa), sin cambiar el código de la clase calendario

    FALSO: El codigo actual de Calendario esta acoplado a la estructura interna de los eventos actuales
    
*/

class Calendario {
    const property eventos = [] //property para almacenar eventos

    /* MEJORA: Delegamos la lógica al evento.
       El calendario ya no pregunta "qué sos" (recordatorio, dia completo, etc.....
       Solo pregunta "che, estas ocupando esta fecha????"
       Esto cumple Open/Closed: podemos agregar eventos nuevos sin tocar esto.
    */
    method estaLibre(unaFecha) {
        // La fecha está libre si NINGÚN evento la ocupa
        return eventos.all({ evento => !evento.ocupaFecha(unaFecha) })
    }
}

// TIPOS DE EVENTOS (Polimórficos) ---------------

class EventoDiaCompleto {
    const property fecha 
    
    // Ocupa la fecha si es exactamente el mismo día
    method ocupaFecha(unaFecha) = fecha == unaFecha
}

class Recordatorio {
    // Los recordatorios nunca ocupan lugar (según enunciado xd
    method ocupaFecha(unaFecha) = false
}

// NUEVO TIPO: Evento de varios días (claramente lista de fechas)
class EventoVariosDias {
    const property fechasQueOcupa = [] // Lista de objetos Date
    
    // Ocupa la fecha si esa fecha está en su lista
    method ocupaFecha(unaFecha) = fechasQueOcupa.contains(unaFecha)
}

// FALTA AGREGAR DIAGRAMAS DE CLASES