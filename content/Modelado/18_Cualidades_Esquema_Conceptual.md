---
tipo: concepto
materia: Modelado de Información
tags:
  - materia/modelado-informacion
  - calidad
  - validacion
  - MER
  - diseño
aliases:
  - Cualidades del esquema conceptual
  - Calidad del modelo E-R
  - Validación del MER
---

# Cualidades de un Esquema de Datos Conceptual

> **Definición:** Un **esquema conceptual de calidad** es aquel que representa fielmente los requisitos del negocio, es correcto en su notación y semántica, no tiene información redundante, se expresa con el vocabulario del dominio, se lee con claridad, se explica por sí mismo, previene anomalías de datos y es fácil de adaptar a cambios futuros.

Estas cualidades se organizan en **ocho criterios** evaluables durante el diseño y la revisión (checklist de calidad):

| # | Cualidad | Pregunta de control |
|---|---|---|
| 1 | [[18_Cualidades_Esquema_Conceptual|Completitud]] | ¿El esquema cubre TODOS los requisitos del negocio? |
| 2 | [[18_Cualidades_Esquema_Conceptual|Corrección]] | ¿Usa bien la notación MER y refleja la realidad? |
| 3 | [[18_Cualidades_Esquema_Conceptual|Minimalidad]] | ¿Hay información que se repite o se puede derivar? |
| 4 | [[18_Cualidades_Esquema_Conceptual|Expresividad]] | ¿Habla el lenguaje del dominio, no jerga inventada? |
| 5 | [[18_Cualidades_Esquema_Conceptual|Legibilidad]] | ¿El diagrama se lee sin cruces ni desorden? |
| 6 | [[18_Cualidades_Esquema_Conceptual|Autoexplicación]] | ¿Se entiende sin notas extensas en lenguaje natural? |
| 7 | [[18_Cualidades_Esquema_Conceptual|Normalidad]] | ¿Previene anomalías de inserción, borrado y actualización? |
| 8 | [[18_Cualidades_Esquema_Conceptual|Extensibilidad]] | ¿Acepta cambios futuros sin rediseño total? |

---

## Cualidad 1: Completitud

### Explicación Teórica

El esquema es **completo** si puede representar **toda la información** que el negocio requiere. La completitud se evalúa **contra la lista de requerimientos**: por cada requisito recogido en el análisis (ver [[01_Etapas_del_Diseño_de_BD]]), debe existir al menos una entidad, relación o atributo que lo satisfaga. Un esquema incompleto "no se ve mal": simplemente **no puede responder preguntas del negocio**.

### Ejemplo Práctico

**E-commerce:** el requisito del negocio es *"el cliente debe poder rastrear el estado de su pedido"*. Esto exige modelar `estado` y `fecha_actualización` en PEDIDO (o una entidad HISTORIAL_ESTADO si interesa el seguimiento temporal).

### Violación vs. Solución Optimizada

| ❌ Violación (incompleto) | ✅ Solución (completo) |
|---|---|
| `PEDIDO(id, fecha, total)` — sin estado | `PEDIDO(id, fecha, total, estado, fecha_estado)` |
| El call center no puede responder "¿dónde está mi pedido?" | El estado se consulta en el modelo |

> [!WARNING] **Prueba de completitud**
> Para cada requisito del enunciado pregúntese: *"¿este dato se puede obtener del esquema?"*. Si la respuesta es no → falto una entidad, relación o atributo.

---

## Cualidad 2: Corrección

### Explicación Teórica

La corrección tiene dos planos:

- **Sintáctica:** el diagrama respeta las reglas de la notación MER (entidades = cajas, relaciones = rombos, cardinalidades correctamente ubicadas, jerarquías con círculo d/s y línea doble/simple).
- **Semántica:** las construcciones reflejan el significado **real** del dominio. Una relación 1:1 declarada cuando en el mundo real es 1:N es sintácticamente válida pero **semánticamente incorrecta**.

### Ejemplo Práctico

**Hospital:** un médico tiene **varios** horarios de atención a la semana. Si el diseñador declara `MÉDICO (1,1) – TIENE – HORARIO (1,1)` está afirmando que cada médico tiene exactamente un horario: falso en el dominio.

### Violación vs. Solución Optimizada

| ❌ Violación (semántica) | ✅ Solución (corregida) |
|---|---|
| `MÉDICO (1,1) — TIENE — HORARIO (1,1)` | `MÉDICO (1,1) — TIENE — HORARIO (0,n)` |
| Un médico "no puede" tener 2 horarios en el modelo | Cada médico tiene 0..n horarios (realidad) |

> [!TIP] **Regla de oro**
> Antes de fijar una cardinalidad, pregunte a quién conoce el negocio: *"¿cuántos puede tener realmente?"*. La corrección semántica no la valida el diagrama, la valida el dominio.

---

## Cualidad 3: Minimalidad

### Explicación Teórica

El esquema es **mínimo** si **cada hecho del dominio se representa exactamente una vez** y todo dato repetido o **derivable** se elimina. La redundancia no es solo "desprolija": es la causa directa de **anomalías** (ver Normalidad) y de inconsistencias (el mismo dato guardado dos veces con valores distintos).

### Ejemplo Práctico

**Banco:** la entidad CUENTA almacena `fecha_nacimiento` del titular **y** su `edad`. La edad se puede **derivar** de la fecha de nacimiento → si alguien cumple años, habría que actualizar en todos lados.

### Violación vs. Solución Optimizada

| ❌ Violación (redundante) | ✅ Solución (mínima) |
|---|---|
| `CUENTA(..., fecha_nacimiento, edad)` | `CUENTA(..., fecha_nacimiento)` |
| `PEDIDO(..., subtotal, impuesto, total)` calculable | `PEDIDO(..., total)` o sólo los datos base |

> [!IMPORTANT] **Regla de derivación**
> Si un atributo se puede **calcular** a partir de otros atributos, NO se almacena (se convierte en atributo derivado al momento de consultar). Excepción justificada: datos derivados que son costosísimos de recalcular y cuyo valor histórico importa (ej. `total` de una factura — que no debe cambiar ni aunque cambien los precios).

---

## Cualidad 4: Expresividad

### Explicación Teórica

El esquema debe **hablar el idioma de los usuarios del negocio**: los nombres de entidades, relaciones y atributos corresponden a los términos reales con que el personal describe su trabajo. Un esquema expresivo permite que el **cliente valide el modelo**; uno inexpresivo obliga a "traducir" y esconde errores de entendimiento.

### Ejemplo Práctico

**Universidad:** el dominio habla de *"matrícula"*, *"arancel"* y *"asistencia"*. Un modelo que nombra esas mismas cosas como `REG_REL_1`, `VALOR_N`, `CONTROL_F` es inexpresivo: nadie del negocio puede confirmar si el modelo es correcto.

### Violación vs. Solución Optimizada

| ❌ Violación (inexpresivo) | ✅ Solución (expresivo) |
|---|---|
| `ENTIDAD_7(id_7, dato_a, dato_b)` | `PEDIDO(id_pedido, fecha, estado)` |
| Relación sin nombre (`◇`) | Relación con verbo: `REALIZA`, `GENERA`, `CONTIENE` |

> [!NOTE] **Ejercicio de validación**
> Muestre su diagrama a una recepcionista de la clínica o al encargado de bodega. Si no entiende qué representa cada caja y flecha **por sí sola**, el esquema no es expresivo.

---

## Cualidad 5: Legibilidad

### Explicación Teórica

La **legibilidad** es la cualidad estética y de navegación del diagrama: entidades que no se cruzan, líneas de relación cortas y sin entrecruzamientos, tamaños uniformes y alineaciones consistentes, agrupación por subsistemas. Un diagrama ilegible puede ser completo y correcto, pero **no comunica** ni permite revisar el diseño.

### Ejemplo Práctico

**Sistema universitario con 12 entidades:** las relaciones MATRICULA, EVALUA, IMPARTE y SUPERVISA se dibujaron sin orden → 7 cruces de líneas. Es imposible seguir qué se relaciona con qué.

### Violación vs. Solución Optimizada

| ❌ Violación (ilegible) | ✅ Solución (legible) |
|---|---|
| Líneas que cruzan 3 entidades | Reordenar: entidades fuertes al centro, débiles al borde |
| Relaciones largas de 4+ saltos | Acercar entidades relacionadas; agrupar por área |
| Fuentes/estilos mezclados | Tamaños y colores uniformes por tipo de componente |

> [!TIP] **Buenas prácticas de dibujo**
> - Colocar las **entidades fuertes** (las que más relaciones tienen) en el **centro**; las débiles y de catálogo en los bordes.
> - Dibujar la relación **entre** las entidades, no alrededor de todo el gráfico.
> - Usar la misma orientación (todas las flechas de cardinalidad de un lado) para no confundir.

---

## Cualidad 6: Autoexplicación

### Explicación Teórica

Un esquema es **autoexplicativo** si se entiende **sin acompañar de extensas notas en lenguaje natural**: los nombres elegidos y la notación bastan para comprender cada elemento. Si el diseñador necesita tres párrafos para explicar qué significa una relación, es síntoma de que la relación está mal nombrada o mal modelada.

### Ejemplo Práctico

**Clínica:** la relación entre MÉDICO y PACIENTE se modeló sin nombre y sin cardinalidades. Hay que explicar verbalmente: *"esto es la atención, un médico atiende varios pacientes..."*. Todo ese texto es innecesario si el rombo dice **ATIENDE** y tiene sus (mín, máx) escritos.

### Violación vs. Solución Optimizada

| ❌ Violación (opaca) | ✅ Solución (autoexplicativa) |
|---|---|
| Rombo vacío entre MÉDICO y PACIENTE | `◇ ATIENDE (0,n)–(0,n)` |
| Nombre de relación genérico: "RELACION_12" | Verbo de dominio: `PRESCRIBE`, `CONSULTA`, `LIQUIDA` |

> [!NOTE] **Métrica informal**
> Invierta el proceso: lea el diagrama en voz alta. "MÉDICO (1,1) ATIENDE (0,n) PACIENTE" se lee solo. Si no puede leerlo sin ayuda, el esquema no es autoexplicativo.

---

## Cualidad 7: Normalidad (Prevención de Anomalías)

### Explicación Teórica

El diseño debe cumplir las **formas normales** (1FN, 2FN, 3FN/BCNF) para evitar tres anomalías clásicas:

- **Anomalía de inserción:** no puedo guardar un dato sin guardar otro que no necesito (ej. no puedo registrar un cliente sin registrar un pedido).
- **Anomalía de borrado:** al eliminar un dato pierdo otros que no quería perder (ej. borro el último pedido del cliente y pierdo sus datos).
- **Anomalía de actualización:** el mismo dato está en muchas filas y debo actualizarlo en todas (ej. cambio del nombre del cliente repetido en 20 pedidos).

La causa raíz de las tres es la **redundancia** (violación de la Minimalidad) y la **dependencia parcial/transitiva** mal resuelta. Ver [[01_Etapas_del_Diseño_de_BD]] (Etapa 4: Normalización).

### Ejemplo Práctico

**E-commerce (diseño malo):** una sola relación PEDIDO que incluye `nombre_cliente`, `dirección_cliente`, `nombre_producto`, `precio` → el nombre del cliente se repite en cada pedido; si cambia su dirección hay que actualizar N filas.

### Violación vs. Solución Optimizada

| ❌ Violación (anómala) | ✅ Solución (normalizada) |
|---|---|
| `PEDIDO(id_pedido, total, nombre_cliente, dirección_cliente, ...)` | `CLIENTE(id_cliente, nombre, dirección)` + `PEDIDO(id_pedido, id_cliente FK, total)` |
| Un solo cambio de dirección = 20 UPDATEs | Un UPDATE en CLIENTE, y PEDIDO lo "ve" por la FK |
| Borrar el pedido del cliente elimina sus datos | CLIENTE sobrevive al borrado de sus pedidos |

> [!IMPORTANT] **Regla práctica de normalidad**
> Si al describir una tabla aparece *"un cliente tiene muchos pedidos y cada pedido repite sus datos"* → descomponga en entidades: la información que depende solo de CLIENTE va en CLIENTE; la que depende solo del par va en la relación (ver [[14_Atributos_Propios_vs_Relacion]]).

---

## Cualidad 8: Extensibilidad / Escalabilidad

### Explicación Teórica

El esquema es **extensible** si **absorbe cambios futuros sin rediseño**: nuevos tipos de datos, nuevos roles, nuevas categorías. El diseño rígido es el que fija en el esquema lo que en el dominio es una **lista que crecerá** (números de teléfono, tipos de pago, roles de usuario). Los patrones que compran extensibilidad son: **generalización/especialización** ([[15_Jerarquias_Superclase_Subclase]]), entidades catálogo y relaciones N:M bien resueltas.

### Ejemplo Práctico

**Banco:** hoy se aceptan pagos con tarjeta y transferencia. El diseño usa un atributo `tipo_pago` (string con check). Mañana llega "pago QR" y "débito automático": con un atributo enumerado solo hay que agregar valores. Pero si el diseño hubiera creado las entidades `PAGO_TARJETA` y `PAGO_TRANSFERENCIA` duplicando todo, cada nuevo medio exigiría una tabla nueva.

### Violación vs. Solución Optimizada

| ❌ Violación (rígido) | ✅ Solución (extensible) |
|---|---|
| `CLIENTE(tel_1, tel_2, tel_3)` — ¿y el 4º teléfono? | `CLIENTE (1,1) —TIENE— TELÉFONO (0,n)` |
| `EMPLEADO(tipo)` con CHECK de 2 valores | Jerarquía `EMPLEADO → OPERARIO / ADMIN / (futuro rol)` con (p,d) |
| Lista de especialidades quemadas en nombres | Entidad catálogo `ESPECIALIDAD` + relación N:M |

> [!WARNING] **Señal de rigidez**
> Si el diseño necesita un campo `tel_4` o una cláusula `ELSE` para acomodar un dato nuevo, el esquema no es extensible: la lista de valores que crece debe modelarse como **entidad hija** o **catálogo**, no como atributos fijos.

---

## 📌 Checklist de Calidad (Resumen)

| Cualidad | Pregunta | Cumple |
|---|---|---|
| Completitud | ¿Todo requisito tiene su representación? | ☐ |
| Corrección | ¿Notación válida y semántica real? | ☐ |
| Minimalidad | ¿Nada se repite ni es derivable? | ☐ |
| Expresividad | ¿Nombres del dominio entendibles? | ☐ |
| Legibilidad | ¿Diagrama limpio, alineado, sin cruces? | ☐ |
| Autoexplicación | ¿Se lee solo, sin notas extensas? | ☐ |
| Normalidad | ¿Sin anomalías de I/B/A? | ☐ |
| Extensibilidad | ¿Absorbe cambios sin rediseño? | ☐ |

> [!TIP] **Cómo usar el checklist**
> Revise el esquema cualidad por cualidad. Si falla una, aplique la corrección inmediata (tablas "Violación → Solución" de esta nota). En el [[20_Taller_Diagnostico_Calidad]] se practica el diagnóstico completo sobre un caso con deficiencias.

---

## 🔗 Notas Relacionadas

- [[01_Etapas_del_Diseño_de_BD]] — Etapas del diseño y normalización
- [[07_Criterios_de_Diseño]] — Decisiones atributo vs. entidad (completitud y minimalidad)
- [[14_Atributos_Propios_vs_Relacion]] — Colocación correcta de datos (normalidad)
- [[15_Jerarquias_Superclase_Subclase]] — Generalización (extensibilidad)
- [[16_Cobertura_Jerarquias]] — Restricciones de jerarquías correctas
- [[19_Antipatrones_MER]] — Errores frecuentes que degradan estas cualidades
- [[20_Taller_Diagnostico_Calidad]] — Práctica de diagnóstico integral