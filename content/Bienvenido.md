---
title: Bienvenido
---

# Bienvenido a mis apuntes

## Objetivo de esta bóveda

El objetivo es sencillo: **tener apuntes, ejemplos y material de aprendizaje en un solo lugar**, siempre accesible desde cualquier navegador.

- **Apuntes**: lo que curso, estudio o investigo, explicado con mis palabras.
- **Ejemplos**: fragmentos de código y diagramas listos para copiar y probar (por ejemplo, los 28 diagramas de [[UML/index|UML]]).
- **Aprendizaje**: cada nota debe poder leerse dentro de un año sin contexto extra: explica el *por qué*, no solo el *qué*.

Todo lo que escribo en Obsidian se publica solo en la web. Si está aquí, es porque me es útil; si no me es útil, no vive en la bóveda.

## Reglas de la bóveda

1. **Una carpeta por materia o tema** (`UML/`, `Matemáticas/`...). Nada suelto en la raíz salvo las notas generales.
2. **Nombres en minúsculas con guiones** y, si la materia se estudia en orden, número delante: `11-diagrama-de-secuencia.md`.
3. **Toda nota empieza con frontmatter**: `title` (título legible) y `tags` (etiquetas de filtro, p. ej. `uml`).
4. **Enlaza con `[[wikilinks]]`** en lugar de copiar texto: los apuntes deben ser una red, no una pila de archivos.
5. **Todo ejemplo va en un bloque con lenguaje** (```` ```plantuml ````, ```` ```python ````...): así se resalta y, si es PlantUML, se dibuja solo.
6. **Los diagramas UML se escriben en bloques `plantuml`**: la web los convierte en imagen automáticamente; el código queda plegado debajo para consultarlo.
7. **Las matemáticas se escriben con LaTeX** (`$...$`, `$$...$$`): se renderizan en la web.
8. **Sube automático cada 5 minutos** (plugin Obsidian Git). Tras escribir, espera al push y revisa el resultado en la web.
9. **La carpeta `private/` nunca se publica**: ahí va lo que no debe salir.
10. **Regla de revisión**: si no entiendo mi propia nota al releerla, la reescribo hoy, no mañana.

## Cómo funciona la publicación

```
Obsidian (escribes)
   │  Obsidian Git: commit + push cada 5 min
   ▼
GitHub (MancheWork/mis-apuntes)
   │  GitHub Actions: renderiza PlantUML → compila Quartz
   ▼
Web pública (manchework.github.io/mis-apuntes)
```

Si algo no aparece en la web: mira la pestaña *Actions* del repo; si la ejecución está en verde, es cosa de caché del navegador (Ctrl+F5).

## Por dónde empezar

- [[index|Mis apuntes]] — portada e índice general.
- [[UML/index|Diagramas UML]] — los 14 diagramas con explicación y ejemplos.
- [[UML/ejemplo-completo|Ejemplo completo]] — cómo armar un modelo UML paso a paso.
