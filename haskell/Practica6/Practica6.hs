{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}


module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numerator

data Evento = Evento {
    nombreEvento :: String,
    duracion :: Number,
    tipoEvento :: String,          -- "Conferencia", "Taller", "Meetup"
    participantes :: [Participante],
    etiquetasEvento :: [String]
} deriving (Show, Eq)

data Participante = Participante {
    nombreParticipante :: String,
    edad :: Number,
    intereses :: [String]
} deriving (Show, Eq)

--Punto 1
cantidadTotalParticipantes :: [Evento] -> Number
cantidadTotalParticipantes [] = 0
cantidadTotalParticipantes (primerEvento:demasEventos) =
    (+) (length . participantes $ primerEvento) (cantidadTotalParticipantes demasEventos)

{-Ejemplo de uso:
agenda = [evento1, evento2, evento3, evento4]
cantidadTotalParticipantes [evento1, evento2, evento3, evento4]
= length (participantes evento1) + cantidadTotalParticipantes [evento2, evento3, evento4]
= 2 + cantidadTotalParticipantes [evento2, evento3, evento4]

segundo llamado:
cantidadTotalParticipantes [evento2, evento3, evento4]
= length (participantes evento2) + cantidadTotalParticipantes [evento3, evento4]
= 1 + cantidadTotalParticipantes [evento3, evento4]

tercerLlamado:
cantidadTotalParticipantes [evento3, evento4]
= length (participantes evento3) + cantidadTotalParticipantes [evento4]
= 2 + cantidadTotalParticipantes [evento4]

cuatoLLamado:
cantidadTotalParticipantes [evento4]
= length (participantes evento4) + cantidadTotalParticipantes []
= 3 + 0
Para [evento4] → 3 + 0 = 3
Para [evento3, evento4] → 2 + 3 = 5
Para [evento2, evento3, evento4] → 1 + 5 = 6
Para todo → 2 + 6 = 8
-}

--Punto 2  importante la estructura

eventosDeTipo :: String -> [Evento] -> [String]
eventosDeTipo estoyBuscando listaDeEventos = map nombreEvento . filter ((== estoyBuscando) . tipoEvento) $ listaDeEventos

--Punto 3
totalHorasDeEventos :: [Evento] -> Number
totalHorasDeEventos = foldl (+) 0 . map duracion 

--Punto 4
{- 
MAL:
eventoConMasParticipantes :: [Evento] -> String
eventoConMasParticipantes agenda = nombreEvento . foldr1 length . participantes $ agenda

posible solucion:
eventoConMasParticipantes :: [Evento] -> String
eventoConMasParticipantes eventos = nombreEvento (foldr1 maxParticipantes eventos)

maxParticipantes :: Evento -> Evento -> Evento
maxParticipantes evento1 evento2
    | length (participantes evento1) >= length (participantes evento2) = evento1
    | otherwise = evento2
-}
