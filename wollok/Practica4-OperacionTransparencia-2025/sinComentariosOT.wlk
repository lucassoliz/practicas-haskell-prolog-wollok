class Causa {
    var property montoBase 
    const property caratula
    const property jueces = [] 

    method perjuicioEconomico() = montoBase() + montoExtra()
    method montoBase() = montoBase 
    method montoExtra() = 0 
    method esTranboliko() = self.perjuicioEconomico() > 5
    method aumentarMontoBase(valor) { montoBase = montoBase + valor }

}

class Soborno inherits Causa {
    const property hayArrepentidos
    override method montoExtra() = if (hayArrepentidos) 1 else 2
}        

class ObraPublica inherits Causa {
    override method montoBase() = 3 
    override method montoExtra() = if (jueces.size() < 2) 2 else 0
}

class CausaCompleja inherits Causa {
    const property subCausas = [] 
    override method montoExtra() = subCausas.sum({subCausa => subCausa.montoExtra()}) 
}

class FuncionarioPublico {
    const property patrimonioActual
    const property causas = [] 
    var property rol 

    method puedeComerseCausa(causa) = patrimonioActual > 0 and rol.cumpleCondicionesSegunTipo(self,causa) 
    method validarQuePuedeComerseCausa(causa) {
        if (!self.puedeComerseCausa(causa)) {
            throw new DomainException(message= "No puede comerse la causa: " + causa.caratula()) 
    }}
    
    const property propuestas = [] 
    method escucharPropuesta(pedido) {if(!rol.aceptarPropuesta(pedido)){ pedido.postergarCumplimiento()} 
                                                                        propuestas.add(pedido) }

    method causasQueDejanPegado() = causas.filter({ causa => causa.esTranboliko() }) 
    method salirEnMedios() = causas.map({ causa => causa.aumentarMontoBase(0.1) })

}

object poderEjecutivo {
    const property juecesAmigos = [] 

    method cumpleCondicionesSegunTipo(funcionario, causa) = causa.jueces().any({ juez => juecesAmigos.contains(juez) })
    method aceptarPropuesta() = self.descripcionContiene(["aumento", "impuestos", "inflacion"])
    method descripcionContiene(palabras) = palabras.any({palabraElemento => descripcion.contains(palabraElemento)})
}
object ministro {
    method cumpleCondicionesSegunTipo(funcionario, causa) = funcionario.patrimonioActual() > (0.5 * causa.perjuicioEconomico())
    method aceptarPropuesta(pedido) = pedido.diferenciaEnAnios() < 1
}

class Propuesta {
    const property descripcion
    const property fechaPresentacion
    var property fechaCumplimiento
    method diferenciaEnAnios() = fechaCumplimiento.year() - fechaPresentacion.year()
    method postergarCumplimiento() = fechaCumplimiento = fechaCumplimiento.plusYears(4)
    
}