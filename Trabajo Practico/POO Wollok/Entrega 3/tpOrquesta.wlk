 object generadorRandom {
  method valorRandom() = 1.randomUpTo(10)
 }
 
 
 class Instrumento {
  //INTEGRANTE 2
    const property familia
    var property random = generadorRandom
    var property historialRevisiones = []
    var property maximoDiasRecientes = 60
    var property minimoDiasRevision = 7
    method multiplicador() = if (random.valorRandom().even()) 2 else 3
    method cuantoCuesta() = familia.size() * self.multiplicador()
    method esSensitivo() = familia.size() == 7
    method esCopado() = false    
    method estaAfinado() = !self.noTieneRevisiones() && self.ultimaRevision().fecha().between(
      self.fechaActual().minusMonths(1), self.fechaActual()
    )
   //todos los integrantes: consultas
    method fechaActual() = new Date()
    //method revisionesRecientes() = historialRevisiones.filter{
    //    verificacion => verificacion.fecha().between(
    //            self.fechaActual().minusDays(maximoDiasRecientes), 
    //            self.fechaActual()
    //        )
     //   }

    method revisionesRecientes() = historialRevisiones.filter{
        revision => revision.esReciente(maximoDiasRecientes)
    }
    //INTEGRANTE 3
    method ultimaRevision() = historialRevisiones.last()    
    method noTieneRevisiones() =  historialRevisiones.size().equals(0)
    method revisadoEstaSemana() = !self.noTieneRevisiones() && self.ultimaRevision().fecha().plusDays(minimoDiasRevision) >= self.fechaActual()
    method correspondeRevision() = self.noTieneRevisiones() || !self.revisadoEstaSemana()
    method afinar(){} //este metodo de efecto varia segun el instrumento, como en los genericos no hace nada lo dejo en blanco
    method revisar(tecnico) {
      tecnico.verificarRevision(self)
      if(!self.correspondeRevision()){
        throw new DomainException (message = "Su ultima revision es reciente")
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
  const property nombre 
  const property listaDePreferencias = [preferenciaDefault]
  /* CORRECCION Entrega 3
    El tecnico tiene solo una preferencia para arreglar instrumentos,
    en el enunciado se dice que por default todas las instancias de Tecnico se inicializan
    con la preferencia por default, pero que la preferencia puede cambiar
  */
  var property preferenciaDefault // CORRECCION Entrega 3: No tiene sentido tener como property una preferencia default y una lista de preferencias

  var property cantidadMinimaDeCombinadas = 2 // CORRECCION Entrega 3: No entiendo la necesidad de esta property, el tecnico solo puede tener una preferencia

  method tieneVariasPreferencias ()= listaDePreferencias.size() >= cantidadMinimaDeCombinadas

  method agregarPreferencia (preferencia){
    if(!listaDePreferencias.contains(preferencia)){
      listaDePreferencias.add(preferencia) 
      preferenciaDefault = preferencia
    }
    else throw new DomainException (message = "El tecnico ya tiene esa preferencia")
  } 

  method eliminarPreferencia (preferencia){
    listaDePreferencias.remove(preferencia)
    preferenciaDefault = listaDePreferencias.last()

  }
  /*CORRECCION Entrega 3
  Estas funciones de agregar y eliminar preferencias no son necesarias si se tiene solo una preferencia como var property
  */
  
  method quiereRevisar(instrumento) = self.tieneVariasPreferencias() || preferenciaDefault.aplica(instrumento)
  // SUGERENCIA Entrega 3: Hubiera estado bueno que la funcion de la preferencia se llame "validaRevision()"
  // que reciba un instrumento y en base a la preferencia retorne un error o no haga nada en caso de
  // el instrumento sea de su preferencia

  //method sabeAfinar(instrumento) = instrumento.familia().equals(familia)
  
  method verificarRevision(instrumento) {
    if(!self.quiereRevisar(instrumento)) {
      throw new DomainException (message = "El tecnico no prefiere revisar ese instrumento")
    }
    // CORRECCION Entrega 3: Lo ideal hubiese sido que las preferencias no solo digan si el instrumento pasa o no
    // sino que tambien realice la accion lanzar la excepcion en caso de que no sea un instrumento valido
  }
  
}
// PREFERENCIAS
object instrumentosValiosos {
  method aplica (instrumento) = instrumento.esValioso()
}

object instrumentosConCostoImpar{
  method aplica (instrumento) = !instrumento.cuantoCuesta().even() // Correccion Entrega 3: es mas directo usar la funcion odd() en vez de negar el resultado de la funcion even()
}

class SegunFamilia{
  const property familiaDeInstrumentos 
  method aplica (instrumento) = instrumento.familia().equals(familiaDeInstrumentos)
}
//como despues voy a tener que identificar las familias en eliminarPreferencia() las instancio aparte en vez de instanciarlas directamente dentro del agregarPreferencia(new SegunFamilia)
const cuerdas = new SegunFamilia(familiaDeInstrumentos = "cuerdas")
const teclado = new SegunFamilia(familiaDeInstrumentos = "teclado")
const vientos = new SegunFamilia(familiaDeInstrumentos = "vientos")

// CORRECCION Entrega 3: Falta la preferencia de preferencias combinadas donde exista una preferencia que combine varias preferencias


class Revision{
  const property tecnico
  const property fecha = new Date()
  method esReciente(maximoDiasRecientes)= fecha.between(new Date().minusDays(maximoDiasRecientes), new Date())

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

  // ==== TP3 - Integrante 1 - Preferencias del musico
  const property preferenciasParaUnirse = #{ preferencia_Default }
  /*CORRECCION ENTREGA 3:
    El musico solo tiene una preferencia para unirse a una orquesta
  */

  method requisitoParaUnirse(orquesta, musico) = preferenciasParaUnirse.all({preferencia => preferencia.requisitoParaUnirse(orquesta, musico)})
  method puedeUnirseAOrquesta(orquesta) {
    if (!self.requisitoParaUnirse(orquesta, self))
      throw new DomainException(message = "El musico no se siente comodo con esta orquesta.")
  }
  /*CORRECCION ENTREGA 3:
    Lo ideal seria que la preferencia sea la que valide si el musico se quiere unir a la orquesta
    y si no lo quiere entonces que retorne una excepcion, y que el musico solamente llame al metodo
    de validacion de la preferencia
  */  
  
  // Modificadores de Preferencias
  method agregarPreferencia(preferencia) { preferenciasParaUnirse.add(preferencia) }
  method quitarPreferencia (preferencia) { 
    self.verificarCantidadRestantePreferencias(preferencia)
    preferenciasParaUnirse.remove(preferencia) 
  }
  method establecerPreferencia(preferencia) {
    preferenciasParaUnirse.clear()
    self.agregarPreferencia(preferencia)
  }
  method establecerCombinacionDePreferencias(listaDePreferencias) {
    self.verificarExistenciaListaPreferencias(listaDePreferencias)
    preferenciasParaUnirse.clear()
    listaDePreferencias.forEach({ preferencia => self.agregarPreferencia(preferencia) })
  }  
  
  // Verificadores
  method verificarCantidadRestantePreferencias(preferencia){
    if(preferenciasParaUnirse.size() == 1)
      throw new DomainException(message = "Un musico no puede quedarse sin preferencias para unirse a una orquesta.")
  }
  method verificarExistenciaListaPreferencias(listaDePreferencias) {
    if(listaDePreferencias.size() == 0)
      throw new DomainException(message = "No se puede establecer una combinacion de preferencias vacia.")
  }
  /*CORRECCION ENTREGA 3:
    Estos metodos de establecer preferencia y verificadores no son necesarios si se tiene una sola preferencia como var property
  */
}

// ==== TP3 - Integrante 1 - Preferencias

// La clase abstracta Preferencia es para poder implementar nuevas Preferencias a futuro de manera mas sencilla, y forzando a continuar con el polimorfismo
class Preferencia {
  method requisitoParaUnirse(orquesta, musico) 
}

object preferencia_Default inherits Preferencia {
  override method requisitoParaUnirse(orquesta, musico) = true
}
  /*CORRECCION ENTREGA 3:
    Si la preferencia tiene el comportamiento de validar si se uniria el musico a la orquesta
    y retornar error en caso de que no sea asi, esta funcion seria un bloque vacio ("{}")
  */
object preferencia_SerUnicoEnTocarInstrumento inherits Preferencia {
  override method requisitoParaUnirse(orquesta, musico) = orquesta.integrantes().all({
    integrante => integrante.instrumentoActual() != musico.instrumentoActual()
  })
}
  /*CORRECCION ENTREGA 3:
    Lo mejor es delegar en la orquesta la logica de evaluar si un instrumento es tocado por uno de sus
    musicos, de esta manera evitan acoplar la preferencia con la orquesta y romper el encapsulamiento
    de la orquesta
    Como sugerencia tambien diria que para validar este punto en la orquesta se puede mapear los instrumentos de los musicos y luego preguntar si en esa coleccion de intrumentos está incluido el intrumento recibido por parametro
  */
class Preferencia_BFFs inherits Preferencia {
  const property bffs = #{}
  method agregarBFF(musico) { bffs.add(musico) }
  method agregarVariosBFFs(musicos) { musicos.forEach({ musico => bffs.add(musico) }) }
  method quitarBFF (musico) { bffs.remove(musico) }
  override method requisitoParaUnirse(orquesta, musico) = 
    self.requisitoSinBFFs(orquesta) || self.requisitoConBFFs(orquesta)
  method requisitoSinBFFs(orquesta) = 
    bffs.size() == 0 && orquesta.integrantes().size() == 0
  method requisitoConBFFs(orquesta) 
    = orquesta.integrantes().size() > 0 
    && orquesta.integrantes().all( { integrante => bffs.contains(integrante) } )
  /*CORRECCION ENTREGA 3:
    No es necesario validar si la lista de bff está vacía, complica la resolucion
  */    
  // Con all( { integrante => bffs.contains(integrante) } ) hacemos que todos los integrantes esten en el set de bffs
  // considero que una orquesta de menor tamaño que la lista de bffs puede ser valida ya que la consigna es cumplida 
  // "otros quieren que la orquesta tenga solo determinados músicos que son sus BFF ", ya que solo contiene miembros de sus bffs
}
object preferencia_EstaBienConformada inherits Preferencia {
  override method requisitoParaUnirse(orquesta, musico) = orquesta.estaBienConformada()
}
  /*CORRECCION ENTREGA 3:
    Falta la preferencia combinada que esté compuesta por varias preferencias
  */
class Orquesta {
    const property cantidadMaximaMusicos
    const property integrantes = []
    var property calcularCobro = cobroTipico //TP 3 - para controlar el tipo de cobro que tiene la orquesta, mayor flexibilidad
  /*CORRECCION ENTREGA 3:
    En el enunciado se aclaraba que las orquestas no cambiaban, teniendo el calculo del cobro como
    variable ésto no se cumpliria y se permitiria que la orquesta tenga distintas formas de cobro
  */
    method contieneAlMusico(musico) = integrantes.contains(musico)

    // Modificadores
    method agregarMusico(musico) {
        self.verificarCantidadMusicosDisponibles()
        self.verificarMusicoPresente(musico)
        musico.puedeUnirseAOrquesta(self)   // TP3
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
    method estaBienConformada() = integrantes.all{musico => musico.esFeliz()}
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
   
    //TP3- INTEGRANTE 2
    method costoPresentacion(fechaPresentacion, cantidadLocalidades) = calcularCobro.calcular(self, fechaPresentacion, cantidadLocalidades)
  /*CORRECCION ENTREGA 3:
    Lo ideal hubiese sido tener nuevas clases de Orquesta que hereden de la Orquesta original
    y el metodo del calculo de cobro por presentacion de la Orquesta sea el calculo base 
    (10 * cantidad de intregrantes) mas un calculo del valor extra.
    Esta funcion de calculo de valor extra para la Orquesta retornaria un 0 ya que no se agrega nada
    y las distintas orquestas nuevas hagan un override de este calculo extra
  */    
}
   //TP3- INTEGRANTE 2========================================================
  /*CORRECCION ENTREGA 3:
    Hubiera estado bueno que la presentacion sea modelada en una entidad nueva Presentacion que tenga
    la cantidad de localidades, la fecha y el metodo que se consulte si la presentacion fue un fin de semana
  */   
class CobroOrquesta {
  method calcular(orquesta, fechaPresentacion, cantidadLocalidades) = 
    10 * orquesta.integrantes().size()
}

object cobroTipico inherits CobroOrquesta {
  override method calcular(orquesta, fechaPresentacion, cantidadLocalidades) =
    super(orquesta, fechaPresentacion, cantidadLocalidades) + 
      (if(self.esFinDeSemana(fechaPresentacion)) 30 else 20)

  method esFinDeSemana(fechaPresentacion) = 
    fechaPresentacion.dayOfWeek().equals("saturday") || fechaPresentacion.dayOfWeek().equals("sunday")
}
  /*SUGERENCIA ENTREGA 3:
    otra manera de saber si la presentacion fue un fin de semana es usar la funcion: fecha.isWeekendDay()
  */
object cobroEstable inherits CobroOrquesta {
  override method calcular(orquesta, fechaPresentacion, cantidadLocalidades) = 
    super(orquesta, fechaPresentacion, cantidadLocalidades) + 
      (cantidadLocalidades / 5000.0 ).roundUp(0) * 5 
}
  /*SUGERENCIA ENTREGA 3:
    otra manera de hacer este calculo puede ser
    5 * (presentacion.cantidadLocalidades().div(5000) + 1)
  */ 

object cobroCamerata inherits CobroOrquesta {
  override method calcular(orquesta, fechaPresentacion, cantidadLocalidades) = 
    super(orquesta, fechaPresentacion, cantidadLocalidades) + 7
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

/*
NOTA ENTREGA 3

Integrante 1:
  El musico solo tiene una preferencia, ésto generó que haya muchas funciones auxiliares innecesarias
  Se rompe el encapsulamiento en algunas preferncias
  Faltó modelar la preferencia combinada
  Nota: 3 puntos
Integrante 2:
  La orquesta no deberia de poder cambiar de manera de cobrar por presentacion
  Se delegó el calculo del costo por presentacion en una abstraccion Cobro, lo ideal hubiese sido que
  se modelen nuevas clases de Orquesta que deleguen de la Orquesta y que las mismas redefinan la manera de calcular el costo extra
  Hubiera estado bueno que exista una abstraccion nueva para la presentacion, cosa de evitar andar pasando valores sueltos como cantidad de localidades vendidas y la fecha de presentacion, sumado a que se podria delegar en esta nueva abstraccion la funcionalidad de definir si la presentacion es en un fin de semana
  Nota: 4 puntos
Integrante 3:
  El tecnico solo tiene una preferencia, ésto generó que haya muchas funciones auxiliares innecesarias
  Hubiera estado bueno que la preferencia se encargue tambien de retornan una excepcion en caso de que no se cumpla su condicion y que el tecnico directamente delegue en la preferencia la manera de accionar
  Faltó modelar la preferencia combinada 
  Nota: 3,5 puntos 
*/