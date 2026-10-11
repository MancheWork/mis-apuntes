---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - relaciones
  - asociacion
  - composicion
  - agregacion
aliases:
  - Relaciones entre Clases
  - Asociación
  - Composición
  - Agregación
---

# 07 — Relaciones entre Clases

> *"Las clases no viven aisladas. Las relaciones entre ellas definen la arquitectura del sistema."*

---

## Tipos de relaciones

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "RELACIONES ENTRE CLASES" as Rel #3E7AB8 {
    rectangle "ASOCIACIÓN\n simple entre clases" as Assoc #Coral
    rectangle "AGREGACIÓN\nparte-de (débil)" as Agg #C9971C
    rectangle "COMPOSICIÓN\nparte-de (fuerte)" as Comp #C0564B
    rectangle "HERENCIA\nes-un" as Her #2E9E52
    rectangle "DEPENDENCIA\nusa temporalmente" as Dep #5F6672
    rectangle "IMPLEMENTACIÓN\nimplementa interfaz" as Impl #3E7AB8
}

Assoc -[hidden]down- Agg
Agg -[hidden]down- Comp
Comp -[hidden]down- Her
Her -[hidden]down- Dep
Dep -[hidden]down- Impl
@enduml
```

---

## 1. Asociación

Relación **general** entre dos clases que se conocen entre sí y **colaboran**.

### Notación UML

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Persona {
    - nombre : String
}

class Universidad {
    - nombre : String
}

Persona "1..*" -- "1..*" Universidad : estudia en / tiene

note top of Universidad
  <b>Multiplicidades:</b>
  1 persona puede estudiar en 1..* universidades
  1 universidad puede tener 1..* personas
end note
@enduml
```

### Multiplicidades

| Multiplicidad | Significado |
| --- | --- |
| `1` | Exactamente uno |
| `0..1` | Cero o uno (opcional) |
| `*` | Muchos (cero o más) |
| `1..*` | Uno o más |
| `0..*` | Cero o más |
| `3..5` | Entre 3 y 5 |

---

## 2. Agregación (relación "parte-de" débil)

Una clase **contiene** a otra pero **ambas existen independientemente**. Si se destruye el todo, las partes **sobreviven**.

### Notación UML

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Universidad {
    - nombre : String
}

class Departamento {
    - nombre : String
}

class Profesor {
    - nombre : String
    - especialidad : String
}

Universidad "1" o-- "0..*" Departamento
Departamento "1" o-- "0..*" Profesor

note right of Departamento
  <b>Agregación (◇ vacía):</b>
  Si cierra la Universidad,
  los Profesores siguen existiendo
  (pueden trabajar en otro lado).

  Si se elimina el Departamento,
  los Profesores no desaparecen.
end note
@enduml
```

### Ejemplo concreto

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Equipo {
    - nombre : String
    - ciudad : String
}

class Jugador {
    - nombre : String
    - posicion : String
    - numero : int
}

class Estadio {
    - nombre : String
    - capacidad : int
}

Equipo "1" o-- "0..*" Jugador
Equipo "1" o-- "1" Estadio

note bottom
  <b>Agregación:</b>
  Si el Equipo se disuelve,
  los Jugadores siguen existiendo
  y pueden ir a otro equipo.

  El Estadio no desaparece
  si el Equipo deja de jugar ahí.
end note
@enduml
```

---

## 3. Composición (relación "parte-de" fuerte)

Una clase **contiene** a otra y **controla su ciclo de vida**. Si se destruye el todo, las partes **se destruyen** también.

### Notación UML

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Computadora {
    - marca : String
    - modelo : String
}

class Procesador {
    - marca : String
    - velocidad : String
}

class MemoriaRAM {
    - capacidad : int
    - tipo : String
}

class DiscoDuro {
    - capacidad : int
    - tipo : String
}

Computadora *-- "1" Procesador
Computadora *-- "1..*" MemoriaRAM
Computadora *-- "1" DiscoDuro

note right of Procesador
  <b>Composición (* sólida):</b>
  Si se destruye la Computadora,
  el Procesador, la RAM y el Disco
  <u>también se destruyen</u>.

  No existen "piezas sueltas" del Procesador
  fuera de esa Computadora.
end note
@enduml
```

### Ejemplo concreto

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Partida {
    - fecha : Date
    - duracion : int
}

class Movimiento {
    - numero : int
    - desde : String
    - hasta : String
    - pieza : String
}

class Turno {
    - numero : int
    - jugador : String
    - tiempoRestante : int
}

Partida *-- "0..*" Movimiento
Partida *-- "2..*" Turno

note bottom
  <b>Composición:</b>
  Si se borra la Partida,
  todos sus Movimientos y Turnos
  <u>también se borran</u>.

  Un Movimiento no tiene sentido
  fuera de su Partida.
end note
@enduml
```

---

## 4. Dependencia

Una clase **usa temporalmente** a otra (por ejemplo, como parámetro de un método). No hay relación permanente.

### Notación UML

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Reporte {
    + generar(datos : Datos) : String
}

class Datos {
    - contenido : Map
}

class FormatoPDF {
    + convertir(texto : String) : byte[]
}

class FormatoExcel {
    + convertir(texto : String) : byte[]
}

Reporte ..> Datos : usa
Reporte ..> FormatoPDF : usa
Reporte ..> FormatoExcel : usa

note bottom
  <b>Dependencia (... punteada):</b>
  Reporte "usa" Datos y Formatos,
  pero no los "tiene".
  Si cambia la interfaz de Datos,
  Reporte puede romperse.
end note
@enduml
```

---

## Comparación de relaciones

| Relación | Notación | Ciclo de vida | Ejemplo |
| --- | --- | --- | --- |
| **Asociación** | `—` sólida | Independientes | Persona ↔ Universidad |
| **Agregación** | `o—` diamante vacío | Independientes | Universidad ◇— Departamento |
| **Composición** | `*—` diamante sólido | Dependientes | Computadora ◆— Procesador |
| **Dependencia** | `...>` punteada | Temporal | Reporte usa Datos |
| **Herencia** | `▷` triángulo | Jerarquía | Perro ▷ Animal |

---

## Decidir la relación correcta

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

start
:¿La clase B puede existir sin la clase A?;

if (¿B existe sin A?) then (si)
    :¿A y B colaboran permanente y bidireccionalmente?;
    if (¿Colaboran permanentemente?) then (si)
        #C9971C:ASOCIACION;
        note right: Persona con Universidad
    else (no, es temporal)
        #5F6672:DEPENDENCIA;
        note right: Reporte usa Datos
    endif
else (no)
    :¿Si se destruye A, se destruye B?;
    if (¿Se destruyen juntos?) then (si)
        #C0564B:COMPOSICION;
        note right: Computadora con Procesador
    else (no, B sobrevive)
        #C9971C:AGREGACION;
        note right: Universidad con Departamento
    endif
endif

stop
@enduml
```

---

## Ejemplo Integrador: Sistema de Gestión de Proyectos

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Empresa {
    - nombre : String
    - rut : String
}

class Departamento {
    - nombre : String
}

class Empleado {
    - nombre : String
    - cargo : String
    - email : String
}

class Proyecto {
    - nombre : String
    - fechaInicio : Date
    - fechaFin : Date
    - estado : String
}

class Tarea {
    - titulo : String
    - descripcion : String
    - prioridad : String
    - estado : String
}

class Comentario {
    - texto : String
    - fecha : Date
}

class Documento {
    - nombre : String
    - tipo : String
    - url : String
}

Empresa "1" o-- "1..*" Departamento
Departamento "1" o-- "0..*" Empleado
Empleado "1" -- "0..*" Proyecto : asignado a
Proyecto *-- "1..*" Tarea
Tarea *-- "0..*" Comentario
Tarea *-- "0..*" Documento

note bottom
  <b>Relaciones:</b>
  Empresa ◇— Departamento (agregación)
  Departamento ◇— Empleado (agregación)
  Empleado — Proyecto (asociación)
  Proyecto ◆— Tarea (composición)
  Tarea ◆— Comentario (composición)
  Tarea ◆— Documento (composición)
end note
@enduml
```

---

## Resumen

| Relación | Fuerza | Ciclo de vida | Notación |
| --- | --- | --- | --- |
| Asociación | Débil | Independiente | Línea sólida |
| Agregación | Media | Independiente | Diamante vacío `◇` |
| Composición | Fuerte | Dependiente | Diamante sólido `◆` |
| Herencia | Fuerte | Jerarquía | Triángulo `▷` |
| Dependencia | Muy débil | Temporal | Flecha punteada `...>` |

> [!tip] Para la siguiente clase
> Modela un **sistema de e-commerce** identificando las relaciones entre: Cliente, Pedido, Producto, Carrito, Pago y Factura. Para cada relación, indica si es asociación, agregación o composición y justifica tu decisión.
