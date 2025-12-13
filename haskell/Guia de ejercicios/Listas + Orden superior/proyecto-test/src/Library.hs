module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--Listas

--Ejercicio 1
suma :: [Number] -> Number
suma = sum 

--Ejercicio 2
--a
promedioFrecuenciaCardiaca :: [Number] -> Number
promedioFrecuenciaCardiaca lista = sum lista / length lista
--b
frecuenciaCardiacaMinuto :: Number -> [Number] -> Number
frecuenciaCardiacaMinuto m lista 
  | m == 0 || m == 10 || m == 20 || m == 30 || m == 40 || m == 50 || m == 60 = lista !! (m `div` 10)
  | otherwise = 0
--c
frecuenciasHastaMomento :: Number -> [Number] -> [Number]
frecuenciasHastaMomento m lista = take (m `div` 10 + 1) lista

--Ejercicio 3
esCapicua :: [String] -> Bool
esCapicua lista = listaConcatenada == reverse listaConcatenada 
  where listaConcatenada = concat lista

--Ejercicio 4
--a
duracionLlamadas = (("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10]))
cuandoHabloMasMinutos :: ((String, [Number]), (String, [Number])) -> String
cuandoHabloMasMinutos (x, y)
  | cantidad x > cantidad y = fst x
  | otherwise = fst y
  where cantidad = sum . snd
cuandoHizoMasLlamadas :: ((String, [Number]), (String, [Number])) -> String
cuandoHizoMasLlamadas (x, y) 
  | cantidad x > cantidad y = fst x
  | otherwise = fst y
  where cantidad = length . snd

------------------------------------
--Orden Superior

--Ejercicio 1
existsAny :: (Number -> Bool) -> (Number, Number, Number) -> Bool
existsAny funcion (n1, n2, n3) = any funcion [n1, n2, n3]

--Ejercicio 2
cuadrado :: Number -> Number
cuadrado numero = numero * numero
triple :: Number -> Number
triple numero = numero * 3
mejor :: (Number -> Number) -> (Number -> Number) -> Number -> Number
mejor funcion1 funcion2 numero = max (funcion1 numero) (funcion2 numero)

--Ejercicio 3
deListaATupla :: [a] -> (a, a)
deListaATupla [n1, n2] = (n1, n2) 
aplicarPar :: (a -> b) -> (a, a) -> (b, b)
aplicarPar funcion (n1, n2) = deListaATupla lista
  where lista = map funcion [n1, n2]

--Ejercicio 4
parDeFns :: (a -> b) -> (a -> c) -> a -> (b, c)
parDeFns funcion1 funcion2 valor = (funcion1 valor, funcion2 valor)

---------------------------------------------
--Orden Superior + Listas

--Ejercicio 1
esMultiploDeAlguno :: Number -> [Number] -> Bool
esMultiploDeAlguno numero lista = any (\x -> numero `mod` x == 0) lista

--Ejercicio 2
promedios :: [[Number]] -> [Number]
promedios = map (\x -> sum x / length x) 

--Ejercicio 3
promediosSinAplazos :: [[Number]] -> [Number]
promediosSinAplazos = map (\x -> sum (filter (>4) x) / length (filter (>4) x))

--Ejercicio 4
mejoresNotas :: [[Number]] -> [Number]
mejoresNotas = map (\x -> maximum x)

--Ejercicio 5
aprobo :: [Number] -> Bool
aprobo = (>=6).minimum 

--Ejercicio 6
aprobaron :: [[Number]] -> [[Number]]
aprobaron = filter aprobo 

--Ejercicio 7
divisores :: Number -> [Number]
divisores numero = filter (\x -> numero `mod` x == 0) [1..numero] 

--Ejercicio 8
exists :: (Number -> Bool) -> [Number] -> Bool
exists = any  

--Ejercicio 9
hayAlgunNegativo :: [Number] -> a -> Bool
hayAlgunNegativo lista algo = any (<0) lista

--Ejercicio 10
aplicarFunciones :: [a -> b] -> a -> [b]
aplicarFunciones lista valor = map (\x -> x valor) lista
-- aplicarFunciones[(*4),even,abs] 8 da error porque es a -> a, no a -> b

--Ejercicio 11
sumaF :: [a -> Number] -> a -> Number
sumaF lista valor = sum (aplicarFunciones lista valor)

--Ejercicio 12
subirHabilidad :: Number -> [Number] -> [Number]
subirHabilidad habilidad equipo = map (\x -> min 12 (x + habilidad)) equipo

--Ejercicio 13
flimitada :: (Number -> Number) -> Number -> Number
flimitada funcion habilidad = min 12 $ max 0 (funcion habilidad)
--a
cambiarHabilidad :: (Number -> Number) -> [Number] -> [Number]
cambiarHabilidad funcion habilidades = map (\x -> flimitada funcion x) habilidades 
--b: cambiarHabilidad (max 4) [2,4,5,3,8] 

--Ejercicio 14: takeWhile :: (a -> Bool) -> [a] -> [a]
--takeWhile recorre los elementos de una lista y revisa
--que se cumpla cierta condición. Si no cumple, se corta
--y devuelve una lista de lo que se verificó.

--Ejercicio 15
primerosPares :: [Number] -> [Number]
primerosPares = takeWhile (\x -> x `mod` 2 == 0) 
primerosDivisores :: Number -> [Number] -> [Number]
primerosDivisores numero lista = takeWhile (\x -> numero `mod` x == 0) lista
primerosNoDivisores :: Number -> [Number] -> [Number]
primerosNoDivisores numero lista = takeWhile (\x -> numero `mod` x /= 0) lista

--Ejercicio 16
huboMesMejorDe :: [Number] -> [Number] -> Number -> Bool
huboMesMejorDe ingresos egresos numero = any (>numero) $ zipWith (-) ingresos egresos

--Ejercicio 17
--a
crecimientoAnual :: Number -> Number
crecimientoAnual edad
  | edad >= 1 && edad < 10 = 24 - (edad * 2)
  | edad >= 10 && edad <= 15 = 4
  | edad == 16 || edad == 17 = 2
  | edad == 18 || edad == 19 = 1
  | otherwise = 0
--b
crecimientoEntreEdades :: Number -> Number -> Number
crecimientoEntreEdades edad1 edad2 = sum $ map crecimientoAnual [edad1..edad2 - 1]
--c
alturasEnUnAnio :: Number -> [Number] -> [Number] 
alturasEnUnAnio edad = map (+ (crecimientoAnual edad))
--d
alturaEnEdades :: Number -> Number -> [Number] -> [Number]
alturaEnEdades altura edad = map (\x -> altura + crecimientoEntreEdades edad x)

--Ejercicio 18
rachasLluvia :: [Number] -> [[Number]]
rachasLluvia = filter (not . null) . foldr f [[]] 
  where
    f 0 parteLista = [] : parteLista
    f lluviaActual (xs : xss) = (lluviaActual : xs) : xss
mayorRachaDeLluvias :: [Number] -> Number
mayorRachaDeLluvias lista = maximum $ map length $ rachasLluvia lista

--Ejercicio 19
sumaLista :: [Number] -> Number
sumaLista = foldr (+) 0 

--Ejercicio 20
productoLista :: [Number] -> Number
productoLista = foldl (*) 1 

--Ejercicio 21
dispersion :: [Number] -> Number
dispersion lista = foldr (-) 0 [maximum lista, minimum lista]