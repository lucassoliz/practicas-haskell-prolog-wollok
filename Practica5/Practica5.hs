{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}


module Library where
import PdePreludat
import Data.Array (listArray)

doble :: Number -> Number
doble numero = numero + numero

data Tarea = Tarea {
    nombreTarea :: String,
    duracionEstimada :: Number,
    prioridad :: Number,
    estadoTarea :: String,      -- "Pendiente", "EnProgreso", "Completada"
    etiquetas :: [String]
} deriving (Show, Eq)

--Punto 1
-- ===============================CON RECURSIVIDAD==========================================
contarCompletadas :: [Tarea] -> Number
contarCompletadas [] = 0
contarCompletadas (tarea:lasDemasTareas)
    | estadoTarea tarea == "Completada" = 1 + contarCompletadas lasDemasTareas
    | otherwise = contarCompletadas lasDemasTareas

-- ================================SIN RECURSIVIDAD========================================
    {-
contarCompletadas :: [Tarea] -> Number
contarCompletadas tareas = length . filter (== "Completada") . estadoTarea $ tareas 
-}
-- ================================POR CONSOLA ================================
{-
Ejemplo de uso por consola:
let tareas = [Tarea "Tarea1" 2 1 "Pendiente"
                , Tarea "Tarea2" 3 2 "Completada"
                , Tarea "Tarea3" 1 3 "Pendiente"]
contarCompletadas tareas
Resultado: 1
-}

--Punto 2
sumarSiPendiente :: Number -> Tarea -> Number
sumarSiPendiente acumulador tarea
    | (== "Pendiente") . estadoTarea $ tarea = (+acumulador) . duracionEstimada $ tarea
    | otherwise                        = acumulador

tiempoTotalPendiente :: [Tarea] -> Number
tiempoTotalPendiente tareas = foldl sumarSiPendiente 0 tareas
{- EJEMPLO DE COMO FUNCIONA PASO POR PASO:
1. Se inicia con un acumulador en 0.
2. Se evalúa la primera tarea: "Tarea1" (Pendiente, 2)
   - Como su estado es "Pendiente", se suma su duración (2) al acumulador.
   - Acumulador ahora es 2.
3. Se evalúa la segunda tarea: "Tarea2" (Completada, 3)
   - Su estado no es "Pendiente", así que el acumulador se mantiene en 2.
4. Se evalúa la tercera tarea: "Tarea3" (Pendiente, 1)
   - Se suma su duración (1) al acumulador.
   - Acumulador final es 3.
-}
{-
Para argumentos para funciones:
foldl sumarSiPendiente 0 [t1, t2, t3]
= foldl sumarSiPendiente (sumarSiPendiente 0 t1) [t2, t3]
= foldl sumarSiPendiente (sumarSiPendiente (sumarSiPendiente 0 t1) t2) [t3]
= foldl sumarSiPendiente (sumarSiPendiente (sumarSiPendiente (sumarSiPendiente 0 t1) t2) t3) []
= (sumarSiPendiente (sumarSiPendiente (sumarSiPendiente 0 t1) t2) t3)

pero si es una operacion simple, seria 
foldl sumarSiPendiente 0 [t1, t2, t3, t4]
= (((0 sumarSiPendiente t1) sumarSiPendiente t2) sumarSiPendiente t3) sumarSiPendiente t4
-}


{-tiempoTotalPendiente :: [Tarea] -> Number
tiempoTotalPendiente tareas = foldl (+) 0 . map duracionEstimada . filter (== "Pendiente") $ tareas
-}
-- ================================POR CONSOLA ================================
{- 
Ejemplo de uso por consola:
let tareas = [Tarea "Tarea1" 2 1 "Pendiente"
                , Tarea "Tarea2" 3 2 "Completada"
                , Tarea "Tarea3" 1 3 "Pendiente"]
tiempoTotalPendiente tareas
Resultado: 3
-}
--PUNTO 3
nombreTareasDePrioridad :: Number -> [Tarea] -> [String]
nombreTareasDePrioridad prioridadBuscada tareas = map nombreTarea . filter ((== prioridadBuscada) . prioridad) $ tareas

-- ================================POR CONSOLA ================================
{-
Ejemplo de uso por consola:
let tareas = [Tarea "Tarea1" 2 1 "Pendiente"
                , Tarea "Tarea2" 3 2 "Completada"
                , Tarea "Tarea3" 1 3 "Pendiente"]
nombreTareasDePrioridad 2 tareas
Resultado: ["Tarea1"]
-}
--PUNTO 4
existeEtiqueta :: String -> [Tarea] -> Bool
existeEtiqueta _ [] = False
existeEtiqueta etiqueta (tarea:lasDemasTareas) 
    | any (== etiqueta) . etiquetas $ tarea = True
    | otherwise = existeEtiqueta etiqueta lasDemasTareas
-- ================================POR CONSOLA ================================
{- 

Ejemplo cuando da True existeEtiqueta:
let tareas = [Tarea "Tarea1" 2 1 "Pendiente" ["Urgente"]
                , Tarea "Tarea2" 3 2 "Completada" ["Importante"]
                , Tarea "Tarea3" 1 3 "Pendiente" ["Urgente"]]
existeEtiqueta "Urgente" tareas
Resultado: True

-}
--PUNTO 5 usando fold1
tareaMasLarga :: [Tarea] -> Tarea
tareaMasLarga tareas = foldl1 max . map duracionEstimada $ tareas
-- ================================POR CONSOLA ================================

--PUNTO 6
sumaDePrioridadesTareasEnProgreso :: [Tarea] -> Number
sumaDePrioridadesTareasEnProgreso tareas = foldl (+) 0 . map prioridad . filter ((== "EnProgreso") . estadoTarea) $ tareas
-- ================================POR CONSOLA ================================
{- Ejemplo de uso por consola:
let tareas = [Tarea "Tarea1" 2 1 "Pendiente" ["Urgente"]
                , Tarea "Tarea2" 3 2 "Completada" ["Importante"]
                , Tarea "Tarea3" 1 3 "EnProgreso" ["Urgente"]]
sumaDePrioridadesTareasEnProgreso tareas
Resultado: 3
-}