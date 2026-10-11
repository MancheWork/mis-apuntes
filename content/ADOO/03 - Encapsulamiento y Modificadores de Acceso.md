---
tipo: apunte
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - POO
  - encapsulamiento
  - modificadores
aliases:
  - Encapsulamiento
  - Modificadores de Acceso
  - Visibilidad
---

# 03 — Encapsulamiento y Modificadores de Acceso

> *"Encapsular es ponerle una cáscara a un objeto para que nadie vea su jugo interno."* — analogía

---

## ¿Qué es el encapsulamiento?

El **encapsulamiento** es el pilar de la POO que consiste en **ocultar los detalles internos** de un objeto y **exponer solo lo necesario** a través de una interfaz controlada.

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "SIN Encapsulamiento" as Sin #C0564B {
    rectangle "Cuenta\nsaldo = 1000\ncualquier función puede\ncambiar saldo" as SinDetail #FFFFFF
}

rectangle "CON Encapsulamiento" as Con #2E9E52 {
    rectangle "Cuenta\n- saldo = 1000\n+ depositar()\n+ retirar()\n(valida antes)" as ConDetail #White
}

Sin -right-> Con : refactorizar
@enduml
```

### ¿Por qué es importante?

| Sin encapsulamiento | Con encapsulamiento |
| --- | --- |
| Cualquier parte del código puede modificar `saldo` directamente | Solo `depositar()` y `retirar()` pueden modificar `saldo` |
| No hay validación — se puede poner saldo negativo | Cada operación valida antes de actuar |
| Si cambia la lógica, hay que buscar en todo el código | Solo se cambia dentro de la clase |
| El objeto es frágil y dependiente de todo el sistema | El objeto es robusto y autocontenido |

---

## Los 4 modificadores de acceso

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "MODIFICADORES DE ACCESO" as Mods #3E7AB8 {
    rectangle "+ PUBLICO\nAccesible desde\nCUALQUIER lugar" as Pub #2E9E52
    rectangle "- PRIVADO\nSolo accesible\ndentro de la clase" as Priv #C0564B
    rectangle "# PROTEGIDO\nDentro de la clase\ny subclases" as Prot #C9971C
    rectangle "~ PACKAGE (default)\nDentro del mismo\npaquete" as Pkg #5F6672
}

Pub -[hidden]down- Priv
Priv -[hidden]down- Prot
Prot -[hidden]down- Pkg
@enduml
```

| Modificador | Palabra clave | Símbolo UML | Desde la clase | Subclase | Mismo paquete | Cualquier lugar |
| --- | --- | --- | --- | --- | --- | --- |
| **Público** | `public` | `+` | ✅ | ✅ | ✅ | ✅ |
| **Protegido** | `protected` | `#` | ✅ | ✅ | ✅ | ❌ |
| **Package** | *(sin palabra)* | `~` | ✅ | ❌ | ✅ | ❌ |
| **Privado** | `private` | `-` | ✅ | ❌ | ❌ | ❌ |

---

## Ejemplo: Cuenta Bancaria encapsulada

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class "Cuenta Bancaria" as CB {
    - saldo : double            // PRIVATE — nadie toca esto directamente
    - numeroCuenta : String
    - movimientos : List<String>
    --
    + depositar(monto : double) : void      // PUBLIC — cualquiera puede llamar
    + retirar(monto : double) : boolean     // PUBLIC — retorna éxito/fallo
    + consultarSaldo() : double             // PUBLIC — solo lectura
    --
    # calcularComision() : double           // PROTEGIDO — útil para subclases
    - registrarMovimiento(tipo : String, monto : double) : void  // PRIVATE
}

note right of CB
  <b>Lectura:</b>
  <b>saldo</b> es <u>private</u> (-): nadie puede hacer cuenta.saldo = 9999
  <b>depositar</b> es <u>public</u> (+): cualquier objeto puede llamarlo
  <b>registrarMovimiento</b> es <u>private</u> (-): solo se usa internamente
end note
@enduml
```

### Código de ejemplo (pseudocódigo Java)

```java
public class CuentaBancaria {
    // Atributos privados — ocultos al mundo exterior
    private double saldo;
    private String numeroCuenta;
    private List<String> movimientos;

    // Constructor
    public CuentaBancaria(String numero, double saldoInicial) {
        this.numeroCuenta = numero;
        this.saldo = saldoInicial;
        this.movimientos = new ArrayList<>();
    }

    // Método público — interfaz controlada
    public void depositar(double monto) {
        if (monto <= 0) {
            throw new IllegalArgumentException("El monto debe ser positivo");
        }
        saldo += monto;
        registrarMovimiento("DEPOSITO", monto);
    }

    // Método público — con lógica de validación
    public boolean retirar(double monto) {
        if (monto <= 0 || monto > saldo) {
            return false;
        }
        saldo -= monto;
        registrarMovimiento("RETIRO", monto);
        return true;
    }

    // Método público — solo lectura
    public double consultarSaldo() {
        return saldo;
    }

    // Método privado — solo la clase lo usa internamente
    private void registrarMovimiento(String tipo, double monto) {
        movimientos.add(tipo + ": $" + monto);
    }
}
```

---

## El principio de información oculta

> *"Todo objeto tiene una frontera. Lo que está adentro es su responsabilidad; lo que está afuera es el contrato con el resto del mundo."*

```plantuml
@startuml
skinparam backgroundColor #FEFEFE

rectangle "Frontera del Objeto" as Frontera #3E7AB8 {
    rectangle "INTERFAZ PÚBLICA\n(Lo que el mundo ve)" as Interfaz #2E9E52 {
        rectangle "+ depositar()" as D
        rectangle "+ retirar()" as R
        rectangle "+ consultarSaldo()" as C
    }

    rectangle "IMPLEMENTACIÓN INTERNA\n(Lo que el mundo NO ve)" as Interna #C9971C {
        rectangle "- saldo" as S
        rectangle "- movimientos" as M
        rectangle "- registrarMovimiento()" as Reg
    }
}

note bottom of Interna
  Los usuarios del objeto
  <b>NO necesitan saber</b> cómo
  se almacena el saldo ni cómo
  se registran movimientos.
  Solo importa el <b>QUÉ hacen</b>
  los métodos públicos.
end note
@enduml
```

---

## Getters y Setters: acceso controlado

Los **getters** y **setters** permiten acceder y modificar atributos privados de forma controlada:

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Persona {
    - nombre : String
    - edad : int
    - email : String
    --
    + getNombre() : String
    + setNombre(nombre : String) : void
    + getEdad() : int
    + setEdad(edad : int) : void
    + getEmail() : String
    + setEmail(email : String) : void
}

note right of Persona
  <b>Getter:</b> solo lee → getNombre()
  <b>Setter:</b> modifica con validación → setEdad()

  Si setEdad valida que edad > 0,
  nadie puede poner edad negativa.
end note
@enduml
```

### ¿Cuándo usar cada uno?

| Escujo | Acceso | Ejemplo |
| --- | --- | --- |
| Solo lectura | Solo getter | `consultarSaldo()` — nadie puede modificar el saldo directamente |
| Lectura + escritura | Getter + Setter | `setNombre()` — con validación interna |
| Solo escritura | Setter sin getter | `registrarAcceso()` — se registra pero no se consulta externamente |

---

## Ejemplo Integrador: Persona con validación

```plantuml
@startuml
skinparam backgroundColor #FEFEFE
skinparam classAttributeIconSize 0

class Persona {
    - nombre : String
    - edad : int
    - email : String
    --
    + Persona(nombre : String, edad : int, email : String)
    + getNombre() : String
    + setNombre(nombre : String) : void
    + getEdad() : int
    + setEdad(edad : int) : void
    + getEmail() : String
    + setEmail(email : String) : void
    + esMayorDeEdad() : boolean
}

note bottom of Persona
  <b>setEdad(edad)</b>:
  if (edad < 0) → lanzar excepción
  if (edad > 150) → lanzar excepción
  this.edad = edad

  <b>setEmail(email)</b>:
  if (!email.contains("@")) → lanzar excepción
  this.email = email

  <b>esMayorDeEdad()</b>:
  return this.edad >= 18
end note
@enduml
```

---

## Errores comunes

| Error | Ejemplo incorrecto | Por qué está mal |
| --- | --- | --- |
| Atributo público directo | `public double saldo;` | Cualquiera puede hacer `cuenta.saldo = -1000` |
| Setter sin validación | `public void setEdad(int e) { this.edad = e; }` | Permite edad = -5 |
| Todo público | Todos los atributos y métodos son `public` | No hay encapsulamiento, el objeto es frágil |
| Getter + Setter de todo | Siempre `getX()` + `setX()` para cada atributo | Muchos atributos solo necesitan lectura (ej: `numeroCuenta`) |

> [!tip] Regla práctica
> Por defecto, los atributos siempre son **privados**. Solo se hace público algo si es estrictamente necesario. Los métodos se hacen públicos según el **contrato** que el objeto ofrece al mundo exterior.
