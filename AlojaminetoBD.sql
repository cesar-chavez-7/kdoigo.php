-- crear la bd owo
CREATE DATABASE IF NOT EXISTS ProyectoAlojamientos;
USE ProyectoAlojamientos;

-- usarios
CREATE TABLE Usuarios (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Rol ENUM('Usuario', 'Administrador') DEFAULT 'Usuario',
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT TRUE
);

-- alojamientos
CREATE TABLE Alojamientos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10,2) NOT NULL,
    Ubicacion VARCHAR(100),
    ImagenUrl VARCHAR(255),
    Amenidades JSON,
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreador INT,
    FOREIGN KEY (UsuarioCreador) REFERENCES Usuarios(Id)
);

-- relacion usuario-aljamineto
CREATE TABLE UsuarioAlojamientos (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioId INT NOT NULL,
    AlojamientoId INT NOT NULL,
    FechaSeleccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id) ON DELETE CASCADE,
    FOREIGN KEY (AlojamientoId) REFERENCES Alojamientos(Id) ON DELETE CASCADE,
    UNIQUE KEY UniqueUsuarioAlojamiento (UsuarioId, AlojamientoId)
);

--usuario Administrador (Rol: 'Administrador')
-- Contraseña: "admin123"
INSERT INTO Usuarios (UserName, Email, PasswordHash, Rol)
VALUES ('admin', 'admin@mail.com', '$2y$10$E/VMkLSOo0y.S2zLwYq4AOlE3cTUj/6pS.Nl3sCVR/LWMpS6gME0O', 'Administrador');

--usuario normal (Rol: 'Usuario')
--Contraseña: "user123"
INSERT INTO Usuarios (UserName, Email, PasswordHash, Rol)
VALUES ('usuario_demo', 'user@mail.com', '$2y$10$A5g1H.gTwc4w5gwg2xJ.X.3NvBfBAlmGzcsdPYiJzHRf6fARsOMle', 'Usuario');

-- Alojamientos (creados por el admin, Id = 1)
-- Estos son los que aparecerán en la Landing Page
INSERT INTO Alojamientos (Nombre, Descripcion, Precio, Ubicacion, ImagenUrl, UsuarioCreador)
VALUES 
('Cabaña en el Bosque', 'Una hermosa cabaña para escapar de la ciudad.', 120.00, 'Montaña El Pital', 'https://elsalvador.travel/system/wp-content/uploads/2022/12/DestinationPital.jpg', 1),
('Apartamento de Playa', 'Vistas increíbles al océano.', 250.50, 'Playa El Tunco', 'https://elsalvador.travel/system/wp-content/uploads/2020/01/EL-TUNCO.jpg', 1),
('Casa Colonial', 'Encanto histórico en el centro de la ciudad.', 90.00, 'Suchitoto', 'https://upload.wikimedia.org/wikipedia/commons/2/21/Casas_de_Suchitoto.jpg', 1);

--Simular que un usuario ya ha seleccionado un alojamiento
-- El 'usuario_demo' (Id = 2) ha seleccionado la 'Cabaña en el Bosque' (Id = 1)
INSERT INTO UsuarioAlojamientos (UsuarioId, AlojamientoId)
VALUES (2, 1);