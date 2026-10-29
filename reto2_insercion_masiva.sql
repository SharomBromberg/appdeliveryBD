-- ==============================================================================
-- Reto Práctico 2: Inserción Masiva y Transacciones
-- Objetivo: Script transaccional que envuelve el lote de 1,000 inserciones
-- para maximizar la velocidad de escritura en el almacenamiento interno de la app.
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

-- Verificación:
SELECT COUNT(*) AS Total_Platos FROM Plato;

