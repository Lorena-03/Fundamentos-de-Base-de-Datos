-- 02_data_inserts.sql | Ejecutar SEGUNDO, despues de 01_schema_ddl.sql.
USE EscuelaSQL;
GO

/* ============================================================
   FASE 2. LMD: insertar datos de prueba
   ============================================================ */
INSERT INTO dbo.Alumnos (Nombre, Correo, Edad)
VALUES
    (N'Ana López',   N'ana@escuela.com',   20),
    (N'Luis Pérez',  N'luis@escuela.com',  22),
    (N'María Ruiz',  N'maria@escuela.com', 19),
    (N'Carlos Díaz', N'carlos@escuela.com', 23),
    (N'Sofía Torres',N'sofia@escuela.com', 21);  -- Sin inscripciones: LEFT JOIN

INSERT INTO dbo.Cursos (Nombre, Costo, Cupo)
VALUES
    (N'Bases de Datos', 1500.00, 30),
    (N'Programación C#', 1800.00, 25),
    (N'Redes',          1200.00, 20),
    (N'Seguridad',      2000.00, 15);  -- Sin inscripciones: LEFT JOIN

-- Los IDENTITY comienzan en 1 porque las tablas se recrearon.
INSERT INTO dbo.Inscripciones (AlumnoID, CursoID, Fecha, Calificacion)
VALUES
    (1, 1, '2026-09-01', 95.00),
    (1, 2, '2026-09-02', 88.00),
    (2, 1, '2026-09-01', 81.00),
    (2, 3, '2026-09-03', 76.00),
    (3, 2, '2026-09-02', 93.00),
    (4, 1, '2026-09-04', 70.00),
    (4, 3, '2026-09-05', NULL);  -- Aún sin calificación
GO
