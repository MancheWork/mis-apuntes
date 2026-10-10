---
title: Archivos en C#
tags: [csharp, archivos]
---

# Archivos en C#

Guardar datos en un archivo de texto permite que la información sobreviva al cerrar el programa: lo que hoy se escribe con `File.WriteAllText`, mañana se recupera con `File.ReadAllText`. Todo se apoya en el espacio de nombres `System.IO`.

Esta sección enseña el camino completo: cómo hablar C# desde cero, cómo modelar datos con clases y cómo persistir esos datos en `datos.txt` — crear, leer, buscar y agregar — hasta unirlo todo en un registro portable con menú.

> [!tip] Empieza por aquí
> ¿Primera vez con archivos? Ve al **[[ejemplo-completo]]**: un registro de estudiantes que crea, lee, busca y agrega, con la ruta resuelta de forma portable.

> [!info] Lo que necesitas
> Solo `using System;` y `using System.IO;`. Los ejemplos son de consola y se prueban tal cual en un proyecto de tipo *Aplicación de consola*.

## 00 — Base C#: el lenguaje

| Nota | Responde a... |
| --- | --- |
| [[00-fundamentos-csharp\|Fundamentos C#]] | ¿Qué son `int/double/string`, `if/else`, `for`, menú y matrices? |

## 01 — POO: el molde de los datos

Sin clases no hay nada que guardar: primero el molde, después el archivo.

| Nota | Responde a... |
| --- | --- |
| [[01-poo-repaso\|Repaso POO]] | ¿Cómo modelo un `Estudiante` con atributos, parámetros y manejo memoria/archivo? |

## 02–05 — Operaciones sobre `datos.txt`

Cada nota trabaja **una sola operación** sobre un archivo con formato `Nombre: ... / Edad: ...`.

| # | Nota | Operación | Método clave |
| --- | --- | --- | --- |
| 02 | [[02-crear-archivos\|Crear]] | Crea/sobrescribe el archivo | `File.WriteAllText` |
| 03 | [[03-leer-archivos\|Leer]] | Lee todo el contenido | `File.ReadAllText` / `ReadAllLines` |
| 04 | [[04-buscar-en-archivos\|Buscar]] | Busca una línea y muestra la siguiente | `File.ReadAllLines` + `for` |
| 05 | [[05-modificar-archivos\|Agregar]] | Agrega al final sin borrar | `File.AppendAllText` |

## 06 — Integración

| Nota | Responde a... |
| --- | --- |
| [[ejemplo-completo\|Ejemplo completo]] | ¿Cómo uno POO + archivos en un registro portable con menú? |

## Consejos para estudiar

1. **Orden de lectura**: [[00-fundamentos-csharp|Fundamentos]] → POO → Crear → Leer → Buscar → Agregar → [[ejemplo-completo|Ejemplo completo]].
2. **Copia y rompe**: cambia `WriteAllText` por `AppendAllText` y mira qué pasa al ejecutar dos veces.
3. **Ojo con la ruta**: si la carpeta no existe, el programa falla al guardar; por eso el ejemplo final crea su carpeta con `MyDocuments` + `Directory.CreateDirectory`.
