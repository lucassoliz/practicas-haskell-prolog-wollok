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

%========================================================
%PUNTO 2
recomendar(Lector, Libro):-
    lector(Lector, _, Generos), %generador
    libro(Libro, Genero, _, _), %generador
    pertenece(Genero, Generos), %me fijo si el genero del libro esta en las preferencias del lector
    not(leyo(Lector, Libro)). %me fijo que el lector no haya leido el libro

pertenece(Elemento, [Elemento|_]).
pertenece(Elemento, [_|Resto]):- pertenece(Elemento, Resto).

%EJEMPLO DE PERTENECE
%pertenece(novela, [novela, poesia]). --> true
%pertenece(novela, [cienciaFiccion, poesia]). --> false

%========================================================
%PUNTO 3

prestamo(ana, "Sapiens", fecha(1,7,2025), prendiente). 
prestamo(bruno, "El Principito", fecha(5,6,2025), fecha(25,6,2025)).
prestamo(carla, "Cien años de soledad", fecha(12,8,2025),pendiente).
prestamo(damian, "Veinte poemas de amor", fecha(20,7,2025), fecha(28,7,2025)).
%tiene sentido es como poner pendiente y noPendiente
%solo que en vez de noPendiente, ponemos la fecha de devolucion, osea el functor

%Este LECTOR tiene un PRESTAMO PENDIENTE de este LIBRO?
%Este LIBRO que lector tiene un PRESTAMO PENDIENTE?
tienePrestamoPendiente(Lector, Libro):-
    prestamo(Lector, Libro, _, pendiente).

%=======================================================
%PUNTO 4
evento("Noche de Garcia Maequez", novela, fecha(14,9,2025), gabrielGarciaMaequez).
evento("Encuentro de poesia", poesia, fecha(22,9,2025), pabloNeruda).
evento("Ciencia ficcion en la Biblioteca", cienciaFiccion, fecha(30,9,2025), isaacAsimov).

puedeParticipar(Lector, Evento):-
    evento(Evento, Tematica, _, AutorPrincipal), %generador
    libro(LibroTitulo, _, AutorPrincipal, _), %generador
    leyo(Lector, LibroTitulo). %filtro

puedeParticipar(Lector, Evento):-
    evento(Evento, Tematica, _, _), %generador
    lector(Lector, _, Generos), %generador
    pertenece(Tematica, Generos). %filtro

/*IMPORTANCIA DEL
pertenece(Elemento, [Elemento|_]).
pertenece(Elemento, [_|Resto]):- pertenece(Elemento, Resto).
*/
%======================================================
%PUNTO 5

atiende(laura, lunes, 8, 14).
atiende(laura, miercoles, 8, 14).

atiende(pedro, martes, 12, 18).
atiende(pedro, jueves, 12, 18).

atiende(sofia, viernes, 10, 20).

atiende(tomas, sabado, 14, 20).
atiende(tomas, domingo, 14, 20).

quienAtiende(Empleado, Dia, Hora):-
    atiende(Empleado, Dia, HoraInicio, HoraFin), %generador
    Hora >= HoraInicio, %filtro
    Hora < HoraFin. %filtro

%======================================================
%¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬


%PUNTO 6 extra
%SABER SI UN LECTOR ES FIEL
%Un lector es fiel si ha leido todos los libros de sus generos preferidos

esFiel(Lector):-
    lector(Lector, _, Generos), %generador
    forall(pertenece(Genero, Generos), %para todo genero que pertenezca a las preferencias del lector
           (libro(Libro, Genero, _, _), %generador
            leyo(Lector, Libro))). %filtro

%======================================================
%PUNTO 7 extra
%SABER SI UN LECTOR ES UN LECTOR AVANZADO
%Un lector es avanzado si ha leido al menos 3 libros de cada uno de sus generos preferidos

esAvanzado(Lector):-
    lector(Lector, _, Generos), %generador
    forall(pertenece(Genero, Generos), %para todo genero que pertenezca a las preferencias del lector
           (findall(Libro, (libro(Libro, Genero, _, _), leyo(Lector, Libro)), LibrosLeidos), %generador + filtro
            length(LibrosLeidos, Cantidad), %cantidad de libros leidos
            Cantidad >= 3)). %filtro


%======================================================
%PUNTO 8 extra
%SABER SI UN LECTOR ES UN LECTOR TOP
%Un lector es top si ha leido al menos un libro de cada autor que haya escrito un libro de sus generos preferidos

esTop(Lector):-
    lector(Lector, _, Generos), %generador
    forall(pertenece(Genero, Generos), %para todo genero que pertenezca a las preferencias del lector
           (libro(_, Genero, Autor, _), %generador
            leyo(Lector, Libro), %filtro
            libro(Libro, _, Autor, _))). %filtro

%======================================================
%PUNTO 9 extra
%SABER SI UN LECTOR ES UN LECTOR FENOMENO
%Un lector es fenomeno si es fiel, avanzado y top
esFenomeno(Lector):-
    esFiel(Lector),
    esAvanzado(Lector),
    esTop(Lector).

%======================================================
%PUNTO 10 extra
%SABER SI UN LECTOR ES UN LECTOR NOVATO
%Un lector es novato si no es fiel, no es avanzado y no es top
esNovato(Lector):-
    not(esFiel(Lector)),
    not(esAvanzado(Lector)),
    not(esTop(Lector)).
