```mermaid
graph TD
    %% Título principal y definición
    BasesDatos["<b>BASES DE DATOS</b><br><i>es</i>"] --> Desc["Conjunto organizado de información almacenada electrónicamente, que permite su administración, consulta y actualización de manera eficiente y segura."]

    %% Conexión a las cuatro categorías principales
    Desc --> Char["<i>se caracteriza por</i>"]
    
    Char --> Conceptos["<b>CONCEPTOS FUNDAMENTALES</b><br><i>incluye</i>"]
    Char --> Objetivos["<b>OBJETIVOS</b><br><i>son</i>"]
    Char --> Usos["<b>USOS</b><br><i>se utilizan para</i>"]
    Char --> Areas["<b>ÁREAS DE APLICACIÓN</b><br><i>se aplican en</i>"]

    %% Contenido de Conceptos Fundamentales
    subgraph S_Conceptos [Conceptos Fundamentales]
        C1["<b>Dato:</b> valor individual que representa un hecho."]
        C2["<b>Información:</b> conjunto de datos organizados con significado."]
        C3["<b>Tabla:</b> estructura que almacena datos relacionados en filas y columnas."]
        C4["<b>Registro:</b> fila que contiene los datos de un elemento."]
        C5["<b>Campo:</b> columna que representa una característica."]
        C6["<b>Clave primaria:</b> identifica de manera única cada registro."]
        C7["<b>Clave foránea:</b> relaciona registros de distintas tablas."]
        C8["<b>SGBD:</b> software que permite crear, consultar, modificar y administrar bases de datos."]
    end
    Conceptos --> S_Conceptos

    %% Contenido de Objetivos
    subgraph S_Objetivos [Objetivos]
        O1["Organizar la información de manera estructurada."]
        O2["Evitar la redundancia innecesaria de datos."]
        O3["Mantener la integridad y consistencia de la información."]
        O4["Facilitar el acceso, consulta y actualización de los datos."]
        O5["Garantizar la seguridad y control de la información."]
        O6["Proporcionar información confiable para la toma de decisiones."]
    end
    Objetivos --> S_Objetivos

    %% Contenido de Usos
    subgraph S_Usos [Usos]
        U1["Registrar y almacenar datos de manera organizada."]
        U2["Buscar y recuperar información rápidamente."]
        U3["Modificar y mantener datos actualizados."]
        U4["Generar reportes y análisis."]
        U5["Compartir información entre usuarios de forma controlada."]
        U6["Automatizar procesos de diferentes áreas."]
    end
    Usos --> S_Usos

    %% Contenido de Áreas de Aplicación
    subgraph S_Areas [Áreas de Aplicación]
        A1["<b>Educación:</b> control de estudiantes, calificaciones, horarios."]
        A2["<b>Salud:</b> expedientes clínicos, citas, inventarios de medicamentos."]
        A3["<b>Banca:</b> cuentas, transacciones, clientes."]
        A4["<b>Comercio:</b> ventas, inventarios, pedidos."]
        A5["<b>Transporte:</b> reservaciones, rutas, vuelos."]
        A6["<b>Gobierno:</b> registros civiles, padrones, trámites."]
        A7["<b>Empresas:</b> gestión de clientes, empleados y recursos."]
        A8["<b>Investigación:</b> almacenamiento y análisis de datos."]
    end
    Areas --> S_Areas

    %% Resultado final
    S_Conceptos --> ResCon["<i>permiten obtener</i>"]
    S_Objetivos --> ResCon
    S_Usos --> ResCon
    S_Areas --> ResCon

    ResCon --> Resultado["<b>RESULTADO</b><br>Información organizada, confiable, disponible y útil para la toma de decisiones."]

    %% Estilos opcionales para asemejarse a los colores originales
    style BasesDatos fill:#d8b4fe,stroke:#333,stroke-width:2px;
    style Desc fill:#fbcfe8,stroke:#333,stroke-width:1px;
    style Conceptos fill:#bae6fd,stroke:#333,stroke-width:2px;
    style Objetivos fill:#bbf7d0,stroke:#333,stroke-width:2px;
    style Usos fill:#fef08a,stroke:#333,stroke-width:2px;
    style Areas fill:#fbcfe8,stroke:#333,stroke-width:2px;
    style Resultado fill:#d8b4fe,stroke:#333,stroke-width:2px;
