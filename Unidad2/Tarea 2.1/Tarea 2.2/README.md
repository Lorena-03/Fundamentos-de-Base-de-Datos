# Actividad 1: Diagrama de Clases UML
```mermaid
classDiagram
    class Sucursal {
        -string idSucursal
        -string nombre
        -string direccion
        -List~string~ telefonos
        +obtenerInventario()
    }

    class Empleado {
        <<abstract>>
        -string idEmpleado
        -string nombreCompleto
        -Date fechaContratacion
    }

    class Farmaceutico {
        -string cedulaProfesional
        -string especialidad
        +validarReceta()
    }

    class Cajero {
        -string turno
        -string cajaAsignada
        +procesarCobro()
    }

    class Cliente {
        -string idCliente
        -string nombre
        -string correo
        -string telefono
    }

    class Proveedor {
        -string idProveedor
        -string razonSocial
        -string direccionFiscal
    }

    class Producto {
        -string idProducto
        -string nombreComercial
        -string principioActivo
        -double precioVenta
        -boolean requiereReceta
    }

    class Lote {
        -string idLote
        -string numeroLote
        -Date fechaCaducidad
        -int stockActual
    }

    class Venta {
        -string idVenta
        -DateTime fechaHora
        -double subtotal
        -double montoTotal
        +calcularTotal()
    }

    class DetalleVenta {
        -string idDetalle
        -int cantidad
        -double subtotalLinea
        +calcularSubtotal()
    }

    class RecetaMedica {
        -string idReceta
        -string folio
        -Date fechaEmision
        -string diagnostico
    }

    class Medico {
        -string idMedico
        -string cedulaMedico
        -string nombreMedico
    }

    %% Generalización / Herencia
    Empleado <|-- Farmaceutico : es_un
    Empleado <|-- Cajero : es_un

    %% Agregaciones
    Sucursal "1" o-- "*" Empleado : labora_en
    Sucursal "1" o-- "*" Lote : almacena
    Producto "1" o-- "1..*" Lote : tiene_lotes

    %% Composición
    Venta "1" *-- "1..*" DetalleVenta : contiene

    %% Asociaciones
    Proveedor "*" -- "*" Producto : suministra
    Cliente "1" -- "0..*" Venta : realiza
    Cajero "1" -- "0..*" Venta : atiende
    Producto "1" -- "0..*" DetalleVenta : incluye
    Medico "1" -- "0..*" RecetaMedica : emite
    RecetaMedica "0..1" -- "0..1" DetalleVenta : autoriza
