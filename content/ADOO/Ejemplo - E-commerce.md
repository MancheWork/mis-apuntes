---
tipo: ejemplo-diagrama
materia: Análisis y Diseño Orientado a Objetos
tags:
  - materia/adoo
  - UML
  - ejemplo
  - e-commerce
aliases:
  - Casos de uso E-commerce
---

# Ejemplo: Diagrama de Casos de Uso — E-commerce

## Contexto

Sistema de tienda en línea donde los clientes pueden comprar productos, los vendedores gestionan su catálogo y un administrador supervisa el sistema.

## Diagrama

```plantuml
@startuml
left to right direction
actor "Cliente" as cliente
actor "Vendedor" as vendedor
actor "Administrador" as admin
actor "Pasarela de Pagos" as pasarela <<external>>

rectangle "Sistema E-commerce" {
    usecase "Buscar productos" as UC1
    usecase "Ver detalle de producto" as UC2
    usecase "Agregar al carrito" as UC3
    usecase "Realizar compra" as UC4
    usecase "Pagar" as UC5
    usecase "Registrarse" as UC6
    usecase "Iniciar sesión" as UC7
    usecase "Consultar historial de pedidos" as UC8
    usecase "Cancelar pedido" as UC9

    usecase "Publicar producto" as UC10
    usecase "Editar producto" as UC11
    usecase "Eliminar producto" as UC12
    usecase "Ver ventas" as UC13

    usecase "Gestionar usuarios" as UC14
    usecase "Gestionar categorías" as UC15
    usecase "Ver reportes de ventas" as UC16
    usecase "Gestionar devoluciones" as UC17
}

cliente --> UC1
cliente --> UC2
cliente --> UC3
cliente --> UC4
cliente --> UC6
cliente --> UC7
cliente --> UC8
cliente --> UC9

vendedor --> UC10
vendedor --> UC11
vendedor --> UC12
vendedor --> UC13
vendedor --> UC7

admin --> UC14
admin --> UC15
admin --> UC16
admin --> UC17
admin --> UC7

UC4 ..> UC5 : <<include>>
UC4 ..> UC7 : <<include>>
UC3 ..> UC2 : <<include>>
UC9 ..> UC4 : <<extend>>

UC5 --> pasarela
@enduml
```

## Desglose por Actor

### Cliente
| Caso de Uso | Descripción |
| --- | --- |
| Buscar productos | El cliente busca productos por nombre, categoría o filtros. |
| Ver detalle de producto | Consulta información completa: precio, descripción, imágenes, stock. |
| Agregar al carrito | Añade un producto a su carrito de compras. |
| Realizar compra | Confirma los productos del carrito e inicia el proceso de pago. |
| Pagar | *(incluido)* Transacción de pago a través de la pasarela externa. |
| Registrarse | Crea una cuenta con datos personales y credenciales. |
| Iniciar sesión | Se autentica para acceder a funcionalidades restringidas. |
| Consultar historial de pedidos | Ve el estado y detalle de compras anteriores. |
| Cancelar pedido | *(extiende* Realizar compra*)* Cancela un pedido antes de ser despachado. |

### Vendedor
| Caso de Uso | Descripción |
| --- | --- |
| Publicar producto | Agrega un nuevo producto al catálogo con imágenes, precio y stock. |
| Editar producto | Modifica información de un producto existente. |
| Eliminar producto | Retira un producto del catálogo. |
| Ver ventas | Consulta el historial y estado de sus ventas. |

### Administrador
| Caso de Uso | Descripción |
| --- | --- |
| Gestionar usuarios | Crear, editar, deshabilitar o eliminar cuentas de usuario. |
| Gestionar categorías | Crear y organizar las categorías del catálogo. |
| Ver reportes de ventas | Consulta estadísticas y métricas de ventas globales. |
| Gestionar devoluciones | Procesa solicitudes de devolución o reembolso. |

## Relaciones Clave

- **`<<include>>`** — Realizar compra **siempre** incluye Pagar e Iniciar sesión. Agregar al carrito **siempre** incluye Ver detalle de producto.
- **`<<extend>>`** — Cancelar pedido **opcionalmente** extiende Realizar compra (solo bajo ciertas condiciones, como antes del despacho).
- **Actor externo** — La Pasarela de Pagos es un sistema externo con el que interactúa el caso Pagar.
