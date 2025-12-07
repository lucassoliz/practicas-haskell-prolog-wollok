/* idea de estructura
Mago:
    - Estado: nombre, poderInnato (1-10), resistenciaMagica, energiaMagica
    - Estrategia: categoria (Aprendiz, Veterano, Inmortal)
    - Coleccion: objetosEquipados (Lista)

    + poderTotal(): objetos.sum(obj -> obj.poder(self)) * poderInnato
       IMPORTANTE: pasar 'self' al objeto para que sepa quién lo usa xd
    
    + desafiar(oponente): 
       -> si oponente.esVencidoPor(self) entonces oponente.entregarEnergiaA(self)

    + esVencidoPor(atacante): delega en categoria -> categoria.esVencido(self, atacante)
    
    + lider(): devuelve self (Caso base para el Gremio)

Objeto Magico (Polimorfismo):
    + poder(usuario): Recibe al mago por parámetro
        Varita:
            -> si usuario.tieneNombrePar() ? valorBase * 1.5 : valorBase
        TunicaComun:
            -> 2 * usuario.resistenciaMagica()
        TunicaEpica:
            -> (2 * usuario.resistenciaMagica()) + 10
        Amuleto:
            -> 200 (fijo, ignora todo)
        Ojota (Object unico):
            -> 10 * usuario.cantidadLetrasNombre()

Categorias (Pattern Strategy):
    Aprendiz:
        + esVencido(defensor, atacante): defensor.resistencia < atacante.poder
        + energiaARobar(defensor): defensor.energia / 2
    Veterano:
        + esVencido(defensor, atacante): atacante.poder >= (1.5 * defensor.resistencia)
        + energiaARobar(defensor): defensor.energia / 4
    Inmortal:
        + esVencido: false (nunca pierde)
        + energiaARobar: 0

Gremio (Pattern Composite):
    - Estado: miembros (Lista de Magos u otros Gremios)

    + initialize(): validar que miembros.size() >= 2

    + poderTotal(): miembros.sum(m -> m.poderTotal())
    
    + resistenciaMagica(): 
        -> miembros.sum(resistencia) + self.lider().resistencia()

    + lider(): 
        1. Buscar miembro con mayor poderTotal (max)
        2. Devolver miembroMasPoderoso.lider() (Recursividad para gremios dentro de gremios)
    
    + desafiar / esVencidoPor: Misma interfaz que Mago (Polimorfismo)
    
    + recibirEnergia / entregarEnergia: Delega todo en self.lider()
*/

class Mago {
    const property nombre
    const property objetos = []
    var property poderInnato = 1 // De 1 a 10
    var property resistenciaMagica
    var property energiaMagica
    var property categoria // Strategy
    
    // calculos de Poder 
    method poderTotal() = objetos.sum({ obj => obj.poder(self) }) * poderInnato

    // Auxiliares para Items
    method tieneNombrePar() = nombre.size().even()
    method cantidadLetrasNombre() = nombre.size()

    //logica de Desafio (Atacar)
    method desafiar(oponente) {
        if (oponente.esVencidoPor(self)) {
            // El oponente pierde energía y me la da a mí
            oponente.entregarEnergiaA(self) 
        }
    }

    // logica de Defensa (Ser Atacado) 
    method esVencidoPor(atacante) = categoria.esVencido(self, atacante)

    method entregarEnergiaA(ganador) {
        const puntosPerdidos = categoria.energiaARobar(self)
        self.perderEnergia(puntosPerdidos)
        ganador.recibirEnergia(puntosPerdidos)
    }

    method perderEnergia(cantidad) {  //accion por eso {}
        energiaMagica = energiaMagica - cantidad
    }

    //Manejo de eenergía (Ganar) 
    method recibirEnergia(cantidad) {
        energiaMagica = energiaMagica + cantidad
    }
    
    //Para Composite (Gremio)
    // Un mago es su propio líder
    method lider() = self 
}
//===================================
class ObjetoMagico {
    const property valorBase = 0 // Default para objetos que no lo usan
    
    method poder(usuario)
}

class Varita inherits ObjetoMagico {

    override method poder(usuario) = if (usuario.tieneNombrePar()) valorBase * 1.5 else valorBase
}

class TunicaComun inherits ObjetoMagico {
    override method poder(usuario) = 2 * usuario.resistenciaMagica()
}

class TunicaEpica inherits TunicaComun {
    override method poder(usuario) = super(usuario) + 10
}

class Amuleto inherits ObjetoMagico {
    override method poder(usuario) = 200
}

object ojotaMagica { // Es única e irrepetible -> object
    method poder(usuario) = 10 * usuario.cantidadLetrasNombre()
}
//===================================
object aprendiz {
    method esVencido(defensor, atacante) = defensor.resistenciaMagica() < atacante.poderTotal()
    method energiaARobar(defensor) = defensor.energiaMagica() / 2
}
object veterano {
    method esVencido(defensor, atacante) = atacante.poderTotal() >= (1.5 * defensor.resistenciaMagica())
    method energiaARobar(defensor) = defensor.energiaMagica() / 4
}

object inmortal {
    method esVencido(defensor, atacante) = false // Nunca es vencido
    method energiaARobar(defensor) = 0
}
//================================
class Gremio {
    const miembros = []

    method initialize() {
        if (miembros.size() < 2) {
            throw new DomainException(message = "Un gremio debe tener al menos 2 miembros")
        }
    }

    //Poder y Resistencia (Suma de miembros)
    method poderTotal() = miembros.sum({ elementoLista => elementoLista.poderTotal() })

    method resistenciaMagica() =
        // La resistencia de todos los miembros + la del líder (que cuenta doble en total)
     miembros.sum({ miembro => miembro.resistenciaMagica() }) + self.lider().resistenciaMagica()
    

    //El Lider (Recursivo)
    /* Busca al miembro con mayor poder total. 
       Luego le pide .lider() a ese miembro.
       - Si es un Mago, devuelve self.
       - Si es un Gremio, delega a su propio líder.
    */
    method lider() = miembros.max({ miemb => miemb.poderTotal() }).lider()

    //Desafiar (Como atacante)
    method desafiar(oponente) {
        if (oponente.esVencidoPor(self)) {
            oponente.entregarEnergiaA(self)
        }
    }

    //Ser Desafiado (como defensor 
    method esVencidoPor(atacante) = atacante.poderTotal() > self.resistenciaMagica()

    method entregarEnergiaA(ganador) {
        // Opcion: que pague el lider
        self.lider().entregarEnergiaA(ganador)
    }

    method recibirEnergia(cantidad) {
        self.lider().recibirEnergia(cantidad)
    }
}