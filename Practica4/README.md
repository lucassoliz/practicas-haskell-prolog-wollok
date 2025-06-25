# Parcial Funcional: GitHubHub

![github_banner](https://tekimobile.com/wp-content/uploads/2024/01/20240108-github-destaque-1920x1097.png)

---

## Disclaimer

En este parcial se evaluarán los conceptos de aplicación parcial, composición, reutilización, recursividad y orden superior para el modelado del mismo. La ausencia de estos conceptos puede significar descuentos en la nota.

---

Vamos a modelar un sistema de gestión de repositorios GitHub donde registramos los repositorios, de los cuales conocemos su nombre, la cantidad de estrellas, la lista de colaboradores (personas que contribuyen), la lista de issues abiertos —cada uno con su título y etiquetas— y la lista de pull requests, cada una con información sobre el autor, la cantidad de commits y si fue aceptada o no. El sistema debe permitir realizar acciones sobre los pull requests, como mergear, agregar commits, o cerrar pull requests de un autor específico, y también debe gestionar situaciones en las que no queden pull requests abiertos.

A continuación se describen los problemas a resolver en este modelo:

El primer punto consiste en determinar cuán “trending” es un repositorio. El puntaje se calcula de la siguiente manera: si el repo tiene más de 1000 estrellas, su puntaje es 1000 puntos. Si no es así, pero tiene menos de 5 issues abiertos, el puntaje será de 15 puntos por cada colaborador más 30 puntos por cada pull request aceptada. En cualquier otro caso, el puntaje es el doble de la suma de commits de todos los pull requests.

En el segundo punto, se pide modelar las acciones sobre los pull requests de un repositorio. Cada vez que se realiza una acción, se debe eliminar el pull request más antiguo y luego verificar si quedan pull requests abiertos. Si no queda ninguno, el sistema debe agregar un issue titulado “Sin PRs activos” con la etiqueta “maintenance”. Las acciones posibles incluyen mergear una cantidad de pull requests pendientes, agregar commits al último pull request, cerrar todos los pull requests de un autor específico y una acción express que combine el merge de un pull request y la suma de tres commits al último pull request.

El tercer punto solicita analizar determinadas propiedades sobre los repositorios. Un repositorio se considera activo si algún pull request tiene más de 10 commits. Un repo está bloqueado si la cantidad de issues abiertos supera la cantidad de colaboradores. Además, una lista de repositorios se considera “githubNoEsistis” si todos los repositorios con nombres de más de 8 letras no tienen pull requests abiertos. En este punto, solo puede usarse composición y aplicación parcial, sin recursividad ni funciones auxiliares.

En el cuarto punto, se pide determinar si un repositorio tiene pull requests copados, lo que significa que, tras aplicar cada acción pendiente sobre la lista de pull requests (en el orden en que se presentan), el puntaje del repo mejora respecto al anterior. Este punto debe resolverse exclusivamente con recursividad.

El quinto punto plantea modelar un proceso donde se apliquen todas las acciones pendientes sobre los pull requests de un repositorio, utilizando únicamente funciones de orden superior y composición, sin recursividad.

Por último, el sexto punto invita a reflexionar sobre qué sucede si un repositorio tiene una cantidad infinita de acciones pendientes, y si sería posible computar el resultado del proceso anterior o del punto cuatro, debiendo justificar la respuesta utilizando el concepto de evaluación perezosa.

---