-- Create tables
CREATE TABLE IF NOT EXISTS usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS odontologos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    especialidad VARCHAR(20) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

CREATE TABLE IF NOT EXISTS responsables (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    parentesco VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS pacientes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    mutua BOOLEAN NOT NULL,
    responsable_id BIGINT,
    FOREIGN KEY (responsable_id) REFERENCES responsables(id)
);

CREATE TABLE IF NOT EXISTS visitas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    paciente_id BIGINT NOT NULL,
    odontologo_id BIGINT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    motivo VARCHAR(255),
    observacion TEXT,
    tratamiento TEXT,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (odontologo_id) REFERENCES odontologos(id)
);

-- Insert initial data
INSERT INTO usuarios (username, password, rol) VALUES
('admin', 'admin123', 'ADMIN'),
('odontologo1', 'odonto123', 'ODONTO');

INSERT INTO odontologos (nombre, especialidad, hora_inicio, hora_fin) VALUES
('Dr. Juan Pérez', 'ORTODONCIA', '08:00:00', '15:00:00'),
('Dra. María García', 'ENDODONCIA', '09:00:00', '16:00:00'),
('Dr. Carlos López', 'PERIODONCIA', '10:00:00', '17:00:00');

INSERT INTO responsables (nombre, parentesco) VALUES
('Ana Martínez', 'Madre'),
('José Rodríguez', 'Padre'),
('María Sánchez', 'Tutora');

INSERT INTO pacientes (nombre, fecha_nacimiento, mutua, responsable_id) VALUES
('Pedro Martínez', '2010-05-15', true, 1),
('Laura Rodríguez', '2008-03-20', false, 2),
('Juan Sánchez', '2012-11-10', true, 3),
('María López', '1995-07-25', false, NULL);

INSERT INTO visitas (paciente_id, odontologo_id, fecha_hora, motivo, observacion, tratamiento) VALUES
(1, 1, '2024-03-20 10:00:00', 'Revisión ortodoncia', 'Buen progreso', 'Ajuste brackets'),
(2, 2, '2024-03-21 11:00:00', 'Dolor molar', 'Caries profunda', 'Endodoncia'),
(3, 3, '2024-03-22 12:00:00', 'Revisión periodontal', 'Limpieza necesaria', 'Limpieza profunda'); 