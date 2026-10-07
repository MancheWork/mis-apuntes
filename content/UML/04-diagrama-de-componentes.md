---
title: Diagrama de componentes
tags: [uml]
---

# Diagrama de componentes

## Explicación didáctica

El **diagrama de componentes** muestra las **piezas físicas del software** (componentes) y cómo se conectan entre sí a través de **interfaces**. Un *componente* es una unidad reemplazable del sistema con interfaces bien definidas: un servicio REST, una librería, un módulo, un microservicio.

**Cuándo usarlo:**
- Para modelar la **arquitectura de software** (piezas + contratos).
- Antes de un refactor: obliga a pensar en **interfaces**, no en implementaciones.
- Para documentar sistemas embebidos o basados en frameworks.

**Notación:**
- Componente: rectángulo con la **interfaz en el borde** (icono de "pastilla"/reloj de arena) o el estereotipo `<<component>>`.
- **Interfaz requerida** (pin/bola huerfana) vs. **interfaz provista**: el clásico "ball and socket"; en PlantUML se conecta con `--` y él dibuja la bola/zócalo en el extremo de la interfaz.
- Dependencia entre componentes: `..>`.

**Idea clave:** *un componente es una caja negra: solo importa lo que expone, no cómo está hecho por dentro* (para ver por dentro usarías el diagrama de estructura compuesta).

## Ejemplo 1: Aplicación web en tres piezas

```plantuml
@startuml
skinparam componentStyle rectangle

component "Interfaz Web\n(HTML + JS)" as web
component "API REST\n(Python/Flask)" as api
component "Base de Datos\n(PostgreSQL)" as db

interface "HTTPS / JSON" as http
interface "SQL" as sql

web -- http
http -- api
api -- sql
sql -- db

web ..> api : consume
api ..> db : consulta
@enduml
```

**Lectura:** *la Interfaz Web necesita la interfaz `HTTPS/JSON` que la API REST provee; la API a su vez necesita `SQL`, que provee la Base de Datos. La bola entra en el zócalo: los contratos coinciden.*

## Ejemplo 2: Librerías de un sistema de pagos (estereotipos y dependencias)

```plantuml
@startuml
component "PasarelaDePagos" as pasarela <<monolito>>
component "LibreriaCriptografia" as crypto
component "NotificadorEmail" as mail
component "PasarelaExterna\n(Stripe)" as stripe

interface "DatosDeTarjeta" as datos
interface "EventoPago" as evento
interface Notificador

pasarela -- datos
crypto -- datos
pasarela ..|> evento
pasarela ..> stripe : HTTPS
pasarela ..> mail : notifica
mail ..|> Notificador
@enduml
```

**Lectura:** *la pasarela usa criptografía para tratar los datos de tarjeta (interfaz compartida), publica eventos de pago, llama a un servicio externo por HTTPS y notifica por email a través de la interfaz `Notificador`.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: modelar una tienda online con **toda la notación de componentes**: interfaces (bola/zócalo), dependencias, realizaciones, estereotipos, anidación y notas.*

### Paso 1 — componentes e interfaces

**Añade:** `component` y las `interface` conectadas con `--` (PlantUML dibuja la bola y el zócalo).

```plantuml
@startuml
component "Frontend Web" as front
component "API Tienda" as api
component "Base de Datos" as db

interface "HTTPS" as https
interface "SQL" as sql

front -- https
https -- api
api -- sql
sql -- db
@enduml
```

### Paso 2 — dependencias y realizaciones

**Añade:** dependencia `..>` (usa), realización `..|>` (implementa) y estereotipo `<<...>>` para tipificar el componente.

```plantuml
@startuml
component "Frontend Web" as front <<aplicacion>>
component "API Tienda" as api <<servicio>>
component "Motor de Precios" as motor
component "Base de Datos" as db <<almacen>>

interface "HTTPS" as https
interface "Precios" as iprecios

front --> api : HTTPS
api ..> iprecios
iprecios ..|> motor
api --> db : SQL
@enduml
```

### Paso 3 — notación completa (anidación y notas)

**Añade:** componentes **dentro** de otros (composición de componentes), interfaces internas con `{}`, nota sobre un componente y paquete agrupador.

```plantuml
@startuml
skinparam componentStyle rectangle

package "Sistema de Ventas" {
  component "Tienda Online" as tienda {
    interface "Catalogo" as cat
    interface "Carrito" as car
    component "Buscador" as buscador
    component "Checkout" as checkout
  }

  component "Pasarela de Pagos" as pasarela <<externo>>
  component "Servidor Correo" as correo <<externo>>

  tienda ..> pasarela : cobra por HTTPS
  tienda ..> correo : notifica
  note right of pasarela
    Proveedor externo:
    no lo controlamos,
    solo su contrato.
  end note
}

buscador -- cat
checkout -- car
@enduml
```

**Cómo se lee el Paso 3:** `Tienda Online` es un componente que **contiene** interfaces y subcomponentes; fuera, depende de dos proveedores externos con `..>` y la nota documenta que solo conocemos su contrato (la interfaz).

## Errores comunes

- Dibujar **clases** en vez de componentes: si el rectángulo tiene atributos/métodos en 3 cajones, es una clase.
- Conectar componentes **directamente** sin interfaces: en componentes, el acople se hace solo por contratos explícitos.
- Mezclar hardware con software: los servidores y cables pertenecen al diagrama de **despliegue**.
