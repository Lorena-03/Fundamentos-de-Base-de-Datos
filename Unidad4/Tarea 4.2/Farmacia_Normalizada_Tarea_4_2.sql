USE master;
GO
CREATE DATABASE Farmacia_Normalizada;
GO
USE Farmacia_Normalizada;
GO
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET XACT_ABORT ON;
GO

-- SUCURSAL
CREATE TABLE dbo.SUCURSAL (
ID_Sucursal INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NULL,
    CONSTRAINT PK_SUCURSAL PRIMARY KEY (ID_Sucursal)
);
GO

-- SUCURSAL_TELEFONO
CREATE TABLE dbo.SUCURSAL_TELEFONO (
ID_Sucursal INT NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    CONSTRAINT PK_SUCURSAL_TELEFONO
        PRIMARY KEY (ID_Sucursal, Telefono),
    CONSTRAINT CK_ST_TELEFONO
        CHECK (LEN(LTRIM(RTRIM(Telefono))) > 0),
    CONSTRAINT FK_ST_SUCURSAL FOREIGN KEY (ID_Sucursal)
        REFERENCES dbo.SUCURSAL(ID_Sucursal)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- EMPLEADO
CREATE TABLE dbo.EMPLEADO (
ID_Empleado INT IDENTITY(1,1) NOT NULL,
    ID_Sucursal INT NOT NULL,
    NombreCompleto VARCHAR(150) NOT NULL,
    FechaContratacion DATE NULL,
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (ID_Empleado),
    CONSTRAINT FK_EMPLEADO_SUCURSAL FOREIGN KEY (ID_Sucursal)
        REFERENCES dbo.SUCURSAL(ID_Sucursal)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- FARMACEUTICO
CREATE TABLE dbo.FARMACEUTICO (
ID_Empleado INT NOT NULL,
    CedulaProfesional VARCHAR(50) NOT NULL,
    Especialidad VARCHAR(100) NULL,
    CONSTRAINT PK_FARMACEUTICO PRIMARY KEY (ID_Empleado),
    CONSTRAINT UQ_FARMACEUTICO_CEDULA
        UNIQUE (CedulaProfesional),
    CONSTRAINT FK_FARMACEUTICO_EMPLEADO FOREIGN KEY (ID_Empleado)
        REFERENCES dbo.EMPLEADO(ID_Empleado)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- CAJERO
CREATE TABLE dbo.CAJERO (
ID_Empleado INT NOT NULL,
    Turno VARCHAR(50) NULL,
    CajaAsignada VARCHAR(50) NULL,
    CONSTRAINT PK_CAJERO PRIMARY KEY (ID_Empleado),
    CONSTRAINT FK_CAJERO_EMPLEADO FOREIGN KEY (ID_Empleado)
        REFERENCES dbo.EMPLEADO(ID_Empleado)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- PRODUCTO
CREATE TABLE dbo.PRODUCTO (
ID_Producto INT IDENTITY(1,1) NOT NULL,
    ID_Sucursal INT NOT NULL,
    NombreComercial VARCHAR(150) NOT NULL,
    PrincipioActivo VARCHAR(150) NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    RequiereReceta BIT NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY (ID_Producto),
    CONSTRAINT CK_PRODUCTO_PRECIO CHECK (PrecioVenta >= 0),
    CONSTRAINT FK_PRODUCTO_SUCURSAL FOREIGN KEY (ID_Sucursal)
        REFERENCES dbo.SUCURSAL(ID_Sucursal)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- PROVEEDOR
CREATE TABLE dbo.PROVEEDOR (
ID_Proveedor INT IDENTITY(1,1) NOT NULL,
    RazonSocial VARCHAR(150) NOT NULL,
    DireccionFiscal VARCHAR(200) NULL,
    CONSTRAINT PK_PROVEEDOR PRIMARY KEY (ID_Proveedor)
);
GO

-- PROVEEDOR_PRODUCTO
CREATE TABLE dbo.PROVEEDOR_PRODUCTO (
ID_Proveedor INT NOT NULL,
    ID_Producto INT NOT NULL,
    CONSTRAINT PK_PROVEEDOR_PRODUCTO
        PRIMARY KEY (ID_Proveedor, ID_Producto),
    CONSTRAINT FK_PP_PROVEEDOR FOREIGN KEY (ID_Proveedor)
        REFERENCES dbo.PROVEEDOR(ID_Proveedor)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_PP_PRODUCTO FOREIGN KEY (ID_Producto)
        REFERENCES dbo.PRODUCTO(ID_Producto)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- LOTE
CREATE TABLE dbo.LOTE (
ID_Lote INT IDENTITY(1,1) NOT NULL,
    ID_Producto INT NOT NULL,
    NumeroLote VARCHAR(50) NOT NULL,
    FechaCaducidad DATE NULL,
    StockActual INT NOT NULL,
    CONSTRAINT PK_LOTE PRIMARY KEY (ID_Lote),
    CONSTRAINT UQ_LOTE_PRODUCTO_NUMERO
        UNIQUE (ID_Producto, NumeroLote),
    CONSTRAINT CK_LOTE_STOCK CHECK (StockActual >= 0),
    CONSTRAINT FK_LOTE_PRODUCTO FOREIGN KEY (ID_Producto)
        REFERENCES dbo.PRODUCTO(ID_Producto)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- PROVEEDOR_LOTE
CREATE TABLE dbo.PROVEEDOR_LOTE (
ID_Proveedor INT NOT NULL,
    ID_Lote INT NOT NULL,
    CONSTRAINT PK_PROVEEDOR_LOTE
        PRIMARY KEY (ID_Proveedor, ID_Lote),
    CONSTRAINT FK_PL_PROVEEDOR FOREIGN KEY (ID_Proveedor)
        REFERENCES dbo.PROVEEDOR(ID_Proveedor)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_PL_LOTE FOREIGN KEY (ID_Lote)
        REFERENCES dbo.LOTE(ID_Lote)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- CLIENTE
CREATE TABLE dbo.CLIENTE (
ID_Cliente INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Correo VARCHAR(150) NULL,
    Telefono VARCHAR(20) NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_Cliente)
);
GO

-- MEDICO
CREATE TABLE dbo.MEDICO (
ID_Medico INT IDENTITY(1,1) NOT NULL,
    CedulaMedico VARCHAR(50) NOT NULL,
    NombreMedico VARCHAR(150) NOT NULL,
    CONSTRAINT PK_MEDICO PRIMARY KEY (ID_Medico),
    CONSTRAINT UQ_MEDICO_CEDULA UNIQUE (CedulaMedico)
);
GO

-- VENTA
CREATE TABLE dbo.VENTA (
ID_Venta INT IDENTITY(1,1) NOT NULL,
    ID_Cliente INT NOT NULL,
    FechaHora DATETIME2(0) NOT NULL,
    CONSTRAINT PK_VENTA PRIMARY KEY (ID_Venta),
    CONSTRAINT FK_VENTA_CLIENTE FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.CLIENTE(ID_Cliente)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- RECETA_MEDICA
CREATE TABLE dbo.RECETA_MEDICA (
ID_Receta INT IDENTITY(1,1) NOT NULL,
    ID_Medico INT NOT NULL,
    Folio VARCHAR(50) NOT NULL,
    FechaEmision DATE NOT NULL,
    Diagnostico VARCHAR(250) NULL,
    CONSTRAINT PK_RECETA_MEDICA PRIMARY KEY (ID_Receta),
    CONSTRAINT FK_RECETA_MEDICO FOREIGN KEY (ID_Medico)
        REFERENCES dbo.MEDICO(ID_Medico)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- DETALLE_VENTA
CREATE TABLE dbo.DETALLE_VENTA (
ID_Detalle INT IDENTITY(1,1) NOT NULL,
    ID_Venta INT NOT NULL,
    NumeroLinea INT NOT NULL,
    ID_Lote INT NOT NULL,
    ID_Medico INT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitarioVenta DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_DETALLE_VENTA PRIMARY KEY (ID_Detalle),
    CONSTRAINT UQ_DETALLE_VENTA_LINEA
        UNIQUE (ID_Venta, NumeroLinea),
    CONSTRAINT CK_DETALLE_LINEA CHECK (NumeroLinea > 0),
    CONSTRAINT CK_DETALLE_CANTIDAD CHECK (Cantidad > 0),
    CONSTRAINT CK_DETALLE_PRECIO CHECK (PrecioUnitarioVenta >= 0),
    CONSTRAINT FK_DETALLE_VENTA FOREIGN KEY (ID_Venta)
        REFERENCES dbo.VENTA(ID_Venta)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_DETALLE_LOTE FOREIGN KEY (ID_Lote)
        REFERENCES dbo.LOTE(ID_Lote)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_DETALLE_MEDICO FOREIGN KEY (ID_Medico)
        REFERENCES dbo.MEDICO(ID_Medico)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- Indice de busqueda sin unicidad: el medico puede repetirse.
CREATE INDEX IX_DETALLE_MEDICO
    ON dbo.DETALLE_VENTA(ID_Medico);
GO

-- VW_DETALLE_IMPORTES
CREATE VIEW dbo.VW_DETALLE_IMPORTES
AS
SELECT d.ID_Detalle, d.ID_Venta, d.NumeroLinea,
       d.ID_Lote, l.ID_Producto, d.ID_Medico,
       d.Cantidad, d.PrecioUnitarioVenta,
       CAST(d.Cantidad * d.PrecioUnitarioVenta
            AS DECIMAL(28,2)) AS SubtotalLinea
FROM dbo.DETALLE_VENTA AS d
INNER JOIN dbo.LOTE AS l ON l.ID_Lote = d.ID_Lote;
GO

-- VW_VENTA_TOTALES
CREATE VIEW dbo.VW_VENTA_TOTALES
AS
SELECT v.ID_Venta, v.ID_Cliente, v.FechaHora,
       COALESCE(t.Subtotal, CAST(0 AS DECIMAL(38,2))) AS Subtotal,
       COALESCE(t.Subtotal, CAST(0 AS DECIMAL(38,2))) AS MontoTotal
FROM dbo.VENTA AS v
LEFT JOIN (
    SELECT ID_Venta, SUM(SubtotalLinea) AS Subtotal
    FROM dbo.VW_DETALLE_IMPORTES
    GROUP BY ID_Venta
) AS t ON t.ID_Venta = v.ID_Venta;
GO

-- Inspeccion de la estructura creada.
SELECT name AS Tabla FROM sys.tables ORDER BY name;
SELECT name AS Vista FROM sys.views ORDER BY name;
SELECT name AS ClaveForanea, OBJECT_NAME(parent_object_id) AS Tabla
FROM sys.foreign_keys ORDER BY Tabla, name;
SELECT name AS Restriccion, OBJECT_NAME(parent_object_id) AS Tabla
FROM sys.check_constraints ORDER BY Tabla, name;
GO

-- =====================================================
-- PRUEBAS TRANSACCIONALES OPCIONALES
-- =====================================================
-- Prueba opcional: ejecutar este bloque completo.
-- Los registros se revierten; IDENTITY puede dejar saltos.
BEGIN TRY
    BEGIN TRANSACTION;
    DECLARE @S INT, @C INT, @M INT, @P1 INT, @P2 INT;
    DECLARE @L1 INT, @L2 INT, @V1 INT, @V2 INT;

    INSERT dbo.SUCURSAL(Nombre) VALUES ('Prueba Centro');
    SET @S = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.SUCURSAL_TELEFONO VALUES
        (@S, '8661112233'), (@S, '8664445566');
    INSERT dbo.CLIENTE(Nombre) VALUES ('Cliente de prueba');
    SET @C = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.MEDICO(CedulaMedico, NombreMedico)
        VALUES ('PRUEBA-T42', 'Medico de prueba');
    SET @M = CONVERT(INT, SCOPE_IDENTITY());

    INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial,
        PrecioVenta, RequiereReceta)
        VALUES (@S, 'Producto A', 25.00, 0);
    SET @P1 = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial,
        PrecioVenta, RequiereReceta)
        VALUES (@S, 'Producto B', 35.00, 0);
    SET @P2 = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.LOTE(ID_Producto, NumeroLote, StockActual)
        VALUES (@P1, 'T42-A', 100);
    SET @L1 = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.LOTE(ID_Producto, NumeroLote, StockActual)
        VALUES (@P2, 'T42-B', 100);
    SET @L2 = CONVERT(INT, SCOPE_IDENTITY());

    INSERT dbo.VENTA(ID_Cliente, FechaHora)
        VALUES (@C, '2026-11-19T10:00:00');
    SET @V1 = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.VENTA(ID_Cliente, FechaHora)
        VALUES (@C, '2026-11-19T11:00:00');
    SET @V2 = CONVERT(INT, SCOPE_IDENTITY());
    INSERT dbo.DETALLE_VENTA(ID_Venta, NumeroLinea, ID_Lote,
        ID_Medico, Cantidad, PrecioUnitarioVenta)
        VALUES (@V1, 1, @L1, @M, 2, 25.00),
               (@V1, 2, @L2, NULL, 1, 35.00),
               (@V2, 1, @L1, @M, 1, 25.00);

    IF (SELECT COUNT(*) FROM dbo.SUCURSAL_TELEFONO
        WHERE ID_Sucursal = @S) <> 2
        THROW 51001, 'Error en telefonos atomicos.', 1;
    IF (SELECT COUNT(DISTINCT ID_Producto)
        FROM dbo.VW_DETALLE_IMPORTES WHERE ID_Venta = @V1) <> 2
        THROW 51002, 'Error en venta con varios productos.', 1;
    IF (SELECT COUNT(*) FROM dbo.DETALLE_VENTA
        WHERE ID_Medico = @M) <> 2
        THROW 51003, 'Error al reutilizar un medico.', 1;
    IF (SELECT MontoTotal FROM dbo.VW_VENTA_TOTALES
        WHERE ID_Venta = @V1) <> 85.00
        THROW 51004, 'Total de venta incorrecto.', 1;

    UPDATE dbo.PRODUCTO SET PrecioVenta = 30.00
        WHERE ID_Producto = @P1;
    IF (SELECT MontoTotal FROM dbo.VW_VENTA_TOTALES
        WHERE ID_Venta = @V1) <> 85.00
        THROW 51005, 'Se altero el precio historico.', 1;

    SELECT * FROM dbo.VW_DETALLE_IMPORTES
        WHERE ID_Venta IN (@V1, @V2) ORDER BY ID_Venta, NumeroLinea;
    SELECT * FROM dbo.VW_VENTA_TOTALES
        WHERE ID_Venta IN (@V1, @V2) ORDER BY ID_Venta;
    ROLLBACK TRANSACTION;
    PRINT 'Pruebas aprobadas; registros de prueba revertidos.';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO
