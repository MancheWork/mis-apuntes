---
title: Archivos en C#
tags: [csharp, archivos]
---

# Archivos en C#

**Guardar datos en archivos de texto** es como tener un cuaderno que no se borra al apagar el computador: lo que hoy guardas con `File.WriteAllText`, mañana lo recuperas con `File.ReadAllText`. Todo vive en el espacio de nombres `System.IO`.

En esta sección encontrarás los **4 programas didácticos de la Clase 8** (crear, leer, buscar y modificar `datos.txt`), más un repaso de **POO** (la base para guardar objetos en archivos) y un **ejemplo completo** que los une en un mini sistema portable.

> [!tip] Empieza por aquí
> ¿Primera vez con archivos? Ve al **[[ejemplo-completo]]**: un registro de estudiantes que crea, lee, busca y agrega, todo en un solo programa portable que sí corre en tu PC.

> [!info] Lo que necesitas
> Solo `using System;` y `using System.IO;`. Los ejemplos usan consola (.NET Framework 4.7.2) y se pegan tal cual en un proyecto de tipo *Aplicación de consola*.

## Repaso POO (base para guardar objetos)

Sin clases no hay nada que guardar: primero el molde, después el archivo.

| # | Nota | Responde a... |
| --- | --- | --- |
| 00 | [[01-poo-repaso\|Repaso POO]] | ¿Cómo modelo un `Estudiante` con atributos y métodos? |

## Operaciones con archivos (4 programas de clase)

Cada programa hace **una sola operación** sobre `datos.txt` con formato `Nombre: ... / Edad: ...`.

| # | Nota | Operación | Método clave |
| --- | --- | --- | --- |
| 01 | [[02-crear-archivos\|Crear]] | Crea/sobrescribe el archivo | `File.WriteAllText` |
| 02 | [[03-leer-archivos\|Leer]] | Lee todo el contenido | `File.ReadAllText` / `ReadAllLines` |
| 03 | [[04-buscar-en-archivos\|Buscar]] | Busca una línea y muestra la siguiente | `File.ReadAllLines` + `for` |
| 04 | [[05-modificar-archivos\|Agregar]] | Agrega al final sin borrar | `File.AppendAllText` |

## Consejos para estudiar

1. **Orden de lectura**: POO → Crear → Leer → Buscar → Agregar → [[ejemplo-completo|Ejemplo completo]].
2. **Copia y rompe**: cambia `WriteAllText` por `AppendAllText` y mira qué pasa al ejecutar dos veces.
3. **Ojo con la ruta**: los ejemplos originales usan `C:\Users\scarrasc\...` (el PC del profe). En el ejemplo completo ya viene la versión portable con `MyDocuments`.
