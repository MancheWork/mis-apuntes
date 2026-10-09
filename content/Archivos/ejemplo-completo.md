---
title: Ejemplo completo
tags: [csharp, archivos]
---

# Ejemplo completo: registro portable con las 4 operaciones

Este ejemplo une **POO + las 4 operaciones de archivos** en un solo programa que sí corre en tu PC: guarda estudiantes en `Mis Documentos\Base_datos\datos.txt`, con menú para crear, ver, buscar y agregar.

**El encargo:** *registrar estudiantes (nombre + edad), verlos todos, buscar uno por nombre y agregar más sin borrar, todo persistente entre ejecuciones.*

## Notación textual vs. visual

| Qué expresa | Notación textual (C#) | Notación visual (en `datos.txt`) |
| --- | --- | --- |
| Crear | `File.WriteAllText(ruta, linea)` | El archivo nace/sobrescribe |
| Leer todo | `File.ReadAllText(ruta)` | `Nombre: Ana / Edad: 20` |
| Leer por líneas | `File.ReadAllLines(ruta)` | `lineas[0]`, `lineas[1]`, ... |
| Buscar | `for + Equals(...OrdinalIgnoreCase)` | La línea `Nombre:` + su `i+1` |
| Agregar | `File.AppendAllText(ruta, bloque)` | Bloque nuevo al final |
| Ruta portable | `Path.Combine(MyDocuments, ...)` | `C:\Users\TU_USUARIO\Documents\...` |

> [!tip] Regla de oro
> ¿*Empiezo de cero*? (Write) ¿*miro*? (Read) ¿*encuentro uno*? (for) ¿*sumo sin borrar*? (Append).

## Paso 1 — Alcance: la clase + dónde vive el archivo

```csharp
using System;
using System.IO;

class Estudiante
{
    public string Nombre { get; set; }
    public int Edad { get; set; }

    public Estudiante(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
    }

    public string ALinea()
    {
        return "Nombre: " + Nombre + Environment.NewLine + "Edad: " + Edad;
    }
}

static class Datos
{
    public static string RutaArchivo()
    {
        string carpeta = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
            "Base_datos");
        Directory.CreateDirectory(carpeta);
        return Path.Combine(carpeta, "datos.txt");
    }
}
```

**Lectura:** *`ALinea()` habla el mismo formato que los 4 programas de clase; `RutaArchivo()` centraliza la ruta portable.*

## Paso 2 — Estructura: crear, leer y agregar

```csharp
static void Crear() // sobrescribe (empieza de cero)
{
    Console.Write("Nombre: ");
    string nombre = Console.ReadLine();
    Console.Write("Edad: ");
    if (!int.TryParse(Console.ReadLine(), out int edad))
    { Console.WriteLine("Edad inválida."); return; }

    File.WriteAllText(Datos.RutaArchivo(),
        new Estudiante(nombre, edad).ALinea() + Environment.NewLine);
    Console.WriteLine("Archivo creado/sobrescrito.");
}

static void VerTodos() // lee todo
{
    string archivo = Datos.RutaArchivo();
    if (!File.Exists(archivo)) { Console.WriteLine("Sin datos aún."); return; }
    Console.WriteLine(File.ReadAllText(archivo));
}

static void Agregar() // suma al final
{
    Console.Write("Nombre: ");
    string nombre = Console.ReadLine();
    Console.Write("Edad: ");
    if (!int.TryParse(Console.ReadLine(), out int edad))
    { Console.WriteLine("Edad inválida."); return; }

    string archivo = Datos.RutaArchivo();
    string bloque = new Estudiante(nombre, edad).ALinea() + Environment.NewLine;
    if (File.Exists(archivo) && new FileInfo(archivo).Length > 0)
        bloque = Environment.NewLine + bloque;
    File.AppendAllText(archivo, bloque);
    Console.WriteLine("Agregado.");
}
```

**Lectura:** *Crear = WriteAllText; VerTodos = ReadAllText con guardia Exists; Agregar = AppendAllText con separador inteligente.*

## Paso 3 — Comportamiento: buscar + menú

```csharp
static void Buscar()
{
    string archivo = Datos.RutaArchivo();
    if (!File.Exists(archivo)) { Console.WriteLine("Sin datos aún."); return; }

    Console.Write("Nombre a buscar: ");
    string buscado = Console.ReadLine().Trim();

    string[] lineas = File.ReadAllLines(archivo);
    bool encontrado = false;
    for (int i = 0; i < lineas.Length; i++)
    {
        if (lineas[i].Trim().Equals("Nombre: " + buscado,
            StringComparison.OrdinalIgnoreCase))
        {
            Console.WriteLine("===== ENCONTRADO =====");
            Console.WriteLine(lineas[i]);
            if (i + 1 < lineas.Length)
                Console.WriteLine(lineas[i + 1]);
            encontrado = true;
            break;
        }
    }
    if (!encontrado) Console.WriteLine("No se encontró a " + buscado);
}

static void Main()
{
    int opcion;
    do
    {
        Console.WriteLine("\n===== REGISTRO =====");
        Console.WriteLine("1. Crear (sobrescribe)");
        Console.WriteLine("2. Ver todos");
        Console.WriteLine("3. Buscar por nombre");
        Console.WriteLine("4. Agregar (sin borrar)");
        Console.WriteLine("5. Salir");
        Console.Write("Opción: ");
        if (!int.TryParse(Console.ReadLine(), out opcion)) { opcion = 0; }

        switch (opcion)
        {
            case 1: Crear(); break;
            case 2: VerTodos(); break;
            case 3: Buscar(); break;
            case 4: Agregar(); break;
            case 5: Console.WriteLine("Chao."); break;
            default: Console.WriteLine("Opción no válida."); break;
        }
    } while (opcion != 5);
}
```

**Lectura:** *el mismo menú de Código 07-01.txt, pero persistente en disco.*

## Checklist para armar tu propio registro

1. **Escribe tu clase** con `ALinea()` (como en [[01-poo-repaso|POO]]).
2. **Centraliza la ruta** con `Path.Combine(MyDocuments, ...)` + `CreateDirectory`.
3. **Elige el método**: ¿cero? Write; ¿miro? Read; ¿uno? for; ¿sumo? Append.
4. **Valida todo**: `TryParse`, `Exists`, `i+1 < Length`.
5. **Pruébalo**: crea 1 vez, agrega 2 veces, busca al segundo, cierra y reabre: todo sigue ahí.
