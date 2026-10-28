
-- --Consilta para obtener los detalles de los pedidos realizados por los clientes, 
-- --incluyendo el nombre del cliente, el nombre del plato, la cantidad solicitada y
-- -- cualquier instrucción especial proporcionada en formato JSON.
-- SELECT 
-- -- Selección de campos relevantes de las tablas involucradas
-- -- Le decimos a sqlite que nos devuelva el ID del pedido, el nombre del cliente, el nombre del plato, 
-- --la cantidad y las opciones solicitadas en formato JSON
--     p.ID_Pedido,
--     --Le decimos a sqlite que nos devuelva el nombre del cliente y del plato en lugar de sus IDs
--     u.Nombre AS Cliente,
--     pl.Nombre AS Plato,
--     dp.Cantidad,
--     -- Uso de json_extract para sacar elementos específicos del string JSON
--     json_extract(dp.Opciones_JSON, '$.opciones[0]') AS Instruccion_Especial
-- -- De la tabla Pedido, unimos con Usuario para obtener el nombre del cliente, con Detalle_Pedido para obtener
-- -- los detalles del pedido y con Plato para obtener el nombre del plato
-- FROM Pedido p
-- JOIN Usuario u ON p.ID_Usuario = u.ID_Usuario
-- JOIN Detalle_Pedido dp ON p.ID_Pedido = dp.ID_Pedido
-- JOIN Plato pl ON dp.ID_Plato = pl.ID_Plato;


SELECT * FROM Detalle_Pedido WHERE ID_plato = 1;

-- Crear una tabla de restaurantes que en su dirección tengan la palabra manzanares: 
--Quiero que se visualice una tabla en la consulta que tenga los campos restaurante y ciudad

SELECT Nombre AS Restaurante, Direccion AS Ciudad FROM Restaurante WHERE Direccion LIKE '%manzanares%';

-- SELECT * FROM Restaurante WHERE Direccion LIKE '%manzanares%'; 
