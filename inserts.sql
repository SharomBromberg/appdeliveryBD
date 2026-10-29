-- ==============================================================================
-- Reto Práctico 2: Inserción Masiva y Transacciones
-- Optimización de Escritura en Almacenamiento Interno:
-- SQLite por defecto opera en modo autocommit (un fsync a disco por cada INSERT).
-- Al envolver el lote de inserciones en un bloque transaccional (BEGIN TRANSACTION / COMMIT),
-- todas las escrituras se consolidan en memoria y se confirman en una única operación
-- de I/O en disco, multiplicando la velocidad de inserción hasta 100 veces.
-- ==============================================================================

BEGIN TRANSACTION;

-- 1. Usuarios (sin dependencias)
INSERT INTO Usuario (ID_usuario, Nombre, Email, Telefono)
VALUES (1, 'juan perez', 'juanperez@gmail.com', '1234567890'),
       (2, 'maria lopez', 'marialopez@gmai.com', '0987654321'),
       (3, 'carlos gomez', 'carlosgomez@gmail.com', '1122334455'),
       (4, 'ana martinez', 'Amartinez@gmail.com', '2233445566'),
       (5, 'luis ramirez', 'lur@gmail.com', '3344556677'),
       (7, 'diego flores', 'diegof@gmail.com', '5566778899');

-- 2. Repartidores (sin dependencias)
INSERT INTO Repartidor (ID_Repartidor, Nombre, Vehiculo)
VALUES (1, 'Pedro Martinez', 'Moto'),
       (2, 'Ana Torres', 'Bicicleta'),
       (3, 'Luis Ramirez', 'Auto'),
       (4, 'Sofia Gonzalez', 'Moto');

-- 3. Categorías (sin dependencias, requerida por Plato)
INSERT INTO Categoria (ID_Categoria, Nombre, Descripcion)
VALUES (1, 'Comida Rápida', 'Hamburguesas, papas fritas y snacks rápidos'),
       (2, 'Comida Japonesa', 'Sushi, ramen, tempura y platos tradicionales'),
       (3, 'Comida Italiana', 'Pastas artesanales, pizzas y lasagnas'),
       (4, 'Comida Mexicana', 'Tacos, quesadillas y antojitos mexicanos'),
       (5, 'Especialidades', 'Platos gourmet, risottos y ensaladas de la casa');

-- 4. Restaurantes (debe ir ANTES de Plato para respetar la clave foránea)
INSERT INTO Restaurante (ID_Restaurante, Nombre, Categoria, Calificacion, Direccion, Icono_Categoria)
VALUES (1, 'La Parrilla', 'Comida Rápida', 4.5, 'Carrera 4 # 5-12, Manzanares', 'icons/comida_rapida.png'),
       (2, 'Sushi House', 'Comida Japonesa', 4.8, 'Calle 3 # 4-20, Marquetalia', 'icons/comida_japonesa.png'),
       (3, 'Pasta Fresca', 'Comida Italiana', 4.2, 'Carrera 6 # 7-15, Pensilvania', 'icons/comida_italiana.png'),
       (4, 'Taco Loco', 'Comida Mexicana', 4.6, 'Calle 5 # 3-10, Manzanares', 'icons/comida_mexicana.png'),
       (5, 'Burger Queen', 'Comida Rápida', 4.3, 'Carrera 2 # 6-08, Marquetalia', 'icons/comida_rapida.png'),
       (6, 'Ramen House', 'Comida Japonesa', 4.7, 'Calle 4 # 5-22, Pensilvania', 'icons/comida_japonesa.png');

-- 5. Platos (depende de Restaurante y Categoria)
INSERT INTO Plato (ID_Plato, ID_Restaurante, ID_Categoria, Nombre, Precio, Foto_Ruta)
VALUES (1, 1, 1, 'Hamburguesa', 10.00, 'images/hamburguesa.jpg'),
       (2, 1, 1, 'Papas Fritas', 5.00, 'images/papas_fritas.jpg'),
       (3, 2, 2, 'Sushi', 15.00, 'images/sushi.jpg'),
       (4, 2, 2, 'Ramen', 12.00, 'images/ramen.jpg'),
       (5, 3, 3, 'Pasta Carbonara', 14.00, 'images/pasta_carbonara.jpg'),
       (6, 3, 3, 'Pizza Margherita', 11.00, 'images/pizza_margherita.jpg'),
       (7, 1, 5, 'Ensalada César', 8.00, 'images/ensalada_cesar.jpg'),
       (8, 2, 2, 'Tempura', 13.00, 'images/tempura.jpg'),
       (9, 3, 3, 'Lasagna', 16.00, 'images/lasagna.jpg'),
       (10, 1, 4, 'Tacos', 9.00, 'images/tacos.jpg'),
       (11, 2, 2, 'Gyoza', 7.00, 'images/gyoza.jpg'),
       (12, 3, 5, 'Risotto', 18.00, 'images/risotto.jpg');

-- 6. Pedidos (depende de Usuario)
INSERT INTO Pedido (ID_Pedido, ID_Usuario, Total)  
VALUES (1, 1, 25.50),
       (2, 2, 15.75),
       (3, 3, 30.00),
       (4, 4, 12.25),
       (5, 5, 18.90),
       (6, 1, 22.10),
       (7, 2, 14.50),
       (8, 3, 28.75),
       (9, 4, 16.80),
       (10, 5, 20.00),
       (11, 1, 19.50),
       (12, 2, 17.25),
       (13, 3, 24.00);

-- 7. Detalle de Pedidos (depende de Pedido y Plato)
INSERT INTO Detalle_Pedido (ID_Pedido, ID_Plato, Cantidad, Opciones_JSON)
VALUES (1, 1, 2, '{"opciones": ["sin cebolla", "extra queso", "sin tomate", "sin dulce"]}'),
       (1, 2, 1, '{"opciones": ["picante", "sin bbq", "extra queso crema"]}'),
       (2, 3, 3, '{"opciones": ["sin sal", "extra wasabi", "sin soja"]}'),
       (3, 4, 1, '{"opciones": ["extra salsa", "sin huevo", "sin algas"]}'),
       (3, 5, 2, '{"opciones": ["sin gluten", "extra parmesano", "sin ajo"]}'),
       (4, 6, 1, '{"opciones": ["extra queso", "sin pepperoni", "sin aceitunas"]}'),
       (5, 7, 2, '{"opciones": ["sin aderezo", "extra croutons", "sin pollo"]}'),
       (6, 8, 1, '{"opciones": ["extra salsa", "sin tempura", "sin zanahoria"]}'),
       (7, 9, 3, '{"opciones": ["sin sal", "extra bechamel", "sin carne"]}'),
       (8, 10, 1, '{"opciones": ["extra guacamole", "sin cebolla", "sin cilantro"]}'),
       (9, 11, 2, '{"opciones": ["sin aceite", "extra jengibre", "sin repollo"]}'),
       (10, 12, 1, '{"opciones": ["extra parmesano", "sin azafrán", "sin champiñones"]}');

-- Confirmar todas las inserciones en una sola operación de disco
COMMIT;
