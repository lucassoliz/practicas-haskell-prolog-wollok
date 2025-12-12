//PARTE C
//PUNTO 1 CODIGO COMPLETO (FERRETERIA) 

class Compra {
    const productos = [] 
    
    // Calculamos el total sumando el precio de cada producto (Polimorfismo por el método precio) 
    method totalAPagar() = productos.sum({ prooduct => prooduct.precio() })
}

class Producto {
    var property origen // Puede ser uruguay, brasil, argentina, etc.
    
    // PATRÓN TEMPLATE METHOD:
    // Define el esqueleto del algoritmo (Base + Recargo) y delega la parte
    // específica (precioBase) a las subclases.
    method precio() = self.precioBase() * (1 + origen.recargo())
    
    // Método abstracto que deben implementar los hijos
    method precioBase() 
}

/*ORIGENES (Strategy para el recargo) */
object uruguay {
    method recargo() = 0.10
}

object brasil {
    method recargo() = 0.07
}

object argentina {
    method recargo() = 0.0 // Asumimos 0 o lo que sea
}

// PRODUCTOS
class Herramienta inherits Producto {
    var property peso = 0
    
    // Implementación específica del hook method
    override method precioBase() = peso * 10
}

class MaterialDeConstruccion inherits Producto {
    // La variable ya actúa como la implementación del método precioBase()
    // al generar el getter automáticamente jaja 
    var property precioBase = 0 
}

/*
PUNTO 2     ||   V O F

a. Hay polimorfismo en precio(), a pesar de que haya una sola implementación
 de dicho método que es la misma para todos los productos.

VERDADERO: El polimorfismo se da e el envio del mensaje precio()
Desde el punto de vista de la Compra, ella le envia precio() a distintos objetos
(Herramienta, Material) y cada uno responde correctamente, aunque el codigo
este compartido en la superclase Producto, el comportamiento es distinto
porque precio() invoca a self.precioBase() que es distinto en cada subclase

b. Si se agregaran nuevos cosas... la clase de la que se instanciarían estos 
nuevos objetos debe también heredar de Producto.

FALSO: el polimorfismo se basa en la interfaz (los mensajes que entienden los objetos)
No es obligatorio que hereden de una superclase en comun. Para que un objeto pueda
ser cobrado en una Compra, solo necesita entender el mensaje precio()

Heredar de Producto es util para reutilizar codigo (la logica del origen), pero no
es obligatorio para que el sistema funcione
(siempre y cuando el nuevo objeto implemente un metodo precio() que funcione bien)


*/

/*
PUNTT 3
     - Precio base es igual (peso * 10)
     - Se aplica el recargo del pais (igual que todos)
     -Al final se suman 10000 de licencia

Implementacion: Creamos una nueva subclase HerramientaProfesional que herede de Herramienta 
 */
class HerramientaProfesional inherits Herramienta {
    
    override method precio() {
        // super() llama a Producto.precio(), que hace: (peso*10) * (1+origen)
        // Luego le sumamos la licencia.
        return super() + 10000
    }
}
