module Library where
import PdePreludat
import Text.Read.Lex (Number)
import Data.Ratio (numerator)
import Distribution.Simple.Program.HcPkg (HcPkgInfo(recacheMultiInstance))
import qualified Control.Applicative as etc

doble :: Number -> Number
doble numero = numero + numerator

data Receta = Receta {
    nombreReceta :: String,
    tiempoCoccion :: Number,
    cantidadMinimaIngredientes :: Number,
    comentariosJueces :: [String],
    enRevision :: Bool,
    ajustes :: [AjusteReceta]
} deriving (Show, Eq, Ord)

data AjusteReceta = AjusteReceta {
    duracionAjuste :: Number,
    trabajoAjuste :: Trabajo
} deriving (Show, Eq, Ord)

type Trabajo = Receta -> Receta 

-- Punto 1: Puntaje de la receta
puntajeReceta :: Receta -> Number
puntajeReceta receta 
    | ((>60) . tiempoCoccion) receta = 90
    | ((<2) . length . ajustes) receta = ( (*7) . length . nombreReceta) receta + ( (*4) . length . comentariosJueces) receta
    | otherwise = (*5) . cantidadMinimaIngredientes receta

{-ajustePendientes :: Receta -> Bool
ajustePendientes receta = (<2) . length . ajustes receta -}
{-puntajePorNombreYComentarios :: Receta -> Number
puntajePorNombreYComentarios receta = ( (*7) . length . nombreReceta) receta + ( (*4) . length . comentariosJueces) receta -}

-- Punto 2: Ajustes de la receta
aplicarAjuste :: Trabajo
aplicarAjuste = verificarAjustePendientes . eliminarAjusteMasReciente

eliminarAjusteMasReciente :: Trabajo
eliminarAjusteMasReciente receta = receta { 
    ajustes = tail . ajustes $ receta }

verificarAjustePendientes :: Trabajo
verificarAjustePendientes receta = receta { 
    ajustes = not . null . ajustes $ receta}

mejoraDeSabor :: Number -> Trabajo
mejoraDeSabor cantidadEspecia receta = receta { 
    tiempoCoccion = min 60 . (+ tiempoCoccion receta ) . ( (*10). cantidadEspecia ) }

-- cuidado en caer en los negativos, para eso estan los tester
reduccionDeIngredientes :: Number -> Trabajo
reduccionDeIngredientes cantidad receta = receta {
    cantidadMinimaIngredientes = max 0 . ( (- cantidad) . cantidadMinimaIngredientes receta ) , 
    comentariosJueces = comentariosJueces receta ++ ["mas simple"]
}
comentarioDePresentacion :: Trabajo
comentarioDePresentacion receta = receta {
    comentariosJueces = take 2 . comentariosJueces $ receta
}
ajusteBasico :: Trabajo
ajusteBasico = mejoraDeSabor 2 . reduccionDeIngredientes 2

-- Punto 3: Recetas con ajustes
platoBomba ::  Receta -> Bool
platoBomba = any (>3) . duracionAjuste . ajustes

recetaFueraDeConcurso :: Receta -> Bool
recetaFueraDeConcurso = (== 6) . sum . duracionAjuste . ajuste

masterchefNoEsistis :: [Receta] -> Bool
masterchefNoEsistis= all (null . ajustes) . filter ((>10) . length . nombreReceta)


-- Punto 4: Ajustes de Peolas
tieneAjustesPeolas :: Receta -> Bool
tieneAjustesPeolas receta = (reparacionesPeolas receta . ajustes) receta
-- reparacionesPeolas receta [AjusteReceta]
reparacionesPeolas :: Receta -> [AjusteReceta] -> Bool
reparacionesPeolas _ [] = True
reparacionesPeolas receta (ajusteee : restoAjustes) = 
    mejoraPuntaje receta ajusteee && reparacionesPeolas (trabajoAjuste ajusteee receta) restoAjustes

-- reparacionesPeolas (trabajoAjuste ajusteee receta) restoAjustes se aplica lo de adentro del parentesis
-- y se le pasa la receta modificada por el ajuste, y asi sucesivamente hasta que
mejoraPuntaje :: Receta -> AjusteReceta -> Bool
mejoraPuntaje receta ajustDeR = ((> puntajeReceta receta) . puntajeReceta) (trabajoAjuste ajustDeR receta)

--AjustDeR es el ajuste pendiente que le aplicamos por ejemplo ajusteBasico, comentariosdepresentaccion etc..
--En (trabajoAjuste ajustDeR receta) lo que estamos haciendo es pasarle la receta y aplicarle el ajuste
--Al aplicar el ajuste nos va a devolver un Trabajo por los argumentos de salida que le pusimos a cada ajuste
--Como type Trabajo = Receta -> Receta, nos dara una receta y tendremos trabajoAjuste recetaModificada
-- y ahi podemos comparar si el puntaje de la receta modificada es mayor al puntaje
-- de la receta original, si es asi devolvemos True, si no devolvemos False

--TrabajoAjuste como es trabajoAjuste :: Receta -> Receta, entonces podemos pasarle la receta y nos devolvera una receta modificada

--PUNTO 5 Manos en la masa
realizarAjuste ::  Receta -> Receta
realizarAjuste receta000 = (foldr (trabajoAjuste) receta000 . ajustes) receta000
-- En este caso foldr recorre la lista de ajustes y aplica el trabajoAjuste a cada uno de los ajustes
-- de la receta, devolviendo una receta modificada con todos los ajustes aplicados.
-- Por ejemplo, si tenemos una receta con dos ajustes, el foldr aplicara el primer ajuste a la receta
-- y luego aplicara el segundo ajuste a la receta modificada por el primer ajuste, devolviendo la receta final
-- que tiene todos los ajustes aplicados
-- equivalente a foldr trabajoAjuste receta (ajustes receta)}
-- Tendremos tipo:  foldr trabajoAjuste receta0 [aj1, aj2, aj3, aj4, aj5, aj6]

{- mejor ejemplo para foldr
foldr (+) 0 [1, 2, 3, 4]
-- = 1 + (2 + (3 + (4 + 0))) = 10-}
--------------------------------------------------------------------------------------
{- En nuestro caso:
trabajoAjuste aj1 (trabajoAjuste aj2 (trabajoAjuste aj3 (trabajoAjuste aj4 (trabajoAjuste aj5 receta0))))
-}
--------------------------------------------------------------------------------------

-- Ejemplo de evaluación por consola: **********************************************
{-
Ejemplo de evaluación por consola:

receta = Receta "Bizcochuelo" 25 8 ["Muy esponjoso", "Delicioso", "Color perfecto"] False [aj1, aj2, aj3, aj4]
realizarAjuste receta

Resultado:
Receta {nombreReceta = "Bizcochuelo", tiempoCoccion = 60, cantidadMinimaIngredientes = 3, comentariosJueces = ["Muy esponjoso","Delicioso","mas simple"], enRevision = False, ajustes = [aj1,aj2,aj3,aj4]}
-}

{-
}
Si hay reparaciones infinitas para el punto anterior no va a seguir operando el foldr y el siguiente elemento nunca va a tener un fin
Para el punto 4, si en algun momento no mejora el scoring, el algoritmo converge a un valor por lazy evaluation. Si todas mejoran el scoring, el mismo diverge
-}
