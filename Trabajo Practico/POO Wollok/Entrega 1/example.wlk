// Correccion: renombren al archivo, quedó como example.wlk, pueden llamaro resolucion o tpOrquesta, algo mas representativo

// ======== Los Instrumentos ========

// ==== Guitarra Fender - Todos los integrantes ====
object fender {
  var property color = "negra"
  method esNegra() = color=="negra"
  // Correccion: este metodo no aporta, termina siendo un pasamos, lo mejor es usarlo directamente en el metodo del costo

  method esValioso() = true
  method estaAfinado() = self.esNegra() // Correccion: no es correcto esto, la fender siempre está afinada, no porque sea de color negro. Lo ideal seria simplemente resolver al metodo retornando true
  method cuantoCuesta() = if(self.esNegra()) 15 else 10
}

// ==== Trompeta Jupiter - Integrante 1 ====
object jupiter {
  var property tieneSardina = true
  var temperatura = 10.randomUpTo(30)
  // Correccion: Esto no es correcto, en el enunciado la temperatura no es un valor random

  method estaAfinado() = (20 <= temperatura && temperatura <= 25)
  // Correccion: Faltó agregar la condicion donde se define si está afinado si es que el instrumento realizó un calentamiento
  // Para definir esa logica lo podrian haber definido con una property booleana que se llame "calentamiento"
  // entonces el afinar implicaba poner al valor "calentamiento" en "true" indicando que "se realizó el calentamiento".
  // Podrian haber utilizado la funcion between para ver si estaba entre cierta temperatura, podria quedar algo asi:
  // "temperaturaAmbiente.between(20, 25) || calentamiento"

  method afinar() { temperatura = 20 }
  method revisarTermometro(temperaturaActual) { temperatura = temperaturaActual }

  method esValioso() = false
  method cuantoCuesta() = 30 + (if(tieneSardina) 5 else 0)
}

// ==== Piano Bechstein - Integrante 2 ====
object bechstein {
  // Correccion: estaria bueno abstraer la logica de la habitacion en una entidad aparte, por ejemplo una
  // clase Habitacion que tenga su ancho y largo y sepa resolver sus metros cuadrados

  var property anchoHabitacion = 5
  var property largoHabitacion = 5
  var property ultimaRevision = new Date()

  method metrosCuadrados() = anchoHabitacion * largoHabitacion
  method estaAfinado() = self.metrosCuadrados() > 20
  method cuantoCuesta() = 2 * anchoHabitacion
  method esValioso() = self.estaAfinado()
}

// ==== Violin Stagg - Integrante 3 ====
object stagg {
  var property cantidadTremolos = 0
  var property tipoPintura = "laca acrilica"
  
  method hacerTremolo() { cantidadTremolos = cantidadTremolos + 1 }
  method estaAfinado() = cantidadTremolos < 10
  method cuantoCuesta() = if((20 - cantidadTremolos)> 15) (20 - cantidadTremolos) else 15
  // Correccion: para definir cuanto cuesta y evitar retornan menos que 15 podrian utilizar el metodo max entre 15 y el resultado de la resta
  // Quedaria algo como "15.max(20 - cantidadTremolos)"
  method esValioso() = self.tipoPintura() == "laca acrilica"
}

// ======== Los Musicos ========

// ==== Johann - Todos los integrantes ====
object johann {
  var property instrumentoActual = jupiter
  method esFeliz() = instrumentoActual.cuantoCuesta() > 20
}
// ==== Wolfgang - Todos los integrantes ====
object wolfgang {
  method esFeliz() = johann.esFeliz()
}
// ==== Antonio - Integrante 1 ====
object antonio {
  var property instrumentoActual = bechstein

  method esFeliz() = instrumentoActual.esValioso()
}


// ==== Giuseppe - Integrante 2 ====
object giuseppe {
  var property instrumentoActual = fender

  method esFeliz() = instrumentoActual.estaAfinado()
}
// ==== Maddalena - Integrante 3 ====
object maddalena {
  var property instrumentoActual = stagg
  method esFeliz() = (instrumentoActual.cuantoCuesta()%2 ) ==0
  // Correccion: otra manera de definir esto es usar el metodo even, quedaria
  // "intrumentoActual.cuantoCuesta().even()"
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