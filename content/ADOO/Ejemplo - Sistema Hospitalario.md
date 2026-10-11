---
tipo: ejemplo-diagrama
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - UML
  - ejemplo
  - hospital
aliases:
  - Casos de uso Hospital
---

# Ejemplo: Diagrama de Casos de Uso — Sistema Hospitalario

## Contexto

Sistema de gestión hospitalaria donde los pacientes agendan citas, los médicos atienden consultas y emiten recetas, los enfermeros administran tratamientos y los administradores gestionan recursos del hospital.

## Diagrama

```plantuml
@startuml
left to right direction
actor "Paciente" as paciente
actor "Médico" as medico
actor "Enfermero" as enfermero
actor "Administrador" as admin
actor "Laboratorio" as lab <<external>>
actor "Farmacia" as farmacia <<external>>

rectangle "Sistema Hospitalario" {
    usecase "Registrarse" as UC0
    usecase "Agendar cita" as UC1
    usecase "Cancelar cita" as UC2
    usecase "Ver historial clínico" as UC3
    usecase "Solicitar receta" as UC4

    usecase "Atender consulta" as UC5
    usecase "Emitir receta" as UC6
    usecase "Solicitar examen" as UC7
    usecase "Ver resultados de examen" as UC8
    usecase "Registrar diagnóstico" as UC9
    usecase "Gestionar agenda" as UC10

    usecase "Administrar tratamiento" as UC11
    usecase "Registrar signos vitales" as UC12
    usecase "Aplicar medicación" as UC13
    usecase "Reportar incidencia" as UC14

    usecase "Gestionar personal" as UC15
    usecase "Gestionar habitaciones" as UC16
    usecase "Ver reportes" as UC17
    usecase "Gestionar inventario" as UC18

    usecase "Procesar examen" as UC19
    usecase "Enviar resultados" as UC20

    usecase "Despachar medicación" as UC21
}

paciente --> UC0
paciente --> UC1
paciente --> UC2
paciente --> UC3
paciente --> UC4

medico --> UC5
medico --> UC6
medico --> UC7
medico --> UC8
medico --> UC9
medico --> UC10

enfermero --> UC11
enfermero --> UC12
enfermero --> UC13
enfermero --> UC14

admin --> UC15
admin --> UC16
admin --> UC17
admin --> UC18

UC1 ..> UC0 : <<include>>
UC1 ..> UC10 : <<include>>
UC5 ..> UC9 : <<include>>
UC13 ..> UC21 : <<include>>
UC7 ..> UC19 : <<include>>

UC4 ..> UC6 : <<extend>>
UC14 ..> UC11 : <<extend>>

UC19 --> lab
UC20 --> lab
UC21 --> farmacia
@enduml
```

## Desglose por Actor

### Paciente
| Caso de Uso | Descripción |
| --- | --- |
| Registrarse | Crea su cuenta con datos personales y seguro médico. |
| Agendar cita | Solicita una cita con un médico en un horario disponible. |
| Cancelar hora | Anula una cita programada con aviso previo. |
| Ver historial clínico | Consulta diagnósticos, tratamientos y exámenes anteriores. |
| Solicitar receta | *(extiende* Emitir receta*)* Solicita renovación de medicamentos recetados. |

### Médico
| Caso de Uso | Descripción |
| --- | --- |
| Atender consulta | Realiza la evaluación clínica del paciente. |
| Emitir receta | Genera una prescripción médica con medicamentos y dosis. |
| Solicitar examen | Pide análisis de laboratorio o imágenes médicas. |
| Ver resultados de examen | Consulta los resultados de exámenes solicitados. |
| Registrar diagnóstico | Documenta el diagnóstico según códigos médicos (CIE-10). |
| Gestionar agenda | Configura sus horarios disponibles para citas. |

### Enfermero
| Caso de Uso | Descripción |
| --- | --- |
| Administrar tratamiento | Supervisa la aplicación de tratamientos hospitalizados. |
| Registrar signos vitales | Registra temperatura, presión, frecuencia cardíaca, etc. |
| Aplicar medicación | Administra medicamentos prescritos al paciente. |
| Reportar incidencia | *(extiende* Administrar tratamiento*)* Documenta eventos adversos o reacciones. |

### Administrador
| Caso de Uso | Descripción |
| --- | --- |
| Gestionar personal | Alta, baja y asignación de médicos, enfermeros y administrative. |
| Gestionar habitaciones | Control de disponibilidad, asignación y mantenimiento. |
| Ver reportes | Estadísticas de pacientes atendidos, ocupación, tiempos de espera. |
| Gestionar inventario | Control de stock de medicamentos, insumos y equipamiento. |

### Actores Externos
| Caso de Uso | Descripción |
| --- | --- |
| Procesar examen | El laboratorio procesa las muestras y genera resultados. |
| Enviar resultados | El laboratorio envía resultados al sistema para consulta del médico. |
| Despachar medicación | La farmacia prepara y entrega los medicamentos prescritos. |

## Relaciones Clave

- **`<<include>>`** — Agendar cita incluye Registrarse y Gestionar agenda. Atender consulta incluye Registrar diagnóstico. Aplicar medicación incluye Despachar medicación. Solicitar examen incluye Procesar examen.
- **`<<extend>>`** — Solicitar receta se activa **opcionalmente** desde Emitir receta (renovación). Reportar incidencia se activa **opcionalmente** desde Administrar tratamiento (cuando hay un evento adverso).
- **Actores externos** — Laboratorio y Farmacia son sistemas/instituciones externas que se integran al sistema hospitalario.
