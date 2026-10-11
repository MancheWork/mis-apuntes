---
tipo: concepto
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - UML
aliases:
  - UML
  - Unified Modeling Language
---

# Diagramas UML

## ¿Qué es UML?

**UML** (*Unified Modeling Language* o Lenguaje Unificado de Modelado) es un **lenguaje de modelado visual estándar** utilizado para representar, visualizar, documentar y construir artefactos de un sistema de software.

No es un método de desarrollo ni un proceso; es un **lenguaje gráfico** con reglas y notaciones definidas que permite comunicar diseños de forma clara y estandarizada entre todos los involucrados en un proyecto.

## Categorías de Diagramas UML

UML 2.x define **14 tipos de diagramas**, divididos en dos grandes categorías:

### Diagramas Estructurales (Estáticos)

Representan la **estructura estática** del sistema: qué elementos existen y cómo se relacionan entre sí.

| Diagrama | Propósito |
| --- | --- |
| **Diagrama de clases** | Modela clases, atributos, métodos y relaciones (asociación, herencia, composición). |
| **Diagrama de objetos** | Muestra instancias concretas de clases en un momento dado. |
| **Diagrama de componentes** | Representa la organización física del código (módulos, bibliotecas, archivos). |
| **Diagrama de despliegue** | Modela la infraestructura física (servidores, redes, dispositivos). |
| **Diagrama de paquetes** | Organiza elementos del modelo en agrupaciones lógicas. |
| **Diagrama de estructura compuesta** | Describe la estructura interna de una clase. |
| **Diagrama de perfiles** | Permite extender UML con estereotipos personalizados. |

### Diagramas Comportamentales (Dinámicos)

Representan el **comportamiento** del sistema: cómo interactúan los elementos y cómo cambia el estado con el tiempo.

| Diagrama | Propósito |
| --- | --- |
| **Diagrama de casos de uso** | Funcionalidades del sistema vista desde los actores/usuarios. |
| **Diagrama de secuencia** | Interacciones entre objetos ordenadas cronológicamente. |
| **Diagrama de actividad** | Flujo de trabajo o procesos con decisiones, paralelismos y ciclos. |
| **Diagrama de máquina de estados** | Ciclo de vida de un objeto: estados, transiciones y eventos. |
| **Diagrama de comunicación** | Interacciones centradas en el enlace entre objetos. |
| **Diagrama de temporal** | Evolución de estados o condiciones a lo largo del tiempo. |
| **Diagrama de interacción general** | Diagrama compuesto que muestra cómo se relacionan otros diagramas de interacción. |

## Relación entre los Diagramas

Los diagramas no existen de forma aislada; se complementan:

- Los **casos de uso** identifican *qué* hace el sistema.
- Las **clases** definen *con qué estructura* se modela.
- Las **secuencias** detallan *cómo* interactúan los objetos para lograr un caso de uso.
- La **actividad** muestra el *flujo completo* de un proceso.
- Los **estados** describen el *ciclo de vida* de objetos clave.

## Los Más Frecuentes en Desarrollo OO

En la práctica diaria de análisis y diseño orientado a objetos, los más utilizados son:

1. **Diagrama de clases** — el más usado; es la base del diseño de software.
2. **Diagrama de casos de uso** — para capturar requerimientos funcionales.
3. **Diagrama de secuencia** — para detallar la interacción en escenarios específicos.
4. **Diagrama de actividad** — para modelar flujos de proceso complejos.

## Herramientas Populares

- **Draw.io / diagrams.net** — gratuito, integra exportación UML.
- **Lucidchart** — colaborativo en línea.
- **PlantUML** — define diagramas en texto plano (ideal para versionar en Git).
- **StarUML** — escritorio, soporte completo de UML 2.x.
- **Mermaid** — sintaxis textual para diagramas, soportado por Obsidian y GitHub.

## Nota Práctica

> No es necesario usar los 14 diagramas en cada proyecto. Selecciona los que aporten valor según la complejidad del sistema y el público al que va dirigido el diseño.
