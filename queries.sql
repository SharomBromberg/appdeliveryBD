-- Consulta para obtener los detalles de los pedidos realizados por los clientes, 
-- incluyendo el nombre del cliente, el nombre del plato, la cantidad solicitada y
-- cualquier instrucción especial proporcionada en formato JSON.
SELECT 
    p.ID_Pedido,
    u.Nombre AS Cliente,
    pl.Nombre AS Plato,
    dp.Cantidad,
    json_extract(dp.Opciones_JSON, '$.opciones[0]') AS Instruccion_Especial
FROM Pedido p
JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario
JOIN Detalle_Pedido dp ON p.ID_Pedido = dp.ID_Pedido
JOIN Plato pl ON dp.ID_Plato = pl.ID_Plato;


SELECT * FROM Detalle_Pedido WHERE ID_plato = 1;

-- Crear una tabla de restaurantes que en su dirección tengan la palabra manzanares: 
-- Quiero que se visualice una tabla en la consulta que tenga los campos restaurante y ciudad
SELECT Nombre AS Restaurante, Direccion AS Ciudad FROM Restaurante WHERE Direccion LIKE '%manzanares%';

-- SELECT * FROM Restaurante WHERE Direccion LIKE '%manzanares%'; 


-- ==============================================================================
-- Reto Práctico 1: Optimización de Consulta de Platos
-- Objetivo: Extraer únicamente 'nombre' y 'precio' de los platos pertenecientes 
-- a la categoría ID 5, evitando SELECT * para no sobrecargar la memoria móvil.
-- ==============================================================================

-- Consulta SQL optimizada (Proyección de columnas):
SELECT Nombre, Precio
FROM Plato
WHERE ID_Categoria = 5;


-- ==============================================================================
-- Reto Práctico 2: Inserción Masiva y Transacciones
-- Objetivo: Script transaccional ejecutable que inserta masivamente 1,000 registros
-- de productos en la tabla Plato en una única transacción ultra rápida.
-- ==============================================================================

BEGIN TRANSACTION;

WITH RECURSIVE contador(i) AS (
    SELECT 1
    UNION ALL
    SELECT i + 1 FROM contador WHERE i < 1000
)
INSERT INTO Plato (ID_Restaurante, ID_Categoria, Nombre, Precio, Foto_Ruta)
SELECT 
    ((i % 6) + 1) AS ID_Restaurante,
    ((i % 5) + 1) AS ID_Categoria,
    'Plato Masivo #' || i AS Nombre,
    ROUND(10.0 + (i % 20) * 1.5, 2) AS Precio,
    'images/plato_' || i || '.jpg' AS Foto_Ruta
FROM contador;

COMMIT;

-- Consulta de verificación para confirmar que se insertaron los 1,000 registros:
SELECT COUNT(*) AS Total_Platos_En_Base_De_Datos FROM Plato;


