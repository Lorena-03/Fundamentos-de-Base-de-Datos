## Tarea 2.1: Modelo Entidad-Relación Extendido (E-RE) — Sistema de Farmacia
```mermaid
erDiagram
    %% Definición de Entidades y Atributos Clave (sin tipos de datos)
    SUCURSAL {
        ID_Sucursal PK
        Nombre
        Direccion
        Telefonos
    }

    EMPLEADO {
        ID_Empleado PK
        NombreCompleto
        FechaContratacion
    }

    FARMACEUTICO {
        ID_Empleado PK,FK
        CedulaProfesional
        Especialidad
    }

    CAJERO {
        ID_Empleado PK,FK
        Turno
        CajaAsignada
    }

    CLIENTE {
        ID_Cliente PK
        Nombre
        Correo
        Telefono
    }

    PROVEEDOR {
        ID_Proveedor PK
        RazonSocial
        DireccionFiscal
    }

    PRODUCTO {
        ID_Producto PK
        NombreComercial
        PrincipioActivo
        PrecioVenta
        RequiereReceta
    }

    LOTE {
        ID_Lote PK
        NumeroLote
        FechaCaducidad
        StockActual
    }

    VENTA {
        ID_Venta PK
        FechaHora
        Subtotal
        MontoTotal
    }

    RECETA_MEDICA {
        ID_Receta PK
        Folio
        FechaEmision
        Diagnostico
    }

    MEDICO {
        ID_Medico PK
        CedulaMedico
        NombreMedico
    }

    DETALLE_VENTA {
        ID_Detalle PK
        Cantidad
        SubtotalLinea
    }

    %% Jerarquía / Especialización de Empleado (1 a 0..1)
    EMPLEADO ||--o| FARMACEUTICO : "es_un (1:0..1)"
    EMPLEADO ||--o| CAJERO : "es_un (1:0..1)"

    %% Relaciones del Sistema con Cardinalidad Explícita
    SUCURSAL ||--|{ EMPLEADO : "LABORA_EN (1:N)"
    SUCURSAL ||--|{ LOTE : "ALMACENA (1:N)"
    PROVEEDOR }|--|{ PRODUCTO : "SUMINISTRA (N:M)"
    PRODUCTO ||--|{ LOTE : "TIENE_LOTES (1:N)"
    
    CLIENTE ||--o{ VENTA : "REALIZA (1:N)"
    CAJERO ||--|{ VENTA : "ATIENDE (1:N)"
    
    VENTA ||--|{ DETALLE_VENTA : "CONTIENE (1:N)"
    PRODUCTO ||--o{ DETALLE_VENTA : "INCLUYE (1:N)"
    
    MEDICO ||--o{ RECETA_MEDICA : "EMITE (1:N)"
    RECETA_MEDICA |o--o| DETALLE_VENTA : "AUTORIZA (0..1:0..1)"
