## Tarea 2.1: Modelo Entidad-Relación Extendido (E-RE) — Sistema de Farmacia
```mermaid
erDiagram
    SUCURSAL {
        ID_Sucursal
        Nombre
        Direccion
        Telefonos
    }

    EMPLEADO {
        ID_Empleado
        NombreCompleto
        FechaContratacion
    }

    FARMACEUTICO {
        ID_Empleado
        CedulaProfesional
        Especialidad
    }

    CAJERO {
        ID_Empleado
        Turno
        CajaAsignada
    }

    CLIENTE {
        ID_Cliente
        Nombre
        Correo
        Telefono
    }

    PROVEEDOR {
        ID_Proveedor
        RazonSocial
        DireccionFiscal
    }

    PRODUCTO {
        ID_Producto
        NombreComercial
        PrincipioActivo
        PrecioVenta
        RequiereReceta
    }

    LOTE {
        ID_Lote
        NumeroLote
        FechaCaducidad
        StockActual
    }

    VENTA {
        ID_Venta
        FechaHora
        Subtotal
        MontoTotal
    }

    RECETA_MEDICA {
        ID_Receta
        Folio
        FechaEmision
        Diagnostico
    }

    MEDICO {
        ID_Medico
        CedulaMedico
        NombreMedico
    }

    DETALLE_VENTA {
        ID_Detalle
        Cantidad
        SubtotalLinea
    }

  %% Jerarquía / Especialización con cardinalidad explícita
    EMPLEADO ||--o| FARMACEUTICO : "es_un (1:0..1)"
    EMPLEADO ||--o| CAJERO : "es_un (1:0..1)"

    %% Relaciones del Sistema con cardinalidad explícita
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
