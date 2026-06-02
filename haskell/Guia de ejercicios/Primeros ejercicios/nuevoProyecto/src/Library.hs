module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--Ejercicio 1
esMultiploDeTres :: Number -> Bool
esMultiploDeTres numero = (mod numero 3 == 0) 

--Ejercicio 2
esMultiploDe :: Number -> Number -> Bool
esMultiploDe n1 n2 = (mod n1 n2 == 0) 

--Ejercicio 3
cubo :: Number -> Number
cubo numero = numero ^ 3

--Ejercicio 4
area :: Number -> Number -> Number
area altura base = altura * base

--Ejercicio 5
esBisiesto :: Number -> Bool
esBisiesto anio = (esMultiploDe anio 400 || esMultiploDe anio 4) && esMultiploDe anio 100 == False

--Ejercicio 6
celsiusToFahr :: Number -> Number
celsiusToFahr numero = numero * 9/5 + 32

--Ejercicio 7
fahrToCelsius :: Number -> Number
fahrToCelsius numero = (numero - 32) * 5/9

--Ejercicio 8
haceFrioF :: Number -> Bool
haceFrioF temperatura = fahrToCelsius temperatura < 8 

--Ejercicio 9
mcm :: Number -> Number -> Number
mcm n1 n2 = n1 * n2 / gcd n1 n2

--Ejercicio 10
--a
dispersion :: Number -> Number -> Number -> Number
dispersion n1 n2 n3 = max n1 (max n2 n3) - min n1(min n2 n3)
--b
diasParejos :: Number -> Number -> Number -> Bool
diasParejos n1 n2 n3 = (dispersion n1 n2 n3) < 30
diasLocos :: Number -> Number -> Number -> Bool
diasLocos n1 n2 n3 = (dispersion n1 n2 n3) > 100
diasNormales :: Number -> Number -> Number -> Bool
diasNormales n1 n2 n3 = not (diasParejos n1 n2 n3) && not (diasLocos n1 n2 n3) 

--Ejercicio 11
pesoPino :: Number -> Number
pesoPino altura 
  | altura <= 3 = altura * 300
  | otherwise = 900 + 200*(altura - 3)
esPesoUtil :: Number -> Bool
esPesoUtil peso = peso >= 400 && peso <= 1000
sirvePino :: Number -> Bool
sirvePino = esPesoUtil.pesoPino

--Ejercicio 12
esCuadradoPerfecto :: Number -> Number -> Number -> Bool
esCuadradoPerfecto numero esperado acumulador
  | numero == esperado = True
  | numero < esperado = False
  | otherwise = esCuadradoPerfecto numero (esperado + acumulador) (acumulador + 2)
confirmarCuadradoPerfecto :: Number -> Bool
confirmarCuadradoPerfecto numero = esCuadradoPerfecto numero 0 1