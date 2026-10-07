---
title: Diagrama de clases
tags: [uml]
---

# Diagrama de clases

## Explicación didáctica

El **diagrama de clases** es el más importante de UML: describe la **estructura estática** del sistema en términos de **clases**, sus **atributos** (datos), sus **métodos** (comportamiento) y las **relaciones** entre ellas. Es el plano que después traduces directamente a código (Java, C#, Python...).

**Cuándo usarlo:** para diseñar el dominio del problema, planificar clases antes de programar o documentar cómo se organizan los datos de tu programa.

**Cómo se lee:**
- Un rectángulo dividido en 3 cajones: `nombre` / `atributos` / `métodos`.
- Atributos: `visibilidad nombre : Tipo`. Métodos: `visibilidad nombre(param) : TipoDeRetorno`.
- Visibilidad: `+` público, `-` privado, `#` protegido, `~` paquete.

**Relaciones principales (de menor a mayor acoplamiento):**

| Relación | Notación | Significado |
| --- | --- | --- |
| Asociación | `A --> B` | A usa/conoce a B |
| Agregación | `A o-- B` | A "tiene" B (B puede existir solo) |
| Composición | `A *-- B` | A "posee" B (B no existe sin A) |
| Herencia | `A <\|-- B` | B hereda de A (generalización) |
| Interfaz | `A ..\|> B` | B implementa la interfaz A |
| Dependencia | `A ..> B` | A usa B puntualmente (p.ej. como parámetro) |

**Multiplicidades:** se escriben en los extremos: `1`, `0..1`, `*` (muchos), `1..*`, `2..5`.

## Ejemplo 1: Sistema de biblioteca (asociaciones y multiplicidades)

Muestra una clase abstracta `Persona` con dos subclases, una biblioteca que **agrega** muchos libros y un préstamo que **compone** el vínculo entre libro y usuario.

```plantuml
@startuml
skinparam classAttributeIconHeight 0

abstract class Persona {
  - nombre : String
  - dni : String
  {abstract} + identificarse() : Boolean
}

class Alumno {
  - legajo : int
  + identificarse() : Boolean
}

class Bibliotecario {
  - matricula : String
  + identificarse() : Boolean
}

class Biblioteca {
  - nombre : String
  + buscar(titulo : String) : List<Libro>
}

class Libro {
  - titulo : String
  - disponible : Boolean
  + prestar() : void
}

class Prestamo {
  - fechaInicio : Date
  - fechaDevolucion : Date
}

Persona <|-- Alumno
Persona <|-- Bibliotecario
Biblioteca "1" o-- "*" Libro : contiene
Alumno "1" -- "0..*" Prestamo
Libro "1" -- "1" Prestamo
@enduml
```

**Lectura:** *una Biblioteca contiene 1 o muchos Libros (agregación, rombo hueco); un Alumno tiene 0 o muchos Préstamos y cada Prestamo se asocia exactamente a 1 Libro.*

## Ejemplo 2: Vehículos (herencia e interfaces)

```plantuml
@startuml
interface Electrico {
  + cargar(bateria : int) : void
  + autonomia() : int
}

abstract class Vehiculo {
  - patente : String
  - velocidadActual : int
  {abstract} + arrancar() : void
  + frenar() : void
}

class Auto {
  - cantidadPuertas : int
  + arrancar() : void
}

class Moto {
  - cilindrada : int
  + arrancar() : void
}

class Camion {
  - cargaMaxima : float
  + arrancar() : void
}

Vehiculo <|-- Auto
Vehiculo <|-- Moto
Vehiculo <|-- Camion
Auto ..|> Electrico
Moto ..|> Electrico
@enduml
```

**Lectura:** *`Vehiculo` es abstracta (no se instancia); `Auto` y `Moto` heredan de ella **e implementan** la interfaz `Electrico` (rombo punteado).*

## Errores comunes

- Poner `*` en **ambos** extremos de una asociación sin explicación: define bien cuántos hay de cada lado.
- Confundir **agregación** (rombo hueco) con **composición** (rombo relleno): si al borrar el contenedor el contenido desaparece, es composición.
- Dibujar métodos privados como `-` pero olvidar que en el código también serán privados: la notación debe reflejar el código real.
