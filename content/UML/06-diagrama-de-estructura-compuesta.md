---
title: Diagrama de estructura compuesta
tags: [uml]
---

# Diagrama de estructura compuesta

## Explicación didáctica

El **diagrama de estructura compuesta** abre la tapa de un componente/clase y muestra **cómo está hecho por dentro**: sus **partes internas**, sus **puertos** (puntos de conexión en el borde) y los **conectores** que las unen. Responde a la pregunta *"¿qué hay dentro de esta caja y cómo se conecta con el exterior?"*.

**Cuándo usarlo:**
- Cuando un componente es complejo y necesitas mostrar su **arquitectura interna**.
- Para sistemas embebidos, sistemas de control o cualquier componente con entradas/salidas definidas.
- Es el puente entre el diagrama de componentes (exterior) y el de clases (detalle).

**Notación:**
- Un **componente o clase contenedora** con partes anidadas.
- **Puerto**: pequeño cuadrado en el borde; puede ser de **entrada** o **salida**.
- **Conector**: línea entre partes (o entre puerto y parte).
- **Interfaz asambleada**: si dos partes se conectan mediante interfaces complementarias.

**Idea clave:** *las partes no pueden existir sin el todo que las contiene* (composición) y el todo se comunica con el resto del mundo **solo por sus puertos**.

## Ejemplo 1: Sistema de correo con partes internas y puertos

```plantuml
@startuml
skinparam componentStyle rectangle

component "Sistema de Correo" as correo {

  interface "SMTP (entrada)" as smtpIn
  interface "IMAP (salida)" as imapOut

  component "Receptor SMTP" as receptor
  component "Buzón" as buzon
  component "Filtro de spam" as filtro

  smtpIn -- receptor
  receptor --> filtro : mensaje
  filtro --> buzon : archiva
  buzon -- imapOut
}
@enduml
```

**Lectura:** *el Sistema de Correo expone dos puertos (SMTP e IMAP); por dentro, el Receptor entrega mensajes al Filtro, que los archiva en el Buzón. Fuera de la caja no se ve nada más.*

## Ejemplo 2: Robot con sensores (partes + conectores)

```plantuml
@startuml
skinparam componentStyle rectangle

component "Robot Limpia pisos" as robot {

  interface "batería" as bat
  interface "botón inicio" as btn

  component "Controlador Central" as ctrl
  component "Sensor de distancia" as sensor
  component "Motor de tracción" as motor
  component "Gestor de batería" as gestor

  bat -- gestor
  btn -- ctrl
  sensor --> ctrl : lectura cm
  ctrl --> motor : girar/avanzar
  gestor --> ctrl : nivel %
  gestor --> motor : energía
}
@enduml
```

**Lectura:** *el robot tiene 4 partes internas; el Controlador recibe lecturas del sensor y órdenes del botón, y manda órdenes al Motor; el Gestor de batería alimenta a ambos.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: abrir un equipo de limpieza robótico y ver **toda la notación de estructura compuesta**: partes anidadas, puertos, conectores, delegación y notas.*

### Paso 1 — el componente con sus partes

**Añade:** el componente contenedor con `{}` y las **partes** (subcomponentes) dentro, con los conectores entre ellas.

```plantuml
@startuml
component "Robot LimpiaPisos" as robot {
  component "Controlador" as ctrl
  component "Recolector" as rec
  component "Bateria" as bat
}

ctrl --> rec : ordena limpieza
ctrl --> bat : consume energia
@enduml
```

### Paso 2 — puertos

**Añade:** los **puertos** `port "nombre"` en el borde y los conectores `-- [puerto]` que llegan exactamente a ellos.

```plantuml
@startuml
component "Robot LimpiaPisos" as robot {
  port "on/off" as pwr
  port "carga" as chg
  component "Controlador" as ctrl
  component "Bateria" as bat
}

component "Enchufe" as enchufe
component "Mano Humana" as mano

enchufe -- [pwr]
mano -- [chg]
pwr --> bat : alimenta
chg --> bat : recarga
@enduml
```

### Paso 3 — notación completa (delegación y notas)

**Añade:** conector que **delega** del puerto a la parte interna que lo atiende, ensamblaje entre partes y nota con la regla de multiplicidad.

```plantuml
@startuml
component "Robot LimpiaPisos" as robot {
  port "electricidad" as p1
  port "succcion" as p2
  component "Controlador" as ctrl
  component "Motor" as motor
}

component "Red Electrica" as red
component "Tuberia de Escape" as tub

red -- [p1]
p1 --> ctrl : delega hacia dentro
ctrl --> motor : orden de movimiento
motor -- p2
p2 -- tub : delega hacia fuera

note right of robot
  Si una parte se repite, se escribe
  con multiplicidad:  rueda[4].
  Los puertos marcan el contrato
  visible del componente.
end note
@enduml
```

**Cómo se lee el Paso 3:** todo lo que cruza el borde del robot pasa por un **puerto**; `p1 --> ctrl` es **delegación** (el puerto de fuera confía en la parte interna) y `ctrl --> motor` es un conector **interno**. La nota recuerda que las partes llevan multiplicidad (`rueda[4]`).

## Errores comunes

- Dibujar **todo el sistema** dentro de un solo componente: la estructura compuesta muestra **un** componente con sus partes, no el mapa completo.
- Conectar partes **ignorando los puertos**: si el exterior debe entrar, debe haber un puerto/interfaz en el borde.
- Confundirlo con un diagrama de **despliegue**: aquí las partes son de **software**, no de hardware.
