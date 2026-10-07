---
title: Diagrama de interacción generalizada
tags: [uml]
---

# Diagrama de interacción generalizada

## Explicación didáctica

El **diagrama de interacción generalizada** (*interaction overview*) es un **híbrido**: tiene la forma de un diagrama de actividades (flujo con inicio, decisiones y forks) pero cada **nodo es una interacción completa** (una secuencia, una comunicación...) referenciada con `ref [n]`. Sirve para **orquestar varios escenarios** en una sola vista: "primero ocurre la interacción 1, si sale bien la 2, si no la 3".

**Cuándo usarlo:**
- Cuando un proceso tiene **varias interacciones** y necesitas ver su **flujo de control** en una página.
- Para narrar un caso de uso completo compuesto de múltiples secuencias (ej: *Alta de usuario → Envío de mail → Confirmación*).
- Es menos común que secuencia/actividades, pero aparece en exámenes y en documentación de procesos largos.

**Notación:**
- **Nodos de interacción**: rectángulos o actividades rotuladas `ref [n] Nombre de la interacción`.
- **Flujo de control**: flechas, decisiones (`if`), barras paralelas (`fork`) — la misma notación que actividades.
- El `ref [n]` remite a la secuencia numerada `n` descrita en otro diagrama.

**Regla de oro:** *el interaction overview **no** detalla los mensajes; los delega en las interacciones referenciadas. Si necesitas ver los mensajes, abrí la secuencia `ref [n]`.*

## Ejemplo 1: Proceso de compra en línea

```plantuml
@startuml
start

:ref [1] Autenticar cliente;
if (¿Sesión válida?) then (sí)
  :ref [2] Explorar catálogo;
  :ref [3] Agregar al carrito;
  :ref [4] Seleccionar medio de pago;

  if (¿Pago aprobado?) then (sí)
    :ref [5] Confirmar pedido;
    :ref [6] Enviar comprobante;
    stop
  else (no)
    :ref [7] Notificar rechazo;
    stop
  endif
else (no)
  :ref [8] Mostrar error de acceso;
  stop
endif

@enduml
```

**Lectura:** *ocho interacciones encadenadas; el diagrama muestra **el flujo y sus puntos de decisión**, mientras que los mensajes concretos viven en cada secuencia referenciada.*

## Ejemplo 2: Atención telefónica con ramas paralelas

```plantuml
@startuml
|Agente|
start
:ref [1] Registrar llamada;

if (¿Cliente existente?) then (sí)
  :ref [2] Consultar historial;
else (no)
  :ref [3] Dar de alta cliente;
endif

|Sistema|
fork
  :ref [4] Validar datos;
fork again
  :ref [5] Verificar elegibilidad;
end fork

|Agente|
:ref [6] Proponer solución;

if (¿Acepta?) then (sí)
  :ref [7] Reservar turno;
  stop
else (no)
  :ref [8] Escalar a supervisor;
  stop
endif

@enduml
```

**Lectura:** *la llamada se registra, se bifurca según si el cliente es nuevo o no, luego dos validaciones corren **en paralelo** y el flujo se sincroniza antes de proponer la solución.*

## Errores comunes

- Escribir **mensajes dentro del nodo de interacción**: el nodo solo **referencia** la interacción; los mensajes van en la secuencia `ref`.
- Numerar los `ref` **sin definirlos**: cada `ref [n]` debe existir como diagrama de secuencia en la documentación.
- Usarlo cuando **un solo diagrama de secuencia alcanza**: si el proceso es corto, la secuencia simple es más clara.
