## Tarea 2.1: Modelo Entidad-Relación Extendido (E-RE) — Sistema de Farmacia
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
