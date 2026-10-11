---
tipo: concepto
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - UML
aliases:
  - Use Case Diagram
  - Caso de Uso
---

# Diagrama de Casos de Uso

## ¿Qué es?

Un **diagrama de casos de uso** es un tipo de diagrama UML que representa las **funcionalidades** o comportamientos de un sistema desde la perspectiva de sus usuarios. Muestra **qué** hace el sistema, no cómo lo hace internamente.

Es una herramienta clave en la fase de **análisis de requerimientos**, ya que ayuda a identificar y comunicar las funcionalidades que el sistema debe ofrecer.

## Componentes Principales

| Elemento | Símbolo UML | Descripción |
| --- | --- | --- |
| **Actor** | Hombre palo | Entidad externa que interactúa con el sistema (usuario, otro sistema, dispositivo). |
| **Caso de uso** | Óvalo | Una funcionalidad o servicio que el sistema ofrece a un actor. |
| **Sistema** | Rectángulo | El límite del sistema que contiene los casos de uso. |
| **Relaciones** | Líneas/flechas | Conexiones entre actores y casos de uso, o entre casos de uso. |

## Relaciones

- **Asociación** — Línea sólida entre un actor y un caso de uso. Indica que el actor participa en ese caso de uso.
- **Inclusión (`<<include>>`)** — Flecha punteada con estereotipo. Un caso de uso **siempre** invoca a otro (es obligatorio).
- **Extensión (`<<extend>>`)** — Flecha punteada con estereotipo. Un caso de uso **opcionalmente** agrega comportamiento a otro bajo ciertas condiciones.
- **Generalización** — Flecha con triángulo vacío. Herencia entre actores o entre casos de uso.

## Ejemplo Conceptual

```
┌─────────────────────────────────┐
│           Sistema Banco          │
│                                 │
│   (Iniciar sesión)              │
│   (Transferir dinero)──<<include>>──(Validar PIN)
│   (Consultar saldo)             │
│                                 │
└─────────────────────────────────┘
        │                   │
      [Cliente]           [Admin]
        │
   (Retirar efectivo)──<<extend>>──(Imprimir comprobante)
```

## Buenas Prácticas

- Nombrar los casos de uso con **verbo + sustantivo** en infinitivo (ej: "Retirar dinero", "Consultar saldo").
- Un caso de uso representa una **unidad de funcionalidad completa** que genera valor al actor.
- No mezclar detalles de implementación; el diagrama debe ser comprensible para no-técnicos.
- Identificar bien los **actores principales** (quien inicia la interacción) y **secundarios** (que participan indirectamente).

## Cuándo Usarlo

- En la fase de **análisis** para capturar requerimientos funcionales.
- Para comunicar funcionalidades a stakeholders no técnicos.
- Como base para diseñar las pruebas de aceptación.
- Para definir el alcance (scope) del sistema.
