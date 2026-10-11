---
title: Modelado de Información
tags: [modelado, mer, bases-de-datos]
---

# Modelado de Información

El modelamiento de datos traduce la realidad de un negocio a un esquema que la base de datos puede guardar: primero entidades y atributos, luego relaciones y cardinalidades, y solo al final tablas SQL. Todo el proceso vive en el espacio entre lo que la gente entiende (un diagrama E-R) y lo que la máquina entiende (filas y claves).

Esta sección recorre esa ruta completa en 20 notas modulares, con diagramas PlantUML/Mermaid que se dibujan solos al publicar.

> [!tip] Empieza por aquí
> ¿Primera vez con el tema? Ve a [[01_Etapas_del_Diseño_de_BD]] para entender las 6 etapas del diseño; después sigue el orden de abajo.

> [!info] Cómo se publican los diagramas
> Cada bloque de código (PlantUML o Mermaid) se compila a imagen; el fuente queda plegado bajo *"Ver código"* para copiarlo cuando lo necesites.

## Bloque 1 — Núcleo MER (01–08)

Lo esencial: el vocabulario y las decisiones que sostienen cualquier esquema.

| # | Nota | Responde a... |
| --- | --- | --- |
| 01 | [[01_Etapas_del_Diseño_de_BD\|Etapas del diseño]] | ¿Cómo se llega de requerimientos a tablas? |
| 02 | [[02_Entidad_Atributos_e_Instancias\|Entidad y atributos]] | ¿Qué es una entidad, un atributo, una instancia? |
| 03 | [[03_Claves_Candidatas_y_Primaria\|Claves]] | ¿Cómo identifico un registro de forma única? |
| 04 | [[04_Relaciones_y_Cardinalidades\|Relaciones y cardinalidades]] | ¿Cómo se conectan las entidades (1:1, 1:N, N:M)? |
| 05 | [[05_Relaciones_Especiales\|Relaciones especiales]] | ¿Qué pasa con ternarias y autorreferencias? |
| 06 | [[06_Entidades_Debiles_vs_Regulares\|Entidades débiles]] | ¿Qué entidades no existen sin su fuerte? |
| 07 | [[07_Criterios_de_Diseño\|Criterios de diseño]] | ¿Atributo o entidad? ¿Cuándo decidir? |
| 08 | [[08_Caso_de_Estudio_Completo\|Caso de estudio]] | ¿Cómo se integra todo en un caso real? |

## Bloque 2 — Complementarias (09–12)

| # | Nota | Responde a... |
| --- | --- | --- |
| 09 | [[09_MER_Extendido\|MER Extendido]] | ¿Cómo modelo generalización, especialización y agregación? |
| 10 | [[10_POO_Conceptos_Fundamentales\|POO conceptos]] | ¿Qué relación tiene esto con clases y objetos? |
| 11 | [[11_Ejercicios_Practicos\|Ejercicios prácticos]] | ¿Cómo practico con casos resueltos paso a paso? |
| 12 | [[12_Herramientas_UML\|Herramientas UML]] | ¿Con qué herramientas se dibuja y se prueba? |

## Bloque 3 — MER Extendido avanzado (13–17)

| # | Nota | Responde a... |
| --- | --- | --- |
| 13 | [[13_Abstraccion_y_Tipos\|Abstracción y tipos]] | ¿Qué abstraer y qué dejar concreto? |
| 14 | [[14_Atributos_Propios_vs_Relacion\|Atributo vs relación]] | ¿Cuándo un dato es columna y cuándo otra entidad? |
| 15 | [[15_Jerarquias_Superclase_Subclase\|Jerarquías]] | ¿Cómo organizo superclase y subclases? |
| 16 | [[16_Cobertura_Jerarquias\|Cobertura de jerarquías]] | ¿Totales/disjuntas o parciales/superpuestas? |
| 17 | [[17_Caso_SIG_Medio_Ambiente\|Caso SIG]] | ¿Cómo aplica todo en un sistema de información geográfica? |

## Bloque 4 — Calidad y validación (18–20)

| # | Nota | Responde a... |
| --- | --- | --- |
| 18 | [[18_Cualidades_Esquema_Conceptual\|Cualidades del esquema]] | ¿Qué hace que un esquema sea bueno? |
| 19 | [[19_Antipatrones_MER\|Antipatrones]] | ¿Qué errores destruyen un esquema? |
| 20 | [[20_Taller_Diagnostico_Calidad\|Taller diagnóstico]] | ¿Cómo diagnostico y corrijo un esquema defectuoso? |

## Ejercicios: dónde practicar

Los ejercicios ya vienen **resueltos con explicación**: enunciado, razonamiento y solución comentada.

| Para practicar... | Nota |
| --- | --- |
| Identificar entidades, herencia válida, cardinalidades (nivel básico → avanzado) | [[11_Ejercicios_Practicos\|Ejercicios prácticos]] |
| Diagnosticar y corregir esquemas con errores reales | [[20_Taller_Diagnostico_Calidad\|Taller diagnóstico]] |
| Un caso completo de la A a la Z (zoológico) | [[08_Caso_de_Estudio_Completo\|Caso de estudio]] |
| Un caso extenso con jerarquías (SIG) | [[17_Caso_SIG_Medio_Ambiente\|Caso SIG]] |

## Consejos para estudiar

1. **Sigue el orden 01 → 08**: cada nota usa conceptos de las anteriores; saltarte claves (03) rompe relaciones (04).
2. **Dibuja mientras lees**: pega cada bloque en el [PlantUML Online Server](https://www.plantuml.com/plantuml/uml) y modifícalo.
3. **Termina con práctica**: 11_Ejercicios antes del 20_Taller; si aciertas el taller, dominas la materia.
