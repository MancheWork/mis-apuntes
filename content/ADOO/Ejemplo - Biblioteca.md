---
tipo: ejemplo-diagrama
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - UML
  - ejemplo
  - biblioteca
aliases:
  - Casos de uso Biblioteca
---

# Ejemplo: Diagrama de Casos de Uso — Biblioteca

## Contexto

Sistema de gestión de biblioteca donde los socios pueden buscar, reservar y devolver libros, los bibliotecarios gestionan el catálogo y el inventario, y el sistema notifica automáticamente vencimientos.

## Diagrama

```plantuml
@startuml
left to right direction
actor "Socio" as socio
actor "Bibliotecario" as bili
actor "Sistema de Notificaciones" as notif <<external>>

rectangle "Sistema Biblioteca" {
    usecase "Buscar libro" as UC1
    usecase "Ver detalle del libro" as UC2
    usecase "Reservar libro" as UC3
    usecase "Devolver libro" as UC4
    usecase "Consultar mis préstamos" as UC5
    usecase "Pagar multa" as UC6
    usecase "Registrarse como socio" as UC7

    usecase "Registrar nuevo libro" as UC8
    usecase "Actualizar información de libro" as UC9
    usecase "Eliminar libro" as UC10
    usecase "Registrar préstamo" as UC11
    usecase "Registrar devolución" as UC12
    usecase "Cobrar multa" as UC13
    usecase "Gestionar socios" as UC14
    usecase "Ver reportes" as UC15

    usecase "Notificar vencimiento" as UC16
    usecase "Confirmar reserva" as UC17
}

socio --> UC1
socio --> UC2
socio --> UC3
socio --> UC4
socio --> UC5
socio --> UC6
socio --> UC7

bili --> UC8
bili --> UC9
bili --> UC10
bili --> UC11
bili --> UC12
bili --> UC13
bili --> UC14
bili --> UC15

UC3 ..> UC2 : <<include>>
UC3 ..> UC5 : <<include>>
UC4 ..> UC12 : <<include>>
UC11 ..> UC1 : <<include>>

UC16 ..> UC5 : <<extend>>
UC17 ..> UC3 : <<extend>>

UC16 --> notif
UC17 --> notif
@enduml
```

## Desglose por Actor

### Socio
| Caso de Uso | Descripción |
| --- | --- |
| Buscar libro | Busca por título, autor, ISBN o categoría. |
| Ver detalle del libro | Consulta disponibilidad, sinopsis y ubicación en estantería. |
| Reservar libro | Aparta un libro que está prestado o en proceso de devolución. |
| Devolver libro | Devuelve un libro previamente prestado. |
| Consultar mis préstamos | Ve el estado de sus préstamos activos y fechas de vencimiento. |
| Pagar multa | Realiza el pago de multas por retraso en devoluciones. |
| Registrarse como socio | Crea su cuenta con datos personales y carné de biblioteca. |

### Bibliotecario
| Caso de Uso | Descripción |
| --- | --- |
| Registrar nuevo libro | Ingresa un título al catálogo con datos bibliográficos y ejemplares. |
| Actualizar información de libro | Modifica datos de un libro existente. |
| Eliminar libro | Retira un libro del catálogo (dado de baja). |
| Registrar préstamo | Registra la salida de un libro a un socio. |
| Registrar devolución | Registra la recepción de un libro devuelto. |
| Cobrar multa | Registra el cobro de una multa por retraso. |
| Gestionar socios | Alta, baja y modificación de cuentas de socios. |
| Ver reportes | Consulta estadísticas de préstamos, socios más activos, libros más prestados. |

### Actor Externo
| Caso de Uso | Descripción |
| --- | --- |
| Notificar vencimiento | Envía alertas automáticas por email o SMS cuando un préstamo está por vencer. |
| Confirmar reserva | Notifica al socio que su reserva está lista para retirar. |

## Relaciones Clave

- **`<<include>>`** — Reservar libro incluye Ver detalle y Consultar mis préstamos. Devolver libro incluye Registrar devolución.
- **`<<extend>>`** — Notificar vencimiento se activa **opcionalmente** cuando se detecta un préstamo próximo a vencer. Confirmar reserva se activa **opcionalmente** cuando un libro reservado está disponible.
