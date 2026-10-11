---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - clases
  - objetos
aliases:
  - Clase
  - Objeto
  - Atributos
  - Métodos
---

# 02 — Clases y Objetos

> *"Una clase es el plano; un objeto es la casa construida a partir de ese plano."*

---

## ¿Qué es una clase?

Una **clase** es la definición abstracta de un tipo de entidad. Es un **molde** o **plano** que describe:

- **Atributos** — qué datos almacena (estado)
- **Métodos** — qué comportamiento tiene (acciones)

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Persona {
    - nombre : String
    - edad : int
    - email : String
    + getNombre() : String
    + setEdad(edad : int) : void
    + esMayorDeEdad() : boolean
}
@enduml
```

| Sección | Visor UML | Significado |
| --- | --- | --- |
| `Persona` | Nombre arriba | El nombre de la clase |
| `- nombre : String` | `−` = privado | Atributo privado de tipo String |
| `+ getNombre()` | `+` = público | Método público que retorna un String |

---

## ¿Qué es un objeto?

Un **objeto** es una **instancia concreta** de una clase. Si la clase es el plano, el objeto es la casa:

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Persona {
    - nombre : String
    - edad : int
    + getNombre() : String
    + setEdad(edad : int) : void
    + esMayorDeEdad() : boolean
}

object "maria" as o1 {
    nombre = "María"
    edad = 22
}

object "carlos" as o2 {
    nombre = "Carlos"
    edad = 17
}

Persona <.. o1 : instancia
Persona <.. o2 : instancia
@enduml
```

> [!key] Distinción fundamental
> - **Clase** = tipo abstracto (existe una sola definición)
> - **Objeto** = instancia concreta (pueden existir miles)

---

## Anatomía de una clase

### Los tres componentes

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "CLASE" as Clase #3E7AB8 {
    rectangle "1. NOMBRE\n(Identifica al tipo)" as Nombre #White
    rectangle "2. ATRIBUTOS\n(Estado / Datos)" as Atributos #2E9E52
    rectangle "3. MÉTODOS\n(Comportamiento)" as Metodos #C9971C
}

Nombre -down-> Atributos
Atributos -down-> Metodos
@enduml
```

### Ejemplo completo: Cuenta Bancaria

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class "Cuenta Bancaria" as CB {
    == Identificación ==
    - numeroCuenta : String
    - titular : Persona
    == Estado ==
    - saldo : double
    - activa : boolean
    == Operaciones ==
    + depositar(monto : double) : void
    + retirar(monto : double) : boolean
    + consultarSaldo() : double
    + transferir(destino : Cuenta, monto : double) : boolean
    == Privado ==
    - registrarMovimiento(tipo : String, monto : double) : void
}
@enduml
```

| Sección | Propósito |
| --- | --- |
| **Identificación** | Datos que identifican de forma única a la cuenta |
| **Estado** | Datos que cambian a lo largo de la vida del objeto |
| **Operaciones públicas** | Acciones que otros objetos pueden solicitar |
| **Privado** | Métodos internos que solo la propia clase usa |

---

## Atributos: el estado del objeto

### Tipos de atributos

| Tipo | Descripción | Ejemplo |
| --- | --- | --- |
| **Primitivos** | Valores simples | `int`, `double`, `boolean`, `char` |
| **Compuestos** | Objetos de otras clases | `Direccion`, `Fecha`, `Persona` |
| **Colectivos** | Colecciones de objetos | `List<Cuenta>`, `Map<String, Integer>` |

### Convenciones de nombre

```
- nombreCompleto : String      // camelCase, empieza con minúscula
- fechaNacimiento : Date       // descriptivo
- MAXIntentos : int            // CONSTANTES en MAYÚSCULAS
```

---

## Métodos: el comportamiento del objeto

### Estructura

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "MÉTODO" as Metodo #C9971C {
    rectangle "VISIBILIDAD\n(+, -, #, ~)" as Vis #White
    rectangle "NOMBRE\n(verbosamente)" as Nom #White
    rectangle "PARÁMETROS\n(entrada)" as Param #White
    rectangle "TIPO RETORNO\n(salida)" as Ret #White
}

Vis -down-> Nom
Nom -down-> Param
Param -down-> Ret
@enduml
```

### Ejemplo: crear cuenta

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class "Cuenta Bancaria" as CB {
    - numeroCuenta : String
    - saldo : double
    --
    + depositar(monto : double) : void
    + retirar(monto : double) : boolean
}

note right of CB
  <b>depositar(monto)</b>
  1. Validar que monto > 0
  2. Sumar monto al saldo
  3. Registrar movimiento

  <b>retirar(monto)</b>
  1. Validar monto > 0
  2. Verificar saldo >= monto
  3. Restar monto al saldo
  4. Registrar movimiento
  5. Retornar true/false
end note
@enduml
```

---

## Constructor: nacimiento del objeto

Un **constructor** es un método especial que se ejecuta al crear un objeto. Inicializa su estado.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Persona {
    - nombre : String
    - edad : int
    + Persona(nombre : String, edad : int)
    + getNombre() : String
    + esMayorDeEdad() : boolean
}

object "maria" as o1 {
    nombre = "María"
    edad = 22
}

note top of o1
  Al ejecutar:
  <b>new Persona("María", 22)</b>
  se llama al constructor
  y se crea este objeto.
end note

Persona <.. o1
@enduml
```

---

## Diferencia: Clase vs. Objeto vs. Interfaz

| Concepto | ¿Qué es? | Ejemplo |
| --- | --- | --- |
| **Clase** | Definición / plano | `class Persona { String nombre; }` |
| **Objeto** | Instancia concreta en memoria | `Persona p = new Persona("Ana");` |
| **Interfaz** | Contrato de comportamiento (sin implementación) | `interface Serializable { }` |

---

## Ejemplo Integrador: Modelando una Biblioteca

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Libro {
    - isbn : String
    - titulo : String
    - autor : String
    - disponible : boolean
    --
    + Libro(isbn : String, titulo : String, autor : String)
    + prestar() : void
    + devolver() : void
    + estaDisponible() : boolean
}

class Socio {
    - rut : String
    - nombre : String
    - librosPrestados : List<Libro>
    --
    + Socio(rut : String, nombre : String)
    + solicitarPrestamo(libro : Libro) : boolean
    + devolverLibro(libro : Libro) : void
    + cantidadPrestamos() : int
}

class Bibliotecario {
    - id : int
    - nombre : String
    --
    + registrarLibro(libro : Libro) : void
    + autorizarPrestamo(socio : Socio, libro : Libro) : boolean
}

Socio --> Libro : solicita
Bibliotecario --> Socio : atiende
Bibliotecario --> Libro : gestiona
@enduml
```

---

## Resumen

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

left to right direction

rectangle "CLASE" as C #3E7AB8 {
    rectangle "Nombre" as N
    rectangle "Atributos\n(estado)" as A
    rectangle "Métodos\n(comportamiento)" as M
}

rectangle "OBJETO" as O #2E9E52 {
    rectangle "Datos concretos\nen memoria" as D
}

C -right-> O : instancia\n(new)
@enduml
```

> [!tip] Para la siguiente clase
> Piensa en 3 objetos del mundo real (una Mascota, un Vehículo, un Producto). ¿Cuáles serían sus atributos y métodos? ¿Qué restricciones de acceso tienen?
