# Tarea 4.2: Proceso paso a paso de normalización del proyecto aplicado

##  Descripción
En esta actividad se realiza el proceso de **normalización de una base de datos**, con el propósito de organizar la información, eliminar datos repetidos y evitar errores al insertar, modificar o eliminar registros.

##  Proceso de normalización

### 1. Estado desnormalizado a Primera Forma Normal (1FN)
Se eliminan los grupos de datos repetitivos y se asegura que cada campo contenga un solo valor (atomicidad). Además, se establece una clave primaria para identificar cada registro.

### 2. Primera Forma Normal (1FN) a Segunda Forma Normal (2FN)
Se eliminan las dependencias funcionales parciales, asegurando que todos los atributos que no forman parte de una clave dependan de la clave completa.

### 3. Segunda Forma Normal (2FN) a Tercera Forma Normal (3FN)
Se eliminan las dependencias transitivas, separando los atributos que dependen de otros atributos que no son clave, para mejorar la organización de las tablas.

### 4. Validación de la Forma Normal de Boyce-Codd (FNBC)
Se verifica que en todas las dependencias funcionales no triviales, el atributo o conjunto de atributos determinante sea una superclave, garantizando una estructura más consistente.

##  Implementación SQL
Una vez terminado el proceso de normalización, se genera un **script SQL corregido** que contiene las tablas normalizadas, sus claves primarias y foráneas, así como las relaciones necesarias para mantener la integridad de los datos.

## Objetivo
Aplicar correctamente las formas normales para obtener una base de datos eficiente, reducir la redundancia y garantizar la integridad de la información.

##  Resultado esperado
Obtener un diseño de base de datos normalizado hasta 3FN, verificando el cumplimiento de FNBC cuando corresponda, junto con su respectivo script SQL.
