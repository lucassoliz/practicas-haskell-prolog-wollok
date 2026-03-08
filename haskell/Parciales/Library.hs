module Library where
import PdePreludat
import Data.List (isInfixOf)

doble :: Number -> Number
doble numero = numero + numero

---------------------------------------------------------------
--Recuperatorio 2023: Gnomos!!!
{-
data Material = Material {
    nombre:: String,
    calidad:: Number
} deriving (Show, Eq)

data Edificio = Edificio {
    tipoEdificio:: String,
    materiales:: [Material]
} deriving (Show, Eq)

data Aldea = Aldea{
    poblacion :: Number,
    materialesDisponibles :: [Material],
    edificios :: [Edificio]
} deriving (Show, Eq)

--Ejercicio 1
--a
esValioso :: Material -> Bool
esValioso material = calidad material > 20
--b
unidadesDisponibles :: String -> Aldea -> Number
unidadesDisponibles nombre_materia aldea = length . filter ((==nombre_materia) . nombre) $ materialesDisponibles aldea 
--c
valorTotal :: Aldea -> Number
valorTotal aldea = sum (map calidad (concatMap materiales (edificios aldea))) + sum (map calidad $ materialesDisponibles aldea)

--Ejercicio 2
type Tarea = Aldea -> Aldea
--a
tenerGnomito :: Tarea
tenerGnomito aldea = aldea {poblacion = poblacion aldea + 1}
--b
lustrarMaterial :: Material -> Material
lustrarMaterial material
  | nombre material == "Madera" = material {calidad = calidad material + 5} 
  | otherwise = material
lustrarMaderas :: Tarea
lustrarMaderas aldea = aldea {materialesDisponibles = map lustrarMaterial (materialesDisponibles aldea)}
--c
agregarMaterialARecolectar :: Material -> Number -> [Material]
agregarMaterialARecolectar material cantidad = replicate cantidad material
recolectar :: Material -> Number -> Tarea
recolectar material cantidad aldea = aldea {materialesDisponibles = materialesDisponibles aldea ++ agregarMaterialARecolectar material cantidad} 

--Ejercicio 3
--a: filter (\x -> esValioso materiales x) (edificios aldea)
--b: foldr1 (\a b -> filter (`elem` b) a) (map (map nombre . materiales) (edificios unaAldea))

--Ejercicio 4
--a
--realizarLasQueCumplan :: [Tarea] -> (Aldea -> Bool) -> Aldea -> Aldea
--realizarLasQueCumplan tareas condicion aldea = foldl funcion aldea tareas 
   -- where funcion aldeaActual tareas
    -- | condicion (tarea aldeaActual) = tarea aldeaActual
    -- | otherwise = aldeaActual
--b
--i
--realizarLasQueCumplan [tenerGnomito, tenerGnomito, tenerGnomito] length (filter (\x -> nombre x == "Comida") (materiales aldea) > poblacion aldea) aldea
--ii
--realizarLasQueCumplen [recolectar 30 ("Madera de pino", maximum (unidadesDisponibles "Madera" aldea)), lustrarMaderas] (all esValioso (materialesDisponibles aldea)) aldea


-------------------------------------------------------
--Recuperatorio 2021: Puños de puria.

--Ejercicio 1
type Ataque = Peleador -> Peleador
--a
data Peleador = Peleador{
    puntosVida :: Number,
    resistencia :: Number,
    conjuntoAtaques :: [Ataque]
} deriving (Show)
--b
--i
estaMuerto :: Peleador -> Bool
estaMuerto = (<1).puntosVida
--ii
--esHabil :: Peleador -> Bool
--esHabil = (>10) . length . conjuntoAtaques
--c
--i
golpe :: Number -> Ataque
golpe intensidadGolpe peleador = peleador{ 
    puntosVida = puntosVida peleador - div intensidadGolpe (resistencia peleador)
}
--ii
toqueMuerte :: Ataque
toqueMuerte peleador = peleador{puntosVida = 0}
--iii
patada :: String -> Ataque
patada tipoPatada peleador
  | tipoPatada == "pecho" && not (estaMuerto peleador) = peleador {puntosVida = puntosVida peleador - 10}
  | tipoPatada == "pecho" && (estaMuerto peleador) = peleador {puntosVida = puntosVida peleador + 1}
  | tipoPatada == "carita" = peleador {puntosVida = div (puntosVida peleador) 2}
  | tipoPatada == "nuca" = peleador {conjuntoAtaques = drop 1 (conjuntoAtaques peleador)}
  | otherwise = peleador
--a
bruceLee :: Peleador 
bruceLee = Peleador{
    puntosVida = 200,
    resistencia = 25,
    conjuntoAtaques = [toqueMuerte, golpe 500, (patada "carita").(patada "carita").(patada "carita")]
}

--Ejercicio 2
mejorAtaque :: Peleador -> Peleador -> Ataque
mejorAtaque enemigo peleador = foldl1 (busquedaMejorAtaque enemigo) $ conjuntoAtaques peleador
busquedaMejorAtaque :: Peleador -> Ataque -> Ataque -> Ataque
busquedaMejorAtaque enemigo ataque1 ataque2
  | puntosVida (ataque1 enemigo) < puntosVida (ataque2 enemigo) = ataque1
  | otherwise = ataque2

--Ejercicio 3
--a
terrible :: [Peleador] -> Ataque -> Bool 
terrible enemigos ataque = length (filter (\x -> estaMuerto x) (map ataque enemigos)) > div (length enemigos) 2
--b
--peligroso :: Peleador -> [Peleador] -> Bool
--peligroso peleador enemigos = all (terrible (filter esHabil enemigos)) (conjuntoAtaques peleador)
--c
invencible :: Peleador -> [Peleador] -> Bool
invencible peleador enemigos = puntosVida (foldl1 ataque enemigos) == puntosVida peleador
    where ataque = (\x -> (mejorAtaque x) peleador)
-}
-------------------------------------------------------
--Recuperatorio agosto 2024: Harry Potter y el examen de funcional.
{-
--Ejercicio1
type Hechizo = Mago -> Mago
data Mago = Mago{
    nombre :: String,
    edad :: Number,
    salud :: Number,
    hechizos :: [Hechizo]
} deriving (Show)
--a
curar :: Number -> Hechizo
curar saludRecuperada mago = mago{salud = ((+saludRecuperada).salud) mago}
--b
lanzarRayo :: Hechizo
lanzarRayo mago
  | ((>10).salud) mago = mago{salud = salud mago - 10}
  | otherwise = mago{salud = div (salud mago) 2}
--c
amnesia :: Number -> Hechizo
amnesia n mago = mago{hechizos = drop n (hechizos mago)}
--d
confundir :: Hechizo
confundir mago = (head (hechizos mago)) mago

--Ejercicio 2
--a
poder :: Mago -> Number
poder mago = salud mago + (edad mago * (length $ hechizos mago))
--b
danio :: Mago -> Hechizo -> Number
danio mago hechizo = salud mago - (salud $ hechizo mago)
--c
diferenciaDePoder :: Mago -> Mago -> Number
diferenciaDePoder mago1 mago2 = abs $ poder mago1 - poder mago2

--Ejercicio 3
data Academia = Academia { 
magos :: [Mago], 
examenDeIngreso :: Mago -> Bool 
}
--a
existeMagoSinHechizoLlamado :: String -> Academia -> Bool
existeMagoSinHechizoLlamado nombreBusqueda academia = any (\x -> nombre x == nombreBusqueda && null (hechizos x)) $ magos academia
--b
sonNono :: Academia -> Number -> Bool
sonNono academia edadBuscada = all (\x -> salud x < length (hechizos x)) $ filter (\x -> (edad x) > edadBuscada) $ magos academia
--c
cuantosPasan :: Academia -> Number
cuantosPasan academia = length . filter (not . examenDeIngreso academia) $ magos academia
--d
sumatoriaEdad :: Academia -> Number
sumatoriaEdad academia = sum $ map edad $ filter (\x -> length (hechizos x) > 10) $ magos academia

--Ejercicio 4
maximoSegun criterio valor comparables = foldl1 (mayorSegun $ criterio valor) comparables 
mayorSegun evaluador comparable1 comparable2 
  | evaluador comparable1 >= evaluador comparable2 = comparable1 
  | otherwise = comparable2
--i
mejorHechizoContra :: Mago -> Mago -> Hechizo
mejorHechizoContra mago1 mago2 = maximoSegun danio mago1 (hechizos mago2)
--ii
--mejorOponente :: Mago -> Academia -> Mago
--mejorOponente mago academia = mayorSegun diferenciaDePoder mago (magos academia)

--Ejercicio 5
noPuedeGanarle :: Mago -> Mago -> Bool
noPuedeGanarle mago1 mago2 = salud (foldl (\x y -> y x) mago1 (hechizos mago2)) == salud mago1
-}

-----------------------------------------------------
--Recuperatorio diciembre 2024: Aventureros.
{-
--Ejercicio 1
data Aventurero = Aventurero{
    nombre :: String,
    carga :: Number,
    salud :: Number,
    coraje :: Bool,
    criterioSeleccion :: CriterioSeleccion
} deriving (Show)

type CriterioSeleccion = Aventurero -> Bool
conformista :: CriterioSeleccion
conformista _ = True 
valiente :: CriterioSeleccion
valiente aventurero = coraje aventurero || salud aventurero > 50
lightPacker :: Number -> CriterioSeleccion
lightPacker valor aventurero = carga aventurero < valor

--Ejercicio 2
--a
masDeCincoLetras :: [Aventurero] -> Bool
masDeCincoLetras = any ((>5) . length . nombre)
--b
cargaTotalPar :: [Aventurero] -> Number
cargaTotalPar = sum . map carga . filter (even . carga)

--Ejercicio 3
type Personaje = Aventurero -> Aventurero
descargarSouvenir :: Aventurero -> Aventurero
descargarSouvenir aventurero = aventurero { carga = carga aventurero - 1 }
curandero :: Personaje
curandero = descargarSouvenir . (\aventurero -> aventurero{
    carga = div (carga aventurero) 2,
    salud = salud aventurero + (salud aventurero * 0.2)
})
inspirador :: Personaje
inspirador = descargarSouvenir . (\aventurero -> aventurero{
    coraje = True,
    salud = salud aventurero + (salud aventurero * 0.1)
})
embaucador :: Personaje
embaucador = descargarSouvenir . (\aventurero -> aventurero{
    coraje = False,
    carga = (carga aventurero) + 10,
    salud = div (salud aventurero) 2,
    criterioSeleccion = lightPacker 10
})

--Ejercicio 4
enfrentaA :: Aventurero -> [Personaje] -> [Personaje]
enfrentaA aventurero (e:es)
  | criterioSeleccion aventurero aventureroPost =
      e : enfrentaA aventureroPost es
  | otherwise = []
  where
    aventureroPost = e aventurero
-}

-----------------------------------------------------
-- Recuperatorio febrero 2024: Hamburguejas al vapor.
{-
type Ingrediente = String 
data Hamburguesa = Hamburguesa {nombreHamburguesa :: String, ingredientes :: [Ingrediente]} 
data Bebida = Bebida {nombreBebida :: String, tamanioBebida :: Number, light :: Bool} 
type Acompaniamiento = String 
type Combo = (Hamburguesa, Bebida, Acompaniamiento) 

hamburguesa (h,_,_) = h 
bebida (_,b,_) = b 
acompaniamiento (_,_,a) = a 

informacionNutricional = [("Carne", 250), ("Queso", 50), ("Pan", 20), ("Panceta", 541), ("Lechuga", 5), ("Tomate", 6)] 

condimentos = ["Barbacoa","Mostaza","Mayonesa","Salsa big mac","Ketchup"] 

comboQyB = (qyb, cocaCola, "Papas") 
cocaCola = Bebida "Coca Cola" 2 False 
qyb = Hamburguesa "QyB" ["Pan", "Carne", "Queso", "Panceta", "Mayonesa", "Ketchup", "Pan"]

--Ejercicio 1
calorias :: Ingrediente -> Number
calorias ingrediente
  | elem ingrediente condimentos = 10
  | otherwise = snd . head . filter ((== ingrediente) . fst) $ informacionNutricional

--Ejercicio 2
esMortal :: Combo -> Bool
esMortal combo = noEsDietetica (bebida combo) && noAcompaniamiento (acompaniamiento combo) || esBomba (hamburguesa combo)
noEsDietetica :: Bebida -> Bool
noEsDietetica = not . light
noAcompaniamiento :: Acompaniamiento -> Bool
noAcompaniamiento = (/= "ensalada")
esBomba :: Hamburguesa -> Bool
esBomba h = any (\x -> calorias x > 300) (ingredientes h) || sum(map (\x -> calorias x) (ingredientes h)) > 1000

--Ejercicio 3
--a
agrandarBebida :: Combo -> Combo
agrandarBebida (h, b, a) =(h, b{tamanioBebida = tamanioBebida b + 1}, a) 
--b
cambiarAcompaniamientoPor :: Combo -> Acompaniamiento -> Combo
cambiarAcompaniamientoPor (h, b, _) a = (h, b, a)
--c
type Condicion = Ingrediente -> Bool
peroSin :: Condicion -> Combo -> Combo
peroSin condicion (h, b, a) = (h{ingredientes = filter (not . condicion) (ingredientes h)}, b, a)
--i
esCondimento :: Condicion
esCondimento ingrediente = any (\x -> x == ingrediente) condimentos
--ii
masCaloricoQue :: Number -> Condicion
masCaloricoQue valor = (>valor) . calorias

{-
--Ejercicio 4
-- foldl (\combo f -> f combo) comboQyB [agrandarBebida, cambiarAcompaniamientoPor "ensalada", peroSin esCondimento, peroSin (masCaloricoQue 400), peroSin ("==queso")]
-}
-}

--------------------------------------------------------
--Recuperatorio febrero 2025: Haskell Holidays!
{-
data Persona = Persona{
    nivelStress :: Number,
    nombre :: String,
    preferencias :: [String],
    cantidadAmigues :: Number
}deriving (Show)

type Contingente = [Persona]

--Ejercicio 1
totalStressGlotones :: Contingente -> Number
totalStressGlotones = sum . map nivelStress . filter (elem "gastronomia" . preferencias)
contingenteRaro :: Contingente -> Bool
contingenteRaro = all $ even . cantidadAmigues

--Ejercicio 2
type PlanTuristico = Persona -> Persona
reducirStress :: PlanTuristico
reducirStress persona = persona{nivelStress = div (nivelStress persona) 2}
villaGesell :: Number -> PlanTuristico
villaGesell mes persona
  | mes == 1 || mes == 2 = persona{nivelStress = nivelStress persona + 10}
  | mes >= 3 && mes < 13 = reducirStress persona
  | otherwise = persona
lasToninas :: Bool -> PlanTuristico
lasToninas plata persona 
  | plata = reducirStress persona
  | otherwise = persona{nivelStress = nivelStress persona + (cantidadAmigues persona * 10)}
puertoMadryn :: PlanTuristico
puertoMadryn persona = persona{cantidadAmigues = cantidadAmigues persona + 1}
laAdela :: PlanTuristico
laAdela persona = persona
--a
planPiola :: [PlanTuristico] -> Persona -> Bool
planPiola planes persona = any (\x -> esPiola x persona) planes
esPiola :: PlanTuristico -> Persona -> Bool
esPiola plan persona = (< nivelStress persona) . nivelStress $ plan persona
--b planPiola [villaGesell 1, lasToninas True, puertoMadryn, laAdela] Persona{10 juana ["mar"] 10}
--c planPiola [laAdela, puertoMadryn, lasToninas False] Persona{10 juana ["mar"] 10}
-}

------------------------------------------------
-- Parcial 2025: Músicos
{-
data Musico = Musico{
    nombre :: String,
    experiencia :: Number,
    instrumentoFavorito :: String,
    historial :: [Actuacion]
} deriving (Show)

data Actuacion = Actuacion{
    fecha :: (Number, Number, Number),
    publico :: Number
} deriving (Show)

--Ejercicio 1
--a
actuacionesConMasDe5000 :: Musico -> Bool
actuacionesConMasDe5000 = any ((>5000) . publico) . historial
--b
actuacionesEn :: Number -> Musico -> Number
actuacionesEn anio = length . filter ((== anio) . anioABuscar . fecha) . historial
anioABuscar :: (a, a, a) -> a
anioABuscar (_, _, anioBuscado) = anioBuscado

--Ejercicio 2

type Actividad = Musico -> Musico
instrumentosSumadores :: [String]
instrumentosSumadores = ["oboe", "fagot", "cello"]
sumarExperiencia :: String -> Musico -> Number
sumarExperiencia instrumento musico 
  | any (==instrumento) instrumentosSumadores = experiencia musico + verificarExperiencia musico
  | otherwise = experiencia musico
verificarExperiencia :: Musico -> Number
verificarExperiencia musico
  | experiencia musico < 10 = 1
  | otherwise = 0

tocarInstrumento :: String -> Actividad
tocarInstrumento instrumento musico = musico{instrumentoFavorito = instrumento, experiencia = sumarExperiencia instrumento musico}

cantar :: Actividad
cantar musico = musico{instrumentoFavorito = instrumentoFavorito musico ++ "Lalala"}

presentar :: Actuacion -> Actividad
presentar actuacion musico = musico{historial = historial musico ++ [actuacion], experiencia = sumarExperiencia (instrumentoFavorito musico) musico + verificarExperiencia musico}

pensar :: Actividad
pensar = id

-- foldl flip($) (musico "juan" 5 "piano" []) [tocarInstrumento "fagot", cantar, presentar ((2, 8, 2025) 300), pensar]

--Ejercicio 3
experienciaGanada :: [Actividad] -> Musico -> Number
experienciaGanada actividades musico = experiencia (foldl (flip($)) musico actividades) - experiencia musico

--Ejercicio 4
presentacionesCorrectas :: Musico -> Bool
presentacionesCorrectas = verificar 1 . map publico . historial

verificar :: Number -> [Number] -> Bool
verificar _ [] = True
verificar n (x:xs)
  | odd n &&  odd x =  verificar (n+1) xs
  | even n && even x = verificar (n+1) xs
  | otherwise = False
-}

-----------------------------------------------------
--Parcial 2023: Alfajores
{-
--Ejercicio 1
data Alfajor = Alfajor{
  capas :: [String],
  peso :: Number,
  dulzor :: Number,
  nombre :: String
} deriving (Show)
--a
--i
jorgito :: Alfajor
jorgito = Alfajor{
  capas = ["dulceLeche"],
  peso = 80,
  dulzor = 8,
  nombre = "Jorgito"
}
--ii
havanna :: Alfajor
havanna = Alfajor{
  capas = ["mousse", "mousse"],
  peso = 60,
  dulzor = 12,
  nombre = "Havanna"
}
--iii
capitanEspacio :: Alfajor
capitanEspacio = Alfajor{
  capas = ["dulceLeche"],
  peso = 40,
  dulzor = 12,
  nombre = "Capitán del Espacio"
}
--b
--i
coeficienteDulzor :: Alfajor -> Number
coeficienteDulzor alfajor = peso alfajor / dulzor alfajor
--ii
precioAlfajor :: Alfajor -> Number
precioAlfajor alfajor = (peso alfajor * 2) + sum (map precioRelleno (capas alfajor)) 
precioRelleno :: String -> Number
precioRelleno relleno 
  | relleno == "dulceLeche" = 12
  | relleno == "mousse" = 15
  | relleno == "fruta" = 10
  | otherwise = 0
--iii 
esPotable :: Alfajor -> Bool
esPotable alfajor = length (capas alfajor) >= 1 && all (== head (capas alfajor)) (capas alfajor) && coeficienteDulzor alfajor >= 0.1  

--Ejercicio 2
--a
abaratar :: Alfajor -> Alfajor
abaratar alfajor = alfajor{peso = peso alfajor - 10, dulzor = dulzor alfajor - 7}
--b
renombrar :: String -> Alfajor -> Alfajor
renombrar nombreNuevo alfajor = alfajor{nombre = nombreNuevo}
--c
agregarRelleno :: String -> Alfajor -> Alfajor
agregarRelleno rellenoNuevo alfajor = alfajor{capas= rellenoNuevo : capas alfajor}
--d
hacerPremium :: Alfajor -> Alfajor
hacerPremium alfajor
  | esPotable alfajor = agregarRelleno (head (capas alfajor)) $ renombrar (nombre alfajor ++ " premium") alfajor
  | otherwise = alfajor
--e
hacerGradoPremium :: Number -> Alfajor -> Alfajor
hacerGradoPremium n alfajor = foldl (flip($)) alfajor (replicate n hacerPremium)
--f
--i
jorgitito :: Alfajor
jorgitito = (abaratar . (renombrar "Jorgitito")) jorgito
--ii
jorgelin :: Alfajor
jorgelin = ((agregarRelleno "dulceLeche") . (renombrar "Jorgelín")) jorgito
--iii
capitanEspacioCostaACosta :: Alfajor
capitanEspacioCostaACosta = (abaratar . (hacerGradoPremium 4) . (renombrar "Capitán del Espacio de Costa a Costa")) capitanEspacio

--Ejercicio 3
type Criterio = Alfajor -> Bool 
data Cliente = Cliente{
  nombreCliente :: String,
  dinero :: Number,
  alfajores :: [Alfajor],
  criterios :: [Criterio]
} deriving (Show)
leGusta :: Cliente -> Criterio
leGusta cliente alfajor = all (\x -> x alfajor) (criterios cliente)
--a
contiene :: String -> Criterio
contiene nombreContenido alfajor = nombreContenido `isInfixOf` (nombre alfajor)
esPretencioso :: Criterio
esPretencioso = contiene "premium"
esDulcero :: Criterio
esDulcero = (>0.15) . dulzor
anti :: String -> Criterio
anti relleno alfajor = not $ any (==relleno) (capas alfajor)
extranio :: Criterio
extranio = not . esPotable
--i
emi :: Cliente
emi = Cliente {
  nombreCliente = "Emi",
  dinero = 120,
  alfajores = [],
  criterios = [contiene "Capitán del Espacio"]
}
--ii
tomi :: Cliente
tomi = Cliente{
  nombreCliente = "Tomi",
  dinero = 100,
  alfajores = [],
  criterios = [esPretencioso, esDulcero]
}
--iii
dante :: Cliente
dante = Cliente{
  nombreCliente = "Dante",
  dinero = 200,
  alfajores = [],
  criterios = [anti "dulceLeche", extranio]
}
--iv
juan :: Cliente
juan = Cliente{
  nombreCliente = "Juan",
  dinero = 500,
  alfajores = [],
  criterios = [esDulcero, contiene "Jorgito", esPretencioso, anti "mousse"]
}
--b
cualesLeGustan :: Cliente -> [Alfajor] -> [Alfajor]
cualesLeGustan cliente alfajores = filter (\alfajor -> all (\criterio -> criterio alfajor) (criterios cliente)) alfajores
--c
comprar :: Alfajor -> Cliente -> Cliente
comprar alfajor cliente
  | (dinero cliente) > (precioAlfajor alfajor) = cliente{dinero = dinero cliente - precioAlfajor alfajor, alfajores = alfajor : alfajores cliente}
  | otherwise = cliente
--d
comprarGusto :: Cliente -> [Alfajor] -> Cliente
comprarGusto cliente alfajores = foldl (flip comprar) cliente (cualesLeGustan cliente alfajores)
-}

------------------------------------------------------
--Parcial 2023: Amazin'
{-
--Ejercicio A
--1
data Usuarie = Usuarie{
  nick :: String,
  indiceFelicidad :: Number,
  librosAdquiridos :: [Libro],
  librosLeidos :: [Libro]
} deriving (Show)
--2
data Libro = Libro{
  titulo :: String,
  autor :: String,
  paginas :: Number,
  afecto :: Afecto
} deriving (Show)
type Afecto = Usuarie -> Usuarie
--3
ana :: Usuarie
ana = Usuarie{
  nick = "anacc4",
  indiceFelicidad = 8,
  librosAdquiridos = [],
  librosLeidos = [harryPotter1]
}
--4
harryPotter1 :: Libro
harryPotter1 = Libro{
  titulo = "Harry Potter y la Piedra Filosofal",
  autor = "J.K. Rowling",
  paginas = 200,
  afecto = fantasia
}
fantasia :: Afecto
fantasia = id

--Ejercicio B
comediaDramatica :: Afecto
comediaDramatica = id
comediaAbsurda :: Afecto
comediaAbsurda usuarie = usuarie{indiceFelicidad = indiceFelicidad usuarie + 5}
comediaSatirica :: Afecto
comediaSatirica usuarie = usuarie{indiceFelicidad = indiceFelicidad usuarie * 2}
comedia :: Afecto
comedia usuarie = usuarie{indiceFelicidad = indiceFelicidad usuarie + 10}
cienciaFiccion :: Afecto
cienciaFiccion usuarie = usuarie{nick = reverse $ nick usuarie}
terror :: Afecto
terror usuarie = usuarie{librosLeidos = []}

--Ejercicio C
lectura :: Libro -> Afecto
lectura libro usuarie = usuarie{librosLeidos = libro : librosLeidos usuarie}
ponerseAlDia :: Afecto
ponerseAlDia usuarie = foldl (flip lectura) usuarie (filter (not . leyo usuarie) (librosAdquiridos usuarie))
leyo :: Usuarie -> Libro -> Bool
leyo usuarie libro = any ((== titulo libro) . titulo) (librosLeidos usuarie)
esFanatico :: Usuarie -> String -> Bool
esFanatico usuarie autorFan = all (\x -> autor x == autorFan) (librosLeidos usuarie)
--Si son libros infinitos, jamás se puede poner al día

--Ejercicio D
type TipoLibro = Libro -> Bool
cuento :: TipoLibro
cuento = (<100) . paginas
novelaCorta :: TipoLibro
novelaCorta libro = paginas libro < 100 && paginas libro > 200
novela :: TipoLibro
novela = (>200) . paginas
librosDe :: TipoLibro -> Usuarie -> [String]
librosDe tipo usuarie = map titulo $ filter tipo (librosAdquiridos usuarie)
-}

--------------------------------------------------------------------------------
--Recuperatorio: La Granja

data Animal = Animal{
  nombre :: String,
  tipo :: String,
  peso :: Number, 
  edad :: Number,
  enfermo :: Bool,
  visitasMedicas :: [VisitaMedica]
} deriving (Show)

data VisitaMedica = VisitaMedica{
  diasRecuperacion :: Number,
  costo :: Number
} deriving (Show)

--Ejercicio 1
laPasoMal :: Animal -> Bool
laPasoMal animal = any ((>30) . diasRecuperacion) (visitasMedicas animal)
nombreFalopa :: Animal -> Bool
nombreFalopa = (=='i') . (last . nombre)

--Ejercicio 2
type Actividad = Animal -> Animal
engorde :: Number -> Actividad
engorde kilos animal
  | (div kilos 2) < 5 = animal{peso = peso animal + (div kilos 2)}
  | otherwise = animal{peso = peso animal + 5}
revisacion :: VisitaMedica -> Actividad
revisacion visita animal
  | enfermo animal = ((realizarVisita visita) . (engorde 2)) animal
  | otherwise = animal
realizarVisita :: VisitaMedica -> Actividad
realizarVisita visita animal = animal{visitasMedicas = visita : visitasMedicas animal}
festejoCumple :: Actividad
festejoCumple animal = animal{edad = edad animal + 1, peso = peso animal - 1}
chequeoPeso :: Number -> Actividad
chequeoPeso x animal
  | peso animal > x = animal{enfermo = True}
  | otherwise = animal

--Ejercicio 3
proceso :: [Actividad] -> Actividad
proceso actividades animal = foldl (flip($)) animal actividades
--Ejemplo: proceso [engorde 4, festejoCumple] ("Mu" "Vaca" 160 17 False [])
--Queda ("Mu" "Vaca" 161 18 False [])

--Ejercicio 4
mejora :: [Actividad] -> Animal -> Bool
mejora [] animal = True
mejora (x : xs) animal 
  | pesoEstable x animal = mejora xs animal
  | otherwise = False
pesoEstable :: Actividad -> Animal -> Bool
pesoEstable actividad animal = peso (actividad animal) >= peso animal || peso (actividad animal) <= peso animal + 3

--Ejercicio 5
--a
tresNombreFalopa :: [Animal] -> [Animal]
tresNombreFalopa animales = take 3 $ filter nombreFalopa animales
--b
-- Si se puede ya que con lazy evaluation, corta al tomar los primeros 3