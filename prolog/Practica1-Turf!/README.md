# Parcial 1 - Paradigma Lógico: Modelado de Carreras de Caballos (Turf!)

## Enunciado

![prolog_resto_banner](https://thfvnext.bing.com/th/id/OIP.D377gNBD1NP56nYs8fz_BwHaEK?r=0&cb=thfvnext&rs=1&pid=ImgDetMain&o=7&rm=3)

### **Turf!**

Nos encargaron el diseño de una aplicación para modelar carreras de caballo en hipódromos (todo totalmente legal). A continuación dejamos los primeros requerimientos, sabiendo que nuestra intención es aplicar los conocimientos del paradigma lógico.

---

### **Punto 1: Pasos al costado (2 puntos)**

Les jockeys son personas que montan el caballo en la carrera:

- **Valdivieso**: mide 155 cms y pesa 52 kilos
- **Leguisamo**: mide 161 cms y pesa 49 kilos
- **Lezcano**: mide 149 cms y pesa 50 kilos
- **Baratucci**: mide 153 cms y pesa 55 kilos
- **Falero**: mide 157 cms y pesa 52 kilos

También tenemos a los caballos: Botafogo, Old Man, Enérgica, Mat Boy y Yatasto, entre otros. Cada caballo tiene sus preferencias:

- **Botafogo**: le gusta que le jockey pese menos de 52 kilos o que sea Baratucci
- **Old Man**: le gusta que le jockey sea alguna persona de muchas letras (más de 7), existe el predicado `atom_length/2`
- **Enérgica**: le gustan todes les jockeys que no le gusten a Botafogo
- **Mat Boy**: le gusta les jockeys que midan más de 170 cms
- **Yatasto**: no le gusta ningún jockey

También sabemos el Stud o la caballeriza al que representa cada jockey:

- Valdivieso y Falero son del stud **El Tute**
- Lezcano representa a **Las Hormigas**
- Baratucci y Leguisamo a **El Charabón**

Por otra parte, sabemos que:

- Botafogo ganó el **Gran Premio Nacional** y el **Gran Premio República**
- Old Man ganó el **Gran Premio República** y el **Campeonato Palermo de Oro**
- Enérgica y Yatasto no ganaron ningún campeonato
- Mat Boy ganó el **Gran Premio Criadores**

Modelar estos hechos en la base de conocimientos e indicar en caso de ser necesario si algún concepto interviene a la hora de hacer dicho diseño, justificando la decisión.

---

### **Punto 2: Para mí, para vos (2 puntos)**

Queremos saber quiénes son los caballos que prefieren a más de un jockey. Ejemplo: Botafogo, Old Man y Enérgica son caballos que cumplen esta condición según la base de conocimiento planteada. El predicado debe ser inversible.

---

### **Punto 3: No se llama Amor (2 puntos)**

Queremos saber quiénes son los caballos que no prefieren a ningún jockey de una caballeriza. El predicado debe ser inversible.

Ejemplos:
- Botafogo aborrece a El Tute (porque no prefiere a Valdivieso ni a Falero).
- Old Man aborrece a Las Hormigas.
- Mat Boy aborrece a todos los studs, entre otros ejemplos.

---

### **Punto 4: Piolines (2 puntos)**

Queremos saber quiénes son les jockeys "piolines", que son las personas preferidas por todos los caballos que ganaron un premio importante. El **Gran Premio Nacional** y el **Gran Premio República** son premios importantes.

Por ejemplo, Leguisamo y Baratucci son piolines, no así Lezcano que es preferida por Botafogo pero no por Old Man. El predicado debe ser inversible.

---

### **Punto 5: El jugador (2 puntos)**

Existen apuestas:

- **A ganador por un caballo**: gana si el caballo resulta ganador
- **A segundo por un caballo**: gana si el caballo sale primero o segundo
- **Exacta**: apuesta por dos caballos, y gana si el primer caballo sale primero y el segundo caballo sale segundo
- **Imperfecta**: apuesta por dos caballos y gana si los caballos terminan primero y segundo sin importar el orden

Queremos saber, dada una apuesta y el resultado de una carrera de caballos, si la apuesta resultó ganadora. No es necesario que el predicado sea inversible.

---

### **Punto 6: Los colores (2 puntos)**

Sabiendo que cada caballo tiene un color de crin:

- **Botafogo**: tordo (negro)
- **Old Man**: alazán (marrón)
- **Enérgica**: ratonero (gris y negro)
- **Mat Boy**: palomino (marrón y blanco)
- **Yatasto**: pinto (blanco y marrón)

Queremos saber qué caballos podría comprar una persona que tiene preferencia por caballos de un color específico. Tiene que poder comprar por lo menos un caballo para que la solución sea válida. Ojo: no perder información que se da en el enunciado.

Ejemplo: una persona que quiere comprar caballos marrones podría comprar a Old Man, Mat Boy y Yatasto. O a Old Man y Mat Boy. O a Old Man y Yatasto. O a Old Man. O a Mat Boy y Yatasto. O a Mat Boy. O a Yatasto.

---

### **NOTA**

- 12 = 10  
- 11 a 10 = 9  
- 9 = 8  
- 8 = 7  
- 7 = 6  
- 6 a 7 = Revisión  
- menos de 5 = desaprobado

---