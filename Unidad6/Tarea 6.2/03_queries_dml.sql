
-- 03_queries_dml.sql
-- Consultas y modificaciones de la base de datos EscuelaSQL

USE EscuelaSQL;
GO

-- =====================================
-- 1. MOSTRAR TODOS LOS ALUMNOS
-- =====================================

SELECT * FROM Alumnos;


-- =====================================
-- 2. MOSTRAR ALUMNOS DE 20 ANIOS O MAS
-- =====================================

SELECT *
FROM Alumnos
WHERE Edad >= 20;


-- =====================================
-- 3. ORDENAR CURSOS POR PRECIO
-- =====================================

SELECT *
FROM Cursos
ORDER BY Costo DESC;


-- =====================================
-- 4. CONTAR LOS CURSOS
-- =====================================

SELECT COUNT(*) AS TotalCursos
FROM Cursos;


-- =====================================
-- 5. SUMA, PROMEDIO, MAYOR Y MENOR COSTO
-- =====================================

SELECT
    SUM(Costo) AS Suma,
    AVG(Costo) AS Promedio,
    MAX(Costo) AS Mayor,
    MIN(Costo) AS Menor
FROM Cursos;


-- =====================================
-- 6. CONTAR ALUMNOS INSCRITOS POR CURSO
-- =====================================

SELECT
    CursoID,
    COUNT(*) AS TotalInscritos
FROM Inscripciones
GROUP BY CursoID;


-- =====================================
-- 7. CURSOS CON 2 O MAS INSCRIPCIONES
-- =====================================

SELECT
    CursoID,
    COUNT(*) AS TotalInscritos
FROM Inscripciones
GROUP BY CursoID
HAVING COUNT(*) >= 2;


-- =====================================
-- 8. INNER JOIN
-- MOSTRAR ALUMNOS Y SUS CURSOS
-- =====================================

SELECT
    Alumnos.Nombre AS Alumno,
    Cursos.Nombre AS Curso
FROM Inscripciones
INNER JOIN Alumnos
    ON Inscripciones.AlumnoID = Alumnos.AlumnoID
INNER JOIN Cursos
    ON Inscripciones.CursoID = Cursos.CursoID;


-- =====================================
-- 9. LEFT JOIN
-- MOSTRAR TODOS LOS ALUMNOS
-- =====================================

SELECT
    Alumnos.Nombre,
    Inscripciones.CursoID
FROM Alumnos
LEFT JOIN Inscripciones
    ON Alumnos.AlumnoID = Inscripciones.AlumnoID;


-- =====================================
-- 10. UPDATE
-- CAMBIAR LA EDAD DE UN ALUMNO
-- =====================================

UPDATE Alumnos
SET Edad = 21
WHERE AlumnoID = 1;

-- Comprobar el cambio
SELECT * FROM Alumnos
WHERE AlumnoID = 1;


-- =====================================
-- 11. DELETE
-- ELIMINAR UNA INSCRIPCION
-- =====================================

DELETE FROM Inscripciones
WHERE InscripcionID = 1;

-- Comprobar las inscripciones
SELECT * FROM Inscripciones;


-- =====================================
-- 12. VERIFICAR LOS REGISTROS
-- =====================================

SELECT COUNT(*) AS TotalAlumnos
FROM Alumnos;

SELECT COUNT(*) AS TotalCursos
FROM Cursos;

SELECT COUNT(*) AS TotalInscripciones
FROM Inscripciones;

