module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--APLICACIÓN PARCIAL
--Ejercicio 1
siguiente :: Number -> Number
siguiente numero = numero + 1

--Ejercicio 2
mitad :: Number -> Number
mitad numero = numero / 2

--Ejercicio 3
inversa :: Number -> Number
inversa numero = 1/numero

--Ejercicio 4
triple :: Number -> Number
triple numero = 3 * numero

--Ejercicio 5
esNumeroPositivo :: Number -> Bool
esNumeroPositivo numero = numero > 0

--COMPOSICIÓN
--Ejercicio 6
esMultiploDe :: Number -> Number -> Bool
esMultiploDe n = (==0).(`mod` n)

--Ejercicio 7
esBisiesto :: Number -> Bool
esBisiesto anio = (esMultiploDe 400 anio || esMultiploDe 4 anio) && not (esMultiploDe 100 anio)

--Ejercicio 8
inversaRaizCuadrada :: Number -> Number
inversaRaizCuadrada = (1/) . sqrt

--Ejercicio 9
incrementMCuadradoN :: Number -> Number -> Number
incrementMCuadradoN m = (+m).(^2) 

--Ejercicio 10
esResultadoPar :: Number -> Number -> Bool
esResultadoPar n = (==0).(`mod` 2).(^n)

