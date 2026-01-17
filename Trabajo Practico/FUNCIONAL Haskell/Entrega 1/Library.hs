module Library where

import PdePreludat

data Auto = Auto
  { marca :: String,
    modelo :: String,
    desgasteChasis :: Number,
    desgasteRuedas :: Number,
    velocidadMaxima :: Number,
    tiempoCarrera :: Number,
    apodos :: [String]
  }
  deriving (Show, Eq)

ferrari :: Auto
ferrari =
  Auto
    { marca = "Ferrari",
      modelo = "F50",
      desgasteChasis = 0,
      desgasteRuedas = 0,
      velocidadMaxima = 65,
      tiempoCarrera = 0,
      apodos = ["La nave", "El fierro", "Ferrucho"]
    }

lamborghini :: Auto
lamborghini =
  Auto
    { marca = "Lamborghini",
      modelo = "Diablo",
      desgasteChasis = 7,
      desgasteRuedas = 4,
      velocidadMaxima = 73,
      tiempoCarrera = 0,
      apodos = ["Lambo", "La bestia"]
    }

fiat :: Auto
fiat =
  Auto
    { marca = "Fiat",
      modelo = "600",
      desgasteChasis = 33,
      desgasteRuedas = 27,
      velocidadMaxima = 44,
      tiempoCarrera = 0,
      apodos = ["La bocha", "La bolita", "Fitito"]
    }

peugeot :: Auto
peugeot =
  Auto
    { marca = "Peugeot",
      modelo = "504",
      desgasteChasis = 0,
      desgasteRuedas = 0,
      velocidadMaxima = 40,
      tiempoCarrera = 0,
      apodos = ["El rey del desierto"]
    }

-- [2.A TODOS LOS INTEGRANTES]------|| SABER SI UN AUTO ESTA EN BUEN ESTADO ||--------------------------
autoEnBuenEstado :: Auto -> Bool
autoEnBuenEstado auto
  | (== "Peugeot") (marca auto) = False -- Peugeot no puede estar en buen estado
  | (< 100) (tiempoCarrera auto) = (< 20) (desgasteChasis auto) -- tiempoCarrera < 100 y desgasteChasis < 20
  | otherwise = (&&) ((< 40) (desgasteChasis auto)) ((< 60) (desgasteRuedas auto)) -- desgasteChasis < 40 y desgasteRuedas < 60

-- [2.B INTEGRANTE 1 ]------|| SABER SI UN AUTO NO DA MAS ||------------------------------------
autoDaParaMas :: Auto -> Bool
autoDaParaMas auto
  | ((== "La ") . take 3 . head . apodos) auto = ((<80) . desgasteChasis) auto -- comienzaConLa y desgasteChasis < 80
  | otherwise = ((<80) . desgasteRuedas) auto -- desgasteRuedas < 80

-- [2.C INTEGRANTE 2 ]------|| SABER SI UN AUTO ES CHICHE ||------------------------------------
esChiche :: Auto -> Bool
esChiche auto
  | (even . length . apodos) auto = ((< 20) . desgasteChasis) auto  -- tieneCantidadParDeApodos y desgasteChasis < 20
  | otherwise = (even . velocidadMaxima) auto                       -- velocidadMaxima es par        

-- [2.D INTEGRANTE 3 ]------||SABER SI UN AUTO ES JOYA || ------------------------------
desgasteCero :: Auto -> Bool
desgasteCero auto = (&&) (((==0) . desgasteChasis) auto) (((==0) . desgasteRuedas) auto)

autoEsJoya :: Auto -> Bool
autoEsJoya auto = (||) 
                      ( (&&) (desgasteCero auto)        (((== 1) . length . apodos) auto) )-- desgasteCero y tieneUnSoloApodo
                      ( (&&) ((not . desgasteCero) auto) (((> 5) . length . marca ) auto) ) -- not desgasteCero y marcaMayoraCinco

-- [3.A TODOS LOS INTEGRANTES]-----|| REPARAR UN AUTO ||------------------------------------
repararAuto :: Auto -> Auto
repararAuto auto = auto {desgasteChasis = ((* 0.15). desgasteChasis) auto, desgasteRuedas = 0 }

-- [3.B INTEGRANTE 1 ]-------------|| PENALIZAR UN AUTO ||------------------------------------
penalizarAuto :: Number -> Auto -> Auto
penalizarAuto tiempo auto =  auto { tiempoCarrera = ((+ tiempo) . tiempoCarrera) auto}

-- [3.C INTEGRANTE 2 ]------------ || AGREGAR NITRO || ---------------------------------
ponerNitro :: Auto -> Auto
ponerNitro auto = auto {velocidadMaxima = ((* 1.2) .velocidadMaxima) auto}

-- [3.D INTEGRANTE 3] -------------||BAUTIZAR UN AUTO|| -----------------------------------
bautizarAuto :: Auto -> String -> Auto
bautizarAuto auto apodoNuevo = auto { apodos = (:) apodoNuevo (apodos auto) }

------------------------- || PISTAS || -----------------------------------------------------------
-- [4.A. TODOS LOS INTEGRANTES]--------------------------------------------------------------------

data Curva = Curva
  { angulo :: Number,
    longitudCurva :: Number
  }
  deriving (Show)

data Pista = Pista
  { nombre :: String,
    pais :: String,
    precioBaseEntrada :: Number,
    tramos :: Tramos
  }
  deriving (Show)

atravesarCurva :: Auto -> Curva -> Auto
atravesarCurva auto curva =
  auto
    { desgasteRuedas = desgasteRuedas auto + (3 * longitudCurva curva / angulo curva),
      tiempoCarrera = tiempoCarrera auto + ((longitudCurva curva - velocidadMaxima auto) / 10)
    }

curvaPeligrosa :: Curva
curvaPeligrosa =
  Curva
    { angulo = 60,
      longitudCurva = 300
    }

curvaTranca :: Curva
curvaTranca =
  Curva
    { angulo = 110,
      longitudCurva = 550
    }

-- [4B. INTEGRANTE 1]--------- || TRAMO RECTO || ------------------------------------------------
data Recto = Recto
  { longitudRecto :: Number
  }
  deriving (Show)

tramoRectoClassic :: Recto
tramoRectoClassic = Recto {longitudRecto = 715}

tramito :: Recto
tramito = Recto {longitudRecto = 260}

transitarTramoRecto :: Auto -> Recto -> Auto
transitarTramoRecto auto recto =
  auto
    { desgasteChasis = desgasteChasis auto + (longitudRecto recto / 100),
      tiempoCarrera = tiempoCarrera auto + (longitudRecto recto / velocidadMaxima auto)
    }

transitarTramoRetroClassic :: Auto -> Auto
transitarTramoRetroClassic auto = transitarTramoRecto auto tramoRectoClassic

transitarTramito :: Auto -> Auto
transitarTramito auto = transitarTramoRecto auto tramito

-- tramoRecto' :: Number -> Auto -> Auto
-- tramoRecto' longitud auto =
--  auto
--    { desgaste = (desgasteChasis auto + longitud / 100, desgasteRuedas auto),
--      tiempoCarrera = tiempoCarrera auto + longitud / velocidadMaxima auto
--    }
--
-- tramoRectoClassic' :: Tramo
-- tramoRectoClassic' = tramoRecto 715
--
-- tramito' :: Tramo
-- tramito' = tramoRecto 260 -}

-- [4C. INTEGRANTE 2]--------- || TRAMO ZIGZAG || ------------------------------------------------
data TramoZigZag = ZigZag
  { cambioDireccion :: Number
  }
  deriving (Show)

type Tramo = Auto -> Auto

calcularDesgasteRuedas :: Auto -> TramoZigZag -> Number
calcularDesgasteRuedas auto zigzag = velocidadMaxima auto * cambioDireccion zigzag * 0.1

calcularTiempoAdicional :: TramoZigZag -> Number
calcularTiempoAdicional = (* 3) . cambioDireccion

transitarZigZag :: Auto -> TramoZigZag -> Auto
transitarZigZag auto zigzag =
  auto
    { desgasteChasis = desgasteChasis auto + 5,
      desgasteRuedas = desgasteRuedas auto + calcularDesgasteRuedas auto zigzag,
      tiempoCarrera = tiempoCarrera auto + calcularTiempoAdicional zigzag
    }

zigZagLoco :: TramoZigZag
zigZagLoco = ZigZag {cambioDireccion = 5}

casiCurva :: TramoZigZag
casiCurva = ZigZag {cambioDireccion = 1}

-- [4.D. INTEGRANTE 3]--------- || TRAMO RULO || ------------------------------------------------
data Rulo = Rulo
  { diametro :: Number
  }
  deriving (Show)

data Tramos = Tramos
  { curva :: Curva,
    recto :: Recto,
    zigzag :: TramoZigZag,
    rulo :: Rulo
  }
  deriving (Show)

ruloClasico :: Rulo
ruloClasico = Rulo {diametro = 13}

deseoDeMuerte :: Rulo
deseoDeMuerte = Rulo {diametro = 26}

atravesarRulo :: Auto -> Rulo -> Auto
atravesarRulo auto rulo =
  auto
    { desgasteRuedas = desgasteRuedas auto + (diametro rulo * 1.5),
      tiempoCarrera = tiempoCarrera auto + (5 * (diametro rulo / velocidadMaxima auto))
    }