```mermaid
erDiagram
    %% Definición de Entidades y Atributos Clave
    SUCURSAL {
        string ID_Sucursal PK
        string Nombre
        string Direccion
        string Telefonos
    }

    EMPLEADO {
        string ID_Empleado PK
        string NombreCompleto
        date FechaContratacion
    }

    FARMACEUTICO {
        string ID_Empleado PK,FK
        string CedulaProfesional
        string Especialidad
    }

    CAJERO {
        string ID_Empleado PK,FK
        string Turno
        string CajaAsignada
    }

    CLIENTE {
        string ID_Cliente PK
        string Nombre
        string Correo
        string Telefono
    }

    PROVEEDOR {
        string ID_Proveedor PK
        string RazonSocial
        string DireccionFiscal
    }

    PRODUCTO {
        string ID_Producto PK
        string NombreComercial
        string PrincipioActivo
        float PrecioVenta
        boolean RequiereReceta
    }

    LOTE {
        string ID_Lote PK
        string NumeroLote
        date FechaCaducidad
        int StockActual
    }

    VENTA {
        string ID_Venta PK
        datetime FechaHora
        float Subtotal
        float MontoTotal
    }

    RECETA_MEDICA {
        string ID_Receta PK
        string Folio
        date FechaEmision
        string Diagnostico
    }

    MEDICO {
        string ID_Medico PK
        string CedulaMedico
        string NombreMedico
    }

    DETALLE_VENTA {
        string ID_Detalle PK
        int Cantidad
        float SubtotalLinea
    }

    %% Jerarquía / Especialización de Empleado
    EMPLEADO ||--o| FARMACEUTICO : "es_un"
    EMPLEADO ||--o| CAJERO : "es_un"

    %% Relaciones del Sistema con Cardinalidad
    SUCURSAL ||--|{ EMPLEADO : "LABORA_EN"
    SUCURsal ||--|{ LOTE : "ALMACENA"
    PROVEEDOR }|--|{ PRODUCTO : "SUMINISTRA"
    PRODUCTO ||--|{ LOTE : "TIENE_LOTES"
    
    CLIENTE ||--o{ VENTA : "REALIZA"
    CAJERO ||--|{ VENTA : "ATIENDE"
    
    VENTA ||--|{ DETALLE_VENTA : "CONTIENE"
    PRODUCTO ||--o{ DETALLE_VENTA : "INCLUYE"
    
    MEDICO ||--o{ RECETA_MEDICA : "EMITE"
    RECETA_MEDICA |o--o| DETALLE_VENTA : "AUTORIZA"
