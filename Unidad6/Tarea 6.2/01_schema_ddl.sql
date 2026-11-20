
CREATE DATABASE EscuelaSQL;
GO

USE EscuelaSQL;
GO

-- El orden respeta las dependencias de claves foraneas.
DROP TABLE IF EXISTS dbo.Inscripciones;
DROP TABLE IF EXISTS dbo.Cursos;
DROP TABLE IF EXISTS dbo.Alumnos;
GO

CREATE TABLE dbo.Alumnos
(
    AlumnoID      INT IDENTITY(1,1) NOT NULL,
    Nombre        NVARCHAR(70) NOT NULL,
    Correo        NVARCHAR(120) NOT NULL,
    Edad          INT NOT NULL,
    FechaRegistro DATE NOT NULL CONSTRAINT DF_Alumnos_FechaRegistro DEFAULT (CONVERT(date, GETDATE())),
    CONSTRAINT PK_Alumnos PRIMARY KEY (AlumnoID),
    CONSTRAINT UQ_Alumnos_Correo UNIQUE (Correo),
    CONSTRAINT CK_Alumnos_Edad CHECK (Edad BETWEEN 15 AND 100)
);
GO

CREATE TABLE dbo.Cursos
(
    CursoID   INT IDENTITY(1,1) NOT NULL,
    Nombre    NVARCHAR(80) NOT NULL,
    Costo     DECIMAL(10,2) NOT NULL,
    Cupo      INT NOT NULL,
    CONSTRAINT PK_Cursos PRIMARY KEY (CursoID),
    CONSTRAINT UQ_Cursos_Nombre UNIQUE (Nombre),
    CONSTRAINT CK_Cursos_Costo CHECK (Costo >= 0),
    CONSTRAINT CK_Cursos_Cupo CHECK (Cupo > 0)
);
GO

CREATE TABLE dbo.Inscripciones
(
    InscripcionID INT IDENTITY(1,1) NOT NULL,
    AlumnoID      INT NOT NULL,
    CursoID       INT NOT NULL,
    Fecha         DATE NOT NULL CONSTRAINT DF_Inscripciones_Fecha DEFAULT (CONVERT(date, GETDATE())),
    Calificacion  DECIMAL(5,2) NULL,
    CONSTRAINT PK_Inscripciones PRIMARY KEY (InscripcionID),
    CONSTRAINT FK_Inscripciones_Alumnos FOREIGN KEY (AlumnoID)
        REFERENCES dbo.Alumnos (AlumnoID),
    CONSTRAINT FK_Inscripciones_Cursos FOREIGN KEY (CursoID)
        REFERENCES dbo.Cursos (CursoID),
    CONSTRAINT UQ_Inscripciones_AlumnoCurso UNIQUE (AlumnoID, CursoID),
    CONSTRAINT CK_Inscripciones_Calificacion CHECK
        (Calificacion IS NULL OR Calificacion BETWEEN 0 AND 100)
);
GO
