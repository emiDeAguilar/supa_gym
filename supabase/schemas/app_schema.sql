CREATE SCHEMA seguridad;
GO

CREATE SCHEMA usuario;
GO

CREATE SCHEMA asistencia;
GO

CREATE SCHEMA equipo;
GO

CREATE SCHEMA entrenamiento;
GO


-- ===================================
-- PERMISOS
-- ===================================
CREATE TABLE seguridad.Permisos (
    id_permiso INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(255) NULL
);

-- ===================================
-- ROLES
-- ===================================
CREATE TABLE seguridad.Cat_rol (
    id_cat_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(255) NULL,
    nivel_jerarquico INT NOT NULL,
    activo BIT NOT NULL DEFAULT 1
);

-- ===================================
-- RELACIÓN PERMISO - ROL
-- ===================================
CREATE TABLE seguridad.Rel_permiso_rol (
    id_cat_rol INT NOT NULL,
    id_permiso INT NOT NULL,
    PRIMARY KEY (id_cat_rol, id_permiso),

    FOREIGN KEY (id_cat_rol) REFERENCES seguridad.Cat_rol(id_cat_rol),
    FOREIGN KEY (id_permiso) REFERENCES seguridad.Permisos(id_permiso)
);

-- ===================================
-- USUARIOS
-- ===================================
CREATE TABLE usuario.Usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    id_cat_rol INT NOT NULL,
    activo BIT NOT NULL DEFAULT 1,
    nombres NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(100) NOT NULL,
    correo NVARCHAR(150) UNIQUE NOT NULL,
    ts_creado DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    ts_modificado DATETIME2  NULL,

    FOREIGN KEY (id_cat_rol) REFERENCES seguridad.Cat_rol(id_cat_rol)
);

-- ===================================
-- ASISTENCIAS
-- ===================================
CREATE TABLE usuario.Asistencias (
    id_asistencias INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    ts_entrada DATETIME2 NOT NULL,
    ts_salida DATETIME2 NULL,

    FOREIGN KEY (id_usuario) REFERENCES usuario.Usuarios(id_usuario)
);

-- ===================================
-- RUTINAS
-- ===================================
CREATE TABLE entrenamiento.Rutinas (
    id_rutina INT IDENTITY(1,1) PRIMARY KEY,
    id_creador INT NOT NULL,
    nombre NVARCHAR(100) NOT NULL,
    nivel INT NOT NULL,
    objetivo NVARCHAR(255) NULL,
    tipo_objetivo NVARCHAR(50) NULL
        CONSTRAINT CHK_tipo_objetivo_valores
        CHECK (tipo_objetivo IN ('Hipertrofia muscular','Fuerza funcional', 'Resistencia muscular','movilidad y flexibilidad','Pérdida de grasa corporal','Rehabilitación','Postura y equilibrio','Preparación física para deporte')),
    es_default BIT NOT NULL DEFAULT 0,
    activo BIT NOT NULL DEFAULT 1,
    ts_creado DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    ts_modificado DATETIME2  NULL,

    FOREIGN KEY (id_creador) REFERENCES usuario.Usuarios(id_usuario)
);

-- ===================================
-- RELACIÓN RUTINA - USUARIO
-- ===================================
CREATE TABLE entrenamiento.Rel_rutina_usuario (
    rutina_usuario INT IDENTITY(1,1) PRIMARY KEY,
    id_rutina INT NOT NULL,
    id_usuario INT NOT NULL,
    activo BIT NOT NULL DEFAULT 1,
    duracion INT NULL,
    dias_semana INT NULL,

    FOREIGN KEY (id_rutina) REFERENCES entrenamiento.Rutinas(id_rutina),
    FOREIGN KEY (id_usuario) REFERENCES usuario.Usuarios(id_usuario)
);

-- ===================================
-- EJERCICIOS
-- ===================================
CREATE TABLE entrenamiento.Ejercicios (
    id_ejercicio INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    tipo_ejercicio NVARCHAR(100) NULL
      CONSTRAINT CHK_tipo_ejercicio
    CHECK(tipo_ejercicio IN ('fuerza','resistencia','otros'))
);

-- ===================================
-- RELACIÓN EJERCICIO - RUTINA
-- ===================================
CREATE TABLE entrenamiento.Rel_ejercicio_rutina (
    id_ejercicio_rutina INT NOT NULL,
    id_rutina INT NOT NULL,
    id_ejercicio INT NOT NULL,
    PRIMARY KEY (id_ejercicio_rutina),

    FOREIGN KEY (id_rutina) REFERENCES entrenamiento.Rutinas(id_rutina),
    FOREIGN KEY (id_ejercicio) REFERENCES entrenamiento.Ejercicios(id_ejercicio)
);

-- ===================================
-- EQUIPOS
-- ===================================
CREATE TABLE equipo.Equipos (
    id_equipo INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    es_mantenimiento_requerido BIT NOT NULL DEFAULT 0
);

-- ===================================
-- RELACIÓN EJERCICIO - EQUIPO
-- ===================================
CREATE TABLE entrenamiento.Rel_ejercicio_equipo (
    id_ejercicio_equipo INT IDENTITY(1,1) PRIMARY KEY,
    id_ejercicio INT NOT NULL,
    id_equipo INT NOT NULL,

    FOREIGN KEY (id_ejercicio) REFERENCES entrenamiento.Ejercicios(id_ejercicio),
    FOREIGN KEY (id_equipo) REFERENCES equipo.Equipos(id_equipo)
);

-- ===================================
-- MANTENIMIENTOS
-- ===================================
CREATE TABLE equipo.Mantenimientos (
    id_mantenimiento INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE NOT NULL,
    descripcion NVARCHAR(255) NULL,
    proximo_mantenimiento DATE NULL
);

-- ===================================
-- RELACIÓN EQUIPO - MANTENIMIENTO
-- ===================================
CREATE TABLE equipo.Rel_equipo_unidad (
    id_equipo_unidad INT IDENTITY(1,1) PRIMARY KEY,
    id_equipo INT NOT NULL,
    id_mantenimiento INT NOT NULL,
    estado NVARCHAR(100) NULL,

    FOREIGN KEY (id_equipo) REFERENCES equipo.Equipos(id_equipo),
    FOREIGN KEY (id_mantenimiento) REFERENCES equipo.Mantenimientos(id_mantenimiento)
);

-- ===================================
-- CATEGORÍA MÚSCULO
-- ===================================
CREATE TABLE entrenamiento.Cat_musculo (
    id_cat_musculo INT IDENTITY(1,1) PRIMARY KEY,
    tipo_grupo_muscular NVARCHAR(100) NOT NULL,
      CONSTRAINT CHK_tipo_grupo_muscular
    CHECK(tipo_grupo_muscular IN ('Pecho','Espalda','Brazo','Abdomen','Cadera','Pierna','Hombro')),
    tipo_musculo_objetivo NVARCHAR(100) NOT NULL
      CONSTRAINT CHK_tipo_musculo_objetivo
    CHECK(tipo_musculo_objetivo IN   ('Deltoides anterior', 'Deltoides lateral', 'Deltoides posterior', 'Bíceps braquial', 'Tríceps braquial', 'Pectoral mayor', 'Dorsal ancho', 'Trapecio', 'Romboides', 'Abdominales', 'Oblicuos', 'Erectores espinales', 'Glúteo mayor', 'Glúteo medio', 'Cuádriceps', 'Isquiotibiales', 'Aductores', 'Gastrocnemio', 'Sóleo','Tibial anterior' ))
);

-- ===================================
-- RELACIÓN EJERCICIO - MÚSCULO
-- ===================================
CREATE TABLE entrenamiento.Rel_ejercicio_musculo (
    id_ejercicio_musculo INT IDENTITY(1,1) PRIMARY KEY,
    id_ejercicio INT NOT NULL,
    id_cat_musculo INT NOT NULL,

    FOREIGN KEY (id_ejercicio) REFERENCES entrenamiento.Ejercicios(id_ejercicio),
    FOREIGN KEY (id_cat_musculo) REFERENCES entrenamiento.Cat_musculo(id_cat_musculo)
);