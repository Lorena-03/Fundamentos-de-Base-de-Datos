-- 03_queries_dml.sql | Ejecutar TERCERO, despues de 02_data_inserts.sql.
-- Incluye consultas SELECT y pruebas controladas UPDATE / DELETE.
USE EscuelaSQL;
GO

/* ============================================================
   FASE 3. CONSULTAS LMD (SELECT)
   ============================================================ */

-- 3.1 SELECT basico: todos los alumnos.
SELECT AlumnoID, Nombre, Correo, Edad, FechaRegistro
FROM dbo.Alumnos;

-- 3.2 WHERE: alumnos de 20 anios o mas.
SELECT AlumnoID, Nombre, Edad
FROM dbo.Alumnos
WHERE Edad >= 20;

-- 3.3 WHERE con AND + ORDER BY: cursos dentro de un rango de costos.
SELECT CursoID, Nombre, Costo
FROM dbo.Cursos
WHERE Costo >= 1200 AND Costo <= 1800
ORDER BY Costo DESC, Nombre ASC;

-- 3.4 COUNT, SUM, AVG, MAX, MIN sobre todos los cursos.
SELECT
    COUNT(*) AS TotalCursos,
    SUM(Costo) AS SumaCostos,
    AVG(Costo) AS PromedioCosto,
    MAX(Costo) AS CostoMaximo,
    MIN(Costo) AS CostoMinimo
FROM dbo.Cursos;

-- 3.5 GROUP BY + COUNT + AVG: resumen por curso.
-- El LEFT JOIN incluye cursos sin inscritos.
SELECT
    c.CursoID,
    c.Nombre AS Curso,
    COUNT(i.InscripcionID) AS CantidadInscritos,
    AVG(i.Calificacion) AS PromedioCalificacion
FROM dbo.Cursos AS c
LEFT JOIN dbo.Inscripciones AS i ON i.CursoID = c.CursoID
GROUP BY c.CursoID, c.Nombre
ORDER BY CantidadInscritos DESC, c.Nombre;

-- 3.6 HAVING: mostrar solo cursos con al menos 2 inscritos.
SELECT
    c.Nombre AS Curso,
    COUNT(i.InscripcionID) AS CantidadInscritos
FROM dbo.Cursos AS c
INNER JOIN dbo.Inscripciones AS i ON i.CursoID = c.CursoID
GROUP BY c.CursoID, c.Nombre
HAVING COUNT(i.InscripcionID) >= 2
ORDER BY CantidadInscritos DESC, c.Nombre;

-- 3.7 INNER JOIN: solo alumnos con inscripcion, y sus cursos.
SELECT
    a.Nombre AS Alumno,
    c.Nombre AS Curso,
    i.Fecha,
    i.Calificacion
FROM dbo.Inscripciones AS i
INNER JOIN dbo.Alumnos AS a ON a.AlumnoID = i.AlumnoID
INNER JOIN dbo.Cursos AS c ON c.CursoID = i.CursoID
ORDER BY a.Nombre, c.Nombre;

-- 3.8 LEFT JOIN: todos los alumnos, incluso los no inscritos.
SELECT
    a.Nombre AS Alumno,
    c.Nombre AS Curso,
    i.Calificacion
FROM dbo.Alumnos AS a
LEFT JOIN dbo.Inscripciones AS i ON i.AlumnoID = a.AlumnoID
LEFT JOIN dbo.Cursos AS c ON c.CursoID = i.CursoID
ORDER BY a.Nombre, c.Nombre;

-- 3.9 LEFT JOIN con IS NULL: alumnos sin inscripciones.
SELECT a.AlumnoID, a.Nombre
FROM dbo.Alumnos AS a
LEFT JOIN dbo.Inscripciones AS i ON i.AlumnoID = a.AlumnoID
WHERE i.InscripcionID IS NULL;

/* ============================================================
   FASE 4. MANTENIMIENTO CONTROLADO: UPDATE / DELETE
   ============================================================ */

-- 4.1 UPDATE dentro de una transaccion; ROLLBACK revierte el cambio.
PRINT N'Prueba 4.1: UPDATE de calificacion (se revierte).';
SELECT InscripcionID, AlumnoID, CursoID, Calificacion
FROM dbo.Inscripciones WHERE InscripcionID = 1;

BEGIN TRANSACTION;
    UPDATE dbo.Inscripciones
    SET Calificacion = 98.00
    WHERE InscripcionID = 1;

    SELECT InscripcionID, AlumnoID, CursoID, Calificacion
    FROM dbo.Inscripciones WHERE InscripcionID = 1;
ROLLBACK TRANSACTION;

SELECT InscripcionID, AlumnoID, CursoID, Calificacion
FROM dbo.Inscripciones WHERE InscripcionID = 1;

-- 4.2 DELETE bloqueado por la FK: Ana (ID 1) tiene inscripciones.
-- La excepcion 547 se espera y se captura sin detener el resto del guion.
PRINT N'Prueba 4.2: intentar borrar un alumno con inscripciones (debe fallar).';
BEGIN TRY
    BEGIN TRANSACTION;
        DELETE FROM dbo.Alumnos WHERE AlumnoID = 1;
    COMMIT TRANSACTION;
    PRINT N'ADVERTENCIA: la eliminacion se completo inesperadamente.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT CONCAT(N'Eliminacion impedida por integridad referencial. Error ',
                 ERROR_NUMBER(), N': ', ERROR_MESSAGE());
END CATCH;

-- 4.3 FK bloquea inscribir un alumno inexistente (ID 9999).
PRINT N'Prueba 4.3: intentar inscribir a un alumno inexistente (debe fallar).';
BEGIN TRY
    BEGIN TRANSACTION;
        INSERT INTO dbo.Inscripciones (AlumnoID, CursoID, Fecha)
        VALUES (9999, 1, '2026-09-06');
    COMMIT TRANSACTION;
    PRINT N'ADVERTENCIA: la insercion se completo inesperadamente.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT CONCAT(N'Insercion impedida por integridad referencial. Error ',
                 ERROR_NUMBER(), N': ', ERROR_MESSAGE());
END CATCH;

-- 4.4 DELETE correcto: primero eliminar inscripciones, luego al alumno.
-- Se usa ROLLBACK para conservar todos los datos de la practica.
PRINT N'Prueba 4.4: eliminar registros dependientes y despues el alumno (se revierte).';
BEGIN TRY
    BEGIN TRANSACTION;
        DELETE FROM dbo.Inscripciones WHERE AlumnoID = 1;
        DELETE FROM dbo.Alumnos WHERE AlumnoID = 1;

        SELECT COUNT(*) AS Alumno1DurantePrueba
        FROM dbo.Alumnos WHERE AlumnoID = 1; -- Debe ser 0

    ROLLBACK TRANSACTION;
    PRINT N'Eliminacion valida comprobada y revertida con ROLLBACK.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;

-- Comprobacion final: se mantienen los datos originales.
SELECT
    (SELECT COUNT(*) FROM dbo.Alumnos) AS TotalAlumnos,       -- 5
    (SELECT COUNT(*) FROM dbo.Cursos) AS TotalCursos,         -- 4
    (SELECT COUNT(*) FROM dbo.Inscripciones) AS TotalInscripciones; -- 7
GO
