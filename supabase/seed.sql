-- ==================================================
-- Poblar datos de ejemplo para la base creada antes
-- Ejecutar en SSMS (asegúrate de que las tablas existen)
-- ==================================================

-- -----------------------
-- 1) Roles
-- -----------------------
INSERT INTO seguridad.Cat_rol (nombre, descripcion, nivel_jerarquico, activo)
VALUES
(N'Administrador', N'Rol con todos los permisos', 10, 1),
(N'Entrenador', N'Rol con permisos de gestión de rutinas y ejercicios', 5, 1),
(N'Cliente', N'Usuario cliente, puede ver y ejecutar rutinas', 1, 1);

-- -----------------------
-- 2) Permisos
-- -----------------------
INSERT INTO seguridad.Permisos (nombre, descripcion)
VALUES
(N'crear_usuario', N'Crear usuarios'),
(N'eliminar_usuario', N'Eliminar usuarios'),
(N'editar_rutina', N'Crear/Editar rutinas'),
(N'ver_rutina', N'Visualizar rutinas'),
(N'registrar_asistencia', N'Registrar asistencias'),
(N'ver_reportes', N'Acceder a reportes');

-- -----------------------
-- 3) Rel_permiso_rol
--    (asumo IDs: Cat_rol 1=Admin,2=Entrenador,3=Cliente; Permisos id 1..6)
-- -----------------------
-- Admin -> todos
INSERT INTO seguridad.Rel_permiso_rol (id_cat_rol, id_permiso)
VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6);

-- Entrenador -> editar_rutina, ver_rutina, registrar_asistencia, ver_reportes
INSERT INTO seguridad.Rel_permiso_rol (id_cat_rol, id_permiso)
VALUES  
(2,3),(2,4),(2,5),(2,6);

-- Cliente -> ver_rutina, registrar_asistencia
INSERT INTO seguridad.Rel_permiso_rol (id_cat_rol, id_permiso)
VALUES
(3,4),(3,5);

-- -----------------------
-- 4) Usuarios
-- -----------------------

INSERT INTO usuario.Usuarios (id_cat_rol, activo, nombres, apellidos, correo, ts_creado)
VALUES
(1, 1, 'Carlos', 'Mendoza Ruiz', 'c.mendoza@example.com',SYSDATETIME()),
(2, 1, 'Luis', 'Aguilar Santos', 'l.aguilar@example.com',SYSDATETIME()),
(2, 1, 'Valeria', 'Torres Hernández', 'v.torres@example.com',SYSDATETIME()),
(3, 1, 'Fernanda', 'Ramos López', 'f.ramos@example.com',SYSDATETIME()),
(3, 1, 'Jorge', 'Martínez Bravo', 'j.martinez@example.com',SYSDATETIME()),
(3, 1, 'Daniela', 'Guzmán Solís', 'd.guzman@example.com',SYSDATETIME()),
(3, 1, 'Eduardo', 'Pérez Vega', 'e.perez@example.com',SYSDATETIME()),
(3, 1, 'Kevin', 'Morales Díaz', 'k.morales@example.com',SYSDATETIME()),
(3, 1, 'Brenda', 'Salinas Flores', 'b.salinas@example.com',SYSDATETIME()),
(3, 1, 'Ricardo', 'Reyes Paredes', 'r.reyes@example.com',SYSDATETIME()),
(3, 1, 'Sofía', 'Navarro Cruz', 's.navarro@example.com',SYSDATETIME()),
(3, 1, 'Héctor', 'Silva Medina', 'h.silva@example.com',SYSDATETIME()),
(3, 1, 'Andrea', 'Hernández Ortiz', 'a.hernandez@example.com',SYSDATETIME()),
(3, 1, 'Miguel', 'Rojas Fuentes', 'm.rojas@example.com',SYSDATETIME()),
(3, 1, 'Paola', 'Castillo Lara', 'p.castillo@example.com',SYSDATETIME()),
(3, 1, 'Roberto', 'Luna Herrera', 'r.luna@example.com',SYSDATETIME()),
(3, 1, 'Monserrat', 'Campos Vera', 'm.campos@example.com',SYSDATETIME()),
(3, 1, 'Diego', 'Núñez Ramos', 'd.nunez@example.com',SYSDATETIME());


-- -----------------------
-- 5) Rutinas
--    (id_creador debe existir: usamos id_usuario 1 y 2)
-- -----------------------

INSERT INTO entrenamiento.Rutinas (id_creador, nombre, nivel, objetivo, tipo_objetivo, es_default, activo)
VALUES
(1, N'Full Body - Principiantes', 1, N'Adaptación neuromuscular y técnica básica', N'Hipertrofia muscular', 1, 1),
(2, N'Fuerza Global 8 semanas', 4, N'Desarrollo de fuerza máxima en ejercicios compuestos', N'Fuerza funcional', 0, 1),
(1, N'Resistencia Cardio 12K', 2, N'Mejora de la capacidad aeróbica para carrera', N'Resistencia muscular', 0, 1),
(2, N'Movilidad y Flexibilidad - Hombros', 1, N'Mejora de rango y prevención de lesiones', N'movilidad y flexibilidad', 0, 1),
(3, N'Reducción Grasa 6 semanas', 3, N'Entrenamiento metabólico y control nutricional', N'Pérdida de grasa corporal', 0, 1),
(2, N'Rehabilitación Lumbar', 1, N'Reforzar control motor y reducir dolor', N'Rehabilitación', 0, 1),
(1, N'Postura y Core', 2, N'Estabilización y corrección postural', N'Postura y equilibrio', 0, 1),
(4, N'Preparación física fútbol', 4, N'Potencia, agilidad y resistencia específica', N'Preparación física para deporte', 0, 1),
(2, N'Hipertrofia Torso', 3, N'Aumento de masa muscular en pecho/espalda', N'Hipertrofia muscular', 0, 1),
(3, N'Circuito Resistencia 30min', 2, N'Sesión intervalada para resistencia muscular', N'Resistencia muscular', 0, 1),
(1, N'Entrenamiento Funcional 3x/sem', 3, N'Mejora de fuerza funcional y coordinación', N'Fuerza funcional', 0, 1),
(4, N'Flexibilidad Dinámica', 1, N'Capacidad de movimiento para deportes explosivos', N'movilidad y flexibilidad', 0, 1),
(2, N'Quema y Tonificación', 2, N'Entrenamientos de alta intensidad para grasa', N'Pérdida de grasa corporal', 0, 1),
(3, N'Programa Rehabilitacion Rodilla', 1, N'Reforzar musculatura y devolver funcionalidad', N'Rehabilitación', 0, 1),
(1, N'Core Avanzado y Estabilidad', 3, N'Control neuromuscular avanzado del core', N'Postura y equilibrio', 0, 1);

-- -----------------------
-- 6) Rel_rutina_usuario (asignaciones)
-- -----------------------
-- Asignar rutina 1 a Luis y Karina, rutina 2 a Luis
INSERT INTO entrenamiento.Rel_rutina_usuario (id_rutina, id_usuario, activo, duracion, dias_semana)
VALUES
(1, 3, 1, 45, 3),
(1, 4, 1, 40, 3),
(2, 3, 1, 60, 2);

-- -----------------------
-- 7) Ejercicios
-- -----------------------

INSERT INTO entrenamiento.Ejercicios (nombre, tipo_ejercicio)
VALUES
(N'Curl bíceps con mancuerna', 'fuerza'),
(N'Press de banca', 'fuerza'),
(N'Peso muerto convencional', 'fuerza'),
(N'Sentadilla trasera', 'fuerza'),
(N'Prensa de pierna', 'fuerza'),
(N'Remo con barra', 'fuerza'),
(N'Face pull en polea', 'fuerza'),
(N'Plancha frontal', 'otros'),
(N'Burpees', 'resistencia'),
(N'Cinta trote continuo 30min', 'resistencia'),
(N'Press militar con barra', 'fuerza'),
(N'Zancada caminando', 'fuerza'),
(N'Russian twist con disco', 'otros'),
(N'Escalador (mountain climber)', 'resistencia'),
(N'Peso muerto rumano', 'fuerza');


-- -----------------------
-- 8) Rel_ejercicio_rutina (mapeo ejercicios -> rutinas)
--    (id_rutina 1 y 2; id_ejercicio 1..8)
-- -----------------------
-- Rutina 1 (Full Body Principiantes): 1,2,8
INSERT INTO entrenamiento.Rel_ejercicio_rutina (id_ejercicio_rutina, id_rutina, id_ejercicio)
VALUES
(1,1,1),(1,1,2),(1,1,8);

-- Rutina 2 (Pierna Avanzada): 4,5,3
INSERT INTO entrenamiento.Rel_ejercicio_rutina (id_ejercicio_rutina, id_rutina, id_ejercicio)
VALUES
(2,2,4),(2,2,5),(2,2,3);

-- -----------------------
-- 9) Equipos
-- -----------------------
INSERT INTO equipo.Equipos (nombre, es_mantenimiento_requerido)
VALUES
(N'Mancuerna', 0),
(N'Barra olímpica', 0),
(N'Banco de press', 0),
(N'Prensa de pierna', 1),
(N'Polea/cable', 1),
(N'Estera/Mat', 0);

-- -----------------------
-- 10) Rel_ejercicio_equipo (qué equipo usa cada ejercicio)
-- -----------------------
-- mapeos de ejemplo
-- Curl bíceps -> Mancuerna (id_equipo 1)
INSERT INTO entrenamiento.Rel_ejercicio_equipo (id_ejercicio, id_equipo)
VALUES
(1,1), -- Curl <-> Mancuerna
(2,3), -- Press de banca <-> Banco de press
(3,2), -- Peso muerto <-> Barra olímpica
(4,2), -- Sentadilla <-> Barra olímpica
(5,4), -- Prensa de pierna <-> Prensa de pierna
(6,2), -- Remo <-> Barra olímpica
(7,5), -- Face pull <-> Polea/cable
(8,6); -- Plancha <-> Estera/Mat

-- -----------------------
-- 11) Mantenimientos
-- -----------------------
INSERT INTO equipo.Mantenimientos (fecha, descripcion, proximo_mantenimiento)
VALUES
('2025-01-10', N'Revisión general prensa de pierna', '2025-07-10'),
('2025-03-05', N'Lubricación polea principal', '2025-09-05');

-- -----------------------
-- 12) Rel_equipo_unidad (vincular mantenimientos a equipos)
-- -----------------------
-- Asumiendo id_mantenimiento 1 y 2; id_equipo 4 = Prensa, 5 = Polea
INSERT INTO equipo.Rel_equipo_unidad (id_equipo, id_mantenimiento, estado)
VALUES
(4, 1, N'Ok - revisión hecha'),
(5, 2, N'Pendiente revisión visual');

-- -----------------------
-- 13) Cat_musculo
-- -----------------------
INSERT INTO entrenamiento.Cat_musculo (tipo_grupo_muscular, tipo_musculo_objetivo)
VALUES
(N'Pecho', N'Pectoral mayor'),
(N'Espalda', N'Dorsal ancho'),
(N'Brazo', N'Bíceps braquial'),
(N'Brazo', N'Tríceps braquial'),
(N'Hombro', N'Deltoides lateral'),
(N'Hombro', N'Deltoides anterior'),
(N'Hombro', N'Deltoides posterior'),
(N'Pecho', N'Trapecio'),
(N'Espalda', N'Romboides'),
(N'Abdomen', N'Abdominales'),
(N'Abdomen', N'Oblicuos'),
(N'Pierna', N'Cuádriceps'),
(N'Pierna', N'Isquiotibiales'),
(N'Cadera', N'Glúteo mayor'),
(N'Pierna', N'Gastrocnemio');


-- -----------------------
-- 14) Rel_ejercicio_musculo
-- -----------------------
-- Mapear ejercicios (1..8) con músculos (1..8)
INSERT INTO entrenamiento.Rel_ejercicio_musculo (id_ejercicio, id_cat_musculo)
VALUES
(1, 1), -- Curl -> Bíceps
(2, 4), -- Press banca -> Pectoral mayor
(3, 3), -- Peso muerto -> Dorsal ancho (y femorales pero queda de ejemplo)
(4, 5), -- Sentadilla -> Cuádriceps
(5, 5), -- Prensa -> Cuádriceps
(6, 3), -- Remo -> Dorsal ancho
(7, 3), -- Face pull -> Dorsal/Trap/Rotadores (simplificado)
(8, 7); -- Plancha -> Rectus abdominis

-- -----------------------
-- 15) Asistencias (ejemplos con DATETIME2)
-- -----------------------
-- Luis (id_usuario=3) entra y sale
INSERT INTO usuario.Asistencias (id_usuario, ts_entrada, ts_salida)
VALUES
(3, '2025-10-20 08:05:00', '2025-10-20 09:10:00'),
(3, '2025-10-22 07:58:00', NULL), -- aún dentro (ejemplo)
(4, '2025-10-21 18:30:00', '2025-10-21 19:05:00'),
(2, '2025-10-22 06:50:00', '2025-10-22 08:00:00'); -- Entrenador

-- ==================================================
-- FIN del poblamiento de ejemplo
-- ==================================================