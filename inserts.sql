INSERT INTO Usuario (ID_usuario, Nombre, Email, Telefono)
VALUES (1, 'juan perez', 'juanperez@gmail.com', '1234567890'),
       (2, 'maria lopez', 'marialopez@gmai.com', '0987654321'),
       (3, 'carlos gomez', 'carlosgomez@gmail.com' , '1122334455');

INSERT INTO Pedido (ID_Pedido, ID_Usuario, Total)  
VALUES (1, 1, 25.50),
       (2, 2, 15.75),
       (3, 3, 30.00);  

INSERT INTO Plato (ID_Plato, ID_Restaurante, Nombre, Precio, Foto_Ruta)
VALUES (1, 1, 'Hamburguesa', 10.00, 'images/hamburguesa.jpg'),
       (2, 1, 'Papas Fritas', 5.00, 'images/papas_fritas.jpg');

INSERT INTO Repartidor (ID_Repartidor, Nombre, Vehiculo)
VALUES (1, 'Pedro Martinez', 'Moto'),
       (2, 'Ana Torres', 'Bicicleta'),
       (3, 'Luis Ramirez', 'Auto');    

INSERT INTO Restaurante (ID_Restaurante, Nombre, Categoria, Calificacion, Icono_Categoria)
VALUES (1, 'La Parrilla', 'Comida Rápida', 4.5, 'icons/comida_rapida.png'),
       (2, 'Sushi House', 'Comida Japonesa', 4.8, 'icons/comida_japonesa.png'),
       (3, 'Pasta Fresca', 'Comida Italiana', 4.2, 'icons/comida_italiana.png');

INSERT INTO detalle_pedido (ID_Pedido, ID_Plato, Cantidad, Opciones_JSON)
VALUES (1, 1, 2, '{"opciones": ["sin cebolla", "extra queso", "sin tomate", "sin dulce"]}'),
       (1, 2, 1, '{"opciones": ["picante"]}'),
       (2, 3, 3, '{"opciones": ["sin sal"]}'),
       (3, 4, 1, '{"opciones": ["extra salsa"]}'),
       (3, 5, 2, '{"opciones": ["sin gluten"]}');