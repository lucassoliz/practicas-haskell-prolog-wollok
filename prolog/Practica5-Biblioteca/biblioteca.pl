%PUNTO 1
lector(ana, 35, [novela, poesia]).
lector(bruno, 20, [cienciaFiccion]).
lector(carla, 42, [ensayo, novela]).
lector(damian, 28, [poesia]).

libro("Cien años de soledad", novela, "Gabriel García Márquez", 1967).
libro("Fundación", cienciaFiccion, "Isaac Asimov", 1951).
libro("Sapiens", ensayo, "Yuval Noah Harari", 2011).
libro("Veinte poemas de amor", poesia, "Pablo Neruda", 1924).
libro("El Principito", novela, "Antoine de Saint-Exupéry", 1943).

leyo(ana, "Cien años de soledad").
leyo(bruno, "Fundación").
leyo(carla, "Sapiens").
leyo(carla, "Cien años de soledad").
leyo(damian, "Veinte poemas de amor").
leyo(ana, "El Principito").
leyo(bruno, "El Principito").
%PUNTO 2