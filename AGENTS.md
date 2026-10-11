# Instrucciones del cuaderno

## Tono de las notas (regla estricta)

Actuar como profesor experto que explica con voz propia, de forma continua y natural.
Prohibidas las meta-referencias al origen del material. No usar frases como:

- "según el texto" / "el documento dice" / "la clase N dice"
- "en la clase 3" / "el archivo menciona" / "tal cual lo escribió el profe"
- "programa de clase" / "de `Ejemplo.txt`" / "de `Código 07-01.txt`"
- "en tu PC" / "el PC del profe" / referencias a rutas personales (`scarrasc`, `aukin`)

## Datos personales (regla de seguridad estricta)

El cuaderno es público. **Nunca** se publica información personal u organizativa:

- No nombres de docentes, correos institucionales, teléfonos.
- No códigos de asignatura, aulas, horarios, semestres, carreras ni rutinas semanales.
- No rutas locales con usuario, ni historiales de organización personales.
- Frontmatter permitido: `title`, `tags`, `tipo`, `materia` (solo el nombre del ramo) y `aliases`.
- Antes de cada publicación, verificar con búsqueda: `docente|correo|@|aula|horario|semestre|código|carrera|202703|L_301|nombres propios`.

En su lugar: explicar el concepto directamente (qué es, para qué sirve, cómo funciona, dónde va),
con ejemplos que se sostienen solos y contexto técnico portable (`MyDocuments`, rutas relativas).

## Estructura de cada nota de Archivos

1. `## Explicación didáctica` — qué es, cuándo se usa, cómo se lee.
2. `## Diagrama` (bloque `plantuml` + párrafo **Lectura:**) — qué muestra el flujo.
3. `## Ejemplo 1` — caso base con título conceptual (no "programa de clase").
4. `## Ejemplo 2` — variante portable/segura.
5. `## Ejemplo completo — construirlo paso a paso` — Paso 1/2/3 acumulativos.
6. `## Errores comunes` — causa + corrección, sin nombrar personas ni clases.

## Índice de Archivos

Orden fijo: `00-fundamentos` → `01-poo` → `02-crear` → `03-leer` → `04-buscar` →
`05-modificar` → `ejemplo-completo`. La tabla 02–05 usa columnas `# | Nota | Operación | Método clave`.
