# Operacion Transparencia Tema 1
[Enunciado pdf]()  
Qué placer vivir en este país: tenemos un frontend (paisajes) que es una maravilla visual y una comunidad (la gente) que es 100% open source, siempre colaborando y ayudando al que tiene al lado. El problema, claro está, es el backend: nuestro sistema político. Es ese proyecto legacy que tiene muchísimos años, escrito en un lenguaje que en ninguna otra parte del mundo entienden, lleno de bugs críticos y con modelados implementados sin un solo test que lo respalde.
Lo peor, es que los devs a cargo insisten en que "en sus máquinas funciona perfecto".
Como no nos dejan hacer el refactor completo que necesitamos, ¡al menos vamos a modelar este caos!

# Punto 1 - ¿Estamos en problemas?

Se necesita modelar las causas que investiga la Oficina Anticorrupción. Estas tienen una carátula (un título) y deben poder calcular su perjuicio económico total al Estado. Toda causa puede ser tratada por una serie de jueces, algunos de ellos muy conocidos como "Dr. Rodolfo Kometa", "Dr. Armando U. Nacausa", el "Dr. Jorge Garantis". Todo cálculo monetario está expresado en millones de dólares. El cálculo del perjuicio se calcularía de la siguiente manera:

- Para las causas de soborno es el monto base de la causa que se le suma 1 millón de dólares si hay arrepentidos o bien 2 millones en caso contrario.
- La causa de obra pública tiene un monto base de 3 millones de dólares, los jueces que tratan esta causa siempre son los mismos y el perjuicio económico es el monto base de la causa que se le suman 2 millones en caso que tenga menos de dos jueces. Si tiene más no se le adiciona dinero dado que entre varios "solucionan" rápido la causa.
- Las causas complejas están formadas por sub-causas que pueden ser de cualquier tipo (incluso otras causas complejas). El perjuicio económico es el monto base + la sumatoria de los montos extra que tiene cada sub-causa.

# Punto 2 - Ñoqui al pesto

El sistema también debe gestionar a los Funcionarios Públicos. Cualquiera de estos personajes puede tener causas y conocemos su patrimonio actual. Para comerse una causa en primer lugar tiene que tener patrimonio (no se puede comer una causa alguien que no tiene un mango) y además:

- Los del poder ejecutivo tiene que tener un juez amigo en la causa.
- Los ministros tienen que tener un patrimonio mayor al 50% del perjuicio de la causa

Queremos que incorpore esta funcionalidad tomando en cuenta las validaciones pedidas por el negocio y en caso de no cumplir alguna regla defina de qué manera debe responder. Claramente los funcionarios pueden pasar de un puesto a otro en diferentes momentos. La solución debe ser flexible.

# Punto 3 - Si Neustadt te viera...

Nos interesa analizar el arco político de nuestro hermoso país. Para ello...

- Nos interesa conocer las causas que te dejan pegado para un funcionario. Estas son las que el perjuicio económico es tramboliko (mayor a 5 millones).
- Todo funcionario puede salir en medios. Cada vez que sale en medios, aumentan todas las causas que se cometieron en 0,1 millones más al monto base.

# Punto 4 - Se acerca la campaña

Se acercan las campañas y como siempre, todos los funcionarios prometen el oro y el moro. A la hora de escuchar una propuesta, el funcionario la transforma en promesas que tienen (JA!) que cumplir. Estos pedidos tienen una descripción y una fecha de presentación y una fecha que deberían dar cumplimiento. Todas las propuestas se escuchan a veces las aceptan como están o de lo contrario las toman pero con fecha de cumplimiento 4 años adelante (cuando terminan su mandato .. XD)

- Los del poder ejecutivo solamente aceptan propuestas que contengan alguna de palabras claves en su descripción que le dan los asesores de imagen como ser por ejemplo "aumento", "impuestos", "inflación".
- Los ministros aceptan los pedidos cortos (tienen menos de un año entre la fecha de cumplimiento y la fecha de presentación).