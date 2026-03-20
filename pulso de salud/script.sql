CREATE TABLE pacientes (
    id SERIAL,
    cedula VARCHAR(20),
    nombre VARCHAR(100),
    fecha_nacimiento DATE,
    tipo_sangre VARCHAR(5),

    CONSTRAINT pk_pacientes PRIMARY KEY (id),
    CONSTRAINT uq_pacientes_cedula UNIQUE (cedula)
);

CREATE TABLE medicos (
    id SERIAL,
    nombre VARCHAR(100),
    tarjeta_profesional VARCHAR(50),
    especialidad VARCHAR(100),

    CONSTRAINT pk_medicos PRIMARY KEY (id),
    CONSTRAINT uq_medicos_tarjeta UNIQUE (tarjeta_profesional)
);

CREATE TABLE citas (
    id SERIAL,
    paciente_id INTEGER,
    medico_id INTEGER,
    fecha_hora TIMESTAMP,
    motivo VARCHAR(255),

    CONSTRAINT pk_citas PRIMARY KEY (id),
    CONSTRAINT fk_citas_paciente FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_citas_medico FOREIGN KEY (medico_id)
        REFERENCES medicos(id)
        ON DELETE SET NULL
);

CREATE TABLE historias_clinicas (
    id SERIAL,
    cita_id INTEGER,
    diagnostico VARCHAR(255),
    tratamiento VARCHAR(255),

    CONSTRAINT pk_historias PRIMARY KEY (id),
    CONSTRAINT uq_historia_cita UNIQUE (cita_id),
    CONSTRAINT fk_historia_cita FOREIGN KEY (cita_id)
        REFERENCES citas(id)
        ON DELETE CASCADE
);

CREATE TABLE signos_vitales (
    id SERIAL,
    paciente_id INTEGER,
    frecuencia_cardiaca INTEGER,
    temperatura DECIMAL,
    fecha_hora TIMESTAMP,

    CONSTRAINT pk_signos PRIMARY KEY (id),
    CONSTRAINT fk_signos_paciente FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id)
        ON DELETE CASCADE
);


INSERT INTO pacientes (cedula, nombre, fecha_nacimiento, tipo_sangre)
VALUES ('123456789', 'Juan Perez', '1990-05-10', 'O+');

INSERT INTO medicos (nombre, tarjeta_profesional, especialidad)
VALUES ('Dra. Ana Lopez', 'MED123', 'Cardiologia');

INSERT INTO citas (paciente_id, medico_id, fecha_hora, motivo)
VALUES (1, 1, '2026-03-20 10:00:00', 'Chequeo general');

INSERT INTO historias_clinicas (cita_id, diagnostico, tratamiento)
VALUES (1, 'Paciente estable', 'Reposo');

INSERT INTO signos_vitales (paciente_id, frecuencia_cardiaca, temperatura, fecha_hora)
VALUES (1, 75, 36.5, '2026-03-20 10:05:00');

----------------
INSERT INTO signos_vitales (paciente_id, frecuencia_cardiaca, temperatura, fecha_hora)
VALUES (1, 75, 36.5, '2026-03-20 10:05:00');

SELECT * FROM pacientes;
SELECT * FROM medicos;
SELECT * FROM citas;
SELECT * FROM historias_clinicas;
SELECT * FROM signos_vitales;
