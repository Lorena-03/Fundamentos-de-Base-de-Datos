UNIDAD 6 — TAREA 6.1
Instituto Tecnológico Superior de Monclova (ITSM)
Materia: Fundamentos de Base de Datos
Alumna: Lorena Cervantes Ibarra
Número de control: I24050374
Profesor: Ruben Miguel Riojas Rodriguez
Grupo: 5to Ing.Informatica
Sentencias y Clasificacion de sentencias SQL
1. Panorama general del lenguaje SQL
SQL (Structured Query Language) es un lenguaje declarativo empleado en los sistemas gestores de bases de datos relacionales. Permite definir estructuras, consultar información y modificar registros. Describe qué resultado se desea obtener, mientras que el motor de base de datos decide cómo ejecutar la operación.

Características principales: utiliza sentencias con palabras clave; trabaja con tablas, filas y columnas; admite restricciones de integridad (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK y NOT NULL); incluye filtros, ordenamiento y agrupaciones; y puede ejecutarse dentro de transacciones, con diferencias entre motores.
2. Tabla comparativa y taxonómica
Grupo	Comando	Función central	Efecto principal
LDD / DDL	CREATE	Crea objetos como tablas, vistas e índices.	Define nueva estructura.
LDD / DDL	ALTER	Modifica la definición de objetos existentes.	Cambia columnas o restricciones.
LDD / DDL	DROP	Elimina objetos de la base de datos.	Retira estructura y datos asociados.
LDD / DDL	TRUNCATE	Vacía todas las filas de una tabla.	Conserva la estructura; elimina registros.
LMD / DML	INSERT	Agrega una o varias filas.	Incorpora datos.
LMD / DML	UPDATE	Actualiza valores de filas existentes.	Modifica datos.
LMD / DML	DELETE	Elimina filas seleccionadas.	Retira datos, no la tabla.
LMD / DML	SELECT	Recupera y transforma información.	Devuelve un conjunto de resultados.


Nota taxonómica: SELECT suele enseñarse dentro de LMD por su uso sobre datos; otras clasificaciones lo distinguen como DQL (lenguaje de consulta). TRUNCATE se clasifica generalmente como DDL, aunque su comportamiento transaccional depende del gestor.
3. Sentencias LDD / DDL
Las formas siguientes son esquemas didácticos. Los ejemplos y extensiones se basan principalmente en PostgreSQL; la sintaxis específica puede variar en MySQL, SQL Server u Oracle.
CREATE — creación
Construye un objeto nuevo; CREATE TABLE especifica columnas, tipos y reglas de integridad.

Sintaxis general:
CREATE TABLE [IF NOT EXISTS] tabla (
  columna tipo [restricción_columna],
  ...
  [CONSTRAINT nombre restricción_tabla]
);
Parámetros: IF NOT EXISTS evita error si existe la tabla; tabla identifica el objeto; tipo define el dominio; restricción establece reglas.

Restricciones y precauciones: Los nombres deben cumplir las reglas del gestor; una PRIMARY KEY no acepta NULL; las FOREIGN KEY deben referenciar claves válidas.

Opciones avanzadas: CREATE TEMP TABLE; CREATE TABLE ... AS SELECT; DEFAULT; GENERATED ... AS IDENTITY.

Ejemplo:
CREATE TABLE alumnos (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  correo VARCHAR(120) UNIQUE
);
ALTER — modificación
Cambia la estructura de una tabla sin necesidad de recrearla desde cero.

Sintaxis general:
ALTER TABLE [IF EXISTS] tabla
  { ADD [COLUMN] columna tipo |
    ALTER [COLUMN] columna TYPE nuevo_tipo |
    DROP [COLUMN] [IF EXISTS] columna };
Parámetros: ADD incorpora; ALTER modifica; DROP COLUMN elimina columna; IF EXISTS controla errores por ausencia.

Restricciones y precauciones: La conversión de tipos puede fallar si hay valores incompatibles; eliminar columnas puede afectar aplicaciones, vistas o restricciones.

Opciones avanzadas: RENAME COLUMN; ADD CONSTRAINT; ALTER COLUMN SET/DROP NOT NULL; USING para conversión de tipos (PostgreSQL).

Ejemplo:
ALTER TABLE alumnos
ADD COLUMN fecha_ingreso DATE;
DROP — eliminación de objetos
Suprime una tabla u otro objeto, junto con su definición; es una operación de alto impacto.

Sintaxis general:
DROP TABLE [IF EXISTS] tabla [, ...]
  [CASCADE | RESTRICT];
Parámetros: IF EXISTS evita error por objeto inexistente; CASCADE incluye objetos dependientes; RESTRICT impide la eliminación si existen dependencias.

Restricciones y precauciones: Requiere los privilegios correspondientes; al eliminar una tabla también se pierden sus filas y ciertos objetos asociados.

Opciones avanzadas: DROP VIEW, DROP INDEX y DROP SCHEMA; CASCADE debe usarse con especial cuidado.

Ejemplo:
DROP TABLE IF EXISTS alumnos RESTRICT;
TRUNCATE — vaciado completo
Elimina todas las filas de una tabla conservando sus columnas, tipos y restricciones.

Sintaxis general:
TRUNCATE [TABLE] tabla [, ...]
  [RESTART IDENTITY | CONTINUE IDENTITY]
  [CASCADE | RESTRICT];
Parámetros: RESTART IDENTITY reinicia secuencias asociadas; CONTINUE IDENTITY las mantiene; CASCADE incluye tablas relacionadas (PostgreSQL).

Restricciones y precauciones: No utiliza WHERE; puede estar restringido por claves foráneas y permisos; no debe asumirse que funciona igual en todos los motores.

Opciones avanzadas: En PostgreSQL puede ejecutarse dentro de una transacción y revertirse; en otros gestores puede implicar confirmación automática.

Ejemplo:
TRUNCATE TABLE registros_temporales
RESTART IDENTITY;
Comparación puntual: DROP, TRUNCATE y DELETE
Criterio	DROP TABLE	TRUNCATE	DELETE
¿Conserva tabla?	No	Sí	Sí
¿Permite WHERE?	No	No	Sí
¿Qué retira?	Objeto y datos	Todas las filas	Filas seleccionadas o todas
Transacción	Depende del motor	Depende del motor	Generalmente transaccional


4. Sentencias LMD / DML
INSERT — inserción de registros
Agrega filas nuevas y verifica las restricciones de las columnas.

Sintaxis general:
INSERT INTO tabla (columna1, columna2, ...)
VALUES (valor1, valor2, ...), (...);
Parámetros: La lista de columnas indica el destino; VALUES contiene los valores correspondientes y en orden.

Restricciones y precauciones: Cada valor debe ser compatible con su tipo; se respetan NOT NULL, UNIQUE, CHECK y FOREIGN KEY.

Opciones avanzadas: INSERT INTO ... SELECT; DEFAULT VALUES; ON CONFLICT DO UPDATE/NOTHING y RETURNING (PostgreSQL).

Ejemplo:
INSERT INTO alumnos (nombre, correo)
VALUES ('Ana López', 'ana@ejemplo.com');
UPDATE — modificación de registros
Cambia el contenido de columnas en las filas que satisfacen una condición.

Sintaxis general:
UPDATE tabla
SET columna1 = expresión1 [, columna2 = expresión2]
[WHERE condición];
Parámetros: SET asigna nuevos valores; WHERE limita las filas afectadas; expresión puede usar funciones o valores previos.

Restricciones y precauciones: Sin WHERE se actualizan todas las filas; se deben respetar restricciones de integridad y revisar la condición.

Opciones avanzadas: UPDATE ... FROM para cruzar información; RETURNING para recuperar filas modificadas (PostgreSQL).

Ejemplo:
UPDATE alumnos
SET correo = 'ana.nuevo@ejemplo.com'
WHERE id = 1;
DELETE — eliminación de registros
Borra filas de una tabla sin eliminar su definición.

Sintaxis general:
DELETE FROM tabla
[WHERE condición];
Parámetros: FROM indica la tabla; WHERE delimita el conjunto de filas a borrar.

Restricciones y precauciones: Sin WHERE se eliminan todas las filas; las claves foráneas pueden impedir el borrado o provocar acciones configuradas.

Opciones avanzadas: DELETE ... USING y RETURNING (PostgreSQL); subconsultas en WHERE.

Ejemplo:
DELETE FROM alumnos WHERE id = 1;
SELECT — consulta de datos
Recupera columnas y filas; puede combinar tablas, ordenar resultados y calcular agregados.

Sintaxis general:
SELECT [DISTINCT] expresión [AS alias], ...
FROM tabla [JOIN otra_tabla ON condición]
[WHERE condición]
[GROUP BY expresión, ...]
[HAVING condición]
[ORDER BY expresión [ASC | DESC]]
[LIMIT n [OFFSET m]];
Parámetros: DISTINCT elimina duplicados; JOIN relaciona tablas; WHERE filtra filas; GROUP BY agrupa; HAVING filtra grupos; ORDER BY ordena.

Restricciones y precauciones: Las columnas no agregadas en una consulta agrupada deben cumplir las reglas de agrupación; LIMIT/OFFSET varían por gestor.

Opciones avanzadas: CTE con WITH; subconsultas; funciones ventana OVER; UNION/INTERSECT/EXCEPT; FETCH FIRST como alternativa más estándar a LIMIT.

Ejemplo:
SELECT nombre, correo
FROM alumnos
WHERE correo IS NOT NULL
ORDER BY nombre ASC;
5. Buenas prácticas de uso
Antes de ejecutar UPDATE o DELETE, prueba la condición con SELECT. En cambios destructivos, utiliza respaldos y transacciones cuando el motor lo permita. Define claves y restricciones desde el diseño; emplea parámetros en aplicaciones para reducir riesgos de inyección SQL; verifica privilegios y compatibilidad de sintaxis entre gestores.
6. Conclusión
El LDD organiza y modifica la estructura de la base de datos, mientras que el LMD incorpora, transforma, elimina y consulta información. Conocer la sintaxis de las ocho sentencias y sus restricciones permite conservar la integridad de los datos y ejecutar operaciones de forma segura.
Fuentes consultadas
- PostgreSQL Global Development Group. (2026). SQL Commands. https://www.postgresql.org/docs/18/sql-commands.html
- PostgreSQL Global Development Group. (2026). CREATE TABLE y ALTER TABLE. https://www.postgresql.org/docs/18/sql-createtable.html ; https://www.postgresql.org/docs/18/sql-altertable.html
- PostgreSQL Global Development Group. (2026). Referencia de comandos DROP TABLE, TRUNCATE, INSERT, UPDATE, DELETE y SELECT. https://www.postgresql.org/docs/18/
