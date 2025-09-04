# Práctico 6 – Listas, recursividad, folds y composición

## Contexto

En este práctico modelamos un sistema de **eventos** y **participantes**.  
Cada evento tiene un nombre, una duración en horas, un tipo ("Conferencia", "Taller", "Meetup"), una lista de participantes y una lista de etiquetas.

Cada participante tiene un nombre, edad y una lista de intereses.

```haskell
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
```

Una agenda es una lista de eventos: `[Evento]`

---

## Consignas

### 1. (Recursividad)
Implementá la función **cantidadTotalParticipantes** que suma la cantidad de participantes de todos los eventos de la agenda usando recursividad explícita.

---

### 2. (Composición y filter)
Implementá la función **eventosDeTipo** que devuelve los nombres de los eventos de un tipo dado (“Taller”, por ejemplo), usando composición y aplicación parcial.

---

### 3. (foldl y map)
Implementá la función **totalHorasDeEventos** que suma la duración de todos los eventos de la agenda usando foldl.

---

### 4. (foldr1 y máximo)
Implementá la función **eventoConMasParticipantes** que devuelve el **nombre** del evento con mayor cantidad de participantes usando foldr1.

---

### 5. (Composición, map, filter)
Implementá la función **nombresDeParticipantesInteresadosEn** que recibe un **interés** y una agenda y devuelve una lista ordenada alfabéticamente con los nombres de los participantes que tienen ese interés y asisten a algún evento de la agenda (¡sin repetidos!).

---

### 6. (Diseño libre)
Proponé y resolvé una función propia que combine dos o más conceptos (fold, recursividad, composición, etc). Explicá la función brevemente.

---
