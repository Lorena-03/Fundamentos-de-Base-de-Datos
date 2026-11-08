
CREATE DATABASE Farmacia;
GO

USE Farmacia;
GO

-- =============================================
-- 1. SUCURSAL
-- =============================================

CREATE TABLE SUCURSAL (
    ID_Sucursal INT IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200),
    Telefonos VARCHAR(100),

    CONSTRAINT PK_SUCURSAL PRIMARY KEY (ID_Sucursal)
);
GO

-- =============================================
-- 2. EMPLEADO
-- =============================================

CREATE TABLE EMPLEADO (
    ID_Empleado INT IDENTITY(1,1),
    ID_Sucursal INT NOT NULL,
    NombreCompleto VARCHAR(150) NOT NULL,
    FechaContratacion DATE,

    CONSTRAINT PK_EMPLEADO PRIMARY KEY (ID_Empleado),

    CONSTRAINT FK_EMPLEADO_SUCURSAL
    FOREIGN KEY (ID_Sucursal)
    REFERENCES SUCURSAL(ID_Sucursal)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 3. FARMACEUTICO
-- =============================================

CREATE TABLE FARMACEUTICO (
    ID_Empleado INT,
    CedulaProfesional VARCHAR(50) NOT NULL,
    Especialidad VARCHAR(100),

    CONSTRAINT PK_FARMACEUTICO PRIMARY KEY (ID_Empleado),
    CONSTRAINT UQ_FARMACEUTICO_CEDULA UNIQUE (CedulaProfesional),

    CONSTRAINT FK_FARMACEUTICO_EMPLEADO
    FOREIGN KEY (ID_Empleado)
    REFERENCES EMPLEADO(ID_Empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 4. CAJERO
-- =============================================

CREATE TABLE CAJERO (
    ID_Empleado INT,
    Turno VARCHAR(50),
    CajaAsignada VARCHAR(50),

    CONSTRAINT PK_CAJERO PRIMARY KEY (ID_Empleado),

    CONSTRAINT FK_CAJERO_EMPLEADO
    FOREIGN KEY (ID_Empleado)
    REFERENCES EMPLEADO(ID_Empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 5. PRODUCTO
-- =============================================

CREATE TABLE PRODUCTO (
    ID_Producto INT IDENTITY(1,1),
    ID_Sucursal INT NOT NULL,
    NombreComercial VARCHAR(150) NOT NULL,
    PrincipioActivo VARCHAR(150),
    PrecioVenta DECIMAL(10,2) NOT NULL,
    RequiereReceta BIT NOT NULL,

    CONSTRAINT PK_PRODUCTO PRIMARY KEY (ID_Producto),

    CONSTRAINT CK_PRODUCTO_PRECIO
    CHECK (PrecioVenta >= 0),

    CONSTRAINT FK_PRODUCTO_SUCURSAL
    FOREIGN KEY (ID_Sucursal)
    REFERENCES SUCURSAL(ID_Sucursal)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 6. PROVEEDOR
-- =============================================

CREATE TABLE PROVEEDOR (
    ID_Proveedor INT IDENTITY(1,1),
    RazonSocial VARCHAR(150) NOT NULL,
    DireccionFiscal VARCHAR(200),

    CONSTRAINT PK_PROVEEDOR PRIMARY KEY (ID_Proveedor)
);
GO

-- =============================================
-- 7. PROVEEDOR_PRODUCTO
-- =============================================

CREATE TABLE PROVEEDOR_PRODUCTO (
    ID_Proveedor INT NOT NULL,
    ID_Producto INT NOT NULL,

    CONSTRAINT PK_PROVEEDOR_PRODUCTO
    PRIMARY KEY (ID_Proveedor, ID_Producto),

    CONSTRAINT FK_PP_PROVEEDOR
    FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_PP_PRODUCTO
    FOREIGN KEY (ID_Producto)
    REFERENCES PRODUCTO(ID_Producto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 8. LOTE
-- =============================================

CREATE TABLE LOTE (
    ID_Lote INT IDENTITY(1,1),
    ID_Producto INT NOT NULL,
    NumeroLote VARCHAR(50) NOT NULL,
    FechaCaducidad DATE,
    StockActual INT NOT NULL,

    CONSTRAINT PK_LOTE PRIMARY KEY (ID_Lote),

    CONSTRAINT CK_LOTE_STOCK
    CHECK (StockActual >= 0),

    CONSTRAINT FK_LOTE_PRODUCTO
    FOREIGN KEY (ID_Producto)
    REFERENCES PRODUCTO(ID_Producto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 9. PROVEEDOR_LOTE
-- =============================================

CREATE TABLE PROVEEDOR_LOTE (
    ID_Proveedor INT NOT NULL,
    ID_Lote INT NOT NULL,

    CONSTRAINT PK_PROVEEDOR_LOTE
    PRIMARY KEY (ID_Proveedor, ID_Lote),

    CONSTRAINT FK_PL_PROVEEDOR
    FOREIGN KEY (ID_Proveedor)
    REFERENCES PROVEEDOR(ID_Proveedor)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_PL_LOTE
    FOREIGN KEY (ID_Lote)
    REFERENCES LOTE(ID_Lote)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 10. CLIENTE
-- =============================================

CREATE TABLE CLIENTE (
    ID_Cliente INT IDENTITY(1,1),
    Nombre VARCHAR(150) NOT NULL,
    Correo VARCHAR(150),
    Telefono VARCHAR(20),

    CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_Cliente)
);
GO

-- =============================================
-- 11. MEDICO
-- =============================================

CREATE TABLE MEDICO (
    ID_Medico INT IDENTITY(1,1),
    CedulaMedico VARCHAR(50) NOT NULL,
    NombreMedico VARCHAR(150) NOT NULL,

    CONSTRAINT PK_MEDICO PRIMARY KEY (ID_Medico),
    CONSTRAINT UQ_MEDICO_CEDULA UNIQUE (CedulaMedico)
);
GO

-- =============================================
-- 12. VENTA
-- =============================================

CREATE TABLE VENTA (
    ID_Venta INT IDENTITY(1,1),
    ID_Cliente INT NOT NULL,
    ID_Producto INT NOT NULL,
    FechaHora DATETIME NOT NULL,
    Subtotal DECIMAL(10,2),
    MontoTotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_VENTA PRIMARY KEY (ID_Venta),

    CONSTRAINT CK_VENTA_SUBTOTAL
    CHECK (Subtotal IS NULL OR Subtotal >= 0),

    CONSTRAINT CK_VENTA_MONTO
    CHECK (MontoTotal >= 0),

    CONSTRAINT FK_VENTA_CLIENTE
    FOREIGN KEY (ID_Cliente)
    REFERENCES CLIENTE(ID_Cliente)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,

    CONSTRAINT FK_VENTA_PRODUCTO
    FOREIGN KEY (ID_Producto)
    REFERENCES PRODUCTO(ID_Producto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
GO

-- =============================================
-- 13. RECETA_MEDICA
-- =============================================

CREATE TABLE RECETA_MEDICA (
    ID_Receta INT IDENTITY(1,1),
    ID_Medico INT NOT NULL,
    Folio VARCHAR(50) NOT NULL,
    FechaEmision DATE NOT NULL,
    Diagnostico VARCHAR(250),

    CONSTRAINT PK_RECETA_MEDICA PRIMARY KEY (ID_Receta),

    CONSTRAINT FK_RECETA_MEDICO
    FOREIGN KEY (ID_Medico)
    REFERENCES MEDICO(ID_Medico)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);
GO
-- =============================================
-- 14 Detalle venta
-- =============================================

CREATE TABLE DETALLE_VENTA (
    ID_Detalle INT IDENTITY(1,1),
    ID_Venta INT NOT NULL,
    ID_Lote INT NOT NULL,
    ID_Medico INT NULL,
    Cantidad INT NOT NULL,
    SubtotalLinea DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_DETALLE_VENTA
    PRIMARY KEY (ID_Detalle),

    CONSTRAINT CK_DETALLE_CANTIDAD
    CHECK (Cantidad > 0),

    CONSTRAINT CK_DETALLE_SUBTOTAL
    CHECK (SubtotalLinea >= 0),

    CONSTRAINT FK_DETALLE_VENTA
    FOREIGN KEY (ID_Venta)
    REFERENCES VENTA(ID_Venta)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_DETALLE_LOTE
    FOREIGN KEY (ID_Lote)
    REFERENCES LOTE(ID_Lote)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

    CONSTRAINT FK_DETALLE_MEDICO
    FOREIGN KEY (ID_Medico)
    REFERENCES MEDICO(ID_Medico)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
GO
-- =============================================
-- INDICE UNICO PARA ID_MEDICO
-- PERMITE VARIOS VALORES NULL
-- =============================================

CREATE UNIQUE INDEX UX_DETALLE_MEDICO
ON DETALLE_VENTA(ID_Medico)
WHERE ID_Medico IS NOT NULL;
GO

-- =============================================
-- VALIDACION DE TABLAS
-- =============================================

SELECT
    TABLE_NAME AS NombreTabla
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

-- =============================================
-- VALIDACION DE LLAVES FORANEAS
-- =============================================

SELECT
    name AS NombreFK,
    OBJECT_NAME(parent_object_id) AS Tabla
FROM sys.foreign_keys
ORDER BY Tabla;
GO

-- =============================================
-- VALIDACION DE RESTRICCIONES CHECK
-- =============================================

SELECT
    name AS NombreCHECK,
    OBJECT_NAME(parent_object_id) AS Tabla
FROM sys.check_constraints
ORDER BY Tabla;
GO

PRINT 'BASE DE DATOS FARMACIA CREADA CORRECTAMENTE';
GO
