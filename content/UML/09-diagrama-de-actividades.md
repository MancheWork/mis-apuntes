---
title: Diagrama de actividades
tags: [uml]
---

# Diagrama de actividades

## Explicación didáctica

El **diagrama de actividades** modela el **flujo de trabajo** (workflow): actividades, decisiones, paralelismos y responsables. Es casi un flowchart, pero con la notación semántica de UML: ideal para describir **procesos de negocio** o la lógica interna de un caso de uso.

**Cuándo usarlo:**
- Para describir **cómo se cumple** un caso de uso paso a paso.
- Para procesos con **condiciones** (`if`), **paralelismo** (`fork`) o **bandas de responsabilidad** (swimlanes).
- Para algoritmos vistos "de alto nivel" antes de programar.

**Notación (sintaxis "nueva" de PlantUML):**

| Elemento | Sintaxis PlantUML |
| --- | --- |
| Inicio / fin | `start` / `stop` |
| Actividad | `:Descripción;` |
| Decisión | `if (condición?) then (sí) ... else (no) ... endif` |
| Bifurcación paralela | `fork ... fork again ... end fork` |
| Banda (swimlane) | `\|Nombre de banda\|` |
| Barra final | `end` (implícito con stop) |
| Subproceso / llamada | `: actividad;` con nota |

**Regla de oro:** el flujo sale del **nodo inicial** (`●`) y termina en uno o varios **finales** (`◉`).

## Ejemplo 1: Inscripción a una materia con decisión

```plantuml
@startuml
|Alumno|
start
:Elegir materia;
if (¿Hay cupo disponible?) then (sí)
  :Completar datos;
  if (¿Pago realizado?) then (sí)
    :Confirmar inscripción;
    :Recibir comprobante;
    stop
  else (no)
    :Ir a caja / pagar;
    :Confirmar inscripción;
    stop
  endif
else (no)
  :Anotarse en lista de espera;
  stop
endif
@enduml
```

**Lectura:** *dos decisiones encadenadas (cupo y pago) con tres posibles finales; nunca se mezclan caminos sin pasar por sus condiciones.*

## Ejemplo 2: Atención de un pedido con paralelismo (fork)

```plantuml
@startuml
|Cocina|
start
:Recibir pedido del sistema;
|Barra|
fork
  :Preparar bebida;
fork again
|Cocina|
  :Preparar plato principal;
end fork
|Servicio|
:Empaquetar y servir;
if (¿Cliente conforme?) then (sí)
  :Cerrar pedido;
  stop
else (no)
  :Rehacer pedido;
  :Volver a servir;
  stop
endif
@enduml
```

**Lectura:** *después de recibir el pedido, la bebida y el plato se preparan **en paralelo** (fork); el flujo se sincroniza (join implícito de `end fork`) antes de servir. Las bandas indican quién es responsable de cada actividad.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: documentar el alta de un usuario con **toda la notación de actividades**: inicio/fin, acciones, decisión, bifurcación paralela, carriles, etiquetas de flujo, notas y `detach`.*

### Paso 1 — flujo lineal

**Añade:** nodo inicial `start`, acciones `:...;` y parada `stop` / `[*]`.

```plantuml
@startuml
start
:Rellenar formulario;
:Enviar solicitud;
stop
@enduml
```

### Paso 2 — decisiones y paralelismo

**Añade:** decisión/fusión `if/else` con su condición y **bifurcación paralela** `fork` que se sincroniza con `end fork`.

```plantuml
@startuml
start
:Rellenar formulario;

if (¿Datos validos?) then (si)
  fork
    :Enviar email de bienvenida;
  fork again
    :Crear perfil en BD;
  end fork
  :Mostrar confirmacion;
else (no)
  :Mostrar errores;
endif
stop
@enduml
```

### Paso 3 — notación completa (carriles, etiquetas de flujo, notas y detach)

**Añade:** **carriles** `|Rol|` (particiones del trabajo), **etiqueta de flujo** sobre la arista `-->[condicion]`, `note` explicativa y `detach` (abandonar el flujo sin terminarlo bien).

```plantuml
@startuml
|Usuario|
start
:Subir documento;

|Sistema|
:Validar formato;
-->[formato incorrecto]
|Usuario|
:Corregir archivo;
detach

|Sistema|
if (¿Guardado ok?) then (si)
  |Notificaciones|
  :Avisar al usuario;
  note right
    Las etiquetas del flujo (entre
    corchetes) son condiciones que
    se evaluan sobre la arista.
  end note
  stop
else (no)
  :Reintentar guardado;
  stop
endif
@enduml
```

**Cómo se lee el Paso 3:** los carriles dicen **quién hace qué**, la arista etiquetada `[formato incorrecto]` indica por dónde salió el flujo cuando falló la validación, y `detach` corta ese camino (el usuario se fue sin completar nada).

## Errores comunes

- Dejar **ramas abiertas**: cada `if` necesita `endif`, cada `fork` necesita `end fork`.
- Decisiones sin **etiqueta de salida** (`(sí)/(no)`): sin rótulos no se sabe qué rama elegir.
- Usar `fork` para alternativas: `fork` es **paralelo**; si solo pasa uno, es `if/else`.
