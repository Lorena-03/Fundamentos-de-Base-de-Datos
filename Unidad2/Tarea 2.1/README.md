## Tarea 2.1: Modelo Entidad-Relación Extendido (E-RE) — Sistema de Farmacia
```mermaid
erDiagram
    SUCURSAL {
        string ID_Sucursal
        string Nombre
        string Direccion
        string Telefonos
    }

    EMPLEADO {
        string ID_Empleado
        string NombreCompleto
        string FechaContratacion
    }

    FARMACEUTICO {
        string ID_Empleado
        string CedulaProfesional
        string Especialidad
    }

    CAJERO {
        string ID_Empleado
        string Turno
        string CajaAsignada
    }

    CLIENTE {
        string ID_Cliente
        string Nombre
        string Correo
        string Telefono
    }

    PROVEEDOR {
        string ID_Proveedor
        string RazonSocial
        string DireccionFiscal
    }

    PRODUCTO {
        string ID_Producto
        string NombreComercial
        string PrincipioActivo
        string PrecioVenta
        string RequiereReceta
    }

    LOTE {
        string ID_Lote
        string NumeroLote
        string FechaCaducidad
        string StockActual
    }

    VENTA {
        string ID_Venta
        string FechaHora
        string Subtotal
        string MontoTotal
    }

    RECETA_MEDICA {
        string ID_Receta
        string Folio
        string FechaEmision
        string Diagnostico
    }

    MEDICO {
        string ID_Medico
        string CedulaMedico
        string NombreMedico
    }

    DETALLE_VENTA {
        string ID_Detalle
        string Cantidad
        string SubtotalLinea
    }

    %% Relaciones y Cardinalidad
    EMPLEADO ||--o| FARMACEUTICO : "es_un (1:0..1)"
    EMPLEADO ||--o| CAJERO : "es_un (1:0..1)"
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
