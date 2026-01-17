module Entrega2 where

import PdePreludat
import Entrega1

-- [1.A INTEGRANTES 1,2,3 ]------|| arrancanONoArrancan ||----------------------------
arrancanONoArrancan :: [Auto] -> [String]
arrancanONoArrancan  = map modelo . filter (not . autoEnBuenEstado) 

-- [1.B INTEGRANTE 1 ]------|| grupoAltoEmbole  ||------------------------------------
grupoAltoEmbole :: Number -> [Auto] -> Bool
grupoAltoEmbole cant = any (not . autoDaParaMas) . take (round cant)

-- [1.C INTEGRANTE 2]------|| clasicoDeClasicos  ||------------------------------------
clasicoDeClasicos :: Number -> [Auto] -> Bool
clasicoDeClasicos tiempoMinimo = all esChiche . filter ((> tiempoMinimo) . tiempoCarrera)

-- [1.D INTEGRANTE 3 ]------|| nivelDeClavo     ||------------------------------------
nivelDeClavo :: Number -> [Auto] -> Bool
nivelDeClavo nivel = (>nivel) . sum . map desgasteChasis

--------------- ----------------- || BIRLARDISMO AUTOMOTOR || ------------------------------------

-- [2.A INTEGRANTE 1] {Bilardismo Automotor}------|| estanOrdenados ||--------------------------
-- Ord a => le avisa a Haskell que "a" puede ser ordenable (osea: mayor, menor, etc) Sino no lo permite comparar
estanOrdenados :: Ord a => (Auto -> a) -> [Auto] -> Bool
estanOrdenados _ [] = True
estanOrdenados _ [x] = True
estanOrdenados criterio (unAuto:otroAuto:resto) = (&&) ((<= criterio otroAuto) . criterio $ unAuto) (estanOrdenados criterio (otroAuto:resto))

-- [2.B INTEGRANTE 2] {Bilardismo Automotor]------|| altoToc ||------------------------------------
type CriterioAuto = Auto -> Bool

altoToc :: CriterioAuto -> [Auto] -> Bool
altoToc _ [] = True
altoToc _ [x] = True
altoToc criterio (_:auto:resto) = (&&) (criterio auto) (altoToc criterio resto)

-- [2.C INTEGRANTE 3] {Bilardismo Automotor]------|| elMasGroso ||------------------------------------
elMasGroso :: Ord a => (Auto -> a) -> [Auto] -> Auto
elMasGroso _ [unAuto] = unAuto
elMasGroso criterio (unAuto:resto) = elMayorEntre criterio unAuto (elMasGroso criterio resto)

elMayorEntre :: Ord a => (Auto->a) -> Auto -> Auto -> Auto
elMayorEntre criterio unAuto otroAuto 
  | criterio unAuto <= criterio otroAuto = otroAuto
  | otherwise = unAuto

-- [3 INTEGRANTE 1,2,3]----------|| a las pistas y mas alla||------------------------------------
data Pista = Pista {
  vuelta :: [Tramo],
  precio :: Number
} deriving (Show)

monza = Pista {
  vuelta = [curvaTranca, tramoRectoClassic, zigZagLoco, curvaPeligrosa, tramito],
  precio = 33
}

recorrerPista :: Pista -> Auto -> Auto
recorrerPista pista auto = foldl (flip transitarTramo) auto (vuelta pista)

{-
3.B Integrante 1
¿Qué ocurre si para grupoAltoEmbole le pasamos una lista infinita de autos? Justifique su respuesta.

- Si le pasamos una lista infinita de autos a grupoAltoEmbole, la funcion va a ejecutarse con normalidad,
hasta que el any detecte un auto que no cumpla con el criterio autoDaParaMas o el take alcance el parametro ingresado.
Para que la funcion se ejecute indefinidamente, todos los autos de la lista infinita deben cumplir con autoDaParaMas y el parametro del take debe ser infinito.
Esto porque haskell trabaja de manera Lazy y va evaluando con lo que tiene en el momento, 
no se va a gastar a evaluar toda una lista si puede cortar con lo que tiene.

3.C Integrante 2
¿Que pasa si le pasamos una lista infinita a clasicoDeClasicos?

- Si le pasamos una lista infinita de autos a clasicoDeClasicos, la funcion all se va a ejecutar cada 
vez que filter se ejecute, entonces si hay infinitos autos que cumple con filter, entonces 
all seguira pidiendo elementos para siempre, por lo que la funcion nunca finaliza, y el proceso 
no termina si la lista filtrada es infinita  

3.D Integrante 3
¿Que ocurre si para nivelDeAutosClavo le pasamos una lista infinita?

- En tal caso la funcion nunca terminaria ya que el problema esta en que 'sum' debe recorrer TODA la lista,
y como esta es infita pues nunca llega a recorrerla por completo. Se podria arreglar con un 'any' o un 'take' el cual 
permitiria que la funcion evalue una parte acotada de la lista.
-}