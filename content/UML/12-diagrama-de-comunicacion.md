---
title: Diagrama de comunicación
tags: [uml]
---

# Diagrama de comunicación

## Explicación didáctica

El **diagrama de comunicación** (*communication*) muestra los **mismos mensajes** que el de secuencia, pero con la visión **estructural**: los objetos aparecen como cajas conectadas por enlaces y los mensajes se escriben **sobre los enlaces**, numerados para indicar el orden. Es el "mapa de quién le habla a quién" en lugar de la "línea de tiempo".

**Cuándo usarlo:**
- Para ver de un vistazo **qué objetos colaboran** y con qué **vínculos** (asociaciones) lo hacen.
- Cuando el **orden temporal es secundario** y lo importante es la topología de la colaboración.
- Complementario al de secuencia: mismo escenario, otra perspectiva.

**Notación:**
- **Objetos** (rectángulos, nombre subrayado o `objeto : Clase`) unidos por **enlaces** (líneas rectas).
- Cada mensaje se anota sobre el enlace con el formato: `número: nombreMensaje(argumentos)`.
- Los mensajes se reenvían sobre los mismos enlaces; si un objeto necesita hablar con otro, **debe existir un enlace** (o una asociación en la clase que los conecte).
- Se pueden añadir `activate/deactivate` mediante notas para marcar activación.

**Diferencia clave con la secuencia:**

| Secuencia | Comunicación |
| --- | --- |
| Eje vertical = **tiempo** | Eje espacial = **colaboración** |
| Se ven retornos y activaciones | Se ven **enlaces/asociaciones** |
| Mejor para **detallar** un flujo | Mejor para ver **estructura** |

## Ejemplo 1: Patrón MVC con mensajes numerados

```plantuml
@startuml
object "botonGuardar : VistaBoton" as vista
object "controlador : ControladorPedido" as ctrl
object "pedido : Pedido" as pedido
object "repositorio : RepositorioSQL" as repo

vista -[thickness=2]-> ctrl : 1: guardarPedido(datos)
ctrl -[thickness=2]-> pedido : 2: validar()
ctrl -[thickness=2]-> repo : 3: persistir(pedido)
repo -[thickness=2]-> ctrl : 4: confirmar()
ctrl -[thickness=2]-> vista : 5: mostrarExito()
@enduml
```

**Lectura:** *la Vista le avisa al Controlador (1), que valida el Pedido (2), lo persiste en el Repositorio (3), recibe la confirmación (4) y le devuelve el éxito a la Vista (5). El orden está en los números, no en el dibujo.*

## Ejemplo 2: Sistema de alarma con colaboración distribuida

```plantuml
@startuml
object "sensorPir : Sensor" as sensor
object "central : CentralAlarma" as central
object "sirena : Sirena" as sirena
object "app : AplicacionMovil" as app
object "usuario : Usuario" as usuario

sensor --> central : 1: notificarMovimiento()
central --> sirena : 2: activar()
central --> app : 3: pushAlerta("Movimiento")
app --> usuario : 4: vibrar()
usuario --> app : 5: desactivar(clave)
app --> central : 6: desarmar()
central --> sirena : 7: silenciar()
@enduml
```

**Lectura:** *siete mensajes numerados que muestran la colaboración completa; el enlace `central-sirena` se usa dos veces (2 y 7), lo que revela que es una asociación reciente en el diseño.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: modelar una alerta de seguridad con **toda la notación de comunicación**: objetos con clase, enlaces con rol, mensajes numerados en varios niveles, estereotipos y notas.*

### Paso 1 — objetos y enlaces

**Añade:** objetos `object "nombre : Clase"` y los **enlaces** (línea recta) por los que viajan los mensajes.

```plantuml
@startuml
object "sensor : Sensor" as sensor
object "central : Central" as central
object "sirena : Sirena" as sirena

sensor --> central
central --> sirena
@enduml
```

### Paso 2 — mensajes numerados

**Añade:** los mensajes con su **número de orden** escrito sobre el enlace (`n: mensaje()`), que es lo que reconstruye la secuencia.

```plantuml
@startuml
object "sensor : Sensor" as sensor
object "central : CentralAlarma" as central
object "sirena : Sirena" as sirena
object "app : AppMovil" as app

sensor --> central : 1: notificarMovimiento()
central --> sirena : 2: activar()
central --> app : 3: enviarAlerta()
@enduml
```

### Paso 3 — notación completa (numeración jerárquica, roles y notas)

**Añade:** numeración **decimal** para sub-mensajes (`1.1`, `1.2`), **rol** en cada extremo del enlace, estereotipo en el objeto `<<...>>` y nota sobre un enlace.

```plantuml
@startuml
object "sensorPir : Sensor" as sensor <<hardware>>
object "central : CentralAlarma" as central {
  estado = "ARMADA"
}
object "app : AppMovil" as app
object "usuario : Usuario" as usuario

sensor -[thickness=2]-> central : vigila
central --> app : alerta
app --> usuario : aviso

sensor -[thickness=2]-> central : 1: movimiento()
central --> app : 2: push()
central --> app : 2.1: icono = rojo
central --> app : 2.2: vibrar()
app --> usuario : 3: mostrar()

note as N
  El número 2 con subniveles 2.1
  y 2.2 muestra que esos mensajes
  ocurren DENTRO del paso 2.
end note
N -[thickness=2]-> central
@enduml
```

**Cómo se lee el Paso 3:** los mensajes `2.1` y `2.2` son **hijos** del mensaje `2` (jerarquía decimal); el rol `vigila` sobre el enlace explica qué papel juega cada extremo y la nota fija la regla de lectura.

## Errores comunes

- Poner mensajes entre objetos **sin enlace**: en este diagrama los mensajes viajan **por los enlaces**; si no existe, primero agrega la asociación al diagrama de clases.
- Olvidar la **numeración**: sin números no se puede reconstruir el orden temporal.
- Esperar que muestre **condiciones o bucles**: eso es del diagrama de secuencia (`alt`, `loop`). En comunicación solo verás mensajes numerados.
