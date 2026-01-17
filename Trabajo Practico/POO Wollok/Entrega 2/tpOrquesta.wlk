 object generadorRandom {
  method valorRandom() = 1.randomUpTo(10)
 }
 
 
 class Instrumento {
  //INTEGRANTE 2
    const property familia
    var property numeroAlAzar = 1.randomUpTo(10)
    var property random = generadorRandom
    var property historialRevisiones = []
    var maximoDiasRecientes = 60
    var minimoDiasRevision = 7
    method multiplicador() = if (random.valorRandom().even()) 2 else 3
    method cuantoCuesta() = familia.size() * self.multiplicador()
    method esSensitivo() = familia.size() == 7
    method esCopado() = false    
    method estaAfinado() = !self.noTieneRevisiones() && self.ultimaRevision().fecha().between(
      self.fechaActual().minusMonths(1), self.fechaActual()
    )
   //todos los integrantes: consultas
    method fechaActual() = new Date()
    method revisionesRecientes() = historialRevisiones.filter{
        verificacion => verificacion.fecha().between(
                self.fechaActual().minusMonths(2), 
                self.fechaActual()
            )
        }
    //INTEGRANTE 3
    method ultimaRevision() = historialRevisiones.last()    
    method noTieneRevisiones() =  historialRevisiones.size().equals(0)
    method esReciente() = !self.noTieneRevisiones() && self.ultimaRevision().fecha().plusDays(minimoDiasRevision) >= self.fechaActual()
    method correspondeRevision() = self.noTieneRevisiones() || !self.esReciente()
    method afinar(){} //este metodo de efecto varia segun el instrumento, como en los genericos no hace nada lo dejo en blanco
    method revisar(tecnico) {
      tecnico.verificarRevision(self)
      if(!self.noTieneRevisiones()) {
        self.correspondeRevision()
      }
      self.registrarVerificacion(new Revision(tecnico = tecnico, fecha = new Date()))
      self.afinar()
    }

    method registrarVerificacion(revision){
      historialRevisiones.add(revision)
    }
}

//INTEGRANTE 3 =========================================================
class Tecnico {
  var property nombre 
  var property familia
  
  method sabeAfinar(instrumento) = instrumento.familia().equals(familia)
  method verificarRevision(instrumento) {
    if(!self.sabeAfinar(instrumento)) {
      throw new DomainException (message = "El tecnico no sabe afinar instrumenetos de esa familia")
    }
  }
}

class Verificacion {
  const property tecnico
  const property fecha
}

class Revision{
  const property tecnico
  const property fecha

  method verificarCorrespondeRevision (instrumento){
    if(!instrumento.correspondeRevision()) throw new DomainException (message = "Ha pasado menos de 1 semana desde la ultima revision")
  }

}

//INTEGRANTE 2========================================================
class Habitacion {
    var property ancho
    var property largo
    method metrosCuadrados() = ancho * largo
}

// ======== Los Instrumentos ==========================================

// ==== Guitarra Fender - Todos los integrantes ====
object fender inherits Instrumento(familia = "cuerdas") {
  var property color = "negra"

  method esValioso() = true
  override method estaAfinado() = true
  override method cuantoCuesta() = if (color == "negra") 15 else 10
  override method esSensitivo() = super() && self.cuantoCuesta() > 12
}

// ==== Trompeta Jupiter - Integrante 1 ====
object jupiter inherits Instrumento(familia = "vientos") {
  var property tieneSardina = true
  var property temperaturaAmbiente = 22
  var property calentamiento = false
  override method estaAfinado() = temperaturaAmbiente.between(20,25) || calentamiento
  override method afinar() { calentamiento = true }

  method revisarTermometro(temperaturaActual) { 
    temperaturaAmbiente = temperaturaActual
    calentamiento = false}

  method esValioso() = false
  override method cuantoCuesta() = 30 + (if(tieneSardina) 5 else 0)

  override method esCopado() = tieneSardina
}

// ==== Piano Bechstein - Integrante 2 ====
object bechstein inherits Instrumento(familia = "teclado") {
  var property habitacion = new Habitacion(ancho = 5, largo = 5)

  override method cuantoCuesta() = super() + (2 * habitacion.ancho())
  override method estaAfinado() = habitacion.metrosCuadrados() > 20
  method esValioso() = self.estaAfinado()
  override method esCopado() = self.habitacion().ancho() > 6 || self.habitacion().largo() > 6

  override method afinar(){
    habitacion = new Habitacion(ancho= 8, largo= 4)
  }
}

// ==== Violin Stagg - Integrante 3 ====
object stagg inherits Instrumento(familia = "cuerdas") {
  var property cantidadTremolos = 0
  var property tipoPintura = "laca acrilica"
  
  method hacerTremolo() { cantidadTremolos = cantidadTremolos + 1 }
  override method estaAfinado() = cantidadTremolos < 10
  override method cuantoCuesta() = 15.max(20 - cantidadTremolos)
  method esValioso() = tipoPintura == "laca acrilica"

  override method afinar(){
    cantidadTremolos = 0
  }
}

// ==== Asociacion Musical ====
object asociacionMusical {
  const listaMusicos = #{johann, wolfgang, antonio, giuseppe, maddalena}

  method musicos() = listaMusicos

  method agregarMusico(musico) { listaMusicos.add(musico) }
  method quitarMusico(musico)  { listaMusicos.remove(musico) }

  method musicosFelices() = listaMusicos.filter({musico => musico.esFeliz()})
}

/*
  Correccion Final:
  Buena resolucion en general, y definicion de tests, solo marqué como mejorar las descripciones,
  el uso de algunas funciones auxiliares como max, between o even
  Tengan cuidado con algunas resoluciones donde definen comportamiento que no está definido en el enunciado.

  Nota final: 2,5 puntos para cada uno
*/

// ==== TP2 - Integrante 1 - Class Musico y Orquesta ====
// PD: Ordeno los musicos despues de las clases para que sea mas prolijo

class Musico {
  var property instrumentoActual
  var property familiaInstrumentosFavorita    // cuerdas, vientos, percusion, etc

  method esExperto() = instrumentoActual.familia().equals(familiaInstrumentosFavorita)
  method esFeliz() = instrumentoActual.esCopado()
}

class Orquesta {
    const property cantidadMaximaMusicos
    const property integrantes = []
    // Los dejo en const property para que no se pueda modificar de manera externa,
    // Pero si se pueda consultar a que referencia

    // Yo lo hubiera hecho con un Set en vez de una lista para evitar duplicados pero la logica rescata el caso de ingresar duplicados, 
    // asi q dejo lista para marcar esa diferencia y que la logica anda

    // Modificadores
    method agregarMusico(musico) {
        self.verificarCantidadMusicosDisponibles()
        self.verificarMusicoPresente(musico)
        integrantes.add(musico)
    }
    method quitarMusico(musico) {
        integrantes.remove(musico)
        // no hace falta un if(integrantes.contains(musico)) porque al remove no le afecta si el elemento no existe en el set/lista
    }

    // Verificadores
    method verificarCantidadMusicosDisponibles() {
        if(cantidadMaximaMusicos.equals(integrantes.size()))
            throw new DomainException(message = "La orquesta se quedo sin cupos disponibles. No se puede agregar mas musicos.")
    }
    method verificarMusicoPresente(musico) {
        if(integrantes.contains(musico))
            throw new DomainException(message = "El musico ya pertenece a la orquesta. No se puede agregar nuevamente.")
    }

    // Consultores
    method bienConformada() = integrantes.all{musico => musico.esFeliz()}
    method esDiversa() =
        integrantes.size().equals(
            integrantes.map{
                musico => musico.instrumentoActual().familia()
            }.asSet().size()
        )

    method esDiversaBis() {
      const conjuntoFamilias = integrantes.map{
                musico => musico.instrumentoActual().familia()
            }

      return conjuntoFamilias.size() == conjuntoFamilias.asSet().size()
    }
    // integrantes.map(musico -> musico.instrumentoActual().familia()) devuelve una lista con todas las familias
    // de instrumentos que se usan, habiendo repetidos en caso de haber
    // asSet() transforma la lista en set, eliminando duplicados
    // Si el size del set de instrumentos es menor al size de integrantes, significa que hay instrumentos repetidos
}

const instrumentoIndefinido = new Instrumento(familia = "indefinida")

// ======== Los Musicos (TP1) ========
object johann inherits Musico (instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos") {
  override method esFeliz() = instrumentoActual.cuantoCuesta() > 20
}
object wolfgang inherits Musico (instrumentoActual = instrumentoIndefinido, familiaInstrumentosFavorita = johann.familiaInstrumentosFavorita()) {
  override method esFeliz() = johann.esFeliz() 
}
object antonio inherits Musico (instrumentoActual = bechstein, familiaInstrumentosFavorita = "cuerdas") {
  override method esFeliz() = instrumentoActual.esValioso()
}
object giuseppe inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {
  override method esFeliz() = instrumentoActual.estaAfinado()
}
object maddalena inherits Musico (instrumentoActual = stagg, familiaInstrumentosFavorita = "cuerdas") {
  override method esFeliz() = instrumentoActual.cuantoCuesta().even()
}