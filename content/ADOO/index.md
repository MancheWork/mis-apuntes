---
title: Análisis y Diseño OO
tags: [adoo, poo, uml]
---

# Análisis y Diseño Orientado a Objetos

La orientación a objetos es una forma de pensar el software: modelas el problema con **clases** (el molde), creas **objetos** (las instancias) y dejas que **herencia**, **polimorfismo**, **encapsulamiento** y **abstracción** trabajen por ti. Analizar es entender *qué* debe hacer el sistema; diseñar es decidir *cómo* se organiza antes de escribir una línea.

Esta sección reúne los apuntes del paradigma, la banca didáctica de diagramas UML con ejemplos aplicados y un resumen compacto para repasar rápido.

> [!tip] Empieza por aquí
> ¿Nuevo en OO? Ve a [[01 - Introducción al Paradigma Orientado a Objetos]]: los 4 pilares con analogías, después [[02 - Clases y Objetos]].

## Apuntes del paradigma (01–08)

| # | Nota | Responde a... |
| --- | --- | --- |
| 01 | [[01 - Introducción al Paradigma Orientado a Objetos\|Paradigma OO]] | ¿Qué es POO y cuáles son sus 4 pilares? |
| 02 | [[02 - Clases y Objetos\|Clases y objetos]] | ¿Qué diferencia hay entre molde e instancia? |
| 03 | [[03 - Encapsulamiento y Modificadores de Acceso\|Encapsulamiento]] | ¿Cómo protejo los datos con visibilidad? |
| 04 | [[04 - Herencia y Generalización\|Herencia]] | ¿Cómo reutilizo código entre superclase y subclase? |
| 05 | [[05 - Polimorfismo\|Polimorfismo]] | ¿Cómo responde el mismo mensaje a objetos distintos? |
| 06 | [[06 - Abstracción e Interfaces\|Abstracción e interfaces]] | ¿Cómo defino contratos sin implementación? |
| 07 | [[07 - Relaciones entre Clases\|Relaciones]] | ¿Asociación, agregación, composición o dependencia? |
| 08 | [[08 - Principios SOLID\|SOLID]] | ¿Qué 5 principios mantienen el diseño sano? |

## Banca didáctica: diagramas UML

| Nota | Responde a... |
| --- | --- |
| [[Diagramas UML\|Panorama UML]] | ¿Cuáles son los 14 diagramas y para qué sirve cada uno? |
| [[Diagrama de Casos de Uso\|Casos de uso]] | ¿Qué hace el usuario con el sistema? |
| [[Diagrama de Clases\|Clases]] | ¿Cómo se estructuran las clases y sus relaciones? |
| [[Diagrama de Secuencia\|Secuencia]] | ¿En qué orden se intercambian mensajes? |
| [[Diagrama de Actividad\|Actividad]] | ¿Cómo es el flujo de trabajo paso a paso? |
| [[Scrum\|Scrum]] | ¿Cómo se organiza el trabajo en un equipo ágil? |

## Ejemplos aplicados (casos de uso resueltos)

Cada ejemplo muestra actores, `<<include>>`, `<<extend>>` y el diagrama completo, con lectura explicada.

| Sistema | Nota |
| --- | --- |
| Biblioteca | [[Ejemplo - Biblioteca\|Ejemplo biblioteca]] |
| E-commerce | [[Ejemplo - E-commerce\|Ejemplo e-commerce]] |
| Bancario | [[Ejemplo - Sistema Bancario\|Ejemplo bancario]] |
| Hospitalario | [[Ejemplo - Sistema Hospitalario\|Ejemplo hospitalario]] |

## Ejercicios: dónde practicar

| Para practicar... | Nota |
| --- | --- |
| Ejercicios graduales con solución comentada (entidades, herencia, cardinalidades) | [[Modelado/11_Ejercicios_Practicos\|Ejercicios prácticos]] |
| Ficha para crear tus propias notas de concepto con ejemplo y cita | [[Ficha Didáctica Modelo\|Ficha didáctica]] |
| Repaso express de todo el temario (SOLID, UML, Scrum) | [[ADOO - Resumen Compacto\|Resumen compacto]] |

## Consulta rápida

- [[Introducción\|Objetivos de aprendizaje]] de la materia y mapa de temas.
- Para modelar datos de un sistema, complementa con [[Modelado/index|Modelado de Información]].

## Consejos para estudiar

1. **Orden recomendado**: 01 → 08 siguiendo los pilares; los diagramas UML van después de dominar clases y relaciones.
2. **Practica con los ejemplos**: pega cada bloque en el [PlantUML Online Server](https://www.plantuml.com/plantuml/uml) y cambia un `..|>` por `-->` a ver qué se rompe.
3. **Cierra con los ejercicios**: `11_Ejercicios_Practicos` tiene enunciado + solución paso a paso; intenta resolver antes de mirar.
