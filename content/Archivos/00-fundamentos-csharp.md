---
title: Fundamentos C# desde cero
tags: [csharp, fundamentos]
---

# Fundamentos C# desde cero

## Explicación didáctica

Antes de guardar en archivos hay que entender **cómo habla C#**: todo dato tiene un **tipo** (qué puede guardar), toda decisión usa **if/else**, toda repetición usa **for/while**, todo menú usa **do/while + switch**, y todo grupo de datos usa **arreglos/matrices**. Esta nota es el piso: sin esto, los programas de Archivos parecen magia.

**Para qué sirve cada pieza:**

| Pieza | Qué es | Para qué sirve | Dónde va |
| --- | --- | --- | --- |
| `int`, `double`, `string`, `bool` | Tipos de dato | Decir qué guarda una variable | En atributos, variables y parámetros |
| `if / else` | Decisión | Elegir un camino según condición | Validar edad, buscar, verificar archivo |
| `for` | Repetición contada | Recorrer líneas o pedir N datos | Llenar arreglo, buscar en `ReadAllLines` |
| `while / do-while` | Repetición por condición | Repetir hasta que pase algo | Menú hasta elegir Salir |
| `switch` | Menú por valor | Elegir caso según opción | Menú 1.Crear 2.Ver 3.Buscar |
| `[]` arreglo / `[,]` matriz | Colección fija | Guardar varios datos juntos en memoria | `Estudiante[]`, tabla de notas ficticias |

## Tipos: `int`, `double`, `string` y demás

```csharp
int edad = 20;              // entero: contar (edad, cantidad, opción)
double promedio = 6.35;     // decimal: medir (notas, promedios)
string nombre = "Paola";    // texto: nombres, rutas, líneas del archivo
bool encontrado = false;    // lógico: ¿se encontró o no?
```

**Cómo funciona:** *el tipo dice cuánta memoria usa y qué operaciones permite: `int + int` suma, `string + string` pega, `double / 3` da decimal.*

> [!tip] El error clásico
> `int.Parse("veinte")` muere. Por eso en Archivos usamos `int.TryParse`: intenta convertir y devuelve `true/false` sin romper.

```csharp
if (!int.TryParse(Console.ReadLine(), out int edad))
{
    Console.WriteLine("Edad inválida.");
    return;
}
```

**Lectura:** *si lo escrito no es número, avisa y sale; si sí, `edad` queda lista para guardar.*


## `if / else`: decidir

```csharp
if (edad >= 18)
{
    Console.WriteLine("Mayor de edad.");
}
else
{
    Console.WriteLine("Menor de edad.");
}
```

**Para qué sirve:** *validar antes de guardar (edad numérica, archivo existe, nombre encontrado).*
**Dónde va:** *después de pedir un dato y antes de usarlo.*

## `for`: repetir N veces

```csharp
string[] lineas = File.ReadAllLines(archivo);
for (int i = 0; i < lineas.Length; i++)
{
    Console.WriteLine((i + 1) + ": " + lineas[i]);
}
```

**Cómo funciona:** *`i` nace en 0, sigue mientras `i < largo`, y sube de 1 en 1; `lineas[i]` es la línea actual.*

## `do / while` + `switch`: el menú

```csharp
int opcion;
do
{
    Console.WriteLine("1. Crear  2. Ver  3. Salir");
    opcion = int.Parse(Console.ReadLine());
    switch (opcion)
    {
        case 1: Crear(); break;
        case 2: Ver(); break;
        case 3: Console.WriteLine("Chao."); break;
        default: Console.WriteLine("Opción no válida."); break;
    }
} while (opcion != 3);
```

**Lectura:** *el `do` muestra el menú al menos una vez; el `switch` elige el caso; el `while` repite hasta el 3.*

## Matrices con datos ficticios

*Objetivo: entender la matriz como tabla fila x columna, leerla celda por celda y promediar cada fila.*

### Paso 1 — declarar la tabla (qué es)

```csharp
// 3 estudiantes (filas) x 3 notas (columnas). Datos inventados para practicar.
double[,] notas = {
    { 6.5, 5.8, 7.0 },   // fila 0 = Paola
    { 4.2, 5.0, 5.5 },   // fila 1 = Diego
    { 7.0, 6.8, 6.9 }    // fila 2 = Ana
};

string[] nombres = { "Paola", "Diego", "Ana" };
```

**Qué es:** *una matriz es una tabla con 2 índices: `notas[fila, columna]`. La coma en `double[,]` dice "2 dimensiones"; cada fila es un estudiante, cada columna una materia (Historia, Matemática, Lenguaje).*
**Cómo se dibuja:**

|  | col 0 (Hist.) | col 1 (Mat.) | col 2 (Leng.) |
| --- | --- | --- | --- |
| fila 0 Paola | `notas[0,0]` = 6.5 | `notas[0,1]` = 5.8 | `notas[0,2]` = 7.0 |
| fila 1 Diego | `notas[1,0]` = 4.2 | `notas[1,1]` = 5.0 | `notas[1,2]` = 5.5 |
| fila 2 Ana | `notas[2,0]` = 7.0 | `notas[2,1]` = 6.8 | `notas[2,2]` = 6.9 |

### Paso 2 — recorrer una fila (cómo se lee una celda)

```csharp
// Suma SOLO la fila 0 (Paola): el for mueve la columna c de 0 a 2
double suma = 0;
for (int c = 0; c < 3; c++)
{
    suma += notas[0, c];   // c=0 -> 6.5, c=1 -> 6.5+5.8, c=2 -> 6.5+5.8+7.0
}
Console.WriteLine("Paola suma: " + suma);          // 19.3
Console.WriteLine("Paola promedio: " + (suma / 3).ToString("F2"));  // 6.43
```

**Cómo funciona:** *fijo la fila (`0`) y el `for` pasea la columna (`c`): `notas[0,c]` visita 6.5 → 5.8 → 7.0 y las acumula en `suma`; al salir divido por 3.*

### Paso 3 — recorrer toda la matriz (notación completa)

```csharp
for (int f = 0; f < 3; f++)        // for EXTERNO: elige la fila (estudiante)
{
    double suma = 0;               // se reinicia en cada fila
    for (int c = 0; c < 3; c++)    // for INTERNO: recorre las 3 columnas (notas)
    {
        suma += notas[f, c];
    }
    Console.WriteLine(nombres[f] + " promedio: " + (suma / 3).ToString("F2"));
}
// Salida:
// Paola promedio: 6.43
// Diego promedio: 4.90
// Ana promedio: 6.90
```

**Cómo se lee el Paso 3:** *el `for` de afuera (`f`) dice "¿de qué estudiante hablo?"; el de adentro (`c`) dice "¿qué nota sumo ahora?". Cuando el interno termina (3 notas), se imprime el promedio, `suma` se reinicia a 0 y el externo avanza al siguiente estudiante. Orden de visita: `[0,0] [0,1] [0,2] → [1,0] [1,1] [1,2] → [2,0] [2,1] [2,2]`.*
**Manejo de datos:** *la matriz vive en memoria (se pierde al cerrar); el archivo la hace permanente: cada fila se vuelve un bloque `Nombre/Edad` en `datos.txt`.*

## Errores comunes

- `int` para notas con decimal: se trunca. Usa `double`.
- `if` sin `else` cuando necesitas avisar el caso contrario (buscar sin "no encontrado").
- `for (i = 1; ...)` en arreglos: los arreglos parten en 0, te saltas el primero.
- Matriz `[3,3]` con índice `[3,0]`: va de 0 a 2, el 3 revienta.

