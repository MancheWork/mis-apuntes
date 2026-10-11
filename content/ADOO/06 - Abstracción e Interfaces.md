---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - abstraccion
  - interfaz
  - contrato
aliases:
  - Abstracción
  - Interfaz
  - Contrato
  - Clase Abstracta
---

# 06 — Abstracción e Interfaces

> *"La abstracción es seleccionar solo lo relevante del mundo real y descartar lo irrelevante para el problema que estamos resolviendo."*

---

## ¿Qué es la abstracción?

La **abstracción** es el proceso de **modelar solo las características esenciales** de un objeto, ignorando los detalles que no son relevantes para el contexto.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "MUNDO REAL" as Real #5F6672 {
    rectangle "Una Persona tiene:\nnombre, edad, rut, peso,\naltura, color de ojos,\ngusto musical, ...\n miles de atributos" as P
}

rectangle "MODELO (Abstracción)" as Modelo #3E7AB8 {
    rectangle "Una Persona en el sistema\ntiene:\nnombre, email, telefono\n(solo lo necesario\npara el problema)" as M
}

Real -right-> Modelo : filtrar\nrelevancia
@enduml
```

### Ejemplo

| Objeto real | Abstracción en sistema de mensajería | Abstracción en sistema médico |
| --- | --- | --- |
| Persona | nombre, email, telefono | nombre, rut, edad, alergias, sangre |

> [!key] La misma entidad se abstrae de forma diferente según el **problema** que se resuelve.

---

## Clase Abstracta vs. Interfaz

Son los dos mecanismos de abstracción en POO:

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "CLASE ABSTRACTA" as Abs #3E7AB8 {
    rectangle "• Puede tener atributos\n• Puede tener constructores\n• Puede tener métodos\n  implementados\n• Método abstracto = sin cuerpo" as AbsD
}

rectangle "INTERFAZ" as If #2E9E52 {
    rectangle "• NO puede tener atributos\n  (solo constantes)\n• NO puede tener constructores\n• Solo define el método (sin cuerpo)\n• múltiple implementación" as IfD
}

Abs -[hidden]right- If
@enduml
```

---

## Clases Abstractas

Una **clase abstracta** es una clase que **no se puede instanciar** directamente. Sirve como base para sus subclases.

### Diagrama UML

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

abstract class "Figura Geométrica" as Fig {
    - color : String
    - relleno : boolean
    --
    + getArea() : double
    + getPerimetro() : double
    + {abstract} calcularArea() : double
    + {abstract} calcularPerimetro() : double
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
    - tipo : String
    + calcularArea() : double
    + calcularPerimetro() : double
}

Fig <|-- Circulo
Fig <|-- Rectangulo
Fig <|-- Triangulo

note bottom of Fig
  <b>abstract</b> = no se puede hacer
  new Figura()

  <b>getArea()</b> tiene implementación
  → reutilizable en todas las subclases

  <b>calcularArea()</b> es abstracto
  → cada subclase DEBE implementarlo
end note
@enduml
```

### Código de ejemplo

```java
public abstract class Figura {
    protected String color;
    protected boolean relleno;

    public Figura(String color) {
        this.color = color;
    }

    // Método CON implementación → reutilizable
    public String getArea() {
        return "Área: " + calcularArea();
    }

    // Método abstracto → cada subclase DEBE implementarlo
    public abstract double calcularArea();
    public abstract double calcularPerimetro();
}

public class Circulo extends Figura {
    private double radio;

    public Circulo(String color, double radio) {
        super(color);
        this.radio = radio;
    }

    @Override
    public double calcularArea() {
        return Math.PI * radio * radio;
    }

    @Override
    public double calcularPerimetro() {
        return 2 * Math.PI * radio;
    }
}
```

---

## Interfaces

Una **interfaz** es un **contrato** que define qué métodos debe implementar una clase, sin decir cómo.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

interface "Dibujable" as Dib {
    + dibujar() : void
    + getDimensiones() : String
}

interface "Exportable" as Exp {
    + exportarPDF() : byte[]
    + exportarPNG() : byte[]
}

interface "Imprimible" as Imp {
    + imprimir() : void
    + getVistaPrevia() : String
}

class Reporte {
    - contenido : String
    - formato : String
}

class Grafico {
    - datos : double[]
    - titulo : String
}

class Diagrama {
    - nodos : List<Nodo>
    - aristas : List<Arista>
}

Dib <|.. Grafico
Dib <|.. Diagrama
Exp <|.. Reporte
Exp <|.. Grafico
Imp <|.. Reporte
Imp <|.. Diagrama

note bottom
  <b>Grafico</b> implementa Dibujable + Exportable
  <b>Reporte</b> implementa Exportable + Imprimible
  <b>Diagrama</b> implementa Dibujable + Imprimible

  Una clase puede implementar <u>múltiples</u> interfaces
end note
@enduml
```

---

## Contrato: qué promete la interfaz

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "CONTRATO" as Contrato #3E7AB8 {
    rectangle "INTERFAZ: Pagable\n\n+ pagar(monto) : boolean\n+ getSaldo() : double\n+ getCuenta() : String" as Interfaz #White
}

rectangle "IMPLEMENTACIONES" as Impl #2E9E52 {
    rectangle "TarjetaCredito\n- numero, banco\n+ pagar() → valida y cobra\n+ getSaldo() → saldo disponible" as TC #White
    rectangle "PayPal\n- email, token\n+ pagar() → redirige a PayPal\n+ getSaldo() → balance PP" as PP #White
    rectangle "CryptoWallet\n- direccion, clave\n+ pagar() → transacción blockchain\n+ getSaldo() → balance ETH" as CW #White
}

Contrato -down-> Impl
@enduml
```

---

## Diferencia Clase Abstracta vs. Interfaz

| Característica | Clase Abstracta | Interfaz |
| --- | --- | --- |
| **Atributos** | Puede tener atributos con estado | Solo constantes (`static final`) |
| **Constructores** | Puede tener constructores | No puede tener constructores |
| **Métodos con implementación** | Puede tener métodos con cuerpo | No (solo definición) |
| **Métodos abstractos** | Puede tener (con `abstract`) | Todos son abstractos (por defecto) |
| **Herencia múltiple** | No (una sola superclase) | Sí (múltiples interfaces) |
| **¿Cuándo usar?** | Cuando las subclases comparten código y estado | Cuando defines un contrato que múltiples clases pueden cumplir |

---

## Ejemplo Integrador: Sistema de Notificaciones

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

abstract class Notificacion {
    - contenido : String
    - fechaEnvio : Date
    - leida : boolean
    --
    + Notificacion(contenido : String)
    + marcarLeida() : void
    + estaLeida() : boolean
    + {abstract} enviar() : boolean
    + {abstract} getCanal() : String
}

interface "Programable" as Prog {
    + programar(fecha : Date) : void
    + cancelarProgramacion() : void
    + estaProgramada() : boolean
}

interface "Rastreable" as Ras {
    + getEstado() : String
    + getHistorial() : List<String>
    + confirmarEntrega() : boolean
}

class EmailNotification {
    - asunto : String
    - destinatario : String
    + enviar() : boolean
    + getCanal() : String
}

class SMSNotification {
    - telefono : String
    + enviar() : boolean
    + getCanal() : String
}

class PushNotification {
    - dispositivoId : String
    + enviar() : boolean
    + getCanal() : String
}

class WhatsAppNotification {
    - numero : String
    + enviar() : boolean
    + getCanal() : String
}

Notificacion <|-- EmailNotification
Notificacion <|-- SMSNotification
Notificacion <|-- PushNotification
Notificacion <|-- WhatsAppNotification

Prog <|.. EmailNotification
Prog <|.. PushNotification
Ras <|.. EmailNotification
Ras <|.. SMSNotification

note bottom
  <b>EmailNotification:</b> hereda Notificacion + implementa Programable + Rastreable

  <b>Código genérico:</b>
  Notificacion n = new EmailNotification("Hola", "a@b.com");
  n.enviar();  // polimorfismo

  Programable p = (Programable) n;
  p.programar(new Date());  // programar para después
end note
@enduml
```

---

## Resumen Visual

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "ABSTRACCIÓN" as Abs #3E7AB8 {
    rectangle "Seleccionar solo lo\nrelevante del mundo real" as A1
}

rectangle "CLASE ABSTRACTA" as CA #C9971C {
    rectangle "Base con código compartido\n+ métodos abstractos\n+ atributos\n→ Una herencia" as C1
}

rectangle "INTERFAZ" as IF #2E9E52 {
    rectangle "Contrato puro\nsolo firmas de métodos\n→ Múltiples implementaciones" as I1
}

Abs -down-> CA
Abs -down-> IF
@enduml
```

> [!tip] Para la siguiente clase
> Diseña un sistema de **compresión de archivos** con una interfaz `Compresor` y al menos 3 implementaciones (ZIP, RAR, GZIP). Incluye también una clase abstracta `ArchivoComprimido` que comparta lógica común. ¿Qué métodos irían en la interfaz y cuáles en la clase abstracta?
