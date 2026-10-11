---
tipo: concepto
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - Scrum
  - agil
aliases:
  - Scrum
---

# Scrum

## ¿Qué es Scrum?

**Scrum** es un marco de trabajo (*framework*) **ágil** para gestionar y ejecutar proyectos complejos, especialmente en desarrollo de software. No es un proceso rígido, sino un conjunto de **prácticas, roles, eventos y artefactos** que permiten entregar valor de forma iterativa e incremental.

> En palabras simples: Scrum organiza el trabajo en ciclos cortos llamados **Sprints** (de 1 a 4 semanas), al final de los cuales se entrega un producto funcional y mejorado.

### ¿Por qué Scrum y no otro método?

El desarrollo de software tradicional (Waterfall) tiene un problema grave: se planifica **todo al inicio** y se entrega **al final**. Si los requisitos cambian (y siempre cambian), el resultado final no es lo que el cliente esperaba.

Scrum resuelve esto con un enfoque diferente:

| Waterfall | Scrum |
| --- | --- |
| Planificación masiva al inicio | Planificación continua |
| Entrega al final del proyecto | Entrega cada 2-4 semanas |
| Requisitos fijos | Requisitos que evolucionan |
| Feedback al final | Feedback constante |
| Cambios son costosos | Cambios son bienvenidos |

## Los 3 Pilares de Scrum

Scrum se sustenta en tres pilares fundamentales:

### 1. Transparencia
Todos los involucrados tienen visibilidad del proceso y del producto. No hay secretos ni información oculta.

**Ejemplo:** El tablero de tareas (Kanban) es visible para todos. Cada persona sabe qué se está haciendo, qué está pendiente y qué tiene problemas.

### 2. Inspección
Se revisa el progreso y los artefactos periódicamente. No se espera al final para ver si va bien.

**Ejemplo:** En la Daily Scrum (reunión diaria), el equipo revisa qué se avanzó y qué obstáculos hay.

### 3. Adaptación
Se ajusta el rumbo cuando algo no funciona. Scrum no es un plan rígido, es un proceso que se mejora constantemente.

**Ejemplo:** En la retrospectiva, el equipo decide cambiar la forma en que estima tareas porque las estimaciones siempre eran optimistas.

## Los 5 Valores de Scrum

| Valor | Significado |
| --- | --- |
| **Compromiso** | El equipo se compromete a alcanzar los objetivos del Sprint |
| **Enfoque** | Cada persona enfoca su energía en el trabajo del Sprint |
| **Apertura** | El equipo es honesto sobre los desafíos y progreso |
| **Respeto** | Los miembros se valoran mutuamente y sus habilidades |
| **Coraje** | Se enfrentan problemas difíciles y se dice la verdad |

## Roles en Scrum

### Product Owner (Dueño del Producto)

Es la persona responsable de **maximizar el valor** del producto. Representa al negocio y a los usuarios.

**Responsabilidades:**
- Definir y comunicar la **visión del producto**
- Crear y mantener el **Product Backlog** (lista de todo lo que se necesita)
- **Priorizar** las historias de usuario según el valor
- **Aceptar o rechazar** el trabajo completado
- Ser la voz del **cliente** y los **usuarios**

**Ejemplo:** En un proyecto de banca digital, el Product Owner decide que transferir dinero es más urgente que cambiar la contraseña, porque aporta más valor al negocio.

### Scrum Master

Es el **facilitador** y **coach** del proceso Scrum. Protege al equipo de interferencias externas.

**Responsabilidades:**
- **Facilitar** los eventos de Scrum
- **Eliminar bloqueos** que impiden al equipo avanzar
- **Educar** al equipo y a la organización sobre Scrum
- **Coaching** al equipo para que mejore continuamente
- Actuar como **servidor líder** (no jefe)

**Ejemplo:** Si el equipo no puede avanzar porque necesita acceso a un servidor de pruebas, el Scrum Master gestiona con TI para obtenerlo rápidamente.

### Development Team (Equipo de Desarrollo)

Es un grupo **multifuncional y auto-organizado** que entrega el producto incremento.

**Características:**
- **Auto-organizado**: deciden cómo hacer el trabajo
- **Multifuncional**: tienen todas las habilidades necesarias (diseño, código, pruebas, etc.)
- **Tamaño**: 3 a 9 miembros (regla de los 7±2)
- **Sin sub-roles**: todos son "desarrolladores" independientemente de su especialidad
- **Compromiso colectivo**: el equipo es responsable, no individuos

**Ejemplo:** Un equipo de 5 personas puede incluir un diseñador UX, dos desarrolladores backend, un desarrollador frontend y un tester. Todos trabajan juntos, no en silos.

## Artefactos de Scrum

### Product Backlog

Es la **lista ordenada de todo lo que se necesita** en el producto. Es dinámico y siempre está en evolución.

**Características:**
- Única fuente de trabajo para el equipo
- Ordenado por **valor** y **riesgo**
- Las **Historias de Usuario** son la unidad de trabajo principal
- Se refina continuamente

**Ejemplo de Historia de Usuario:**

> **Como** usuario del sistema bancario,
> **Quiero** poder transferir dinero a otra cuenta,
> **Para que** pueda realizar pagos a terceros de forma segura.

**Criterios de Aceptación:**
- Puedo seleccionar cuenta origen y destino
- Puedo ingresar el monto a transferir
- El sistema valida fondos suficientes
- Recibo confirmación de la transferencia

### Sprint Backlog

Es el **plan de trabajo del Sprint**: las historias seleccionadas y las tareas para implementarlas.

### Incremento

Es la **suma de todas las historias de usuario** completadas durante el Sprint. Debe ser **potencialmente entregable** (*shippable*).

## Eventos de Scrum

### Sprint (El Ciclo de Trabajo)

El **Sprint** es el corazón de Scrum. Es un período de tiempo fijo (generalmente 2 semanas) durante el cual el equipo trabaja para entregar un incremento del producto.

**Características:**
- Duración fija (no se extiende)
- El objetivo del Sprint no cambia durante el Sprint
- Cada Sprint es un proyecto pequeño con inicio, desarrollo y cierre

### Sprint Planning (Planificación del Sprint)

El equipo decide **qué** y **cómo** se hará durante el Sprint.

**Duración:** Máximo 8 horas para un Sprint de 4 semanas (proporcionalmente menos).

**Resultados:**
- **Objetivo del Sprint**: una meta clara
- **Sprint Backlog**: las historias seleccionadas y las tareas

**Ejemplo:** Para un Sprint de 2 semanas, el equipo selecciona 3 historias de usuario que suman 13 puntos de esfuerzo y define como objetivo: "El usuario puede iniciar sesión y ver su saldo".

### Daily Scrum (Reunión Diaria)

Reunión **corta** (máximo 15 minutos) para sincronizar al equipo.

**Tres preguntas clásicas:**
1. ¿Qué hice ayer?
2. ¿Qué haré hoy?
3. ¿Tengo algún bloqueo?

**Ejemplo:**
- "Ayer terminé la pantalla de login. Hoy voy a trabajar en la validación de contraseña. No tengo bloqueos."
- "Ayer me quedé atascado con un error de base de datos. Hoy voy a pedir ayuda a Juan. Tengo un bloqueo con los permisos de acceso."

### Sprint Review (Revisión del Sprint)

El equipo **muestra** el incremento completado a los stakeholders.

**Duración:** Máximo 4 horas para un Sprint de 4 semanas.

**Resultados:**
- Demostración del producto funcionando
- Feedback de los stakeholders
- Actualización del Product Backlog

### Sprint Retrospective (Retrospectiva)

El equipo reflexiona sobre **cómo trabajó** durante el Sprint.

**Duración:** Máximo 3 horas para un Sprint de 4 semanas.

**Preguntas guía:**
1. ¿Qué salió bien?
2. ¿Qué se puede mejorar?
3. ¿Qué acciones concretas tomaremos?

**Ejemplo de hallazgos:**
- **Bien:** La daily scurt fue muy productiva, nos mantuvo enfocados
- **Mejorar:** Las estimaciones siempre fueron optimistas
- **Acción:** Usar Planning Poker la próxima vez para estimar mejor

## Planning Poker - Técnica de Estimación

El **Planning Poker** es una técnica colaborativa para estimar el esfuerzo de las historias de usuario.

**Proceso:**
1. El Product Owner presenta la historia de usuario
2. Cada miembro del equipo selecciona una carta con un número (Fibonacci: 0, 1, 2, 3, 5, 8, 13, 21...)
3. Todos revelan sus cartas **simultáneamente**
4. Los que tienen estimaciones muy diferentes **discuten** sus razones
5. Se repite hasta llegar a un **consenso**

**¿Por qué Fibonacci?** Porque la incertidumbre crece con el tamaño. La diferencia entre 5 y 8 es más significativa que entre 1 y 2.

**Ejemplo:**
- Ana dice 5 (/piensa que es sencillo)
- Pedro dice 13 (piensa que hay complejidad oculta)
- Discuten: Pedro menciona que hay que validar que la cuenta destino exista y que no esté bloqueada
- Después de la discusión, ambos coinciden en 8

## Definición de "Terminado" (Definition of Done)

Cada equipo define su propia **Definición de Hecho**. Es un checklist que garantiza la calidad.

**Ejemplo:**
- [ ] Código revisado por al menos 2 personas
- [ ] Pruebas unitarias escritas y pasando
- [ ] Pruebas de integración pasando
- [ ] Documentación actualizada
- [ ] Desplegado en el ambiente de staging
- [ ] Aceptado por el Product Owner

> Si una historia no cumple todos los puntos, **no está terminada**, aunque el código funcione. La Definition of Done es el estándar de calidad del equipo.

## Ejemplo Práctico Completo

### Contexto
Equipo de 5 personas desarrollando un sistema de banca digital. Sprint de 2 semanas.

### Sprint 1

**Objetivo:** El usuario puede iniciar sesión y ver su saldo.

**Historias seleccionadas:**
| ID | Historia | Estimación |
| --- | --- | --- |
| HU-001 | Como usuario, quiero iniciar sesión con mi DNI y contraseña | 5 pts |
| HU-002 | Como usuario, quiero ver mi saldo y movimientos | 3 pts |
| HU-003 | Como usuario, quiero cerrar sesión de forma segura | 2 pts |

**Total:** 10 puntos de esfuerzo

**Desarrollo:**
- Día 1-2: Sprint Planning y diseño inicial
- Día 3-8: Desarrollo de las historias
- Día 9: Pruebas y correcciones
- Día 10: Sprint Review y Retrospective

**Resultado:** El equipo entrega una aplicación donde el usuario puede autenticarse y consultar su saldo. Los stakeholders están satisfechos y dan feedback para el siguiente Sprint.

## Consejos Prácticos

> **No automatizar Scrum**: Scrum es un marco, no una herramienta. Adaptarlo al contexto del equipo es clave.
>
> **Empezar pequeño**: si tu equipo nunca usó Scrum, empieza con un solo Sprint piloto.
>
> **No saltarse eventos**: cada evento tiene un propósito. Saltarse la retrospectiva es perder la oportunidad de mejorar.
>
> **El Product Owner es clave**: sin un PO comprometido y disponible, Scrum falla.

---

## Referencias

- Ken Schwaber & Jeff Sutherland — *The Scrum Guide*
- *Agile Software Development with Scrum* — Ken Schwaber & Mike Beedle
- *User Stories Applied* — Mike Cohn
