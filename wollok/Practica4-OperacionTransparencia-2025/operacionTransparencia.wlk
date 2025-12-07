//============= PUNTO 1==================

class Causa {
    var property montoBase //no me dice cual es el monto base, lo dejo para que el usuario lo defina
    const property caratula
    const property jueces = [] //SERIE de jueces que tratan la causa --> LISTA
//ej: causa1 = Causa(montoBase = 5, caratula = "Coimas en obra publica", jueces = [juez1, juez2])

    method perjuicioEconomico() = montoBase() + montoExtra()
    method montoBase() = montoBase //A IMPLEMENTAR en subclases PRIMITIVA
    method montoExtra() = 0 //A IMPLEMENTAR en subclases PRIMITIVA, lo inicializo en 0

//============= PUNTO 3 ======================
    method esTranboliko() = self.perjuicioEconomico() > 5
    method aumentarMontoBase(valor) {
        montoBase = montoBase + valor // PARA QUE SE ACTUALICE EL MONTO BASE DE LA CAUSA DEL ATRIBUTO DE LA CLASE
}
//=============================================
}

class Soborno inherits Causa {
    const property hayArrepentidos
//ej: causaSoborno = Soborno(montoBase = 4, caratula = "Coimas en ministerio X", jueces = [juez1], hayArrepentidos = true)
    override method montoExtra() = if (hayArrepentidos) 1 else 2
}        

class ObraPublica inherits Causa {
    override method montoBase() = 3 //aca el monto base es siempre 3 millones
//ej: causaObraPublica = ObraPublica(caratula = "Desvio de fondos en obra Y", jueces = [juez1, juez2, juez3])
    override method montoExtra() = if (jueces.size() < 2) 2 else 0
}

class CausaCompleja inherits Causa {
    const property subCausas = [] //SERIE de sub-causas que forman la causa compleja --> LISTA
//ej: causaCompleja = CausaCompleja(montoBase = 2, caratula = "Red de corrupcion Z", jueces = [juez1, juez2], subCausas = [causaSoborno, causaObraPublica])
    override method montoExtra() = subCausas.sum( subCausa => subCausa.montoExtra() ) 
    //convierte la lista de subCausas en una lista de montos extra y los suma
}

//============= PUNTO 2==================
class FuncionarioPublico {
    const property patrimonioActual
    const property causas = [] //SERIE de causas que tiene el funcionario --> LISTA
    var property rol //para que pueda cambiar de rol (PoderEjecutivo o Ministro) <-- "Claramente los funcionarios pueden pasar de un puesto a otro en diferentes momentos."
//Ahora cambiar de rol es tan simple como asignar un nuevo objeto a la propiedad rol
//ej: func1 = FuncionarioPublico(patrimonioActual = 10, causas = [causaSoborno], rol = new PoderEjecutivo())
    method puedeComerseCausa(causa) =
        patrimonioActual > 0 and rol.cumpleCondicionesSegunTipo(self,causa) //self es el funcionario actual <-- antes era solo causa


    method validarQuePuedeComerseCausa(causa) {
        if (!self.puedeComerseCausa(causa)) {
            throw new DomainException(message: "No puede comerse la causa: " + causa.caratula) //dicha causa accdedemos a su caratula
    }}
//================ PUNTO 4 ==========================
    const property propuestas = [] 
    method escucharPropuesta(pedido) {if(!rol.aceptarPropuesta(pedido)){ pedido.postergarCumplimiento()} 
                                                                        propuestas.add(pedido) }
//==================== PUNTO 3 =========================================
     method causasQueDejanPegado() =
        causas.filter({ causa => causa.esTranboliko() }) //filtra las causas cuyo perjuicioEconomico es mayor a 5 millones
    method salirEnMedios() = causas.map({ causa => causa.aumentarMontoBase(0.1) })
    //=====================================================================
}

//LO HABIA HECHO ASI PERO ME DI CUENTA QUE NO PODIA CAMBIAR DE ROL Y CREO QUE HAY OTRA FORMA MAS LIMPIA DE HACERLO +++++++++++++++++++
/*
class PoderEjecutivo inherits FuncionarioPublico {
    const property juecesAmigos = [] //SERIE de jueces amigos del funcionario --> LISTA

    override method cumpleCondicionesSegunTipo(causa) =
        causa.jueces.any({ juez => juecesAmigos.contains(juez) })
//verifica si alguno de los jueces de la causa es amigo del funcionario
//ej: funcEjecutivo = PoderEjecutivo(patrimonioActual = 10, causas = [causaSoborno], juecesAmigos = [juez1])
//funcEjecutivo.puedeComerseCausa(causaSoborno) --> true si juez1 es juez de causaSoborno   
}

class Ministro inherits FuncionarioPublico {
    override method cumpleCondicionesSegunTipo(causa) =
        patrimonioActual > (0.5 * causa.perjuicioEconomico())
}
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
PROPUESTA:*/

object PoderEjecutivo {
    const property juecesAmigos = [] //SERIE de jueces amigos del funcionario --> LISTA

    method cumpleCondicionesSegunTipo(funcionario, causa) =
        causa.jueces.any({ juez => juecesAmigos.contains(juez) })
//verifica si alguno de los jueces de la causa es amigo del funcionario
//ej: funcEjecutivo = FuncionarioPublico(patrimonioActual = 10, causas = [causaSoborno], rol = PoderEjecutivo)
//funcEjecutivo.puedeComerseCausa(causaSoborno) --> true si juez1 es juez de causaSoborno 

// ==================== PUNTO 4=====================
   // const property palabrasClaves = ["aumento", "impuestos", "inflacion"]
    
    method aceptarPropuesta() = self.descripcionContiene(["aumento", "impuestos", "inflacion"])
    method descripcionContiene(palabras) = palabras.any(palabraElemento -> descripcion.contains(palabraElemento))

}
object Ministro {
    method cumpleCondicionesSegunTipo(funcionario, causa) =
        funcionario.patrimonioActual > (0.5 * causa.perjuicioEconomico())
//================ Punto 4 ============================
    method aceptarPropuesta(pedido) = pedido.diferenciaEnAnios() < 1
}

//============= PUNTO 3==================
/*
Causas que te dejan pegado para un funcionario: 
    - perjuicioEconomico > tramboliko (5 millones)

funcionaro saleEnMedios():
    - todas las causas que se cometieron aumentan en 0,1 millones más al monto base
*/
// ================= PUNTO 4==================
/* funcionario:
        propuestas = []  --> transformar a promesas
    propuesta:
        -descripcion
        -fechaPresentacion
        -fechaCumplimiento
    
            escucharPropuesta --> aveces la aceptan como están || fechaCumplimiento + 4 años
    poderEjecutivo:
        -aceptarPropuesta: que usemos contains practicamente <-- palabras claves que le dan los asesores de imagen
    ministro:
        -aceptarPropuesta: pedidos cortos (menos de un año entre fechaCumplimiento y fechaPresentacion)
*/
class Propuesta {
    const property descripcion
    const property fechaPresentacion
    var property fechaCumplimiento
//es "algo" que se encarga de modelar la propuesta
    method diferenciaEnAnios() = fechaCumplimiento.year() - fechaPresentacion.year()
    method postergarCumplimiento() = fechaCumplimiento = fechaCumplimiento.plusYears(4)
    
}