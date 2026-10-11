---
tipo: ejemplo-diagrama
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - UML
  - ejemplo
  - bancario
aliases:
  - Casos de uso Banco
---

# Ejemplo: Diagrama de Casos de Uso — Sistema Bancario

## Contexto

Sistema bancario donde los clientes realizan operaciones financieras, los cajeros atienden en sucursal, los asesores gestionan productos financieros y un sistema centraliza las transacciones.

## Diagrama

```plantuml
@startuml
left to right direction
actor "Cliente" as cliente
actor "Cajero" as cajero
actor "Asesor" as asesor
actor "Sistema Central" as central <<external>>

rectangle "Sistema Bancario" {
    usecase "Iniciar sesión" as UC0
    usecase "Consultar saldo" as UC1
    usecase "Transferir dinero" as UC2
    usecase "Depositar efectivo" as UC3
    usecase "Retirar efectivo" as UC4
    usecase "Pagar servicio" as UC5
    usecase "Solicitar préstamo" as UC6
    usecase "Ver.extracto" as UC7
    usecase "Configurar alertas" as UC8

    usecase "Atender cliente" as UC9
    usecase "Procesar depósito" as UC10
    usecase "Procesar retiro" as UC11
    usecase "Validar identidad" as UC12

    usecase "Evaluar riesgo" as UC13
    usecase "Aprobar préstamo" as UC14
    usecase "Rechazar préstamo" as UC15
    usecase "Crear cuenta" as UC16
    usecase "Cerrar cuenta" as UC17

    usecase "Registrar transacción" as UC18
    usecase "Verificar fondos" as UC19
}

cliente --> UC0
cliente --> UC1
cliente --> UC2
cliente --> UC3
cliente --> UC4
cliente --> UC5
cliente --> UC6
cliente --> UC7
cliente --> UC8

cajero --> UC9
cajero --> UC10
cajero --> UC11
cajero --> UC12

asesor --> UC13
asesor --> UC14
asesor --> UC15
asesor --> UC16
asesor --> UC17

UC2 ..> UC19 : <<include>>
UC2 ..> UC18 : <<include>>
UC3 ..> UC18 : <<include>>
UC4 ..> UC19 : <<include>>
UC4 ..> UC18 : <<include>>
UC5 ..> UC18 : <<include>>
UC10 ..> UC18 : <<include>>
UC11 ..> UC18 : <<include>>

UC6 ..> UC13 : <<include>>
UC14 ..> UC18 : <<include>>
UC15 ..> UC18 : <<include>>

UC12 ..> UC0 : <<extend>>

UC18 --> central
UC19 --> central
@enduml
```

## Desglose por Actor

### Cliente
| Caso de Uso | Descripción |
| --- | --- |
| Iniciar sesión | Se autentica con credenciales o biometría. |
| Consultar saldo | Ve el saldo disponible en sus cuentas. |
| Transferir dinero | Envía dinero a otra cuenta (propia o de terceros). |
| Depositar efectivo | Ingresa dinero en efectivo a su cuenta. |
| Retirar efectivo | Saca dinero de su cuenta. |
| Pagar servicio | Paga boletas de servicios básicos (agua, luz, etc.). |
| Solicitar préstamo | Solicita un crédito con monto y plazo. |
| Ver extracto | Consulta el historial de transacciones del mes. |
| Configurar alertas | Define notificaciones por email/SMS para movimientos. |

### Cajero (Sucursal)
| Caso de Uso | Descripción |
| --- | --- |
| Atender cliente | Inicia la atención presencial en ventanilla. |
| Procesar depósito | Registra un depósito en efectivo o cheque. |
| Procesar retiro | Procesa un retiro con validación de identidad. |
| Validar identidad | *(extiende* Iniciar sesión*)* Verifica identidad con documento físico. |

### Asesor Financiero
| Caso de Uso | Descripción |
| --- | --- |
| Evaluar riesgo | Analiza el perfil crediticio del cliente para un préstamo. |
| Aprobar préstamo | Aprueba la solicitud y genera el contrato. |
| Rechazar préstamo | Rechaza la solicitud con motivo registrado. |
| Crear cuenta | Apertura una nueva cuenta bancaria para un cliente. |
| Cerrar cuenta | Cierra una cuenta existente (previa liquidación). |

### Actor Externo
| Caso de Uso | Descripción |
| --- | --- |
| Registrar transacción | El sistema central registra cada movimiento en la base de datos. |
| Verificar fondos | Consulta si hay fondos suficientes antes de una operación. |

## Relaciones Clave

- **`<<include>>`** — Transferir, retirar y pagar siempre incluyen Verificar fondos y Registrar transacción. Solicitar préstamo incluye Evaluar riesgo.
- **`<<extend>>`** — Validar identidad se activa **opcionalmente** en el Iniciar sesión cuando el monto supera un umbral.
- **Actor externo** — El Sistema Central es el backbone que valida y persiste todas las transacciones.
