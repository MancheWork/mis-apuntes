---
title: Diagrama de tiempo
tags: [uml]
---

# Diagrama de tiempo

## Explicación didáctica

El **diagrama de tiempo** (*timing*) es un diagrama **cuantitativo**: muestra cómo cambian los **estados de los participantes a lo largo de una línea de tiempo concreta**. A diferencia de la máquina de estados (que dice *qué puede pasar*), el timing dice *cuándo pasa exactamente*: milisegundos, ciclos, unidades de tiempo.

**Cuándo usarlo:**
- Sistemas **en tiempo real**, embebidos, protocolos de red, sensores, audio/video.
- Cuando los requisitos dicen *"en menos de 200 ms"* o *"cada 500 µs"*.
- Para modelar **protocolos de comunicación** (líneas de vida con estados y umbrales).

**Notación (sintaxis PlantUML):**
- `robust "Nombre" as X` → participante con **múltiples estados** visibles.
- `concise "Nombre" as Y` → participante con **un solo estado** a la vez.
- `@0`, `@100`... → **marcas de tiempo** (las unidades las defines tú: ms, µs, s).
- `X is Estado` → el participante X pasa a ese estado en ese instante.
- Se pueden marcar **periodos** con `highlight` y umbrales con `@` sobre un participante.

**Idea clave:** *el eje horizontal es el **tiempo real**; la altura muestra simultáneamente a todos los participantes, así que se ven las **relaciones de causa-efecto** entre ellos.*

## Ejemplo 1: Petición HTTP con tiempos de respuesta

```plantuml
@startuml
robust "Navegador" as nav
concise "Servidor" as srv

@0
nav is Idle
srv is Idle

@100
nav is Requesting

@150
srv is Processing
nav is Waiting

@300
srv is Responding
nav is Receiving

@400
nav is Idle
srv is Idle

nav@150 -> srv@300 : 150 ms de respuesta
@enduml
```

**Lectura:** *a los 100 ms el navegador pide; a los 150 ms el servidor empieza a procesar y el navegador espera; a los 300 ms llega la respuesta: el navegador estuvo esperando 150 ms.*

## Ejemplo 2: Sensor de alarma con estados concisos

```plantuml
@startuml
concise "Sensor PIR" as sensor
robust "Central" as central
robust "Sirena" as sirena

@0
sensor is Monitoreando
central is Armada
sirena is Silenciosa

@2000
sensor is DetectandoMovimiento

@2100
central is Evaluando
sirena is Silenciosa

@2300
central is Alarmada
sirena is Sonando

@5000
sensor is Monitoreando
central is Armada
sirena is Silenciosa

sensor@2100 -> central@2300 : demora de análisis
@enduml
```

**Lectura:** *el sensor detecta a los 2000; la central tarda 300 ms en evaluar y alarmar; la sirena suena 2700 ms y todo vuelve al reposo a los 5000.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: documentar la latencia de un sensor con **toda la notación de tiempo**: participantes `concise` y `robust`, marcas de tiempo, estados `is`, flechas entre participantes y ventana `highlight`.*

### Paso 1 — un participante concise con marcas

**Añade:** `concise` (un solo estado visible), marcas `@tiempo` y cambio de estado `X is Estado`.

```plantuml
@startuml
concise "Sensor" as s

@0
s is Monitoreando
@100
s is Detectando
@250
s is Monitoreando
@enduml
```

### Paso 2 — un participante robust y la flecha entre ambos

**Añade:** `robust` (varios estados visibles en paralelo) y la **flecha de relación** `A@t1 -> B@t2 : etiqueta`.

```plantuml
@startuml
concise "Sensor" as s
robust "Central" as c

@0
s is Monitoreando
c is Armada
@100
s is Detectando
@130
c is Evaluando
@200
c is Alarmada
s is Monitoreando

s@130 -> c@200 : 70 ms de reaccion
@enduml
```

### Paso 3 — notación completa (ventana highlight y ejes de tiempo)

**Añade:** ventana **`highlight desde hasta`** para remarcar un periodo crítico, ambos tipos de participante juntos y flecha etiquetada entre puntos concretos del tiempo.

```plantuml
@startuml
robust "Servidor Web" as web
concise "BD" as db

@0
web is Libre
db is Libre
highlight 150 to 300
@150
web is Cargando
@190
db is Consultando
@250
db is Libre
@300
web is Libre

web@190 -> db@250 : consulta (60 ms)
db@250 -> web@300 : resultado (50 ms)
@enduml
```

**Cómo se lee el Paso 3:** la banda `highlight 150 a 300` es la **ventana crítica** de tiempo; dentro de ella, las flechas `web@190 -> db@250` miden duraciones concretas entre instantes de participantes distintos.

## Errores comunes

- Usar tiempos **sin unidades definidas**: aclara en una nota si `@100` es ms, µs o ciclos de reloj.
- Poner **estados que no existen** en la máquina de estados: cada estado del timing debe corresponder a un estado definido en el diagrama de estados correspondiente.
- Olvidar que el eje es **tiempo**, no orden de mensajes: si necesitas ver mensajes, usa el diagrama de secuencia.
