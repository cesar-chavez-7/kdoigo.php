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

-- Aqui hirian las insercciones de datos pero como no c como le vamos a hacer asi lo voy a dejar xd