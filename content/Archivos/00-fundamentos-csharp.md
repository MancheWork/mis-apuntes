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

```csharp
// 3 estudiantes x 3 notas (datos inventados para practicar)
double[,] notas = {
    { 6.5, 5.8, 7.0 },
    { 4.2, 5.0, 5.5 },
    { 7.0, 6.8, 6.9 }
};

string[] nombres = { "Paola", "Diego", "Ana" };

for (int f = 0; f < 3; f++)
{
    double suma = 0;
    for (int c = 0; c < 3; c++)
    {
        suma += notas[f, c];
    }
    Console.WriteLine(nombres[f] + " promedio: " + (suma / 3).ToString("F2"));
}
```

**Cómo funciona:** *`notas[f, c]` es fila f (estudiante) columna c (materia); el `for` interno suma la fila y el externo cambia de estudiante.*
**Manejo de datos:** *la matriz vive en memoria (se pierde al cerrar); el archivo la hace permanente: cada fila se vuelve un bloque `Nombre/Edad` en `datos.txt`.*

## Errores comunes

- `int` para notas con decimal: se trunca. Usa `double`.
- `if` sin `else` cuando necesitas avisar el caso contrario (buscar sin "no encontrado").
- `for (i = 1; ...)` en arreglos: los arreglos parten en 0, te saltas el primero.
- Matriz `[3,3]` con índice `[3,0]`: va de 0 a 2, el 3 revienta.

