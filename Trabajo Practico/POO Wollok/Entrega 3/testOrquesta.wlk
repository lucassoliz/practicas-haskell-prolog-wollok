import tpOrquesta.*

// ======== Los Instrumentos ========

// ==== Guitarra Fender - Todos los integrantes ====
describe "Tests para la fender"{
  // Correccion: para evitar estar atado al valor especifico para definir el escenario que estan testeando
  // pueden poner en la descripcion que la fender negra tiene un costo especial, o una fender no negra no tiene un costo especial o costo mas barato
  test "Fender Negra siempre esta afinada"{
    fender.color("negra")
    assert.that(fender.estaAfinado())
  }
  test "Fender roja tambien esta afinada"{
    fender.color("roja")
    assert.that(fender.estaAfinado())
  }
  test "Fender Negra vale 15"{
    fender.color("negra")
    assert.equals(15, fender.cuantoCuesta())
  }
  test "Fender Roja vale 10"{
    fender.color("roja")
    assert.equals(10, fender.cuantoCuesta())
  }
  test "Fender es valiosa"{
    assert.that(fender.esValioso())
  }
}

// ==== Trompeta Jupiter - Integrante 1 ====
// Correccion: para evitar estar atado al valor de la temperatura ambiente pueden poner en la descripcion
// que la temperatura ambiente es maxima agradable o minima agradable o no es agradable por fresca o por calurosa 
describe "Tests para la Trompeta Jupiter" {
  test "Jupiter a 20 grados esta afinada" {
    jupiter.revisarTermometro(20)
    assert.that(jupiter.estaAfinado())
  }
  test "Jupiter a 25 grados esta afinada" {
    jupiter.revisarTermometro(25)
    assert.that(jupiter.estaAfinado())
  }
  test "Jupiter a 19 grados no esta afinada" {
    jupiter.revisarTermometro(19)
    assert.notThat(jupiter.estaAfinado())
  }
  test "Jupiter a 26 grados no esta afinada" {
    jupiter.revisarTermometro(26)
    assert.notThat(jupiter.estaAfinado())
  }
  test "Jupiter a 19 grados, y la afinamos, pasa a estar afinada" {
    jupiter.revisarTermometro(19)
    jupiter.afinar()
    assert.that(jupiter.estaAfinado())
  }
  test "Jupiter sin sardina cuesta 30 chelines" {
    jupiter.tieneSardina(false)
    assert.equals(30, jupiter.cuantoCuesta())
  }
  test "Jupiter con sardina cuesta 35 chelines" {
    jupiter.tieneSardina(true)
    assert.equals(35, jupiter.cuantoCuesta())
  }
  test "Jupiter no es valiosa" {
    assert.equals(false, jupiter.esValioso())
  }
}

// ==== Piano Bechstein - Integrante 2 ====
describe "Tests para el Piano Bechstein" {
  // Correccion: para evitar estar atado al valor especifico de la habitacion es grande o chica sin definir un numero en especifico
  test "Piano en habitacion 5x5 esta afinado" {
    bechstein.habitacion().ancho(5)
    bechstein.habitacion().largo(5)
    assert.that(bechstein.estaAfinado())
  }
  test "Piano en habitacion chica (20 metros cuadrados) no esta afinado" {
    bechstein.habitacion().ancho(4)
    bechstein.habitacion().largo(5)
    assert.notThat(bechstein.estaAfinado())
  }
  test "Costo del piano en habitacion 5x5 con numero al azar impar" {
    const impar = object{
      method valorRandom() = 3
    }
    bechstein.random(impar)
    bechstein.habitacion().ancho(5)
    assert.equals(31, bechstein.cuantoCuesta())
  }
  test "Piano es valioso en habitacion inicial de 5x5" {
    bechstein.habitacion().ancho(5)
    bechstein.habitacion().largo(5)
    assert.that(bechstein.esValioso())
  }
  test "Piano movido a habitacion chica (20 metros cuadrados) no es valioso" {
    bechstein.habitacion().ancho(4)
    bechstein.habitacion().largo(5)
    assert.notThat(bechstein.esValioso())
  }
}
// ==== Violin Stagg - Integrante 3 ====

describe "Tests para el Violin Stagg"{
  // Correccion: para evitar estar atados a un valor en especifico pueden decir que el violin tiene poco, algunos o muchos tremolos
  // o un tipo de pintura bueno o no tan buena
  test "Violin comienza con sin tremolos hechos"{
    assert.equals(0, stagg.cantidadTremolos())
    }
  test "Un violin con menos de 10 tremolos está afinado"{
    stagg.cantidadTremolos(9)
    assert.that(stagg.estaAfinado())
  }
  test "Un violin con 10 o mas tremolos esta desafinado"{
    stagg.cantidadTremolos(10)
    assert.notThat(stagg.estaAfinado())
  }
  test "Un violin comienza valiendo 20 chelines"{
    assert.equals(20, stagg.cuantoCuesta())
  }
  test "Un violin con 2 tremolos cuesta 18 chelines"{
    stagg.cantidadTremolos(2)
    assert.equals(18, stagg.cuantoCuesta())
  }
  test "Un violin desafinado siempre cuesta 15 chelines"{
    stagg.cantidadTremolos(10)
    assert.equals(15, stagg.cuantoCuesta())
  }
  test "Un violin pintado a laca acrilica es valioso"{
    stagg.tipoPintura("laca acrilica")
    assert.that(stagg.esValioso())
  }
  test "Un violin pintado a latex satinado no es valioso"{
    stagg.tipoPintura("latex satinado")
    assert.notThat(stagg.esValioso())
  }
}
// ======== Los Musicos ========

// ==== Johann - Todos los integrantes ====
describe "Tests para Johann" {
  // Correccion: para estos casos alcanza con decir que tiene un instrumento caro o barato
  test "Johann es feliz con trompeta Jupiter (que es cara)" {
    johann.instrumentoActual(jupiter)
    assert.that(johann.esFeliz())
  }
  test "Johann no es feliz con violin Stagg (sin tremolos, que no es cara)" {
    stagg.cantidadTremolos(0)
    johann.instrumentoActual(stagg)
    assert.notThat(johann.esFeliz())
  }

}


// ==== Wolfgang - Todos los integrantes ====
describe "Tests para Wolfgang" {
  //Correccion: aca pueden poner que wolfgang es feliz porque johann es feliz
  test "Wolfgang es feliz si Johann tiene trompeta Jupiter" {
    johann.instrumentoActual(jupiter)
    assert.that(wolfgang.esFeliz())
  }
  test "Wolfgang no es feliz si Johann tiene violin Stagg (sin tremolos)" {
    stagg.cantidadTremolos(0)
    johann.instrumentoActual(stagg)
    assert.notThat(wolfgang.esFeliz())
  }
}

// ==== Antonio - Integrante 1 ====
describe "Tests para Antonio" {
  // Correccion: aca pueden poner en la descripcion que Antonio es feliz con un instrumento valioso
  test "Antonio es feliz con piano Bechstein (que es valioso)" {
    antonio.instrumentoActual(bechstein)
    assert.that(antonio.esFeliz())
  }
  test "Antonio no es feliz con trompeta Jupiter (que no es valiosa)" {
    antonio.instrumentoActual(jupiter)
    assert.notThat(antonio.esFeliz())
  }
  test "Antonio es feliz con guitarra Fender (que es valiosa)" {
    antonio.instrumentoActual(fender)
    assert.that(antonio.esFeliz())
  }
}

// ==== Giuseppe - Integrante 2 ====
describe "Tests para Giuseppe" {
  // Correccion: aca pueden poner que es feliz porque tiene un instrumento afinado
  test "Giuseppe es feliz con guitarra Fender (que esta siempre afinada)" {
    assert.that(giuseppe.esFeliz())
  }
  test "Giuseppe no es feliz con piano Bechstein en habitacion de un metro cuadrado" {
    giuseppe.instrumentoActual(bechstein)
    bechstein.habitacion().ancho(1)
    bechstein.habitacion().largo(1)
    assert.notThat(giuseppe.esFeliz())
  }
}

// ==== Maddalena - Integrante 3 ====

describe "Tests para Maddalena"{
  // Correccion: aca pueden poner que es feliz porque tiene un instrumento con valor par
  test "Maddalena es feliz si el violin Stagg no tiene tremolos"{
    stagg.cantidadTremolos(0)
    assert.that(maddalena.esFeliz())
  }
  test "Maddalena es no es feliz si el violin tiene tremolos impares"{
    stagg.cantidadTremolos(1)
    assert.notThat(maddalena.esFeliz())
    }
}

// ==== Asociacion Musical ====
describe "Tests para la Asociacion Musical"{
  test "Asociacion Musical tiene 5 musicos" {
    assert.equals(5, asociacionMusical.musicos().size())
  }
  test "Asociacion Musical quita 1 musico" {
    asociacionMusical.quitarMusico(antonio)
    assert.equals(4, asociacionMusical.musicos().size())
  }
  test "Asociacion Musical quita 3 musicos y agrega 1 musico" {
    asociacionMusical.quitarMusico(antonio)
    asociacionMusical.quitarMusico(giuseppe)
    asociacionMusical.quitarMusico(maddalena)
    asociacionMusical.agregarMusico(antonio)
    assert.equals(3, asociacionMusical.musicos().size())
  }
  test "Todos los musicos son felices" {
    johann.instrumentoActual(jupiter)
    stagg.cantidadTremolos(0)
    antonio.instrumentoActual(fender)
    bechstein.habitacion().ancho(5)
    bechstein.habitacion().largo(5)
    assert.equals(5, asociacionMusical.musicosFelices().size())    
  }
  test "Ningun musico es feliz" {
    johann.instrumentoActual(fender)
    
    antonio.instrumentoActual(jupiter)

    jupiter.revisarTermometro(10) // desafinado
    giuseppe.instrumentoActual(jupiter) // desafinado

    jupiter.tieneSardina(true) // costo impar
    maddalena.instrumentoActual(jupiter) // costo impar
    
    assert.equals(0, asociacionMusical.musicosFelices().size())    
  }
}

// ==== TP2 - Integrante 1 - Class Musico y Orquesta ====
// ==== Músicos genéricos - integrante 1 ====
describe "Test Musicos genéricos - TP2 - Integrante 1" {
    test "Un músico que es experto porque su preferencia coincide con la del instrumento que tiene" {
      const musico = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
      assert.that(musico.esExperto())
    }
    test "Un músico cuya preferencia de familia no coincida con la del instrumento no es experto" {
      const musico = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "vientos")
      assert.notThat(musico.esExperto())
    }
    test "Un músico feliz porque la trompeta Júpiter tiene sordina y es copada" {
      jupiter.tieneSardina(true)
      const musico = new Musico(instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos")
      assert.that(musico.esFeliz())
    }
    test "Un músico que no es feliz porque la trompeta Júpiter no tiene sordina y no es copada" {
      jupiter.tieneSardina(false)
      const musico = new Musico(instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos")
      assert.notThat(musico.esFeliz())
    }
    test "Un músico común no es feliz con el violín Stagg" {
      const musico = new Musico(instrumentoActual = stagg, familiaInstrumentosFavorita = "cuerdas")
      assert.notThat(musico.esFeliz())
    }
    test "Un músico común no es feliz con la guitarra Fender" {
      const musico = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
      assert.notThat(musico.esFeliz())
    }
    test "Un músico común es feliz con el piano Bechstein en una habitación grande" {
      bechstein.habitacion().ancho(7)
      bechstein.habitacion().largo(7)
      const musico = new Musico(instrumentoActual = bechstein, familiaInstrumentosFavorita = "teclado")
      assert.that(musico.esFeliz())
    }
    test "Un músico común es feliz con el piano Bechstein en una habitación ancha" {
      bechstein.habitacion().ancho(7)
      bechstein.habitacion().largo(2)
      const musico = new Musico(instrumentoActual = bechstein, familiaInstrumentosFavorita = "teclado")
      assert.that(musico.esFeliz())
    }
    test "Un músico común es feliz con el piano Bechstein en una habitación larga" {
      bechstein.habitacion().ancho(2)
      bechstein.habitacion().largo(7)
      const musico = new Musico(instrumentoActual = bechstein, familiaInstrumentosFavorita = "teclado")
      assert.that(musico.esFeliz())
    }
    test "Un músico común no es feliz con el piano Bechstein en una habitación pequeña" {
      bechstein.habitacion().ancho(2)
      bechstein.habitacion().largo(2)
      const musico = new Musico(instrumentoActual = bechstein, familiaInstrumentosFavorita = "teclado")
      assert.notThat(musico.esFeliz())
    }
    test "Un músico con preferencia por la `percusión` que no es feliz con un instrumento de `cuerdas`" {
      const musico = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "percusion")
      assert.notThat(musico.esFeliz())
    }
}

// ==== Orquestas genéricas - integrante 1 ====
describe "Test Orquestas genéricas - TP2 - Integrante 1" {
  test "No se puede agregar un mismo músico dos veces a la orquesta" {
    const orquesta = new Orquesta(cantidadMaximaMusicos = 3)
    orquesta.agregarMusico(johann)
    assert.throwsExceptionWithMessage(
    "El musico ya pertenece a la orquesta. No se puede agregar nuevamente.",
      {orquesta.agregarMusico(johann) }
    )
  }
  test "No se puede agregar más músicos de los permitidos" {
    const orquesta = new Orquesta(cantidadMaximaMusicos = 2)
    orquesta.agregarMusico(johann)
    orquesta.agregarMusico(wolfgang)
    assert.throwsExceptionWithMessage(
      "La orquesta se quedo sin cupos disponibles. No se puede agregar mas musicos.", 
      {orquesta.agregarMusico(antonio) }
    )
  }
  test "Se pueden agregar tres músicos si hay cupos y no están repetidos" {
    const orquesta = new Orquesta(cantidadMaximaMusicos = 6)
    orquesta.agregarMusico(johann)
    orquesta.agregarMusico(wolfgang)
    orquesta.agregarMusico(antonio)
    assert.equals(3, orquesta.integrantes().size())
  }
}

// ==== Consultas a Orquestas genéricas ====
describe "Test consultas a Orquestas genéricas" {
  // El test lo corria pero el IDE me marcaba error en la sintaxis
  const unMusicoFeliz = object inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {override method esFeliz() = true}
  const otroMusicoFeliz = object inherits Musico (instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos") {override method esFeliz() = true}
  const unMusicoTriste = object inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {override method esFeliz() = false}
  
  const unMusicoCuerdas = new  Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
  const unMusicoVientos = new  Musico (instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos")
  const otroMusicoCuerdas = new  Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
  
  const orquesta = new Orquesta(cantidadMaximaMusicos = 5)
  
  test "Una orquesta bien conformada tiene todos sus músicos felices" {
    // quise hacer object unMusico inherits Musico ...
    orquesta.agregarMusico(unMusicoFeliz)
    orquesta.agregarMusico(otroMusicoFeliz)
    assert.that(orquesta.estaBienConformada())
  }
  test "Una orquesta no esta bien conformada si un musico no es feliz" {
    orquesta.agregarMusico(unMusicoFeliz)
    orquesta.agregarMusico(unMusicoTriste)
    assert.notThat(orquesta.estaBienConformada())
  }
  test "Una orquesta es diversa si todos sus instrumentos son de familias diferentes" {
    orquesta.agregarMusico(unMusicoCuerdas)
    orquesta.agregarMusico(unMusicoVientos)
    assert.that(orquesta.esDiversa())
  }
  test "Una orquesta no es diversa si alguno de sus instrumentos repite su familia" {
    orquesta.agregarMusico(unMusicoCuerdas)
    orquesta.agregarMusico(unMusicoVientos)
    orquesta.agregarMusico(otroMusicoCuerdas)
    assert.notThat(orquesta.esDiversa())
  }
}

/* 
COMENTO PARA DESARROLLAR SIN ERRORES
hay que arreglar esto en base al refactor que trajo la correcion del tp2
*/

// === Consultas Revisiones recientes ====
describe "Tests para Revisiones Recientes" {
  const instrumento = new Instrumento(familia = "cuerdas")
  const tecnico = new Tecnico(nombre = "Jorge", preferenciaDefault = new SegunFamilia (familiaDeInstrumentos = "cuerdas"))

   test "un instrumento sin revisiones no tiene revisiones recientes" {
        assert.that(instrumento.revisionesRecientes().isEmpty())
  }
  test "una revisión de hace 1 mes es reciente" {
    const fechaReciente = new Date().minusMonths(1)
    instrumento.registrarVerificacion(new Revision(tecnico = tecnico, fecha = fechaReciente))
    assert.equals(1, instrumento.revisionesRecientes().size())
  }
    
  test "una revisión de hace 3 meses no es reciente" {
    const fechaAntigua = new Date().minusMonths(3)
    instrumento.registrarVerificacion(new Revision(tecnico = tecnico, fecha = fechaAntigua))
    assert.that(instrumento.revisionesRecientes().isEmpty())
    }
    
    test "filtra correctamente una lista con revisiones antiguas y recientes" {
        const fechaReciente1 = new Date().minusDays(10)
        const fechaAntigua = new Date().minusMonths(3)
        const fechaReciente2 = new Date().minusMonths(1)

        instrumento.registrarVerificacion(new Revision(tecnico = tecnico, fecha = fechaReciente1))
        instrumento.registrarVerificacion(new Revision(tecnico = tecnico, fecha = fechaAntigua))
        instrumento.registrarVerificacion(new Revision(tecnico = tecnico, fecha = fechaReciente2))
        
        assert.equals(2, instrumento.revisionesRecientes().size())
    }
}

// Tests Instrumentos genéricos - integrante 2 =====
describe "Tests Instrumentos genéricos" {
    
    test "El instrumento generico no es copado" {
        const instrumento = new Instrumento(familia = "cuerdas")
        assert.notThat(instrumento.esCopado())
    }

    test "Costo de instrumento de cuerdas con numero par da 14" {
      //Objeto stub para controlar comportamiento random
        const par = object {
          method valorRandom() = 2
        }
        const instrumento = new Instrumento(familia = "cuerdas")
        instrumento.random(par)
        assert.equals(14, instrumento.cuantoCuesta())
    }

    test "Costo de instrumento cuerdas con numero impar da 21" {
        const impar = object {
        method valorRandom() = 3
      }
        const instrumento = new Instrumento(familia = "cuerdas")
        instrumento.random(impar)
        assert.equals(21, instrumento.cuantoCuesta())
    }

    test "Un instrumento de percusión no es sensitivo" {
        const instrumento = new Instrumento(familia = "percusion")
        assert.notThat(instrumento.esSensitivo())
    }

    test "Un instrumento de cuerdas es sensitivo" {
        const instrumento = new Instrumento(familia = "cuerdas")
        assert.that(instrumento.esSensitivo())
    }

    test "La guitarra Fender negra es sensitiva" {
        fender.color("negra")
        assert.that(fender.esSensitivo())
    }

    test "La guitarra Fender blanca no es sensitiva" {
        fender.color("blanca")
        assert.notThat(fender.esSensitivo())
    }
}

 //===========Proceso de revisión - integrante 3===========================================================
 describe "Tests para el proceso de revision de un instrumento"{
  const fulanito = new Tecnico (nombre = "sebas", preferenciaDefault = new SegunFamilia(familiaDeInstrumentos ="cuerdas"))

  test "Un tecnico que no puede revisar un instrumento si no se especializa en su familia de instrumentos" {
	  assert.throwsExceptionWithMessage("El tecnico no prefiere revisar ese instrumento", 
    {jupiter.revisar(fulanito)})
  }

  test "No se debe verificar al instrumento si ya se ha verificado en la ultima semana" {
    fender.registrarVerificacion(new Revision(tecnico = fulanito, fecha= new Date()))
    assert.throwsExceptionWithMessage("Su ultima revision es reciente", 
    {fender.revisar(fulanito)})
}

  test "Al hacer una revision, la ultima que figura en el historial debe ser la de hoy"{
    fender.historialRevisiones([])
    fender.revisar(fulanito)
    assert.equals(fender.fechaActual(), fender.ultimaRevision().fecha())
    assert.equals(fulanito, fender.ultimaRevision().tecnico())
  }
  test "Al afinar un instrumento de teclado desafinado este queda afinado"{
    fulanito.preferenciaDefault(new SegunFamilia (familiaDeInstrumentos= "teclado"))
    bechstein.habitacion(new Habitacion (ancho = 2, largo = 3))
    bechstein.historialRevisiones([])
    bechstein.revisar(fulanito)
    assert.that(bechstein.estaAfinado())
  }

  test"Al afinar un instrumento de viento desafinado, este queda afinado"{
    fulanito.preferenciaDefault(new SegunFamilia (familiaDeInstrumentos= "vientos"))
    jupiter.revisarTermometro(19)
    jupiter.revisar(fulanito)
    assert.that(jupiter.estaAfinado())
  }
    
  }

//=====================================================================================
describe "Test funcionalidad orquesta contiene a un musico" {
  const orquesta = new Orquesta(cantidadMaximaMusicos = 5)
  
  test "Orquesta vacia no contiene a un musico" {
    assert.notThat(orquesta.contieneAlMusico(johann))
  }
  test "Orquesta con un musico contiene a ese musico" {
    orquesta.agregarMusico(johann)
    assert.that(orquesta.contieneAlMusico(johann))
  }
  test "Orquesta con unMusico no contienen a otroMusico" {
    const otroMusico = new Musico(instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos")
    orquesta.agregarMusico(johann)
    assert.notThat(orquesta.contieneAlMusico(otroMusico))
  }
  test "Orquesta con varios musicos contiene a uno de ellos" {
    const otroMusico = new Musico(instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos")
    orquesta.agregarMusico(johann)
    orquesta.agregarMusico(wolfgang)
    orquesta.agregarMusico(otroMusico)
    assert.that(orquesta.contieneAlMusico(otroMusico))
  }
}
// ======== TP3 - Preferencias de musicos - Integrante 1 ========

const orquestaGenerica = new Orquesta(cantidadMaximaMusicos = 5)
describe "Test Preferencia Default - TP3 - Integrante 1" {
  test "Un musico por Default puede unirse a cualquier orquesta" {
    const musicoGenerico = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
    orquestaGenerica.agregarMusico(musicoGenerico)
    assert.that(orquestaGenerica.contieneAlMusico(musicoGenerico))
  }
}
describe "Test Preferencia Ser Unico - TP3 - Integrante 1" {
  test "Un musico con preferencia de ser el Unico en tocar Un Instrumento se puede unir a una orquesta si nadie mas toca su instrumento" {
    const musicoConPreferencia = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
    musicoConPreferencia.establecerPreferencia(preferencia_SerUnicoEnTocarInstrumento)
    
    const musicoConPiano = new Musico(instrumentoActual = bechstein, familiaInstrumentosFavorita = "teclado")

    orquestaGenerica.agregarMusico(musicoConPiano)
    orquestaGenerica.agregarMusico(musicoConPreferencia)

    assert.that(orquestaGenerica.contieneAlMusico(musicoConPreferencia))
  }
  test "Un musico que quiere ser el unico en tocar un instrumento no se puede unir a una orquesta si alguien mas toca su instrumento" {
    const musicoConPreferencia = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
    musicoConPreferencia.establecerPreferencia(preferencia_SerUnicoEnTocarInstrumento)
    
    const otroMusicoConMismoInstrumento = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")

    orquestaGenerica.agregarMusico(otroMusicoConMismoInstrumento)
    
    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
}
describe "Test Preferencia BFFs - TP3 - Integrante 1" {
  const preferencia_BFFs = new Preferencia_BFFs()
  const musicoConPreferencia = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")

  test "Un musico con preferencia BFFs se puede unir a una orquesta si todos sus BFFs ya estan en la orquesta" {
    musicoConPreferencia.establecerPreferencia(preferencia_BFFs)
    
    preferencia_BFFs.agregarBFF(wolfgang)
    preferencia_BFFs.agregarBFF(antonio)

    orquestaGenerica.agregarMusico(wolfgang)
    orquestaGenerica.agregarMusico(antonio)
    orquestaGenerica.agregarMusico(musicoConPreferencia)

    assert.that(orquestaGenerica.contieneAlMusico(musicoConPreferencia))
  }
    
  test "Un musico con preferencia BFFs no se puede unir a una orquesta si alguno de los integrantes no es su BFF" {
    musicoConPreferencia.establecerPreferencia(preferencia_BFFs)
    
    preferencia_BFFs.agregarBFF(wolfgang)
    
    orquestaGenerica.agregarMusico(wolfgang)
    orquestaGenerica.agregarMusico(antonio)
    
    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
  test "Un musico con preferencia BFFs, sin BFFs, no se puede unir a una orquesta con miembros"{
    musicoConPreferencia.establecerPreferencia(preferencia_BFFs)
    
    orquestaGenerica.agregarMusico(wolfgang)

    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
  test "Un musico con preferencia BFFs, con BFFs, no se puede unir a una orquesta vacia" {
    musicoConPreferencia.establecerPreferencia(preferencia_BFFs)

    preferencia_BFFs.agregarBFF(wolfgang)
    
    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
  test "Un musico con preferencia BFFs, sin BFFs, se puede unir a una orquesta vacia" {
    musicoConPreferencia.establecerPreferencia(preferencia_BFFs)
    orquestaGenerica.agregarMusico(musicoConPreferencia)
    
    assert.that( orquestaGenerica.contieneAlMusico(musicoConPreferencia) )
  }
}
describe "Test Preferencia Bien Conformada - TP3 - Integrante 1" {
  const unMusicoFeliz = object inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {override method esFeliz() = true}
  const otroMusicoFeliz = object inherits Musico (instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos") {override method esFeliz() = true}
  const unMusicoTriste = object inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {override method esFeliz() = false}
  
  const musicoConPreferencia = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")
  test "Un musico con preferencia Bien Conformada se puede unir a una orquesta bien conformada" {
    musicoConPreferencia.establecerPreferencia(preferencia_EstaBienConformada)

    orquestaGenerica.agregarMusico(unMusicoFeliz)
    orquestaGenerica.agregarMusico(otroMusicoFeliz)
    orquestaGenerica.agregarMusico(musicoConPreferencia)

    assert.that(orquestaGenerica.contieneAlMusico(musicoConPreferencia))
  }
  test "Un musico Triste con preferencia Bien Conformada se puede unir a una orquesta bien conformada" {
    unMusicoTriste.establecerPreferencia(preferencia_EstaBienConformada)

    orquestaGenerica.agregarMusico(unMusicoFeliz)
    orquestaGenerica.agregarMusico(otroMusicoFeliz)
    orquestaGenerica.agregarMusico(unMusicoTriste)

    assert.that(orquestaGenerica.contieneAlMusico(unMusicoTriste))
  }
  test "Un musico con preferencia Bien Conformada no se puede unir a una orquesta que no esta bien conformada" {
    musicoConPreferencia.establecerPreferencia(preferencia_EstaBienConformada)

    orquestaGenerica.agregarMusico(unMusicoFeliz)
    orquestaGenerica.agregarMusico(unMusicoTriste)

    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
}

describe "Test Combinacion de Preferencias - TP3 - Integrante 1" {
  const unMusicoFeliz = object inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {override method esFeliz() = true}
  const otroMusicoFeliz = object inherits Musico (instrumentoActual = jupiter, familiaInstrumentosFavorita = "vientos") {override method esFeliz() = true}
  const unMusicoTriste = object inherits Musico (instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas") {override method esFeliz() = false}
  
  const musicoConPreferencia = new Musico(instrumentoActual = fender, familiaInstrumentosFavorita = "cuerdas")

  const preferenciaBFFs = new Preferencia_BFFs()
  test "Un musico con preferencia Bien Conformada y BFFs, se puede unir a una orquesta bien conformada si la orquesta contiene unicamente a sus BFFs" {
    musicoConPreferencia.establecerPreferencia(preferencia_EstaBienConformada)
    musicoConPreferencia.agregarPreferencia(preferenciaBFFs)

    preferenciaBFFs.agregarBFF(unMusicoFeliz)
    preferenciaBFFs.agregarBFF(otroMusicoFeliz)

    orquestaGenerica.agregarMusico(unMusicoFeliz)
    orquestaGenerica.agregarMusico(otroMusicoFeliz)
    orquestaGenerica.agregarMusico(musicoConPreferencia)

    assert.that(orquestaGenerica.contieneAlMusico(musicoConPreferencia))
  }
  test "Un musico con preferencia Bien Conformada y BFFs, no se puede unir a una orquesta bien conformada si la orquesta contiene a alguien que no es su BFF" {
    musicoConPreferencia.establecerPreferencia(preferencia_EstaBienConformada)
    musicoConPreferencia.agregarPreferencia(preferenciaBFFs)

    preferenciaBFFs.agregarBFF(unMusicoFeliz)

    orquestaGenerica.agregarMusico(unMusicoFeliz)
    orquestaGenerica.agregarMusico(otroMusicoFeliz)
    
    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
  test "Un musico con preferencia Bien Conformada y BFFs, no se puede unir a una orquesta que no esta bien conformada" {
    musicoConPreferencia.establecerPreferencia(preferencia_EstaBienConformada)
    musicoConPreferencia.agregarPreferencia(preferenciaBFFs)

    preferenciaBFFs.agregarBFF(unMusicoFeliz)
    preferenciaBFFs.agregarBFF(unMusicoTriste)

    orquestaGenerica.agregarMusico(unMusicoFeliz)
    orquestaGenerica.agregarMusico(unMusicoTriste)

    assert.throwsExceptionWithMessage(
      "El musico no se siente comodo con esta orquesta.",
      {orquestaGenerica.agregarMusico(musicoConPreferencia)}
    )
  }
}

// ======== TP3 -Las Orquestas - Integrante 2 ========
describe "Costos de presentacion de orquestas" {
    const miercoles = object { method dayOfWeek() = "wednesday" }
    const sabado = object { method dayOfWeek() = "saturday" }    
    // ========== ORQUESTA TIPICA =============================
    
    test "Orquesta Tipica cobra en Fin de Semana" {
        const orquestaTipica = new Orquesta(cantidadMaximaMusicos = 5)
        orquestaTipica.calcularCobro(cobroTipico)
        orquestaTipica.agregarMusico(johann)
        orquestaTipica.agregarMusico(wolfgang)
        orquestaTipica.agregarMusico(antonio)
        
        assert.equals(60, orquestaTipica.costoPresentacion(sabado, 3000))
    }
    
    test "Orquesta Tipica cobra en dia de semana" {
        const orquestaTipica = new Orquesta(cantidadMaximaMusicos = 5)
        orquestaTipica.calcularCobro(cobroTipico)
        orquestaTipica.agregarMusico(johann)
        orquestaTipica.agregarMusico(wolfgang)
        orquestaTipica.agregarMusico(antonio)
        orquestaTipica.agregarMusico(giuseppe)
        
        assert.equals(60, orquestaTipica.costoPresentacion(miercoles, 4000))
    }
    // ===================== CAMERATA ======================
    
    test "Camerata cobra sin importar el dia y la cantidad de localidades" {
        const camerata = new Orquesta(cantidadMaximaMusicos = 5)
        camerata.calcularCobro(cobroCamerata)
        camerata.agregarMusico(johann)
        camerata.agregarMusico(wolfgang)
        camerata.agregarMusico(antonio)
        camerata.agregarMusico(giuseppe)
      
        assert.equals(47, camerata.costoPresentacion(miercoles, 8000)) 
    }
    
    // ================== ORQUESTA ESTABLE ================================
    
    test "Orquesta Estable cobra con baja cantidad de localidades, sin importar el dia" {
        const orquestaEstable = new Orquesta(cantidadMaximaMusicos = 10)
        orquestaEstable.calcularCobro(cobroEstable)
        orquestaEstable.agregarMusico(johann)
        orquestaEstable.agregarMusico(wolfgang)
        orquestaEstable.agregarMusico(antonio)
        
        assert.equals(35, orquestaEstable.costoPresentacion(miercoles, 490)) 
    }

    test "Orquesta Estable cobra con gran cantidad de localidades, sin importar el dia" {
        const orquestaEstable = new Orquesta(cantidadMaximaMusicos = 10)
        orquestaEstable.calcularCobro(cobroEstable)
        orquestaEstable.agregarMusico(johann)
        orquestaEstable.agregarMusico(wolfgang)
        orquestaEstable.agregarMusico(antonio)
        orquestaEstable.agregarMusico(giuseppe)
        orquestaEstable.agregarMusico(maddalena)
        
        assert.equals(65, orquestaEstable.costoPresentacion(miercoles, 12141))
    }

// ============== FLEXIBILIDAD EN EL TIPO DE COBRO ==========================
    test "Flexibilidad para cambiar el tipo de cobro de una orquesta"{
        const losBorbotones = new Orquesta(cantidadMaximaMusicos = 4)
        losBorbotones.calcularCobro(cobroCamerata)
        losBorbotones.agregarMusico(johann)
        losBorbotones.agregarMusico(wolfgang)
        losBorbotones.agregarMusico(antonio)
        assert.equals(37, losBorbotones.costoPresentacion(sabado, 2000))

        losBorbotones.calcularCobro(cobroTipico)
        assert.equals(60, losBorbotones.costoPresentacion(sabado, 2000))
    }    
}

// ================ TP3 Cambios en Proceso de Revision - INTEGRANTE 3 =====================
describe "Preferencias de un tecnico"{
  const fulanito = new Tecnico (nombre = "sebas", preferenciaDefault = teclado)
  test "Un tecnico prefiere afinar instrumentos de teclado"{
    assert.throwsExceptionWithMessage("El tecnico no prefiere revisar ese instrumento", 
    {fender.revisar(fulanito)})
  }
  test "Un tecnico prefiere afinar instrumentos que son valiosos"{
    fulanito.preferenciaDefault(instrumentosValiosos)
    assert.throwsExceptionWithMessage("El tecnico no prefiere revisar ese instrumento", 
    {jupiter.revisar(fulanito)})
    //jupiter por defecto no es valiosa
  }
  test "Un tecnico prefiere afinar instrumentos cuyo costo es impar"{
    fulanito.preferenciaDefault(instrumentosConCostoImpar)
    assert.throwsExceptionWithMessage("El tecnico no prefiere revisar ese instrumento", 
    {stagg.revisar(fulanito)}) 
    //el stagg por defecto arranca sin tremolos, => vale 20
  }
  test "Un tecnico con 2 preferencias o más afina cualquier instrumento"{
    fulanito.agregarPreferencia(instrumentosValiosos)
    jupiter.revisar(fulanito)
    assert.equals(2, fulanito.listaDePreferencias().size())
    assert.equals(fulanito, jupiter.ultimaRevision().tecnico()) 
    //la jupiter no es de teclado ni valiosa
  }
  test "Un tecnico puede adquirir más de una preferencia"{
    //+ familia de teclado
    fulanito.agregarPreferencia(instrumentosConCostoImpar)
    fulanito.agregarPreferencia(instrumentosValiosos)
    fulanito.agregarPreferencia(cuerdas)

    assert.equals(4, fulanito.listaDePreferencias().size())
  }
  test "Un tecnico no puede repetir una preferencia"{
    assert.throwsExceptionWithMessage("El tecnico ya tiene esa preferencia", 
    {fulanito.agregarPreferencia(teclado)})
  }
  test "Un tecnico puede perder una preferencia"{
    fulanito.agregarPreferencia(instrumentosConCostoImpar)
    fulanito.agregarPreferencia(instrumentosValiosos) 

    assert.equals(3, fulanito.listaDePreferencias().size())

    fulanito.eliminarPreferencia(teclado)
    assert.equals(2, fulanito.listaDePreferencias().size())
  }
}