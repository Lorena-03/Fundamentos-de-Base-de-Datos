
# EscuelaSQL — Práctica de LDD y LMD en SQL Server

Proyecto académico que demuestra la creación de una base de datos relacional, la inserción de registros, la ejecución de consultas SQL y las pruebas de integridad referencial utilizando **Microsoft SQL Server**.

## Objetivo

Implementar una base de datos escolar mediante sentencias SQL, aplicando el Lenguaje de Definición de Datos (LDD) y el Lenguaje de Manipulación de Datos (LMD).

## Tecnologías utilizadas

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Transact-SQL (T-SQL)
- Git y GitHub

## Estructura del proyecto

```text
EscuelaSQL/
├── 01_schema_ddl.sql
├── 02_data_inserts.sql
├── 03_queries_dml.sql
└── README.md
```

| Archivo | Descripción |
|---|---|
| `01_schema_ddl.sql` | Creación de la base de datos, tablas y restricciones. |
| `02_data_inserts.sql` | Inserción de datos de prueba. |
| `03_queries_dml.sql` | Consultas SQL y pruebas de mantenimiento. |
| `README.md` | Documentación del proyecto. |

## 1. Requisitos previos

Antes de ejecutar el proyecto es necesario contar con:

1. Microsoft SQL Server instalado.
2. SQL Server Management Studio (SSMS).
3. Una instancia de SQL Server en funcionamiento.
4. Permisos para crear bases de datos y tablas.
5. Git instalado (opcional).

> **Nota:** Los scripts están desarrollados específicamente para SQL Server y utilizan sintaxis T-SQL.

## 2. Clonar el repositorio

Abre Git Bash, PowerShell o una terminal y ejecuta:

```bash
git clone https://github.com/USUARIO/REPOSITORIO.git
```

Después, ingresa a la carpeta:

```bash
cd REPOSITORIO
```

**Importante:** Reemplaza `USUARIO` y `REPOSITORIO` con los datos reales del repositorio de GitHub.

También puedes descargar el proyecto desde GitHub seleccionando **Code > Download ZIP**.

## 3. Abrir SQL Server Management Studio

1. Ejecuta SQL Server Management Studio.
2. Conéctate a tu instancia de SQL Server.
3. Selecciona **File > Open > File**.
4. Abre los archivos SQL descargados.
5. Ejecuta los scripts en el orden indicado.

## 4. Ejecución de los scripts

Los archivos deben ejecutarse en el siguiente orden:

```text
01_schema_ddl.sql
        |
        v
02_data_inserts.sql
        |
        v
03_queries_dml.sql
```

### Paso 1: Creación de la base de datos (LDD)

Abre el archivo:

`01_schema_ddl.sql`

Este script crea la base de datos `EscuelaSQL` y las siguientes tablas:

- **Alumnos:** almacena los datos de los estudiantes.
- **Cursos:** contiene los cursos disponibles.
- **Inscripciones:** relaciona alumnos con cursos.

Se implementan las siguientes restricciones:

- `PRIMARY KEY`: identifica cada registro.
- `FOREIGN KEY`: establece relaciones entre tablas.
- `NOT NULL`: evita valores nulos.
- `UNIQUE`: impide valores duplicados.
- `CHECK`: valida condiciones.
- `DEFAULT`: asigna valores predeterminados.

Presiona **F5** o selecciona **Execute**.

Para verificar la creación, abre:

`Databases > EscuelaSQL > Tables`

> **Advertencia:** El script puede eliminar y recrear las tablas de la práctica. Los datos anteriores de esas tablas se perderán.

### Paso 2: Inserción de registros (LMD)

Abre:

`02_data_inserts.sql`

Este script utiliza `INSERT INTO` para registrar información de prueba.

| Tabla | Cantidad de registros |
|---|---:|
| Alumnos | 5 |
| Cursos | 4 |
| Inscripciones | 7 |
| **Total** | **16** |

Ejecuta el archivo con **F5**.

Para comprobar los registros:

```sql
USE EscuelaSQL;
GO

SELECT * FROM dbo.Alumnos;
SELECT * FROM dbo.Cursos;
SELECT * FROM dbo.Inscripciones;
```

> **Nota:** Ejecuta los INSERT solamente después de crear las tablas. Repetirlos puede provocar errores por restricciones de unicidad.

### Paso 3: Consultas SQL (LMD)

Abre:

`03_queries_dml.sql`

Este script contiene las siguientes operaciones:

| Sentencia | Función |
|---|---|
| `SELECT` | Consultar información. |
| `WHERE` | Filtrar registros. |
| `ORDER BY` | Ordenar resultados. |
| `GROUP BY` | Agrupar registros. |
| `HAVING` | Filtrar agrupaciones. |
| `COUNT()` | Contar registros. |
| `SUM()` | Sumar valores. |
| `AVG()` | Calcular promedios. |
| `MAX()` | Obtener el valor máximo. |
| `MIN()` | Obtener el valor mínimo. |
| `INNER JOIN` | Relacionar registros coincidentes. |
| `LEFT JOIN` | Mostrar todos los registros de la tabla izquierda y sus coincidencias. |

Ejecuta el script y observa las pestañas **Results** y **Messages**.

## 5. Ejemplos de consultas SQL

### Consultar todos los alumnos

```sql
SELECT *
FROM dbo.Alumnos;
```

### Contar alumnos registrados

```sql
SELECT COUNT(*) AS TotalAlumnos
FROM dbo.Alumnos;
```

### Ordenar alumnos por nombre

```sql
SELECT *
FROM dbo.Alumnos
ORDER BY Nombre ASC;
```

### Consultar inscripciones con INNER JOIN

```sql
SELECT
    a.Nombre AS Alumno,
    c.NombreCurso AS Curso
FROM dbo.Inscripciones AS i
INNER JOIN dbo.Alumnos AS a
    ON i.AlumnoID = a.AlumnoID
INNER JOIN dbo.Cursos AS c
    ON i.CursoID = c.CursoID;
```

### Contar inscripciones por curso

```sql
SELECT
    c.NombreCurso,
    COUNT(i.InscripcionID) AS TotalInscritos
FROM dbo.Cursos AS c
LEFT JOIN dbo.Inscripciones AS i
    ON c.CursoID = i.CursoID
GROUP BY c.NombreCurso;
```

## 6. Pruebas de integridad referencial

La base de datos implementa relaciones entre las tablas mediante claves foráneas.

Por ejemplo:

- Una inscripción debe pertenecer a un alumno existente.
- Una inscripción debe estar asociada a un curso existente.
- SQL Server impide eliminar directamente un alumno con inscripciones dependientes si la restricción no permite esa operación.

El tercer script incluye pruebas con:

- `UPDATE`: modificación de registros.
- `DELETE`: eliminación de registros.
- `BEGIN TRANSACTION`: inicio de transacciones.
- `ROLLBACK`: reversión de modificaciones.
- `TRY...CATCH`: control de errores.

Estas pruebas permiten verificar el funcionamiento de las restricciones sin perder los registros originales.

## 7. Verificación final

Ejecuta las siguientes consultas:

```sql
USE EscuelaSQL;
GO

SELECT COUNT(*) AS TotalAlumnos
FROM dbo.Alumnos;

SELECT COUNT(*) AS TotalCursos
FROM dbo.Cursos;

SELECT COUNT(*) AS TotalInscripciones
FROM dbo.Inscripciones;
```

### Resultados esperados

| Tabla | Resultado |
|---|---:|
| Alumnos | 5 |
| Cursos | 4 |
| Inscripciones | 7 |

Si los resultados coinciden, la carga de datos se realizó correctamente.

## 8. Solución de problemas

| Error | Solución |
|---|---|
| La base de datos no existe | Ejecutar primero `01_schema_ddl.sql`. |
| La tabla no existe | Comprobar la creación de las tablas. |
| Error al insertar registros | Revisar claves primarias, foráneas y valores duplicados. |
| Error de clave foránea | Comprobar que existen los registros relacionados. |
| Error de permisos | Verificar los permisos del usuario de SQL Server. |
| Error al repetir INSERT | Recrear las tablas de prueba o evitar insertar duplicados. |

## 9. Evidencias de ejecución

Para documentar la práctica se recomienda incluir capturas de:

1. Creación de la base de datos `EscuelaSQL`.
2. Visualización de las tres tablas.
3. Inserción de registros mediante `INSERT INTO`.
4. Consultas con `SELECT`, `WHERE` y `ORDER BY`.
5. Consultas con funciones de agregación.
6. Relaciones mediante `INNER JOIN` y `LEFT JOIN`.
7. Pruebas de `UPDATE` y `DELETE`.
8. Verificación final de registros.

## Conclusión

Esta práctica permitió implementar una base de datos relacional utilizando Microsoft SQL Server.

Mediante instrucciones LDD se crearon las tablas, relaciones y restricciones necesarias.

Posteriormente, mediante instrucciones LMD se insertaron registros y se ejecutaron consultas para analizar la información almacenada.

Finalmente, las pruebas de mantenimiento permitieron comprobar la importancia de las claves foráneas y la integridad referencial para conservar información consistente.

---

**Proyecto académico:** Práctica de SQL Server — LDD y LMD.
