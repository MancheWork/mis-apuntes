---
title: Diagrama de objetos
tags: [uml]
---

# Diagrama de objetos

## Explicación didáctica

El **diagrama de objetos** muestra **instancias concretas** de las clases en un **momento específico** del tiempo: una "fotografía" o *snapshot* del sistema en ejecución. Mientras el diagrama de clases dice *"existe la clase Alumno"*, el de objetos dice *"la alumna Ana, legajo 12345, tiene estas cuentas"*.

**Cuándo usarlo:**
- Para explicar **ejemplos concretos** de un diseño (ideal para estudiar y para tests).
- Para verificar que las **multiplicidades** del diagrama de clases son correctas.
- En análisis: para mostrar el estado de los datos de un caso de uso.

**Notación clave:**
- Rectángulo con el nombre del objeto **subrayado**: `JuanPerez : Alumno` (instancia `JuanPerez` de la clase `Alumno`).
- Los **atributos** muestran sus **valores**: `dni = "30.111.222"`.
- Los enlaces entre objetos se llaman **enlaces (links)** y pueden llevar el nombre de la asociación.

> [!tip] Regla de oro
> En un diagrama de objetos **nunca** aparecen clases "suelas" ni métodos: solo instancias y sus valores en ese instante.

## Ejemplo 1: Préstamo en una biblioteca

```plantuml
@startuml
skinparam objectAttributeIconHeight 0

object "bibliotecaCentral : Biblioteca" as bib {
  nombre = "Biblioteca Central"
}

object "elQuijote : Libro" as libro {
  titulo = "Don Quijote de la Mancha"
  disponible = false
}

object "anaGomez : Alumno" as ana {
  nombre = "Ana Gómez"
  legajo = 12345
}

object "prestamoHoy : Prestamo" as pre {
  fechaInicio = 07/10/2026
  fechaDevolucion = 21/10/2026
}

bibliotecaCentral o-- elQuijote
anaGomez -- prestamoHoy
elQuijote -- prestamoHoy
@enduml
```

**Lectura:** *en este instante, la Biblioteca Central tiene el libro "Don Quijote" (prestado, `disponible = false`) y existe un préstamo que une a Ana Gómez con ese libro.*

## Ejemplo 2: Cuentas bancarias (una clase, varias instancias)

```plantuml
@startuml
object "luisRojas : Persona" as luis {
  nombre = "Luis Rojas"
  email = "luis@correo.com"
}

object "cuentaAhorro : Cuenta" as ca {
  numero = "0012-A"
  saldo = 1500.00
  moneda = "PESOS"
}

object "cuentaCte : Cuenta" as cc {
  numero = "0013-C"
  saldo = 300.50
  moneda = "PESOS"
}

object "banco : Banco" as banco {
  razonSocial = "Banco del Sur"
}

banco --> cuentaAhorro
banco --> cuentaCte
banco --> luisRojas : titular
@enduml
```

**Lectura:** *dos instancias distintas de la misma clase `Cuenta` con valores diferentes, ambas bajo el mismo `Banco`.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: mostrar el carrito de compras de **un cliente en un momento exacto**, cubriendo la notación completa de diagrama de objetos: nombres subrayados, valores, enlaces con roles y notas.*

### Paso 1 — los objetos con sus valores

**Añade:** `object` con el formato `instancia : Clase` (se subraya solo) y el par `atributo = valor`.

```plantuml
@startuml
object "cliente1 : Cliente" as c1 {
  nombre = "Ana"
  saldo = 40.00
}
object "carrito1 : Carrito" as car {
  estado = "abierto"
  total = 25.50
}
@enduml
```

### Paso 2 — los enlaces

**Añade:** los **enlaces** (línea continua entre instancias) con el **rol** que juega cada extremo.

```plantuml
@startuml
object "cliente1 : Cliente" as c1 {
  nombre = "Ana"
}
object "carrito1 : Carrito" as car {
  total = 25.50
}
object "libroX : Libro" as l {
  isbn = "978-84"
}
object "item1 : LineaCarrito" as it {
  cantidad = 2
}

c1 --> car : posee
car --> it : contiene
it --> l : referencia
@enduml
```

### Paso 3 — notación completa (instantánea completa)

**Añade:** enlaces sin etiqueta, objeto **sin** atributos (solo para amarrar), notas explicando el momento capturado y multiplicidades visibles en el texto del rol.

```plantuml
@startuml
object "cliente1 : Cliente" as c1 {
  nombre = "Ana"
  tipo = "premium"
}
object "carrito1 : Carrito" as car {
  estado = "cerrado"
  total = 51.00
}
object "item1 : LineaCarrito" as it1 {
  cantidad = 1
}
object "item2 : LineaCarrito" as it2 {
  cantidad = 3
}
object "libroA : Libro" as a {
  isbn = "111"
}
object "libroB : Libro" as b {
  isbn = "222"
}
object "pago9 : Pago" as p {
  metodo = "tarjeta"
  importe = 51.00
}

c1 --> car
car --> it1
car --> it2
it1 --> a
it2 --> b
car --> p : liquida

note as N
  Instantánea: 3 items (1 + 3 unidades),
  pago ya realizado → carrito cerrado.
end note
N .. car
@enduml
```

**Cómo se lee el Paso 3:** todo está **subrayado** porque son instancias, los `=` muestran el estado real de cada atributo y el enlace `car --> p : liquida` añade la asociación con su rol de lectura.

## Errores comunes

- Escribir **métodos** en los objetos: los objetos de UML muestran estado (atributos con valor), no comportamiento.
- Olvidar el **subrayado** del nombre: sin subrayado ya no es un objeto, es una clase.
- Mezclar en un mismo diagrama clases y objetos sin separarlos: si necesitas ambos, usa un diagrama de clases enriquecido con instancias.
