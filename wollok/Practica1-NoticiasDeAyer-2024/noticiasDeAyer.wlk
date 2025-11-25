//1)
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