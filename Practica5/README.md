# Práctico 5 – Recursividad y Folds en Haskell

## Objetivo
Este práctico está enfocado en ejercitar y reforzar los conceptos de recursividad y el uso de funciones de orden superior como `foldl`, `foldr`, `foldl1` y `foldr1` en Haskell.  
Todos los ejercicios están pensados para que practiques la construcción de funciones tanto recursivamente como utilizando folds.

---

## Modelos y consignas

### **Contexto general**
Vamos a modelar una lista de tareas para un sistema de gestión de proyectos.  
Cada tarea se representa como un registro con nombre, duración estimada (en horas), prioridad (de 1 a 5), estado ("Pendiente", "EnProgreso" o "Completada") y lista de etiquetas.

```haskell
data Tarea = Tarea {
    nombreTarea :: String,
    duracionEstimada :: Number,
    prioridad :: Number,
    estadoTarea :: String,      -- "Pendiente", "EnProgreso", "Completada"
    etiquetas :: [String]
} deriving (Show, Eq)
```

La lista de tareas de un proyecto se representa como `[Tarea]`.

---

## **Puntos**

### **1. (Recursividad simple)**
Implementá la función `contarCompletadas :: [Tarea] -> Number` que cuenta cuántas tareas están completadas utilizando **recursividad explícita** (no usar folds ni funciones de orden superior).

---

### **2. (foldl básico)**
Implementá la función `tiempoTotalPendiente :: [Tarea] -> Number` que calcula la suma de la duración estimada de todas las tareas en estado `"Pendiente"` usando **foldl**.

---

### **3. (foldr y filtrado)**
Implementá la función `nombresTareasDePrioridad :: Number -> [Tarea] -> [String]` que devuelve los nombres de las tareas de cierta prioridad (por ejemplo, solo prioridad 5) usando **foldr**.

---

### **4. (Recursividad anidada)**
Implementá la función `existeEtiquetaEnTodas :: String -> [Tarea] -> Bool` que indica si **todas** las tareas (si la lista es vacía, devolver True) tienen una etiqueta dada, usando **recursividad explícita**.

---

### **5. (foldl1/foldr1 y máximo/mínimo)**
Implementá la función `tareaMasLarga :: [Tarea] -> Tarea` que devuelve la tarea con mayor duración estimada utilizando **foldl1**.

---

### **6. (Diseño libre: fold o recursividad)**
Proponé y resolvé una función de utilidad para la lista de tareas que combine estados y prioridades (por ejemplo: devolver la suma de prioridades de las tareas en progreso, o concatenar los nombres de las tareas completadas, etc). Explicá brevemente tu elección y resolvé el punto usando **recursividad o fold**, a elección.

---
