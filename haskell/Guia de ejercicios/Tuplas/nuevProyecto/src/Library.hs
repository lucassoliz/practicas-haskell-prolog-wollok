module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--Ejercicio 1
fst3 :: (a, b, c) -> a
fst3 (a, _, _) = a
snd3 :: (a, b, c) -> b
snd3 (_, b, _) = b
trd3 :: (a, b, c) -> c
trd3 (_, _, c) = c

--Ejercicio 2
aplicar :: (Number, Number) -> Number -> (Number, Number)
aplicar (a, b) numero = (a * numero, b * numero)

--Ejercicio 3
cuentaBizarra :: (Number, Number) -> Number
cuentaBizarra (a, b)
  | a > b = a + b
  | b - 10 > a = b - a
  | otherwise = a * b 

--Ejercicio 4
--a
esNotaBochazo :: Number -> Bool
esNotaBochazo = (<6)
--b
aprobo :: (Number, Number) -> Bool
aprobo (a, b) = not (esNotaBochazo a) && not (esNotaBochazo b)
--c
promociono :: (Number, Number) -> Bool
promociono (a, b) = a >= 7 && b >= 7 && a + b >= 15
--d: (esNotaBochazo . fst) (5, 8)

--Ejercicio 5
--a
notasFinales :: ((Number, Number), (Number, Number)) -> (Number, Number)
notasFinales ((a, b), (c, d)) = (max a c, max b d)
--b: (aprobo . notasFinales) ((2,7), (6,-1))
--c: con snd definido en PdePreludat: (esNotaBochazo . snd . notasFinales) ((2,7), (6,-1))
--d
recuperoDeGusto :: ((Number, Number), (Number, Number)) -> Bool
recuperoDeGusto lista = promociono (fst lista) && (snd (snd lista) /= -1 || fst (snd lista) /= -1)

--Ejercicio 6
esMayorDeEdad :: (String, Number) -> Bool
esMayorDeEdad = (>21).snd

--Ejercicio 7
calcular :: (Number, Number) -> (Number, Number)
calcular = sumar.duplicar 
duplicar :: (Number, Number) -> (Number, Number)
duplicar (x, y) 
  | esPar x = (x * 2, y)
  | otherwise = (x, y)
sumar :: (Number, Number) -> (Number, Number)
sumar (x, y)
  | not $ esPar y = (x, y + 1)
  | otherwise = (x, y)
esPar :: Number -> Bool
esPar = (== 0) . (`mod` 2)