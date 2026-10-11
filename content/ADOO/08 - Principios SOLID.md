---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - SOLID
  - principios
  - disenio
aliases:
  - SOLID
  - Principios SOLID
  - Principios de Diseño
---

# 08 — Principios SOLID

> *"SOLID son los 5 principios de diseño orientado a objetos que, cuando se aplican, producen sistemas fáciles de mantener, extender y reutilizar."* — Robert C. Martin (Uncle Bob)

---

## Visión General

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "SOLID" as SOLID #3E7AB8 {
    rectangle "S\nSingle Responsibility\nPrinciple" as S #C0564B
    rectangle "O\nOpen/Closed\nPrinciple" as O #2E9E52
    rectangle "L\nLiskov Substitution\nPrinciple" as L #C9971C
    rectangle "I\nInterface Segregation\nPrinciple" as I #3E7AB8
    rectangle "D\nDependency Inversion\nPrinciple" as D #5F6672
}

S -[hidden]right- O
O -[hidden]right- L
L -[hidden]right- I
I -[hidden]right- D
@enduml
```

| Letra | Principio | En una frase |
| --- | --- | --- |
| **S** | Single Responsibility | Una clase = una sola razón para cambiar |
| **O** | Open/Closed | Abierto a extensión, cerrado a modificación |
| **L** | Liskov Substitution | Los subtipos deben ser sustituibles por sus supertipos |
| **I** | Interface Segregation | Mejor muchas interfaces específicas que una general |
| **D** | Dependency Inversion | Depender de abstracciones, no de implementaciones concretas |

---

## S — Single Responsibility (Responsabilidad Única)

> *"Una clase debería tener solo una razón para cambiar."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "❌ VIOLACIÓN" as Mal #C0564B {
    rectangle "class Employee {\n  calcularSueldo()\n  generarReporte()\n  enviarEmail()\n  guardarEnBD()\n  calcularImpuestos()\n }" as MalCode
}

rectangle "✅ CORRECTO" as Bien #2E9E52 {
    rectangle "class Employee {\n  calcularSueldo()\n  calcularImpuestos()\n}" as B1
    rectangle "class ReportService {\n  generarReporte()\n}" as B2
    rectangle "class EmailService {\n  enviarEmail()\n}" as B3
    rectangle "class EmployeeRepository {\n  guardar()\n  buscar()\n}" as B4
}

Mal -right-> Bien : refactorizar
@enduml
```

### Ejemplo

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Empleado {
    - nombre : String
    - salario : double
    + calcularSueldo() : double
    + calcularImpuestos() : double
}

class ReporteService {
    + generarReporteNomina(empleados : List<Empleado>) : String
}

class EmailService {
    + enviarNotificacion(email : String, asunto : String, body : String) : void
}

class EmpleadoRepository {
    + guardar(empleado : Empleado) : void
    + buscarPorId(id : int) : Empleado
    + eliminar(id : int) : void
}

note bottom
  <b>Cada clase tiene UNA responsabilidad:</b>
  - Empleado: modela datos y cálculos propios
  - ReporteService: genera reportes
  - EmailService: envía emails
  - EmpleadoRepository: persiste datos
end note
@enduml
```

---

## O — Open/Closed (Abierto/Cerrado)

> *"Las entidades de software deben estar abiertas a la extensión pero cerradas a la modificación."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "❌ VIOLACIÓN (modificar para extender)" as Mal #C0564B {
    rectangle "class CalculadoraDescuento {\n  calcularDescuento(tipo) {\n    if (tipo == \"VIP\") ...\n    if (tipo == \"NORMAL\") ...\n    // cada vez que agrego un tipo,\n    // DEBO modificar esta clase\n  }\n}"
}

rectangle "✅ CORRECTO (extender sin modificar)" as Bien #2E9E52 {
    rectangle "interface Descuento {\n  calcular(monto) : double\n}\n\nclass DescuentoVIP implements Descuento { ... }\n\nclass DescuentoNormal implements Descuento { ... }\n\n// Para agregar un nuevo tipo,\n// solo creo una NUEVA clase\n// SIN modificar las existentes"
}

Mal -right-> Bien
@enduml
```

### Ejemplo

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

interface "Descuento" as Desc {
    + calcular(monto : double) : double
}

class DescuentoVIP {
    + calcular(monto : double) : double
}

class DescuentoNormal {
    + calcular(monto : double) : double
}

class DescuentoEmpleado {
    + calcular(monto : double) : double
}

class DescuentoBlackFriday {
    + calcular(monto : double) : double
}

Desc <|.. DescuentoVIP
Desc <|.. DescuentoNormal
Desc <|.. DescuentoEmpleado
Desc <|.. DescuentoBlackFriday

note bottom
  <b>Para agregar "DescuentoBlackFriday":</b>
  Solo creo una NUEVA clase.
  NO modifico ninguna clase existente.
  El código que usa Descuento sigue funcionando.
end note
@enduml
```

---

## L — Liskov Substitution (Sustitución de Liskov)

> *"Si S es un subtipo de T, entonces los objetos de tipo T pueden ser reemplazados por objetos de tipo S sin alterar las propiedades correctas del programa."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Cuadrado {
    - lado : double
    + setBase(b : double) : void
    + setAltura(a : double) : void
    + getArea() : double
}

class Rectangulo {
    - base : double
    - altura : double
    + setBase(b : double) : void
    + setAltura(a : double) : void
    + getArea() : double
}

Rectangulo <|-- Cuadrado

note bottom of Cuadrado
  <b>⚠️ PROBLEMA de LSP:</b>
  Un Cuadrado ES un Rectangulo matemáticamente,
  pero programáticamente:

  Rectangulo r = new Cuadrado();
  r.setBase(5);
  r.setAltura(3);
  r.getArea();  // esperamos 15, pero es 9 (¡es un cuadrado!)

  El cliente de Rectangulo no puede sustituir
  Cuadrado sin romper el comportamiento esperado.
end note
@enduml
```

### Solución correcta

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

interface "Forma" as F {
    + getArea() : double
}

class Rectangulo {
    - base : double
    - altura : double
    + getArea() : double
}

class Cuadrado {
    - lado : double
    + getArea() : double
}

class Circulo {
    - radio : double
    + getArea() : double
}

F <|.. Rectangulo
F <|.. Cuadrado
F <|.. Circulo

note bottom
  <b>Solución:</b> Ambas implementan Forma
  pero no hay relación de herencia
  entre Rectangulo y Cuadrado.
  Cada una es independiente y
  cumple el contrato de Forma.
end note
@enduml
```

---

## I — Interface Segregation (Segregación de Interfaces)

> *"Ningún cliente debería ser forzado a depender de métodos que no usa."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "❌ VIOLACIÓN" as Mal #C0564B {
    rectangle "interface Trabajador {\n  trabajar()\n  comer()\n  dormir()\n  programming()\n  reunirse()\n}" as MalI
}

rectangle "✅ CORRECTO" as Bien #2E9E52 {
    rectangle "interface Trabajable {\n  trabajar()\n}" as I1
    rectangle "interface Alimentable {\n  comer()\n}" as I2
    rectangle "interface Programable {\n  programming()\n}" as I3
    rectangle "interface Reunible {\n  reunirse()\n}" as I4
}

Mal -right-> Bien
@enduml
```

### Ejemplo

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

interface "Imprimible" as Imp {
    + imprimir() : void
}

interface "Escaneable" as Esc {
    + escanear() : String
}

interface "Fax" as Fax {
    + enviarFax(numero : String, doc : byte[]) : boolean
}

class ImpresoraBasica {
    + imprimir() : void
}

class ImpresoraMultifuncion {
    + imprimir() : void
    + escanear() : String
    + enviarFax(numero : String, doc : byte[]) : boolean
}

class Escaner {
    + escanear() : String
}

Imp <|.. ImpresoraBasica
Imp <|.. ImpresoraMultifuncion
Esc <|.. ImpresoraMultifuncion
Esc <|.. Escaner
Fax <|.. ImpresoraMultifuncion

note bottom
  <b>ImpresoraBasica</b> solo implementa Imprimible
  <b>Escaner</b> solo implementa Escaneable
  <b>ImpresoraMultifuncion</b> implementa las 3

  Ninguna está forzada a implementar
  métodos que no le corresponden.
end note
@enduml
```

---

## D — Dependency Inversion (Inversión de Dependencias)

> *"Los módulos de alto nivel no deben depender de los de bajo nivel. Ambos deben depender de abstracciones."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "❌ VIOLACIÓN" as Mal #C0564B {
    rectangle "class ServicioNotificacion {\n  EmailService email;  // concreto\n  SMSService sms;      // concreto\n  // si cambio el proveedor,\n  // debo modificar esta clase\n}"
}

rectangle "✅ CORRECTO" as Bien #2E9E52 {
    rectangle "interface Notificador {\n  enviar(mensaje) : void\n}\n\nclass ServicioNotificacion {\n  Notificador notificador;  // abstracción\n}\n\nclass EmailService implements Notificador { ... }\nclass SMSService implements Notificador { ... }\nclass PushService implements Notificador { ... }"
}

Mal -right-> Bien
@enduml
```

### Ejemplo

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

interface "Notificador" as Not {
    + enviar(mensaje : String, destino : String) : boolean
}

class EmailNotifier {
    + enviar(mensaje : String, destino : String) : boolean
}

class SMSNotifier {
    + enviar(mensaje : String, destino : String) : boolean
}

class PushNotifier {
    + enviar(mensaje : String, destino : String) : boolean
}

class WhatsAppNotifier {
    + enviar(mensaje : String, destino : String) : boolean
}

class PedidoService {
    - notificador : Notificador
    + PedidoService(notificador : Notificador)
    + confirmarPedido(pedido : Pedido) : void
}

Not <|.. EmailNotifier
Not <|.. SMSNotifier
Not <|.. PushNotifier
Not <|.. WhatsAppNotifier

PedidoService --> Not

note bottom
  <b>PedidoService</b> depende de <b>Notificador</b> (abstracción),
  NO de EmailService o SMSService (implementaciones concretas).

  Para cambiar el canal de notificación,
  solo paso otra implementación al constructor.
end note
@enduml
```

---

## Resumen Visual

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "SOLID" as S #3E7AB8 {
    rectangle "S — Responsabilidad Única\nUna clase, un trabajo" as S1 #C0564B
    rectangle "O — Abierto/Cerrado\nExtender sin modificar" as O1 #2E9E52
    rectangle "L — Liskov\nSubtipos sustituibles" as L1 #C9971C
    rectangle "I — Interfaces\nPequeñas y específicas" as I1 #3E7AB8
    rectangle "D — Inversión\nDepender de abstracciones" as D1 #5F6672
}

S1 -[hidden]down- O1
O1 -[hidden]down- L1
L1 -[hidden]down- I1
I1 -[hidden]down- D1
@enduml
```

---

## ¿Por qué importan SOLID?

| Sin SOLID | Con SOLID |
| --- | ---|
| Clases grandes y difíciles de mantener | Clases pequeñas y enfocadas |
| Modificar una cosa rompe otras | Los cambios son locales |
| Difícil de testear | Fácil de mockear y testear |
| Acoplamiento alto entre componentes | Componentes independientes |
| Duplicación de código | Reutilización natural |

> [!tip] Para la siguiente clase
> Revisa el código de un proyecto existente (o inventa uno simple). Identifica al menos **una violación de cada principio SOLID** y propón cómo refactorearla aplicando el principio correspondiente.
