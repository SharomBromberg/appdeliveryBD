DROP TABLE IF EXISTS Pedido;
drop table if exists Detalle_Pedido;
drop table if exists Plato;
drop table if exists Restaurante;
drop table if exists Repartidor;
drop table if exists Usuario;
PRAGMA foreign_keys = ON;
CREATE TABLE Usuario (
    ID_Usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    Telefono TEXT
);
CREATE TABLE Repartidor (
    ID_Repartidor INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Vehiculo TEXT NOT NULL
);
CREATE TABLE Restaurante (
    ID_Restaurante INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Categoria TEXT NOT NULL,
    Calificacion REAL DEFAULT 0.0,
    -- Aplicación de Desnormalización para lecturas ultra rápidas en UI
    Icono_Categoria TEXT
);
CREATE TABLE Plato (
    ID_Plato INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Restaurante INTEGER NOT NULL,
    Nombre TEXT NOT NULL,
    Precio REAL NOT NULL,
    -- Almacenamiento multimedia optimizado: ruta física en lugar de BLOB
    Foto_Ruta TEXT,
    FOREIGN KEY (ID_Restaurante) REFERENCES Restaurante(ID_Restaurante) ON DELETE CASCADE
);
CREATE TABLE Pedido (
    ID_Pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_Usuario INTEGER NOT NULL,
    Total REAL NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);
CREATE TABLE Detalle_Pedido (
    ID_Pedido INTEGER NOT NULL,
    ID_Plato INTEGER NOT NULL,
    Cantidad INTEGER DEFAULT 1,
    -- Estructura Dinámica con soporte JSON1 nativo de SQLite
    Opciones_JSON TEXT,
    PRIMARY KEY (ID_Pedido, ID_Plato),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE,
    FOREIGN KEY (ID_Plato) REFERENCES Plato(ID_Plato)
);
CREATE INDEX idx_pedido_usuario ON Pedido(ID_Usuario);
CREATE INDEX idx_plato_restaurante ON Plato(ID_Restaurante);