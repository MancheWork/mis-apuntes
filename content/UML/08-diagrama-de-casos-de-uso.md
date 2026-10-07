---
title: Diagrama de casos de uso
tags: [uml]
---

# Diagrama de casos de uso

## Explicación didáctica

El **diagrama de casos de uso** captura el sistema **desde el punto de vista del usuario**: qué pueden *hacer* los actores con el sistema. Es el primer diagrama de un proyecto porque define el **alcance** (scope) y los **requisitos funcionales**.

**Cuándo usarlo:**
- Al inicio del análisis: levantamiento de requisitos con el cliente.
- Para delimitar qué entra y qué no entra en la primera versión.
- Para escribir pruebas: cada caso de uso genera escenarios de prueba.

**Notación:**
- **Actor**: figura de "palito" — persona u otro sistema que interactúa (puede ser `<<sistema>>`).
- **Caso de uso**: elipse con verbo en infinitivo: *Realizar pedido*, *Emitir factura*.
- **Frontera del sistema**: rectángulo que contiene los casos de uso.
- Relaciones:
  - `actor --> caso`: **participación**.
  - `casoA ..> casoB : <<include>>`: A **siempre** ejecuta B (obligatorio).
  - `casoA ..> casoB : <<extend>>`: B **puede** ocurrir en A bajo cierta condición (opcional).
  - `caso <|-- caso`: **generalización** de casos de uso.

> [!tip] Cómo escribirlos bien
> Siempre en **infinitivo** y desde la perspectiva del actor: *"Registrar usuario"*, nunca *"El usuario hace clic en..."*.

## Ejemplo 1: Sistema de e-commerce

```plantuml
@startuml
left to right direction

actor "Cliente" as cliente
actor "Administrador" as admin

rectangle "Tienda Online" {

  usecase "Iniciar sesión" as ucLogin
  usecase "Explorar catálogo" as ucCatalogo
  usecase "Agregar al carrito" as ucCarrito
  usecase "Realizar compra" as ucCompra
  usecase "Pagar con tarjeta" as ucPagar
  usecase "Emitir factura" as ucFactura
  usecase "Gestionar stock" as ucStock
}

cliente --> ucCatalogo
cliente --> ucLogin
ucLogin ..> ucCatalogo : <<include>>
ucCatalogo --> ucCarrito
ucCarrito --> ucCompra
ucCompra ..> ucPagar : <<include>>
ucPagar ..> ucFactura : <<extend>>

admin --> ucStock
admin --> ucFactura
@enduml
```

**Lectura:** *el Cliente necesita iniciar sesión para explorar (include = siempre); pagar es parte obligatoria de la compra; la factura se emite **solo si** el cliente la solicita (extend = opcional).*

## Ejemplo 2: Biblioteca con actores y generalización

```plantuml
@startuml
left to right direction

actor "Usuario" as usuario
actor "Socio" as socio
actor "Invitado" as invitado
usuario <|-- socio
usuario <|-- invitado

rectangle "Sistema de Biblioteca" {
  usecase "Buscar libro" as buscar
  usecase "Reservar libro" as reservar
  usecase "Pedir préstamo" as prestar
  usecase "Devolver libro" as devolver
  usecase "Pagar multa" as multa
  usecase "Consultar historial" as historial
}

socio --> buscar
socio --> reservar
socio --> prestar
socio --> devolver
socio --> historial
invitado --> buscar

reservar ..> prestar : <<extend>>
prestar ..> multa : <<extend>>
@enduml
```

**Lectura:** *el Invitado solo busca; el Socio puede todo; reservar solo termina en préstamo si hay disponibilidad (extend) y la multa aparece únicamente si hay retraso.*

## Errores comunes

- Poner **pantallas o botones** como casos de uso (*"Hacer clic en Aceptar"*): el caso de uso es la **intención del usuario**, no la interfaz.
- Usar `<<extend>>` donde en realidad es obligatorio: si **siempre** pasa, es `<<include>>`.
- Dibujar al actor dentro del rectángulo del sistema: el actor está **fuera** de la frontera.
