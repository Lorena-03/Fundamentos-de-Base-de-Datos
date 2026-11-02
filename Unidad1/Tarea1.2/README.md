# Unidad 1. Fundamentos de Bases de Datos

# Tarea 1.2. Clasificación y arquitectura de las bases de datos

## 1. Cuadro sinóptico: Clasificación de las bases de datos

Las bases de datos se pueden clasificar según diferentes criterios, como su ubicación, variabilidad, modelo de datos, contenido y forma de acceso o alojamiento.

```mermaid
flowchart LR
    A["CLASIFICACIÓN DE LAS BASES DE DATOS"]

    A --> B["1. SEGÚN SU UBICACIÓN"]
    A --> C["2. SEGÚN SU VARIABILIDAD"]
    A --> D["3. SEGÚN SU MODELO DE DATOS"]
    A --> E["4. SEGÚN SU CONTENIDO"]
    A --> F["5. SEGÚN SU ACCESO O ALOJAMIENTO"]

    B --> B1["Centralizadas"]
    B1 --> B11["Información en un servidor central"]
    B11 --> B12["Ejemplo: servidor de una escuela"]
    B --> B2["Distribuidas"]
    B2 --> B21["Información repartida entre varios equipos"]
    B21 --> B22["Ejemplo: sucursales en distintas ciudades"]

    C --> C1["Estáticas"]
    C1 --> C11["Datos sin cambios frecuentes"]
    C11 --> C12["Ejemplo: registros históricos de temperaturas"]
    C --> C2["Dinámicas"]
    C2 --> C21["Permiten insertar, actualizar y eliminar información"]
    C21 --> C22["Ejemplo: inventario de una tienda"]

    D --> D1["Jerárquicas"]
    D1 --> D11["Estructura de árbol"]
    D --> D2["En red"]
    D2 --> D21["Registros relacionados con múltiples registros"]
    D --> D3["Relacionales"]
    D3 --> D31["Datos organizados en tablas"]
    D --> D4["Orientadas a objetos"]
    D4 --> D41["Información representada mediante objetos"]
    D --> D5["NoSQL"]
    D5 --> D51["Documentos, clave-valor, grafos y columnas anchas"]
    D5 --> D52["Ejemplos: MongoDB y bases de datos de grafos"]

    E --> E1["Bibliográficas"]
    E1 --> E11["Referencias de libros, artículos y publicaciones"]
    E --> E2["Texto completo"]
    E2 --> E21["Almacenan documentos completos"]
    E --> E3["Multimedia"]
    E3 --> E31["Administran imágenes, audio y video"]
    E --> E4["Científicas o estadísticas"]
    E4 --> E41["Datos para investigación y análisis"]

    F --> F1["Locales"]
    F1 --> F11["Se utilizan desde un equipo local"]
    F --> F2["En red"]
    F2 --> F21["Acceso mediante una red de computadoras"]
    F --> F3["En la nube"]
    F3 --> F31["Alojadas en infraestructura de un proveedor"]

    classDef principal fill:#d9efff,stroke:#17618a,stroke-width:2px,color:#174d6b
    classDef categoria fill:#c9f0e5,stroke:#15936f,stroke-width:2px,color:#174d6b
    classDef detalle fill:#f4f5f8,stroke:#8a9aa5,color:#303747

    class A principal
    class B,C,D,E,F categoria
    class B1,B2,C1,C2,D1,D2,D3,D4,D5,E1,E2,E3,E4,F1,F2,F3 detalle
```

---

## 2. Arquitectura funcional interna del SGBD

Este esquema representa los componentes internos de un Sistema Gestor de Bases de Datos (SGBD) y cómo se comunican para procesar las solicitudes de los usuarios y administrar la información.

```mermaid
flowchart TB
    A["USUARIOS Y APLICACIONES<br/>Solicitudes SQL · Aplicaciones · Administradores"]

    B["1. PROCESADOR DE CONSULTAS<br/>Analiza SQL, valida instrucciones, optimiza consultas y coordina su ejecución."]

    C["2. MÓDULOS DE CONTROL Y ADMINISTRACIÓN<br/>Gestor de transacciones · Gestor de seguridad<br/>Control de integridad y concurrencia<br/>Catálogo de metadatos"]

    D["3. GESTOR DE ALMACENAMIENTO<br/>Administra archivos, índices, búferes y acceso a los datos."]

    E["4. ALMACENAMIENTO FÍSICO<br/>Datos · Índices · Registro de transacciones"]

    A --> B
    B <-->|Comunicación| C
    C <-->|Administración| D
    D <-->|Lectura y escritura| E

    classDef usuarios fill:#f8d8ee,stroke:#db70b3,stroke-width:2px,color:#292536
    classDef consultas fill:#c7edf0,stroke:#37b7c2,stroke-width:2px,color:#292536
    classDef control fill:#e6dcfa,stroke:#a77be7,stroke-width:2px,color:#292536
    classDef gestor fill:#ffe69b,stroke:#e6b83c,stroke-width:2px,color:#292536
    classDef fisico fill:#dff0c9,stroke:#8bbd55,stroke-width:2px,color:#292536

    class A usuarios
    class B consultas
    class C control
    class D gestor
    class E fisico
```

---

## 3. Arquitectura de tres niveles de una base de datos

La arquitectura de tres niveles permite separar la forma en que los usuarios visualizan la información, la estructura lógica de la base de datos y la manera en que los datos se almacenan físicamente.

```mermaid
flowchart TB
    A["ARQUITECTURA DE TRES NIVELES DE UNA BASE DE DATOS"]

    A --> B["NIVEL EXTERNO<br/><br/>Vistas de los usuarios<br/><br/>Administrador · Cajero · Cliente<br/><br/>Cada usuario ve la información que necesita."]

    B <-->|Comunicación| C["NIVEL CONCEPTUAL<br/><br/>Estructura lógica de la base de datos<br/><br/>Tablas · Campos · Relaciones · Restricciones"]

    C <-->|Comunicación| D["NIVEL INTERNO O FÍSICO<br/><br/>Almacenamiento de los datos<br/><br/>Archivos · Páginas · Índices<br/><br/>Estructuras de acceso"]

    classDef titulo fill:#e8d9f7,stroke:#9670c4,stroke-width:2px,color:#222
    classDef externo fill:#ffc1c8,stroke:#e87583,stroke-width:2px,color:#222
    classDef conceptual fill:#c8edf0,stroke:#578cdb,stroke-width:2px,color:#222
    classDef interno fill:#e0f0cc,stroke:#8bbd55,stroke-width:2px,color:#222

    class A titulo
    class B externo
    class C conceptual
    class D interno
```

---

