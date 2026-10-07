---
title: Diagrama de máquina de estados
tags: [uml]
---

# Diagrama de máquina de estados

## Explicación didáctica

El **diagrama de máquina de estados** (*state machine*) describe la vida de **un solo objeto**: en qué **estados** puede estar y qué **eventos/transiciones** lo hacen pasar de uno a otro. Es la herramienta para modelar objetos con ciclo de vida: pedidos, conexiones, cuentas, máquinas, procesos.

**Cuándo usarlo:**
- Cuando el comportamiento de un objeto depende de **en qué estado está** (no de quién lo llama).
- Para modelar estados con historial, estados compuestos o condiciones complejas.
- Clásicos: estado de un `Pedido`, de una `Conexión`, de un `Cajero`.

**Notación:**
- Estado inicial: `[*] --> Estado`; final: `Estado --> [*]`.
- Transición: `EstadoA --> EstadoB : evento [condición] / acción`.
- **Estado compuesto**: estado que contiene subestados (agrupamiento).
- **Elección** (`choice`): bifurcación con condiciones.
- **Historial**: vuelve al subúltimo estado visitado.

**Lectura de una transición:** *cuando el objeto está en A y recibe el evento E (si se cumple la condición), pasa a B ejecutando la acción entre `/`.*

## Ejemplo 1: Ciclo de vida de un pedido

```plantuml
@startuml
[*] --> Nuevo

Nuevo --> EnValidacion : recibir pedido
EnValidacion --> EnPreparacion : stock OK
EnValidacion --> Rechazado : sin stock
EnPreparacion --> EnEnvio : empacado
EnEnvio --> Entregado : confirmar entrega
EnEnvio --> Devuelto : rechazo en puerta

Entregado --> [*]
Rechazado --> [*]
Devuelto --> [*]

EnPreparacion --> EnPreparacion : agregar ítem
@enduml
```

**Lectura:** *un pedido nace `Nuevo`, se valida, se prepara y se envía; dos caminos terminan mal (`Rechazado`, `Devuelto`) y uno bien (`Entregado`). También puede quedarse en el mismo estado (transición a sí mismo).*

## Ejemplo 2: Conexión con estado compuesto y elección

```plantuml
@startuml
[*] --> Desconectado

state "Conectado" as conectado {
  [*] --> Inactivo
  Inactivo --> Activo : movimiento del mouse
  Activo --> Inactivo : 5 min sin actividad
  Activo --> Transmitiendo : enviar datos
  Transmitiendo --> Activo : cola vacía
}

Desconectado --> conectado : conectar()
conectado --> Desconectado : desconectar()

state "¿Reintentar?" as decidir
conectado --> decidir : falla de red
decidir --> conectado : quedan reintentos
decidir --> Desconectado : reintentos agotados

@enduml
```

**Lectura:** *`Conectado` es un estado compuesto con 3 subestados; tras una falla hay una **elección**: si quedan reintentos vuelve a conectarse, si no corta la sesión.*

## Errores comunes

- Poner **acciones del sistema** como estados (*"Esperando respuesta del usuario"* suele ser un estado; *"Mostrar ventana"* es una acción): los estados describen **situaciones**, no pantallas.
- Olvidar el **estado inicial/final**: toda máquina necesita `[*]`.
- Mezclar **muchos objetos** en una máquina de estados: este diagrama sigue la vida de **un** objeto; si hay intercambio de mensajes, usa un diagrama de secuencia.
