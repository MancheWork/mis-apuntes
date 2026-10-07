---
title: UML
tags: [uml]
---

# Diagramas UML

**UML** (*Unified Modeling Language* / Lenguaje Unificado de Modelado) es un lenguaje gráfico estandarizado por la **OMG** para visualizar, especificar, construir y documentar sistemas de software. No es un método: es la notación que usan métodos como UP o Agile para dibujar el diseño.

En esta carpeta encontrarás los **14 diagramas oficiales de UML 2**, cada uno con:

- Explicación didáctica de **qué es, cuándo se usa y cómo se lee**.
- **2 ejemplos completos** en formato **PlantUML** (código que genera el diagrama).
- Un **ejemplo completo paso a paso** que construye un caso real añadiendo **toda la notación** del diagrama en 3 pasos.
- Los errores más comunes al dibujarlo.

> [!tip] Empieza por aquí
> ¿Primera vez con UML? Ve al **[[ejemplo-completo]]**: un sistema de biblioteca armado paso a paso, con la **notación textual y la visual** explicadas símbolo a símbolo.

> [!info] Cómo se publican los diagramas
> Cada bloque de código PlantUML se compila automáticamente a imagen (SVG). En la **web** ves primero el **diagrama** y el código aparece **plegado** — pulsa *"Ver codigo PlantUML"* para desplegarlo cuando lo necesites.

## Diagramas estructurales (7)

Representan la **estática** del sistema: qué cosas existen.

| # | Diagrama | Responde a... |
| --- | --- | --- |
| 01 | [[01-diagrama-de-clases\|Clases]] | ¿Qué clases hay y cómo se relacionan? |
| 02 | [[02-diagrama-de-objetos\|Objetos]] | ¿Cómo son las instancias en un momento dado? |
| 03 | [[03-diagrama-de-paquetes\|Paquetes]] | ¿Cómo se agrupa el código en módulos? |
| 04 | [[04-diagrama-de-componentes\|Componentes]] | ¿Qué piezas de software se conectan? |
| 05 | [[05-diagrama-de-despliegue\|Despliegue]] | ¿Dónde corre cada pieza (hardware)? |
| 06 | [[06-diagrama-de-estructura-compuesta\|Estructura compuesta]] | ¿De qué se compone un componente por dentro? |
| 07 | [[07-diagrama-de-perfiles\|Perfiles]] | ¿Cómo extendemos UML con estereotipos? |

## Diagramas de comportamiento (7)

Representan la **dinámica**: qué pasa y cuándo.

| # | Diagrama | Responde a... |
| --- | --- | --- |
| 08 | [[08-diagrama-de-casos-de-uso\|Casos de uso]] | ¿Qué hace el usuario con el sistema? |
| 09 | [[09-diagrama-de-actividades\|Actividades]] | ¿Cómo es el flujo de trabajo paso a paso? |
| 10 | [[10-diagrama-de-estados\|Máquina de estados]] | ¿En qué estados puede estar algo y quién lo cambia? |
| 11 | [[11-diagrama-de-secuencia\|Secuencia]] | ¿En qué orden se intercambian mensajes? |
| 12 | [[12-diagrama-de-comunicacion\|Comunicación]] | ¿Quién le manda qué a quién (vista estática)? |
| 13 | [[13-diagrama-de-tiempo\|Tiempo]] | ¿Cómo cambian los estados en el tiempo? |
| 14 | [[14-diagrama-de-interaccion-general\|Interacción generalizada]] | ¿Cómo se combinan varias interacciones? |

## Consejos para estudiar

1. **Lee el diagrama, no lo memorices**: cada notación responde una pregunta concreta (estática vs. dinámica).
2. **Empieza por casos de uso → clases → secuencia**: es el orden clásico de análisis → diseño.
3. **Prueba el código**: copia cualquier ejemplo, pégalo en el [PlantUML Online Server](https://www.plantuml.com/plantuml/uml) y modifícalo.
