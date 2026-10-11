---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - herencia
  - generalización
aliases:
  - Herencia
  - Generalización
  - Superclase
  - Subclase
---

# 04 — Herencia y Generalización

> *"La herencia permite construir nuevas clases a partir de las existentes, reutilizando código y estableciendo jerarquías naturales."*

---

## ¿Qué es la herencia?

La **herencia** es un mecanismo que permite crear una **nueva clase** (subclase) basándose en una **clase existente** (superclase). La subclase **hereda** atributos y métodos de la superclase, y puede **agregar** o **modificar** comportamiento.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Animal {
    - nombre : String
    - edad : int
    + respirar() : void
    + comer() : void
    + dormir() : void
}

class Perro {
    - raza : String
    + ladrar() : void
    + buscar() : void
}

class Gato {
    - color : String
    + maullar() : void
    + ronronear() : void
}

Animal <|-- Perro
Animal <|-- Gato
@enduml
```

> [!note] Notación UML
> La **flecha con triángulo vacío** (`▷`) apunta de la subclase a la superclase. Se lee: "Perro **es un** Animal".

---

## Generalización vs. Especialización

| Concepto | Dirección | Ejemplo |
| --- | --- | --- |
| **Generalización** | De lo específico a lo general | Perro, Gato, Ave → Animal |
| **Especialización** | De lo general a lo específico | Animal → Perro, Gato, Ave |

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "GENERALIZACIÓN\n(lo específico → lo general)" as Gen #3E7AB8 {
    rectangle "Perro, Gato, Ave\n→ Animal" as GenEjemplo
}

rectangle "ESPECIALIZACIÓN\n(lo general → lo específico)" as Esp #2E9E52 {
    rectangle "Animal\n→ Perro, Gato, Ave" as EspEjemplo
}

Gen -right-> Esp : misma relación,\ndistinta perspectiva
@enduml
```

---

## Ejemplo Completo: Vehículos

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

abstract class Vehiculo {
    - marca : String
    - modelo : String
    - anio : int
    - velocidadActual : int
    --
    + Vehiculo(marca : String, modelo : String, anio : int)
    + encender() : void
    + apagar() : void
    + acelerar(incremento : int) : void
    + frenar(decremento : int) : void
    + getVelocidadActual() : int
    + {abstract} getType() : String
}

class Auto {
    - numPuertas : int
    - tipoCombustible : String
    --
    + getType() : String
    + abrirMaletero() : void
    + usarClimatizador() : void
}

class Moto {
    - cilindrada : int
    - tipoManubrio : String
    --
    + getType() : String
    + hacerWheelie() : void
}

class Camion {
    - capacidadCarga : double
    - numEjes : int
    --
    + getType() : String
    + cargar(peso : double) : void
    + descargar() : void
}

Vehiculo <|-- Auto
Vehiculo <|-- Moto
Vehiculo <|-- Camion
@enduml
```

### ¿Qué hereda cada subclase?

| Hereda de Vehiculo | Auto añade | Moto añade | Camion añade |
| --- | --- | --- | --- |
| `marca`, `modelo`, `anio`, `velocidadActual` | `numPuertas`, `tipoCombustible` | `cilindrada`, `tipoManubrio` | `capacidadCarga`, `numEjes` |
| `encender()`, `apagar()`, `acelerar()`, `frenar()` | `abrirMaletero()`, `usarClimatizador()` | `hacerWheelie()` | `cargar()`, `descargar()` |

---

## El constructor en la herencia

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Animal {
    - nombre : String
    - edad : int
    + Animal(nombre : String, edad : int)
    + respirar() : void
}

class Perro {
    - raza : String
    + Perro(nombre : String, edad : int, raza : String)
    + ladrar() : void
}

Animal <|-- Perro

note bottom of Perro
  <b>Constructor de Perro:</b>
  super(nombre, edad)  // llama al constructor de Animal
  this.raza = raza     // inicializa lo propio
end note
@enduml
```

### Flujo de construcción

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

|Línea de código|
start
:new Perro("Max", 5, "Labrador");
note right: Se llama al constructor de Perro

|Constructor de Perro|
:recibe nombre, edad, raza;
:llama super(nombre, edad);
note right: Ejecuta constructor de Animal

|Constructor de Animal|
:Animal.nombre = "Max";
:Animal.edad = 5;

|Constructor de Perro|
:Perro.raza = "Labrador";

stop
@enduml
```

---

## Sobrescritura de métodos (Override)

Una subclase puede **reescribir** un método de la superclase para cambiar su comportamiento:

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Animal {
    - nombre : String
    + hacerSonido() : void
    --
    note bottom of Animal
      <b>hacerSonido()</b>:
      print("Sonido genérico")
    end note
}

class Perro {
    + hacerSonido() : void
    --
    note bottom of Perro
      <b>hacerSonido()</b> (override):
      print("Guau guau")
    end note
}

class Gato {
    + hacerSonido() : void
    --
    note bottom of Gato
      <b>hacerSonido()</b> (override):
      print("Miau")
    end note
}

Animal <|-- Perro
Animal <|-- Gato
@enduml
```

```java
// Superclase
public class Animal {
    public void hacerSonido() {
        System.out.println("Sonido genérico");
    }
}

// Subclase
public class Perro extends Animal {
    @Override  // anotación que indica override
    public void hacerSonido() {
        System.out.println("Guau guau");
    }
}
```

---

## super: acceder a la superclase

La palabra clave `super` permite invocar **métodos o constructores** de la superclase:

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Empleado {
    - nombre : String
    - salario : double
    + Empleado(nombre : String, salario : double)
    + calcularBonificacion() : double
    + getInfo() : String
}

class Gerente {
    - bonoExtra : double
    + Gerente(nombre : String, salario : double, bonoExtra : double)
    + calcularBonificacion() : double  // override
    + getInfo() : String               // override
}

Empleado <|-- Gerente

note bottom of Gerente
  <b>calcularBonificacion():</b>
  return super.calcularBonificacion() + bonoExtra

  <b>getInfo():</b>
  return super.getInfo() + " | Bono extra: $" + bonoExtra
end note
@enduml
```

---

## Tipos de herencia

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "HERENCIA SIMPLE" as Simple #3E7AB8 {
    rectangle "Una subclase hereda\nde UNA sola superclase\n(Java, C#, C++)" as S
}

rectangle "HERENCIA MÚLTIPLE" as Multiple #C9971C {
    rectangle "Una subclase hereda\nde VARIAS superclases\n(C++, Python)" as M
}

rectangle "INTERFACES" as IF #2E9E52 {
    rectangle "Una clase IMPLEMENTA\nmúltiples contratos\n(Java, C#)" as I
}

Simple -right-> IF : preferido en\nlenguajes OO estrictos
Multiple -right-> IF : solución alternativa
@enduml
```

| Tipo | Lenguaje | Ejemplo |
| --- | --- | --- |
| **Simple** | Java, C#, C++ | `class Perro extends Animal` |
| **Múltiple** | C++, Python | `class A(B, C, D)` |
| **Interfaces** | Java, C# | `class A implements X, Y, Z` |

---

## Principio de sustitución de Liskov (LSP)

> *"Si S es un subtipo de T, entonces los objetos de tipo T pueden ser reemplazados por objetos de tipo S sin alterar las propiedades correctas del programa."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Figura {
    + calcularArea() : double
    + calcularPerimetro() : double
}

class Circulo {
    - radio : double
    + calcularArea() : double
    + calcularPerimetro() : double
}

class Rectangulo {
    - base : double
    - altura : double
    + calcularArea() : double
    + calcularPerimetro() : double
}

class Triangulo {
    - base : double
    - altura : double
    + calcularArea() : double
    + calcularPerimetro() : double
}

Figura <|-- Circulo
Figura <|-- Rectangulo
Figura <|-- Triangulo

note bottom of Figura
  <b>LSP dice:</b>
  Donde se espere una Figura,
  se puede poner un Circulo,
  Rectangulo o Triangulo
  y el programa sigue funcionando
  correctamente.
end note
@enduml
```

---

## Ejemplo Integrador: Sistema de Empleados

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

abstract class Empleado {
    - nombre : String
    - id : int
    - salarioBase : double
    --
    + Empleado(nombre : String, id : int, salarioBase : double)
    + getNombre() : String
    + calcularSueldo() : double
    + {abstract} getTipo() : String
}

class EmpleadoFijo {
    - bonoAntiguedad : double
    --
    + calcularSueldo() : double
    + getTipo() : String
}

class EmpleadoPorHoras {
    - tarifaPorHora : double
    - horasTrabajadas : int
    --
    + calcularSueldo() : double
    + getTipo() : String
}

class EmpleadoTemporal {
    - fechaFin : Date
    - bonoFinContrato : double
    --
    + calcularSueldo() : double
    + getTipo() : String
    + estaVigente() : boolean
}

Empleado <|-- EmpleadoFijo
Empleado <|-- EmpleadoPorHoras
Empleado <|-- EmpleadoTemporal
@enduml
```

### Flujo de ejecución

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

start
:Crear lista de empleados;
:Empleado e1 = new EmpleadoFijo("Ana", 1, 500000);
:Empleado e2 = new EmpleadoPorHoras("Luis", 2, 5000);
:Empleado e3 = new EmpleadoTemporal("Pedro", 3, 600000);

:Calcular sueldo de cada uno;
:e1.calcularSueldo();  // → EmpleadoFijo: 500000 + bonoAntiguedad
:e2.calcularSueldo();  // → EmpleadoPorHoras: tarifa * horas
:e3.calcularSueldo();  // → EmpleadoTemporal: salarioBase + bonoFin

stop
@enduml
```

---

## Resumen

| Concepto | Descripción |
| --- | --- |
| **Superclase** | Clase de la que se hereda (padre) |
| **Subclase** | Clase que hereda (hijo) |
| **Herencia** | Mecanismo de reutilización y jerarquía |
| **Override** | Reescribir un método de la superclase |
| **super** | Acceder a miembros de la superclase |
| **abstract** | Clase/método que no se puede instanciar directamente |
| **LSP** | Los subtipos deben ser sustituibles por sus supertipos |

> [!tip] Para la siguiente clase
> Diseña una jerarquía de **Formas Geométricas** (Círculo, Rectángulo, Triángulo) que hereden de una clase abstracta `Forma`. Cada una debe implementar `calcularArea()` y `calcularPerimetro()`. ¿Qué otros métodos comunes podrían compartir?
