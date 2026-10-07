---
title: Diagrama de paquetes
tags: [uml]
---

# Diagrama de paquetes

## Explicación didáctica

El **diagrama de paquetes** agrupa elementos (clases, otros paquetes, componentes) en **módulos** para organizar sistemas grandes. Es el mapa de carpetas de tu proyecto: evita el "código espagueti" mostrando qué módulos existen y **cuáles dependen de cuáles**.

**Cuándo usarlo:**
- Al inicio de un diseño para definir la **arquitectura por capas** o módulos.
- Para detectar **dependencias circulares** (A → B → A), un síntoma de mal diseño.
- Para explicar un proyecto grande sin abrumar con todas sus clases.

**Notación:**
- **Carpeta** con pestaña: `package "Nombre" { ... }`.
- Las **dependencias** punteadas con flecha `..>` indican que el origen usa al destino.
- Las **relaciones de importación** (`..>`) entre paquetes suelen significar "este paquete importa clases de aquel".
- Un paquete puede contener **subpaquetes** anidados.

**Buenas prácticas:**
- Los paquetes deben tener **una sola responsabilidad** (no metas todo en `Utilidades`).
- Las flechas deben apuntar "hacia abajo" (presentación → lógica → datos), nunca al revés.

## Ejemplo 1: Arquitectura en tres capas

```plantuml
@startuml
skinparam packageStyle rectangle

package "Capa de Presentación" as presentacion {
  class Ventana
  class ControladorWeb
}

package "Capa de Lógica de Negocio" as negocio {
  class GestorDePedidos
  class ValidadorDeStock
}

package "Capa de Acceso a Datos" as datos {
  interface Repositorio {
    + guardar(objeto : Object) : void
  }
  class RepositorioMySQL
}

presentacion ..> negocio : usa
negocio ..> datos : usa
datos ..|> Repositorio : implementa
@enduml
```

**Lectura:** *la presentación depende de la lógica; la lógica depende de los datos; `RepositorioMySQL` implementa la interfaz `Repositorio`. Las flechas nunca van hacia arriba.*

## Ejemplo 2: Sistema universitario con subpaquetes

```plantuml
@startuml
package "SistemaUniversitario" as sistema {

  package "Academico" as academico {
    class Materia
    class Inscripcion
    class Cursada
  }

  package "Administracion" as admin {
    class Alumno
    class Factura
  }

  package "Comun" as comun {
    class Persona
    class Auditoria
  }
}

academico ..> admin : consulta legajo
academico ..> comun : registra
admin ..> comun : registra
@enduml
```

**Lectura:** *`SistemaUniversitario` contiene tres subpaquetes; `Academico` consulta datos de `Administracion` y ambos usan elementos `Comun`.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: organizar una tienda en paquetes usando **toda la notación**: paquetes anidados, estereotipos, dependencias etiquetadas y notas.*

### Paso 1 — paquetes con clases

**Añade:** el paquete `package "Nombre"` y su contenido.

```plantuml
@startuml
package "Tienda" {
  class Producto
  class Pedido
}
@enduml
```

### Paso 2 — anidación y estereotipos

**Añade:** paquetes **dentro** de paquetes (módulos) y el estereotipo `<<...>>` para clasificar el paquete.

```plantuml
@startuml
package "Tienda" {
  package "Dominio" <<core>> {
    class Producto
    class Pedido
    class LineaPedido
  }
  package "Infra" <<detalles>> {
    class RepositorioSQL
    class PasarelaPagos
  }
}
@enduml
```

### Paso 3 — notación completa (dependencias entre paquetes)

**Añade:** dependencias **entre paquetes** `..>` con etiqueta de tipo (`<<import>>`, `<<acceso>>`), clase pública vs. privada y nota de regla de dependencia.

```plantuml
@startuml
skinparam packageStyle rectangle

package "Presentacion" <<capa>> {
  class ControladorPedido
}
package "Dominio" <<capa>> {
  class Pedido {
    + total(): double
  }
  class LineaPedido
  package "Extras" {
    class Descuento
  }
}
package "Infraestructura" <<capa>> {
  class RepositorioPedido
}

Presentacion ..> Dominio : <<import>>
Dominio ..> Infraestructura : <<acceso>>
ControladorPedido ..> Pedido
RepositorioPedido ..> Pedido : persiste
note bottom of Dominio
  Regla: las dependencias apuntan
  hacia DENTRO. Dominio no conoce
  a las capas que lo usan.
end note
@enduml
```

**Cómo se lee el Paso 3:** tres paquetes-capa con estereotipo `<<capa>>`, dependencias etiquetadas (`<<import>>` = usa las clases públicas; `<<acceso>>` = accede a su interior) y la nota recuerda el sentido correcto de las flechas.

## Errores comunes

- **Dependencias circulares** entre paquetes: si A depende de B y B de A, extrae una interfaz o una tercera capa `Comun`.
- Paquetes con **demasiadas clases** (más de ~20): probablemente necesites dividirlo.
- Usar paquetes solo por capas de carpetas del IDE sin significado real: el paquete UML representa **responsabilidad**, no ubicación física.
