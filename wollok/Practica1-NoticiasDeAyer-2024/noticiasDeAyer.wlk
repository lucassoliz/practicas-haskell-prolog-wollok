

/* =================== 1) ==================
Noticia:
    - fechaDePublicacion
    - periodista (que fuen quien lo publico)// mas bien el autor 
    - gradoDeImportancia (que va del 1 a 10)
    - titulo
    - desarrollo


Tipos de Noticia:
    - ArticuloComun:
        - linksANoticias
    - Chivo:
        - plataPagada
    - Reportaje:
        - entrevistados (ej: "María Becerra" o a "Los Auténticos Decadentes")
    - Cobertura:
        - noticiasRelacionadas


    + esCopada: gradoImportancia >= 8  && fechaDePublicacion < 3 dias &&
        - ArticuloComun: linksANoticias.size >= 2
        - Chivo: plataPagada > 2M
        - Reportaje: entrevistados.letras.impar
        - Cobertura: todas las noticiasRelacionadas.sonCopadas()

    Por lo que es claro que aca tenemos que usar polimorfismo para definir el metodo esCopada en cada subclase
    y delegar la responsabilidad de saber si es copada o no a cada tipo de noticia, es decir herencia

    OSEA QUE: NOTICIA es nuestras SUPERCLASE, y los distipos tipos de NOTICIA son nuestras SUBCLASES
*/
/*=================== 2) ==================
    Periodista:
        - fechaDeIngreso
        - preferencias 
        + quierePublicarNoticiaCopada() //Algunos
        + quierePublicarNoticiaSensacionalista() //Otros --> tiene que tener la palabra “espectacular”, “increíble”, o “grandioso” 
        + quierePublicarNoticiasVagas() //Estan los vagos --> solo chivos o desarrollo < 100 palabras
        + quierePublicarNoticiasDeTituloConT() //Jose De Zer --> titulo comienza con "T"
*/
class Noticia {
    const property fechaDePublicacion // solo getter porque no deberia cambiarse nunca en teoria
    const property autor
    const property gradoDeImportancia
    const property titulo
    const property desarrollo

    method esCopada() = 
        self.esImportante() &&
        self.esReciente() &&
        self.condicionParticularDeTipo() // no implementamos la logica de una para que cada subclase lo haga

    //Ahora a implementar la logica de los metodos auxiliares
    method esImportante() = gradoDeImportancia >= 8
    method esReciente() = (new Date() - fechaDePublicacion) < 3
// new Date() representa la fecha actual menos la fecha de publicacion
    method condicionParticularDeTipo() //primitiva que cada subclase debe implementar 

 // ============= 2) ==============================
    method esSensacionalista() = 
        self.tituloContiene(["espectacular", "increíble", "grandioso"]) //usamos el metodo tituloContiene como AUXILIAR

    method tituloContiene(palabras) = 
        palabras.any(palabraElementoLista -> titulo.contains(palabraElementoLista))   /* esto verifica si alguna de las palabras 
        esta contenida en el titulo de la noticia, si te fijas usamos any para que alcance con que una sola palabra
        ademas usamos el metodo: 
        contains que verifica si una cadena de texto esta dentro de otra cadena de texto  <--------------- !!
Lectur:
Che toma la lista de palabras que me interesan y fijate si alguna (any) de esas palabras (palabraElementoLista ->) 
esta contenida en el titulo (titulo.contains(palabraElementoLista))

CONSTAINS: se fija si esa palabraElementoLista esta dentro del titulo EJ: titulo = "Noticia espectacular de hoy" --> true (GOD)
        */

    method aptaParaVago() = desarrollo.words().size() < 100  
    /*words() separa el desarrollo en palabras y size() cuenta la cantidad de palabras
    
    EJEMPLO words:
    desarrollo = "El dibujo atajo todo" --> desarrollo.words() = ["El","Dibo","atajo","todo"] --> size() cuenta cada elemento */

    method tituloComienzaCon(letra) = titulo.startsWith(letra) //importante generalizar con parametro letra, mas flexible
// startsWith basicamente se fija el primer caracter de la cadena de texto y lo compara con la letra dada, si coinciden devuelve true
}

class ArticuloComun inherits Noticia {
    const links = [] // lista vacia por defecto, se puede inicializar con una lista de links
    // const links para que no se pueda modificar despues de crear el objeto

    override method condicionParticularDeTipo() =
        links.size() >= 2 //con size() contamos la cantidad de links, es decir el tamaño de la lista

}

class Chivo inherits Noticia {
    const property plataPagada
    
    override method condicionParticularDeTipo() = plataPagada > 2000000 //2M en numeros xd
}

class Reportaje inherits Noticia {
    const property entrevistados

    override method condicionParticularDeTipo() =
        entrevistados.size().odd() //de entrevistado se fija la cantidad de letras con size() y se fija si es impar con odd()
// ============ 2) ==============
    override method esSensacionalista() = super() && entrevistado == "Dibu Martínez"  
    //pense tambien como && self.tituloContiene(["Dibu Martínez"])

}

class Cobertura inherits Noticia {
    const property noticiasRelacionadas = []  // lista por ser varias noticias relacionadas a la vez
    
    override method condicionParticularDeTipo() =
        noticiasRelacionadas.all(noticia -> noticia.esCopada())
/* all verifica que todas las noticias relacionadas cumplan con la condicion de ser copadas
   Se lee como:
Che toma la lista de noticias relacionadas, te tenes que fijar que todas (all) las noticias (noticia ->) 
cumplan con la condicion de que noticia.esCopada() sea true, cada noticia es un elemento de la lista noticiasRelacionadas
*/
        
}

//subclases porque es lo mismo que una noticia pero con caracteristicas particulares

//2)
//necesitamos preguntarle a la noticia si es copada, sensacionalista, apta para vagos o si el titulo comienza con T
class Periodista { //clase porque es un objeto con propiedades y comportamientos, que tiene diferente cada periodista
    const property fechaDeIngreso
    const property preferencia //= [] // lista de preferencias del periodista

    method prefiere(noticia) = preferencia.prefiere(noticia)
    //esto es para que el periodista le pregunte a su preferencia si prefiere esa noticia
    //es decir le pregunta al objeto cual es su preferencia y este le responde si prefiere o no esa noticia
}

object noticiaCopada {
    method prefiere(noticia) = noticia.esCopada()
}

object noticiaSensacionalista {
    method prefiere(noticia) = noticia.esSensacionalista()
}

object vago {
    method prefiere(noticia) = noticiaa.aptaParaVago()
}

object joseDeZer {
    method prefiere(noticia) = noticia.tituloComienzaConT("T")
}

        