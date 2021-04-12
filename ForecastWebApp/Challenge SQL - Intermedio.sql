-------------
-- CREATION

CREATE TABLE Libro (
  idLibro INT AUTO_INCREMENT NOT NULL,
  Titulo VARCHAR(255),
  Editorial VARCHAR(255),
  Area VARCHAR(255),
  PRIMARY KEY(idLibro)
);

CREATE TABLE Autor (
  idAutor INT AUTO_INCREMENT NOT NULL,
  Nombre VARCHAR(255),
  Nacionalidad VARCHAR(255),
  PRIMARY KEY(idAutor)
);

CREATE TABLE Estudiante (
  idLector INT AUTO_INCREMENT NOT NULL,
  CI VARCHAR(255),
  Nombre VARCHAR(255),
  Direccion VARCHAR(255),
  Carrera VARCHAR(255),
  Edad INT,
  PRIMARY KEY(idLector)
);

CREATE TABLE LibAut (
  idLibro INT NOT NULL,
  idAutor INT NOT NULL,
  PRIMARY KEY(idLibro, idAutor),
  FOREIGN KEY (idLibro) REFERENCES Libro(idLibro),
  FOREIGN KEY (idAutor) REFERENCES Autor(idAutor)
);

CREATE TABLE Prestamo (
  idLector INT NOT NULL,
  idLibro INT NOT NULL,
  FechaPrestamo date,
  FechaDevolucion date,
  Devuelto bool,
  PRIMARY KEY(idLector, idLibro, FechaPrestamo),
  FOREIGN KEY (idLector) REFERENCES Estudiante(idLector),
  FOREIGN KEY (idLibro) REFERENCES Libro(idLibro)
);

-------------
-- INSERTS

-- Libro
INSERT INTO Libro (idLibro, Titulo, Editorial, Area) VALUES (1,'Design Patterns','Pearson Education Limited','Software engineering');
INSERT INTO Libro (idLibro, Titulo, Editorial, Area) VALUES (2, 'Operating System Concepts','Wiley','Software engineering');
-- Autor
INSERT INTO Autor (idAutor, Nombre, Nacionalidad) VALUES (1, 'Erich Gamma','Switzerland');
INSERT INTO Autor (idAutor, Nombre, Nacionalidad) VALUES (2, 'Ralph Johnson','USA');
INSERT INTO Autor (idAutor, Nombre, Nacionalidad) VALUES (3, 'Abraham Silberschatz','Israel');
-- Estudiante
INSERT INTO Estudiante (idLector, CI, Nombre, Direccion, Carrera, Edad) VALUES (1, '123', 'Agustin Koszczej', 'Foor Bar Av.', 'Systems Engineering', 24);
INSERT INTO Estudiante (idLector, CI, Nombre, Direccion, Carrera, Edad) VALUES (2, '123', 'Bill Gates', 'Microsoft Av.', 'Systems Engineering', 65);
-- Prestamo
INSERT INTO Prestamo (idLector, idLibro, FechaPrestamo, FechaDevolucion, Devuelto) VALUES (1,1,'1996-04-26', '2008-04-15', true);
INSERT INTO Prestamo (idLector, idLibro, FechaPrestamo, FechaDevolucion, Devuelto) VALUES (2,1,'1975-04-04', null, false);
-- LibAut
INSERT INTO LibAut (idLibro, idAutor) VALUES (1,1);
INSERT INTO LibAut (idLibro, idAutor) VALUES (1,2);
INSERT INTO LibAut (idLibro, idAutor) VALUES (1,3);
INSERT INTO LibAut (idLibro, idAutor) VALUES (2,3);


-------------
-- EXERCISES

-- 1. Listar los datos de los autores que tengan más de un libro publicado
SELECT DISTINCT A.* FROM Autor AS A 
INNER JOIN LibAut AS L ON (L.idAutor = A.idAutor)
GROUP BY L.idAutor
HAVING COUNT(L.idAutor) > 1;

-- 2. Listar nombre y edad de los estudiantes
SELECT nombre, edad FROM Estudiante;

-- 3. ¿Qué estudiantes pertenecen a la carrera de Informática?
SELECT * FROM Estudiante 
WHERE Carrera="Informática";

-- 4. Listar los nombres de los estudiantes cuyo apellido comience con la letra G?
SELECT Nombre FROM Estudiante
WHERE Nombre LIKE "% G%";

-- 5. ¿Quiénes son los autores del libro “Visual Studio Net”, listar solamente los nombres?
SELECT Nombre FROM Autor AS A
INNER JOIN LibAut AS LA ON (LA.idAutor=A.idAutor)
INNER JOIN Libro AS L ON (L.idLibro=LA.idLibro)
WHERE L.Titulo="Visual Studio Net";

-- 6. ¿Qué autores son de nacionalidad “USA” o “Francia”?
SELECT * FROM Autor
WHERE Nacionalidad IN("USA","Francia");

-- 7. ¿Qué libros NO Son del Area “CABA”?
SELECT * FROM Libro WHERE Area <> "CABA";

-- 8. ¿Qué libros se prestó del Lector “Felipe Loayza Beramendi”?
SELECT * FROM Libro
WHERE idLibro IN(SELECT idLibro FROM Prestamo WHERE idLector 
IN(SELECT idLector FROM Estudiante WHERE Nombre="Felipe Loayza Beramendi"));


-- 9. Listar el nombre del estudiante de menor edad
SELECT * FROM Estudiante
ORDER BY Edad ASC
LIMIT 1;

-- 10. Listar los nombres de los estudiantes que se prestaron Libros del área “BUENOS AIRES”
SELECT * FROM Estudiante
WHERE idLector IN(SELECT idLector FROM Prestamo WHERE idLibro IN(SELECT idLibro FROM Libro WHERE Area="BUENOS AIRES"))

-- 11. Listar los libros de editorial “ALFA” y de “OMEGA”
SELECT * FROM Libro 
WHERE Editorial IN("ALFA", "OMEGA");

-- 12. Listar los libros que pertenecen al autor “FELIPE PIGNA”
SELECT DISTINCT L.* FROM Libro AS L
INNER JOIN LibAut AS LA ON LA.idLibro=L.idLibro
INNER JOIN Autor AS A ON A.idAutor=LA.idAutor
WHERE Nombre="FELIPE PIGNA";

-- 13. Listar los títulos de los libros que debían devolverse el “10/04/2020”
SELECT * FROM Libro AS L
INNER JOIN Prestamo AS P ON P.idLibro=L.idLibro
WHERE FechaDevolucion="2020-04-10" AND Devuelto=false;

-- 14. Hallar el promedio de edad de los estudiantes
SELECT AVG(Edad) AS "Promedio Edad" FROM Estudiante;

-- 15. Listar los datos de los estudiantes cuya edad es mayor al promedio
SELECT * FROM Estudiante 
WHERE Edad > (SELECT AVG(Edad) FROM Estudiante)

-- 16. Crear un Stored Procedure que muestre los libros de un determinado Autor que se especique.
CREATE PROCEDURE Exercise16(IN Autor VARCHAR(255))
BEGIN
	SELECT DISTINCT L.* FROM Libro AS L
	INNER JOIN LibAut AS LA ON LA.idLibro=L.idLibro
	INNER JOIN Autor AS A ON A.idAutor=LA.idAutor
	WHERE Nombre=@Autor;
END;

-- 17. Crear un Stored Procedure que inserte nuevos Estudiantes
CREATE PROCEDURE Exercise17(IN p_idlector INT, IN p_ci VARCHAR(255),IN p_nombre VARCHAR(255), IN p_direccion VARCHAR(255), IN p_carrera VARCHAR(255), IN p_edad INT)
BEGIN
	INSERT INTO INSERT INTO Estudiante (idLector, CI, Nombre, Direccion, Carrera, Edad) VALUES (p_idlector, p_ci, p_nombre, p_direccion, p_carrera, p_edad)
END;

-- 18. Crear un Stored Procedure que actualice cualquier Libro especicando su código.
CREATE PROCEDURE Exercise18(IN p_idlibro INT, IN p_titulo VARCHAR(255),IN p_editorial VARCHAR(255), IN p_area VARCHAR(255))
BEGIN
	UPDATE Libro SET Titulo=p_titulo, Editorial=p_editorial, Area=p_area WHERE idLibro=p_idlibro
END;

-- 19. Crear un disparador DML que permita listar los registros de la Tabla Estudiante luego de insertar un nuevo registro.
CREATE TRIGGER Exercise19 AFTER INSERT  
ON Estudiante FOR EACH ROW  
BEGIN  
   SELECT * FROM Estudiante; 
END;

-- 20. Crear una Función (que devuelva una Tabla) que liste los préstamos solicitados por un determinado alumno
CREATE FUNCTION Exercise20 (p_nombre VARCHAR)
RETURNS TABLE
BEGIN
	SELECT * FROM Libro
	WHERE idLibro IN(SELECT idLibro FROM Prestamo WHERE idLector 
	IN(SELECT idLector FROM Estudiante WHERE Nombre=p_nombre));

END;

-- 21. ¿Cuáles son lAS diferenciAS entre los comandos ‘delete’ y ‘truncate’
Delete: Es una operación DML. Tiene borrado selectivo (WHERE). Más lenta.
Truncate: Es una operación DDL. NO tiene borrado selectivo (WHERE). Más rápida.
-- 22. ¿Puedes decir que los valores NULL equivalen a cero?
No.
-- 23. Responda lAS preguntAS 2, 3, 4, 9, 11, 14, 16, 22 solamente.
???
-- 24. Genere una sentencia para crear una tabla vacía llamada AUTOR2 identica a la tabla AUTOR que ya tiene datos.
CREATE TABLE AUTOR2 AS SELECT * FROM AUTOR LIMIT 0;