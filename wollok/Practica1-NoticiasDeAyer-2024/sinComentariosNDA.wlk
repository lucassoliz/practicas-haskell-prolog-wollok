class Noticia {
    const property fechaDePublicacion
    const property autor
    const property gradoDeImportancia
    const property titulo
    const property desarrollo

    method esCopada() = 
        self.esImportante() &&
        self.esReciente() &&
        self.condicionParticularDeTipo() 
    method esImportante() = gradoDeImportancia >= 8
    method esReciente() = (new Date() - fechaDePublicacion) < 3
    method condicionParticularDeTipo()
    method esSensacionalista() = 
        self.tituloContiene(["espectacular", "increíble", "grandioso"]) 

    method tituloContiene(palabras) = 
        palabras.any({ palabraElementoLista => titulo.contains(palabraElementoLista) })
    method aptaParaVago() = desarrollo.words().size() < 100  
    method tituloComienzaCon(letra) = titulo.startsWith(letra)
    method esPreferidaPorAutor() = autor.prefiere(self) 
    method esDeLaFecha(fecha) = fechaDePublicacion == fecha
    method validarBienEscrita() {
        if (self.cantidadDePalabrasEnTitulo() < 2) {
            throw new DomainException( message= "El titulo debe tener al menos 2 palabras" )
        }
    }
    method cantidadDePalabrasEnTitulo() = titulo.words().size()
    method validarDesarrollo() {
        if (desarrollo == "" || desarrollo == null) {
            throw new DomainException( message= "El desarrollo no puede estar vacio" )
        }
        
}
    method esNueva() = (new Date() - fechaDePublicacion) <= 7
    method tieneAutorReciente() = autor.esReciente()
}

class ArticuloComun inherits Noticia {
    const links = [] 
    override method condicionParticularDeTipo() =
        links.size() >= 2 
}
class Chivo inherits Noticia {
    const property plataPagada
    
    override method condicionParticularDeTipo() = plataPagada > 2000000 
    override method aptaParaVago() = true
}

class Reportaje inherits Noticia {
    const property entrevistado

    override method condicionParticularDeTipo() =
        entrevistado.size().odd()
    override method esSensacionalista() = super() && entrevistado == "Dibu Martínez"  
}
class Cobertura inherits Noticia {
    const property noticiasRelacionadas = [] 
    
    override method condicionParticularDeTipo() =
        noticiasRelacionadas.all({ noticia => noticia.esCopada() })
}

class Periodista {
    const property fechaDeIngreso
    const property preferencia

    method prefiere(noticia) = preferencia.prefiere(noticia)
    method esReciente() = (new Date() - fechaDeIngreso) <= 365
}
object noticiaCopada {
    method prefiere(noticia) = noticia.esCopada()
}

object noticiaSensacionalista {
    method prefiere(noticia) = noticia.esSensacionalista()
}

object vago {
    method prefiere(noticia) = noticia.aptaParaVago()
}

object joseDeZer {
    method prefiere(noticia) = noticia.tituloComienzaCon("T")
}
object medioDeComunicacion {
    const noticias = [] 

    method agregarNoticia(noticia) {
        self.validarPublicacion(noticia)
        noticias.validarBienEscrita(noticia)
        noticias.add(noticia)
    }

    method validarPublicacion(noticia) {
        if (!noticia.esPreferidaPorAutor() &&
            self.alcanzoLimiteDeNoPreferidas(noticia.autor())) {
                throw new DomainException( message= "El periodista ya alcanzo el limite de noticias no preferidas por dia" )
            }
    }
    method alcanzoLimiteDeNoPreferidas(autor) {
    return noticias.count({ noti => noti.autor() == autor && !autor.prefiere(noti) && noti.esDeLaFecha(new Date()) }) >= 2 
}
    method periodistaRecientesQuePublicaron() {
        return self.noticiasNuevasDePeriodistasRecientes().map({ noticia => noticia.autor() }).asSet()
    }
    method noticiasNuevasDePeriodistasRecientes() {
        return noticias.filter({ noticia => noticia.esNueva() && noticia.tieneAutorReciente() })
    }
}
