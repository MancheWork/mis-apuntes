---
title: Diagrama de secuencia
tags: [uml]
---

# Diagrama de secuencia

## Explicación didáctica

El **diagrama de secuencia** es el diagrama dinámico más usado: muestra los **mensajes** que se intercambian los objetos **en orden temporal**, de arriba hacia abajo. Cada participante tiene una **línea de vida** (lifeline) vertical y cada mensaje es una flecha horizontal.

**Cuándo usarlo:**
- Para diseñar/detallar **un escenario concreto** de un caso de uso ("¿qué pasa cuando el usuario paga?").
- Para entender y explicar **colaboraciones entre objetos** paso a paso.
- Es el diagrama que mejor traduce a código: cada línea de vida suele ser una clase/objeto real.

**Notación:**
- **Participantes**: `actor`, `participant`, `entity`, `control`, `database`, `boundary`.
- Mensaje **síncrono** `->` (espera respuesta), **asíncrono** `->>` (no espera), retorno `-->`.
- **Activación** (barra de vida activa): `activate` / `deactivate` (o automático con `autonumber`).
- **Fragmentos** (marcos de interacción):
  - `alt/else` = alternativa (if/else)
  - `opt` = opcional
  - `loop` = repetición
  - `par` = paralelo
  - `note over / note left` = notas
- `create X` crea el objeto; `destroy X` lo elimina.
- `autonumber` numera los mensajes automáticamente (útil para explicar).

## Ejemplo 1: Login con alternativa (alt/else)

```plantuml
@startuml
autonumber

actor "Usuario" as u
participant "Formulario" as form
participant "Servidor de Auth" as auth
database "Base de Datos" as db

u -> form : ingresar email y contraseña
form -> auth : POST /login {email, pass}
activate auth
auth -> db : SELECT usuario por email
db --> auth : registro (hash)
auth -> auth : verificar contraseña

alt credenciales válidas
  auth --> form : 200 OK + token
  form --> u : mostrar panel
else credenciales inválidas
  auth --> form : 401 Unauthorized
  form --> u : "Usuario o contraseña incorrectos"
end

deactivate auth
@enduml
```

**Lectura:** *secuencia completa de un login; el fragmento `alt` cubre los dos escenarios posibles (éxito/error) sin necesidad de dos diagramas.*

## Ejemplo 2: Compra con creación de objetos y nota

```plantuml
@startuml
skinparam responseMessageBelowArrow true

participant "Cliente" as c
participant "Carrito" as car
participant "Servicio de Pagos" as pago
participant "Servidor de Correo" as mail

c -> car : agregar(libro)
c -> car : finalizar compra
car -> pago : cobrar(total)
activate pago
pago --> car : idPago = 8842
deactivate pago

note right of pago
  Se persiste la venta
  con estado PAGADA
end note

car -> mail : enviarComprobante(cliente)
mail --> car : ok
car --> c : mostrar confirmación
@enduml
```

**Lectura:** *el Carrito orquesta la operación: cobra al Servicio de Pagos, registra una nota con el id y pide el comprobante al servidor de correo antes de responder al Cliente.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: detallar la reserva de una mesa con **toda la notación de secuencia**: tipos de participante, mensajes síncrono/asíncrono/retorno, `activate`, mensajes a sí mismo, `create`/`destroy`, fragmentos, divisores, `box`, notas y numeración automática.*

### Paso 1 — participantes y mensajes

**Añade:** `autonumber`, participantes con tipo (`actor`, `participant`, `database`) y mensaje con retorno `-->`.

```plantuml
@startuml
autonumber

actor "Cliente" as cli
participant "Mozo" as mozo
database "Reservas" as db

cli -> mozo : reservar mesa 4
mozo -> db : buscarDisponibilidad()
db --> mozo : libre
mozo --> cli : confirmada
@enduml
```

### Paso 2 — activación, asíncronos y mensajes a sí mismo

**Añade:** `activate`/`deactivate`, mensaje **asíncrono** `->>` (no espera) y **automensaje** (la flecha que sale y regresa al mismo participante).

```plantuml
@startuml
autonumber

actor "Cliente" as cli
participant "App" as app
participant "Servicio Notificaciones" as noti
database "Reservas" as db

cli -> app : reservar mesa 4
activate app
app -> db : guardar()
db --> app : OK

app ->> noti : enviarConfirmacion()   (asincrono: no espera)
app --> cli : reserva confirmada
deactivate app

app -> app : limpiarCache()
@enduml
```

### Paso 3 — notación completa (fragmentos, creación/destrucción y estructura)

**Añade:** fragmento `alt/else`, nota sobre mensaje, `create`/`destroy` de participantes, separador de fases `== ... ==`, `box` de agrupación y nota lateral.

```plantuml
@startuml
autonumber

actor "Cliente" as cli
box "Frontend" #EFEFEF
  participant "App" as app
  participant "Pagina Web" as web
end box
participant "Servicio Mesa" as srv
database "Base de Datos" as db

cli -> web : elegir horario
web -> app : solicitar()
alt horario disponible
  create srv
  app -> srv : reservar(horario)
  activate srv
  srv -> db : INSERT reserva
  db --> srv : OK
  srv --> app : confirmada
  deactivate srv
  note right of srv
    El return puede ir debajo
    con responseMessageBelowArrow.
  end note
else horario ocupado
  app --> cli : proponer alternativa
end

== Cierre ==
app -> app : guardar en local
destroy srv
@enduml
```

**Cómo se lee el Paso 3:** el `box` agrupa los participantes del frontend, `create`/`destroy` marcan cuándo nace y muere el Servicio Mesa, el fragmento `alt` cubre los dos escenarios y el separador `== Cierre ==` divide las fases de tiempo.

## Errores comunes

- Flechas **hacia atrás en el tiempo** (un mensaje que retorna antes de haber ido): el eje vertical es el tiempo.
- Ordenar participantes alfabéticamente: ordénalos por **colaboración** (izquierda = quien inicia).
- Usar secuencia para **todo el sistema**: un diagrama = **un escenario**. Para el diagrama general de clases, usa el diagrama de clases.
