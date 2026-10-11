---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - polimorfismo
aliases:
  - Polimorfismo
  - Sobrecarga
  - Sobreescritura
  - Ligadura
---

# 05 — Polimorfismo

> *"Polimorfismo significa 'muchas formas'. Un mismo mensaje puede producir comportamientos distintos según el objeto que lo reciba."*

---

## ¿Qué es el polimorfismo?

El **polimorfismo** es la capacidad de un mismo método de tener **comportamientos diferentes** dependiendo del tipo de objeto que lo invoca. Es el pilar que permite escribir código **genérico** que funciona con muchos tipos.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "POLIMORFISMO" as Pol #3E7AB8 {
    rectangle "Un mensaje: calcularSueldo()" as Msg #White
    rectangle "→ EmpleadoFijo: salario + bono\n→ EmpleadoHoras: tarifa × horas\n→ Gerente: salario + bono + bonoExtra" as Res #2E9E52
}

Msg -down-> Res
@enduml
```

---

## Los dos tipos de polimorfismo

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "POLIMORFISMO" as Padre #3E7AB8 {
    rectangle "SOBRECARGA\n(Overloading)\nCompile-time polymorphism" as Sob #C9971C
    rectangle "SOBRESCRITURA\n(Overriding)\nRuntime polymorphism" as Sob2 #2E9E52
}

Sob -[hidden]right- Sob2
@enduml
```

### 1. Sobrecarga (Overloading)

**Mismo nombre, diferentes parámetros.** Se resuelve en tiempo de compilación.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Calculadora {
    + sumar(a : int, b : int) : int
    + sumar(a : double, b : double) : double
    + sumar(a : int, b : int, c : int) : int
    + sumar(a : String, b : String) : String
}

note right of Calculadora
  <b>Todos se llaman "sumar"</b> pero:
  - sumar(2, 3) → 5
  - sumar(2.5, 3.1) → 5.6
  - sumar(1, 2, 3) → 6
  - sumar("Hola", " Mundo") → "Hola Mundo"
end note
@enduml
```

| Llamada | Método invocado | Retorno |
| --- | --- | --- |
| `sumar(2, 3)` | `sumar(int, int)` | `5` |
| `sumar(2.5, 3.1)` | `sumar(double, double)` | `5.6` |
| `sumar(1, 2, 3)` | `sumar(int, int, int)` | `6` |

### 2. Sobreescritura (Overriding)

**Mismo nombre, mismos parámetros, diferente implementación.** Se resuelve en tiempo de ejecución.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Figura {
    + calcularArea() : double
}

class Circulo {
    - radio : double
    + calcularArea() : double
}

class Rectangulo {
    - base : double
    - altura : double
    + calcularArea() : double
}

class Triangulo {
    - base : double
    - altura : double
    + calcularArea() : double
}

Figura <|-- Circulo
Figura <|-- Rectangulo
Figura <|-- Triangulo

note bottom of Figura
  <b>Figura:</b> return 0  // base por defecto
  <b>Circulo:</b> return π × radio²
  <b>Rectangulo:</b> return base × altura
  <b>Triangulo:</b> return (base × altura) / 2
end note
@enduml
```

---

## La magia del polimorfismo en acción

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

start
:List<Figura> figuras = new ArrayList<>();
:figuras.add(new Circulo(5));
:figuras.add(new Rectangulo(4, 6));
:figuras.add(new Triangulo(3, 8));

:double total = 0;
:for (Figura f : figuras) {
    total += f.calcularArea();
}

note right
  En tiempo de ejecución, Java
  "sabe" que:
  - f1 es Circulo → llama Circulo.calcularArea()
  - f2 es Rectangulo → llama Rectangulo.calcularArea()
  - f3 es Triangulo → llama Triangulo.calcularArea()
end note

:total = 78.54 + 24 + 12 = 114.54;

stop
@enduml
```

> [!key] El punto clave
> El código que itera **no sabe** qué tipo concreto de Figura es cada una. Solo sabe que **todas son Figuras** y que todas tienen `calcularArea()`. El polimorfismo se encarga de elegir la implementación correcta.

---

## Ligadura dinámica (Dynamic Binding)

La **ligadura dinámica** es el mecanismo por el cual el lenguaje decide **en tiempo de ejecución** qué método invocar, basándose en el tipo real del objeto.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "TIPO DECLARADO (compile-time)" as Declarado #C9971C {
    rectangle "Figura f" as F
}

rectangle "TIPO REAL (runtime)" as Real #2E9E52 {
    rectangle "Circulo / Rectangulo / Triangulo" as R
}

rectangle "MÉTODO EJECUTADO" as Metodo #3E7AB8 {
    rectangle "calcularArea() de la subclase\ncorrecta" as M
}

Declarado -right-> Real : el objeto
Real -right-> Metodo : decidir\ncuál método llamar
@enduml
```

### Ejemplo de ligadura dinámica

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

start
:Figura f = new Circulo(5);
note right: Declarado: Figura\nReal: Circulo

:f.calcularArea();
note right
  Java busca en tiempo de ejecución:
  1. ¿f es Figura? Sí
  2. ¿f es Circulo? Sí → ejecuta Circulo.calcularArea()
end note
:Resultado: 78.54;

:f = new Rectangulo(4, 6);
note right: Ahora f apunta a un Rectangulo

:f.calcularArea();
note right
  1. ¿f es Figura? Sí
  2. ¿f es Rectangulo? Sí → ejecuta Rectangulo.calcularArea()
end note
:Resultado: 24;

stop
@enduml
```

---

## Polimorfismo con colecciones

El verdadero poder del polimorfismo se ve al trabajar con **colecciones de tipo base**:

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

abstract class Empleado {
    + {abstract} calcularSueldo() : double
    + {abstract} getTipo() : String
}

class EmpleadoFijo {
    - salario : double
    - bonoAntiguedad : double
    + calcularSueldo() : double
    + getTipo() : String
}

class EmpleadoPorHoras {
    - tarifa : double
    - horas : int
    + calcularSueldo() : double
    + getTipo() : String
}

Empleado <|-- EmpleadoFijo
Empleado <|-- EmpleadoPorHoras

note bottom
  <b>POLIMORFISMO:</b>
  double total = 0;
  for (Empleado e : empleados) {
      total += e.calcularSueldo();  // cada tipo calcula distinto
  }
  print("Total nómina: $" + total);
end note
@enduml
```

---

## Sobrecarga vs. Sobreescritura

| Característica | Sobrecarga (Overloading) | Sobreescritura (Overriding) |
| --- | --- | --- |
| **Nombre** | Igual | Igual |
| **Parámetros** | Diferentes | Iguales |
| **Relación de clases** | Misma clase (o herencia) | Superclase ↔ Subclase |
| **Tipo de polimorfismo** | Compile-time (estático) | Runtime (dinámico) |
| **Palabra clave** | Ninguna | `@Override` |
| **Determinado por** | El compilador, según argumentos | El tipo real del objeto, en ejecución |

---

## Ejemplo Integrador: Sistema de Pagos

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

interface "FormaDePago" as FP {
    + pagar(monto : double) : boolean
    + getNombre() : String
    + getComision() : double
}

class TarjetaCredito {
    - numero : String
    - banco : String
    + pagar(monto : double) : boolean
    + getNombre() : String
    + getComision() : double
}

class Transferencia {
    - cuentaOrigen : String
    - cuentaDestino : String
    + pagar(monto : double) : boolean
    + getNombre() : String
    + getComision() : double
}

class Efectivo {
    + pagar(monto : double) : boolean
    + getNombre() : String
    + getComision() : double
}

class Webpay {
    - token : String
    + pagar(monto : double) : boolean
    + getNombre() : String
    + getComision() : double
}

FP <|.. TarjetaCredito
FP <|.. Transferencia
FP <|.. Efectivo
FP <|.. Webpay

note bottom
  <b>El código del checkout NO cambia:</b>
  for (FormaDePago fp : formas) {
      if (fp.pagar(total)) {
          print("Pago exitoso con " + fp.getNombre());
      }
  }
end note
@enduml
```

---

## Resumen

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "Polimorfismo" as P #3E7AB8 {
    rectangle "SOBRECARGA\n(Overloading)\nMismo método, distintos parámetros\n→ Compile-time" as S #C9971C
    rectangle "SOBRESCRITURA\n(Overriding)\nMismo método, misma interfaz,\ndistinta implementación → Runtime" as SO #2E9E52
    rectangle "LIGADURA DINÁMICA\nDecide en ejecución\nqué método invocar" as L #C0564B
}

S -[hidden]down- SO
SO -[hidden]down- L
@enduml
```

> [!tip] Para la siguiente clase
> Crea una jerarquía de `FormaDePago` con al menos 3 implementaciones. Escribe un programa que procese una lista de pagos usando polimorfismo, calculando el total de comisiones sin saber de antemano qué formas de pago habrá.
