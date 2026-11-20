/* ============================================================================
   TAREA 5.2 - FARMACIA_NORMALIZADA
   Archivo: Tarea_5_2_Farmacia_Datos_y_Consultas.sql
   Motor: Microsoft SQL Server (SSMS)

   REQUISITO: ejecutar PRIMERO el script original que crea Farmacia_Normalizada.
   Este script NO altera tablas existentes, NO borra informacion y puede
   ejecutarse varias veces sin volver a insertar los registros de demostracion.

   Contenido:
     A) Datos auxiliares de prueba (etiqueta AR52_)
     B) 12 consultas de validacion, de basicas a avanzadas
     C) Comprobaciones finales de integridad de los ejemplos

   Nota: los resultados de las consultas pueden incluir tambien datos reales
   que ya existieran. Las pruebas AR52_ se usan como casos reproducibles.
   ============================================================================ */

USE Farmacia_Normalizada;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

/* ======================= A. DATOS DE PRUEBA =============================== */
BEGIN TRY
    BEGIN TRANSACTION;

    -- Todo el bloque de datos es atomico e idempotente.
    IF NOT EXISTS (SELECT 1 FROM dbo.SUCURSAL WHERE Nombre = 'AR52_Centro')
    BEGIN
        DECLARE @Centro INT, @Norte INT, @Sur INT;
        DECLARE @Paracetamol INT, @Amoxicilina INT, @Vitamina INT, @Ibuprofeno INT, @Jarabe INT;
        DECLARE @LPara INT, @LAmo INT, @LVita INT, @LIbu INT;
        DECLARE @ProvGeneral INT, @ProvSelectivo INT, @ProvSinProducto INT;
        DECLARE @ClienteAna INT, @ClienteLuis INT, @ClienteSinVentas INT;
        DECLARE @Venta1 INT, @Venta2 INT, @VentaSinDetalles INT;
        DECLARE @Medico INT, @Empleado INT;

        INSERT dbo.SUCURSAL(Nombre, Direccion) VALUES
            ('AR52_Centro', 'Calle Principal 100 (datos de ejemplo)'),
            ('AR52_Norte', 'Avenida Norte 200 (datos de ejemplo)'),
            ('AR52_Sur', 'Avenida Sur 300 (datos de ejemplo)');

        SELECT @Centro = ID_Sucursal FROM dbo.SUCURSAL WHERE Nombre = 'AR52_Centro';
        SELECT @Norte  = ID_Sucursal FROM dbo.SUCURSAL WHERE Nombre = 'AR52_Norte';
        SELECT @Sur    = ID_Sucursal FROM dbo.SUCURSAL WHERE Nombre = 'AR52_Sur';

        INSERT dbo.SUCURSAL_TELEFONO(ID_Sucursal, Telefono) VALUES
            (@Centro, '8710005201'), (@Centro, '8710005202'),
            (@Norte,  '8710005203');

        INSERT dbo.EMPLEADO(ID_Sucursal, NombreCompleto, FechaContratacion)
        VALUES (@Centro, 'AR52_Laura Farmaceutica', '2025-03-10');
        SET @Empleado = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.FARMACEUTICO(ID_Empleado, CedulaProfesional, Especialidad)
        VALUES (@Empleado, 'AR52-CED-001', 'Farmacia comunitaria');

        INSERT dbo.EMPLEADO(ID_Sucursal, NombreCompleto, FechaContratacion)
        VALUES (@Norte, 'AR52_Diego Cajero', '2025-04-20');
        SET @Empleado = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.CAJERO(ID_Empleado, Turno, CajaAsignada)
        VALUES (@Empleado, 'Matutino', 'Caja AR52-1');

        INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial, PrincipioActivo, PrecioVenta, RequiereReceta)
        VALUES (@Centro, 'AR52_Paracetamol', 'Paracetamol', 45.00, 0);
        SET @Paracetamol = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial, PrincipioActivo, PrecioVenta, RequiereReceta)
        VALUES (@Centro, 'AR52_Amoxicilina', 'Amoxicilina', 155.00, 1);
        SET @Amoxicilina = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial, PrincipioActivo, PrecioVenta, RequiereReceta)
        VALUES (@Centro, 'AR52_Vitamina C', 'Acido ascorbico', 85.00, 0);
        SET @Vitamina = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial, PrincipioActivo, PrecioVenta, RequiereReceta)
        VALUES (@Norte, 'AR52_Ibuprofeno', 'Ibuprofeno', 120.00, 0);
        SET @Ibuprofeno = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.PRODUCTO(ID_Sucursal, NombreComercial, PrincipioActivo, PrecioVenta, RequiereReceta)
        VALUES (@Sur, 'AR52_Jarabe', 'Dextrometorfano', 65.00, 1);
        SET @Jarabe = CONVERT(INT, SCOPE_IDENTITY());

        INSERT dbo.PROVEEDOR(RazonSocial, DireccionFiscal)
        VALUES ('AR52_Distribuidora Total', 'Direccion fiscal demostrativa');
        SET @ProvGeneral = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.PROVEEDOR(RazonSocial, DireccionFiscal)
        VALUES ('AR52_Proveedor Parcial', 'Direccion fiscal demostrativa');
        SET @ProvSelectivo = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.PROVEEDOR(RazonSocial, DireccionFiscal)
        VALUES ('AR52_Proveedor Sin Productos', 'Direccion fiscal demostrativa');
        SET @ProvSinProducto = CONVERT(INT, SCOPE_IDENTITY());

        -- Total provee TODOS los productos de la sucursal Centro.
        INSERT dbo.PROVEEDOR_PRODUCTO(ID_Proveedor, ID_Producto) VALUES
            (@ProvGeneral, @Paracetamol), (@ProvGeneral, @Amoxicilina),
            (@ProvGeneral, @Vitamina), (@ProvGeneral, @Ibuprofeno),
            (@ProvSelectivo, @Paracetamol), (@ProvSelectivo, @Amoxicilina);

        INSERT dbo.LOTE(ID_Producto, NumeroLote, FechaCaducidad, StockActual)
        VALUES (@Paracetamol, 'AR52-L-001', '2027-12-31', 80);
        SET @LPara = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.LOTE(ID_Producto, NumeroLote, FechaCaducidad, StockActual)
        VALUES (@Amoxicilina, 'AR52-L-002', '2027-06-30', 20);
        SET @LAmo = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.LOTE(ID_Producto, NumeroLote, FechaCaducidad, StockActual)
        VALUES (@Vitamina, 'AR52-L-003', '2028-01-31', 0);
        SET @LVita = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.LOTE(ID_Producto, NumeroLote, FechaCaducidad, StockActual)
        VALUES (@Ibuprofeno, 'AR52-L-004', '2027-09-30', 50);
        SET @LIbu = CONVERT(INT, SCOPE_IDENTITY());
        -- Jarabe queda sin lote para mostrar relaciones sin coincidencias.

        INSERT dbo.PROVEEDOR_LOTE(ID_Proveedor, ID_Lote) VALUES
            (@ProvGeneral, @LPara), (@ProvGeneral, @LAmo),
            (@ProvGeneral, @LVita), (@ProvGeneral, @LIbu),
            (@ProvSelectivo, @LPara);

        INSERT dbo.CLIENTE(Nombre, Correo, Telefono)
        VALUES ('AR52_Ana', 'ar52_ana@example.invalid', '8710005301');
        SET @ClienteAna = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.CLIENTE(Nombre, Correo, Telefono)
        VALUES ('AR52_Luis', 'ar52_luis@example.invalid', '8710005302');
        SET @ClienteLuis = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.CLIENTE(Nombre, Correo, Telefono)
        VALUES ('AR52_Sofia Sin Compras', NULL, NULL);
        SET @ClienteSinVentas = CONVERT(INT, SCOPE_IDENTITY());

        INSERT dbo.MEDICO(CedulaMedico, NombreMedico)
        VALUES ('AR52-MED-001', 'AR52_Dra. Elena');
        SET @Medico = CONVERT(INT, SCOPE_IDENTITY());

        INSERT dbo.RECETA_MEDICA(ID_Medico, Folio, FechaEmision, Diagnostico)
        VALUES (@Medico, 'AR52-REC-001', '2026-11-10', 'Ejemplo academico');
        -- El esquema original NO asocia RECETA_MEDICA directamente con DETALLE_VENTA.

        INSERT dbo.VENTA(ID_Cliente, FechaHora)
        VALUES (@ClienteAna, '2026-11-12T10:00:00');
        SET @Venta1 = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.VENTA(ID_Cliente, FechaHora)
        VALUES (@ClienteLuis, '2026-11-13T11:00:00');
        SET @Venta2 = CONVERT(INT, SCOPE_IDENTITY());
        INSERT dbo.VENTA(ID_Cliente, FechaHora)
        VALUES (@ClienteAna, '2026-11-14T12:00:00');
        SET @VentaSinDetalles = CONVERT(INT, SCOPE_IDENTITY());

        INSERT dbo.DETALLE_VENTA(ID_Venta, NumeroLinea, ID_Lote, ID_Medico,
                               Cantidad, PrecioUnitarioVenta) VALUES
            (@Venta1, 1, @LPara, NULL,     2,  45.00), -- 90.00
            (@Venta1, 2, @LAmo,  @Medico,  1, 155.00), -- 155.00
            (@Venta2, 1, @LPara, NULL,     1,  45.00), -- 45.00
            (@Venta2, 2, @LIbu,  NULL,     2, 120.00);-- 240.00
        -- Venta 1: 245.00; venta 2: 285.00; venta 3: 0.00.
    END;

    COMMIT TRANSACTION;
    PRINT 'Datos de ejemplo AR52_ disponibles (sin duplicarlos).';
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

/* ======================= B. CATALOGO DE CONSULTAS =========================
   SQL usa multiconjuntos en SELECT sin DISTINCT. Cuando se desea representar
   proyeccion de algebra relacional clasica (conjuntos), se usa DISTINCT.
   Cada bloque tiene el requerimiento, una expresion AR y su SQL equivalente.
   ======================================================================== */

-- Q01. SELECCION: productos con precio mayor que 100.
-- AR: sigma_{PrecioVenta > 100}(PRODUCTO)
SELECT ID_Producto, ID_Sucursal, NombreComercial, PrincipioActivo,
       PrecioVenta, RequiereReceta
FROM dbo.PRODUCTO
WHERE PrecioVenta > 100;
GO

-- Q02. PROYECCION: pares unicos de nombre comercial y precio.
-- AR: pi_{NombreComercial, PrecioVenta}(PRODUCTO)
SELECT DISTINCT NombreComercial, PrecioVenta
FROM dbo.PRODUCTO;
GO

-- Q03. SELECCION COMPUESTA: productos sin receta y precio entre 40 y 100.
-- AR: sigma_{RequiereReceta=0 AND PrecioVenta>=40 AND PrecioVenta<=100}(PRODUCTO)
SELECT ID_Producto, NombreComercial, PrecioVenta
FROM dbo.PRODUCTO
WHERE RequiereReceta = 0 AND PrecioVenta BETWEEN 40 AND 100;
GO

-- Q04. JOIN: producto y sucursal a la que pertenece.
-- AR: pi_{NombreComercial, NombreSucursal}(
--       PRODUCTO join_{PRODUCTO.ID_Sucursal=SUCURSAL.ID_Sucursal} SUCURSAL)
SELECT p.ID_Producto, p.NombreComercial, s.Nombre AS NombreSucursal
FROM dbo.PRODUCTO AS p
INNER JOIN dbo.SUCURSAL AS s ON s.ID_Sucursal = p.ID_Sucursal;
GO

-- Q05. JOIN DE TRES TABLAS: producto, numero de lote y sucursal.
-- AR: pi_{NombreComercial, NumeroLote, NombreSucursal}(
--       (LOTE join_{LOTE.ID_Producto=PRODUCTO.ID_Producto} PRODUCTO)
--       join_{PRODUCTO.ID_Sucursal=SUCURSAL.ID_Sucursal} SUCURSAL)
SELECT p.NombreComercial, l.NumeroLote, s.Nombre AS NombreSucursal,
       l.StockActual
FROM dbo.LOTE AS l
INNER JOIN dbo.PRODUCTO AS p ON p.ID_Producto = l.ID_Producto
INNER JOIN dbo.SUCURSAL AS s ON s.ID_Sucursal = p.ID_Sucursal;
GO

-- Q06. DIFERENCIA: productos sin proveedor asignado.
-- AR: pi_{ID_Producto}(PRODUCTO) - pi_{ID_Producto}(PROVEEDOR_PRODUCTO)
-- EXCEPT implementa la diferencia de conjuntos.
SELECT ID_Producto FROM dbo.PRODUCTO
EXCEPT
SELECT ID_Producto FROM dbo.PROVEEDOR_PRODUCTO;
GO

-- Q07. UNION: identificadores de productos baratos O que requieren receta.
-- AR: pi_{ID_Producto}(sigma_{PrecioVenta<100}(PRODUCTO)) UNION
--     pi_{ID_Producto}(sigma_{RequiereReceta=1}(PRODUCTO))
SELECT ID_Producto FROM dbo.PRODUCTO WHERE PrecioVenta < 100
UNION
SELECT ID_Producto FROM dbo.PRODUCTO WHERE RequiereReceta = 1;
GO

-- Q08. INTERSECCION: productos con precio >100 Y que requieren receta.
-- AR: pi_{ID_Producto}(sigma_{PrecioVenta>100}(PRODUCTO)) INTERSECT
--     pi_{ID_Producto}(sigma_{RequiereReceta=1}(PRODUCTO))
SELECT ID_Producto FROM dbo.PRODUCTO WHERE PrecioVenta > 100
INTERSECT
SELECT ID_Producto FROM dbo.PRODUCTO WHERE RequiereReceta = 1;
GO

-- Q09. DIVISION RELACIONAL: proveedores que surten TODOS los productos
--      de la sucursal de ejemplo AR52_Centro.
-- AR: R = pi_{ID_Proveedor,ID_Producto}(PROVEEDOR_PRODUCTO)
--     S = pi_{ID_Producto}(sigma_{Nombre='AR52_Centro'}(
--           SUCURSAL join_{ID_Sucursal} PRODUCTO))
--     Resultado = R DIVIDE S
-- SQL: doble NOT EXISTS, equivalente a "para todo".
SELECT pr.ID_Proveedor, pr.RazonSocial
FROM dbo.PROVEEDOR AS pr
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.PRODUCTO AS p
    INNER JOIN dbo.SUCURSAL AS s ON s.ID_Sucursal = p.ID_Sucursal
    WHERE s.Nombre = 'AR52_Centro'
      AND NOT EXISTS (
          SELECT 1 FROM dbo.PROVEEDOR_PRODUCTO AS pp
          WHERE pp.ID_Proveedor = pr.ID_Proveedor
            AND pp.ID_Producto = p.ID_Producto
      )
)
-- Evita el caso vacio si la sucursal no existe/no tiene productos.
AND EXISTS (
    SELECT 1 FROM dbo.PRODUCTO AS p
    JOIN dbo.SUCURSAL AS s ON s.ID_Sucursal = p.ID_Sucursal
    WHERE s.Nombre = 'AR52_Centro'
);
GO

-- Q10. AGREGACION: cantidad de lotes y stock total por producto.
-- AR extendida: gamma_{ID_Producto; COUNT(ID_Lote)->NumeroLotes,
--                             SUM(StockActual)->StockTotal}(LOTE)
SELECT p.ID_Producto, p.NombreComercial,
       COUNT(l.ID_Lote) AS NumeroLotes,
       COALESCE(SUM(l.StockActual), 0) AS StockTotal
FROM dbo.PRODUCTO AS p
LEFT JOIN dbo.LOTE AS l ON l.ID_Producto = p.ID_Producto
GROUP BY p.ID_Producto, p.NombreComercial;
GO

-- Q11. LEFT OUTER JOIN: todos los clientes, incluso quienes no compraron.
-- AR extendida: CLIENTE LEFT_OUTER_JOIN_{CLIENTE.ID_Cliente=VENTA.ID_Cliente} VENTA
SELECT c.ID_Cliente, c.Nombre AS Cliente,
       v.ID_Venta, v.FechaHora
FROM dbo.CLIENTE AS c
LEFT JOIN dbo.VENTA AS v ON v.ID_Cliente = c.ID_Cliente;
GO

-- Q12. PROYECCION GENERALIZADA + AGREGACION: subtotal por renglon y total
--      por venta, incluyendo ventas que no tienen renglones.
-- AR (paso 1): D = pi_{ID_Venta, (Cantidad*PrecioUnitarioVenta)->SubtotalLinea}(DETALLE_VENTA)
-- AR (paso 2): T = gamma_{ID_Venta; SUM(SubtotalLinea)->Total}(D)
-- AR (paso 3): VENTA LEFT_OUTER_JOIN_{VENTA.ID_Venta=T.ID_Venta} T
WITH Importes AS (
    SELECT ID_Venta,
           CAST(Cantidad * PrecioUnitarioVenta AS DECIMAL(28,2)) AS SubtotalLinea
    FROM dbo.DETALLE_VENTA
),
Totales AS (
    SELECT ID_Venta, SUM(SubtotalLinea) AS Total
    FROM Importes
    GROUP BY ID_Venta
)
SELECT v.ID_Venta, v.ID_Cliente,
       COALESCE(t.Total, CONVERT(DECIMAL(38,2), 0)) AS TotalVenta
FROM dbo.VENTA AS v
LEFT JOIN Totales AS t ON t.ID_Venta = v.ID_Venta;
GO

/* ================== C. VALIDACIONES REPRODUCIBLES =========================
   No se modifican los datos al ejecutar estas verificaciones.
   Estado = OK indica que los casos de ejemplo cumplen lo esperado.
   Los datos reales de otras personas no se contabilizan en estos checks.
   ======================================================================== */

-- C1. La venta de Ana del 12/11/2026 debe sumar 245.00.
SELECT 'C1: Total de venta Ana' AS Validacion,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.VW_VENTA_TOTALES AS vt
           JOIN dbo.VENTA AS v ON v.ID_Venta = vt.ID_Venta
           JOIN dbo.CLIENTE AS c ON c.ID_Cliente = v.ID_Cliente
           WHERE c.Nombre = 'AR52_Ana'
             AND v.FechaHora = '2026-11-12T10:00:00'
             AND vt.MontoTotal = 245.00
       ) THEN 'OK' ELSE 'REVISAR' END AS Estado;
GO

-- C2. El proveedor Total debe cubrir los 3 productos de AR52_Centro.
SELECT 'C2: Cobertura completa del proveedor' AS Validacion,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.PROVEEDOR AS pr
           WHERE pr.RazonSocial = 'AR52_Distribuidora Total'
             AND (SELECT COUNT(*) FROM dbo.PRODUCTO AS p
                  JOIN dbo.SUCURSAL AS s ON s.ID_Sucursal = p.ID_Sucursal
                  WHERE s.Nombre = 'AR52_Centro') = 3
             AND (SELECT COUNT(*) FROM dbo.PROVEEDOR_PRODUCTO AS pp
                  JOIN dbo.PRODUCTO AS p ON p.ID_Producto = pp.ID_Producto
                  JOIN dbo.SUCURSAL AS s ON s.ID_Sucursal = p.ID_Sucursal
                  WHERE pp.ID_Proveedor = pr.ID_Proveedor
                    AND s.Nombre = 'AR52_Centro') = 3
       ) THEN 'OK' ELSE 'REVISAR' END AS Estado;
GO

-- C3. La venta sin detalles se incluye con importe cero en la vista.
SELECT 'C3: Venta sin detalles' AS Validacion,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.VW_VENTA_TOTALES AS vt
           JOIN dbo.VENTA AS v ON v.ID_Venta = vt.ID_Venta
           JOIN dbo.CLIENTE AS c ON c.ID_Cliente = v.ID_Cliente
           WHERE c.Nombre = 'AR52_Ana'
             AND v.FechaHora = '2026-11-14T12:00:00'
             AND vt.MontoTotal = 0.00
             AND NOT EXISTS (
                SELECT 1 FROM dbo.DETALLE_VENTA AS d WHERE d.ID_Venta = v.ID_Venta
             )
       ) THEN 'OK' ELSE 'REVISAR' END AS Estado;
GO

-- C4. El cliente de ejemplo Sofia existe, pero no tiene ventas.
SELECT 'C4: Cliente sin compras' AS Validacion,
       CASE WHEN EXISTS (
           SELECT 1 FROM dbo.CLIENTE AS c
           WHERE c.Nombre = 'AR52_Sofia Sin Compras'
             AND NOT EXISTS (SELECT 1 FROM dbo.VENTA AS v WHERE v.ID_Cliente = c.ID_Cliente)
       ) THEN 'OK' ELSE 'REVISAR' END AS Estado;
GO

PRINT 'Fin del catalogo Tarea 5.2: 12 consultas y 4 verificaciones.';
GO
