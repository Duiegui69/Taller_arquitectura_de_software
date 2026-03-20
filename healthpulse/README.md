# Taller Arquitectura de Software - HealthPulse

## Descripción
Este proyecto consiste en el diseño e implementación de una arquitectura de datos para la red de clínicas "HealthPulse", enfocada en modularidad, cohesión y bajo acoplamiento.

---

## Fase 1: Modelado Arquitectónico

Se diseñó un modelo de base de datos con las siguientes entidades:

- Pacientes
- Médicos
- Citas
- Historias Clínicas
- Signos Vitales

El modelo garantiza:
- Alta cohesión
- Bajo acoplamiento
- Relaciones bien definidas

Adicionando tambien que el modelo fue diseñado utilizando DBML para tener claridad estructural y relaciones bien definidas.

```dbml
Table pacientes {
  id integer [pk]
  cedula varchar [unique]
  nombre varchar
  fecha_nacimiento date
  tipo_sangre varchar
}

Table medicos {
  id integer [pk]
  nombre varchar
  tarjeta_profesional varchar [unique]
  especialidad varchar
}

Table citas {
  id integer [pk]
  paciente_id integer
  medico_id integer
  fecha_hora timestamp
  motivo varchar
}

Table historias_clinicas {
  id integer [pk]
  cita_id integer [unique]
  diagnostico varchar
  tratamiento varchar
}

Table signos_vitales {
  id integer [pk]
  paciente_id integer
  frecuencia_cardiaca integer
  temperatura decimal
  fecha_hora timestamp
}

Ref: citas.paciente_id > pacientes.id
Ref: citas.medico_id > medicos.id
Ref: historias_clinicas.cita_id > citas.id
Ref: signos_vitales.paciente_id > pacientes.id
---

## Fase 2: Implementación

Se implementó la base de datos utilizando PostgreSQL con:

- Uso de `SERIAL` para IDs
- Constraints definidos al final (PRIMARY KEY, FOREIGN KEY, UNIQUE)
- Integridad referencial con `ON DELETE`

Y tabien se realizo uso de la base de datos siguiendo buenas prácticas:

-Uso de SERIAL para claves primarias
-Definición de constraints al final de cada tabla
-Convención de nombres clara:
-pk_ para PRIMARY KEY
-fk_ para FOREIGN KEY
-uq_ para UNIQUE

---

## Fase 3: Reflexión Arquitectónica

1. Modularidad

El módulo de monitoreo de signos vitales está desacoplado del resto del sistema, ya que solo depende de la entidad pacientes. Esto permite escalar este módulo de manera independiente o migrarlo a otro servicio sin afectar la operación general del sistema.

2. Acoplamiento

La tabla de citas actúa como núcleo del sistema, conectando pacientes, médicos e historias clínicas. Un cambio estructural en esta tabla impactaría múltiples módulos, lo que evidencia su papel central y el nivel de acoplamiento existente.

3. Cohesión

Separar la historia clínica de la tabla de citas permite mantener responsabilidades bien definidas. La cita representa un evento administrativo, mientras que la historia clínica contiene información médica. Esta separación mejora la mantenibilidad, la escalabilidad y la claridad del modelo de datos.

---
## Diagrama de la Base de Datos

![Diagrama](Diagrama.png)
