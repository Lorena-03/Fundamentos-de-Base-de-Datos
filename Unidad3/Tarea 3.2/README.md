## Tarea 3.2: Generación del esquema físico en SGBD y script LDD

En el siguiente diagrama representa el modelo relacional de la base de datos Farmacia, incluyendo sus 14 tablas, atributos, claves primarias y claves foráneas.

```mermaid
erDiagram

    SUCURSAL {
        INT ID_Sucursal PK
        VARCHAR Nombre
        VARCHAR Direccion
        VARCHAR Telefonos
    }

    EMPLEADO {
        INT ID_Empleado PK
        INT ID_Sucursal FK
        VARCHAR NombreCompleto
        DATE FechaContratacion
    }

    FARMACEUTICO {
        INT ID_Empleado PK, FK
        VARCHAR CedulaProfesional UK
        VARCHAR Especialidad
    }

    CAJERO {
        INT ID_Empleado PK, FK
        VARCHAR Turno
        VARCHAR CajaAsignada
    }

    PRODUCTO {
        INT ID_Producto PK
        INT ID_Sucursal FK
        VARCHAR NombreComercial
        VARCHAR PrincipioActivo
        DECIMAL PrecioVenta
        BIT RequiereReceta
    }

    PROVEEDOR {
        INT ID_Proveedor PK
        VARCHAR RazonSocial
        VARCHAR DireccionFiscal
    }

    PROVEEDOR_PRODUCTO {
        INT ID_Proveedor PK, FK
        INT ID_Producto PK, FK
    }

    LOTE {
        INT ID_Lote PK
        INT ID_Producto FK
        VARCHAR NumeroLote
        DATE FechaCaducidad
        INT StockActual
    }

    PROVEEDOR_LOTE {
        INT ID_Proveedor PK, FK
        INT ID_Lote PK, FK
    }

    CLIENTE {
        INT ID_Cliente PK
        VARCHAR Nombre
        VARCHAR Correo
        VARCHAR Telefono
    }

    MEDICO {
        INT ID_Medico PK
        VARCHAR CedulaMedico UK
        VARCHAR NombreMedico
    }

    VENTA {
        INT ID_Venta PK
        INT ID_Cliente FK
        INT ID_Producto FK
        DATETIME FechaHora
        DECIMAL Subtotal
        DECIMAL MontoTotal
    }

    RECETA_MEDICA {
        INT ID_Receta PK
        INT ID_Medico FK
        VARCHAR Folio
        DATE FechaEmision
        VARCHAR Diagnostico
    }

    DETALLE_VENTA {
        INT ID_Detalle PK
        INT ID_Venta FK
        INT ID_Lote FK
        INT ID_Medico FK
        INT Cantidad
        DECIMAL SubtotalLinea
    }

    SUCURSAL ||--o{ EMPLEADO : tiene
    SUCURSAL ||--o{ PRODUCTO : registra

    EMPLEADO ||--o| FARMACEUTICO : especializa
    EMPLEADO ||--o| CAJERO : especializa

    PROVEEDOR ||--o{ PROVEEDOR_PRODUCTO : suministra
    PRODUCTO ||--o{ PROVEEDOR_PRODUCTO : recibe

    PRODUCTO ||--o{ LOTE : contiene

    PROVEEDOR ||--o{ PROVEEDOR_LOTE : suministra
    LOTE ||--o{ PROVEEDOR_LOTE : recibe

    CLIENTE ||--o{ VENTA : realiza
    PRODUCTO ||--o{ VENTA : incluye

    MEDICO ||--o{ RECETA_MEDICA : emite

    VENTA ||--o{ DETALLE_VENTA : contiene
    LOTE ||--o{ DETALLE_VENTA : corresponde
    MEDICO o|--o{ DETALLE_VENTA : supervisa
```

## Descripción

La base de datos está compuesta por 14 tablas relacionadas mediante claves primarias (PK) y claves foráneas (FK). Su estructura permite administrar sucursales, empleados, productos, proveedores, lotes, clientes, médicos, recetas médicas y ventas.

Las tablas `PROVEEDOR_PRODUCTO` y `PROVEEDOR_LOTE` permiten representar relaciones de muchos a muchos.
