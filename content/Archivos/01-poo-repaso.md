---
title: Repaso POO
tags: [csharp, poo]
---

# Repaso POO — la base para guardar objetos

## Explicación didáctica

La **POO** (Programación Orientada a Objetos) es el molde: la **clase** describe *qué datos tiene* algo (atributos) y *qué sabe hacer* (métodos); el **objeto** es cada ejemplar concreto. Sin este molde, no hay nada ordenado que guardar en un archivo.

**Cuándo usarla:** siempre que tus datos tengan estructura repetida (estudiantes, productos, socios): defines la clase una vez y creas tantos objetos como necesites.

**Cómo se lee:**
- `class Estudiante { ... }` → el molde.
- `public string Nombre;` → atributo (dato).
- `public void MostrarInformacion() { ... }` → método (comportamiento).
- `new Estudiante()` → crear el objeto en memoria.

## Ejemplo 1: Estudiante mínimo (de `Ejemplo.txt`)

Crea un estudiante con datos fijos y lo muestra. Es el "hola mundo" de las clases.

```csharp
using System;

class Estudiante
{
    // Atributos
    public string Nombre;
    public int Edad;
    public string Carrera;

    // Método para mostrar la información
    public void MostrarInformacion()
    {
        Console.WriteLine("----- DATOS DEL ESTUDIANTE -----");
        Console.WriteLine("Nombre: " + Nombre);
        Console.WriteLine("Edad: " + Edad);
        Console.WriteLine("Carrera: " + Carrera);
    }
}

class Program
{
    static void Main(string[] args)
    {
        // Crear un objeto de la clase Estudiante
        Estudiante estudiante1 = new Estudiante();

        // Asignar valores a los atributos
        estudiante1.Nombre = "Juan Pérez";
        estudiante1.Edad = 20;
        estudiante1.Carrera = "Analista Programador";

        // Llamar al método para mostrar la información
        estudiante1.MostrarInformacion();

        Console.ReadKey();
    }
}
```

**Lectura:** *el molde `Estudiante` se llena con Juan Pérez / 20 / Analista Programador y `MostrarInformacion()` lo imprime.*

## Ejemplo 2: Sistema de estudiantes con promedio (de `Código 07-01.txt`)

Sube de nivel: constructor, cálculo y menú con arreglo + búsqueda por `Id`.

```csharp
using System;

namespace SistemaEstudiantes
{
    class Estudiante
    {
        public string Id;
        public string Nombre;
        public double Historia;
        public double Matematica;
        public double Lenguaje;

        public Estudiante(string id, string nombre,
            double historia, double matematica, double lenguaje)
        {
            Id = id;
            Nombre = nombre;
            Historia = historia;
            Matematica = matematica;
            Lenguaje = lenguaje;
        }

        public double CalcularPromedio()
        {
            return (Historia + Matematica + Lenguaje) / 3;
        }

        public void MostrarInformacion()
        {
            Console.WriteLine("Identificador: " + Id);
            Console.WriteLine("Nombre: " + Nombre);
            Console.WriteLine("Historia: " + Historia);
            Console.WriteLine("Matemática: " + Matematica);
            Console.WriteLine("Lenguaje: " + Lenguaje);
            Console.WriteLine("Promedio: " + CalcularPromedio().ToString("F2"));
            Console.WriteLine("-----------------------------------");
        }
    }
}
```

Y el `Main` pide la cantidad, llena un `Estudiante[]` con `for` y ofrece menú:

```csharp
Console.Write("Ingrese la cantidad de estudiantes: ");
int cantidad = int.Parse(Console.ReadLine());
Estudiante[] estudiantes = new Estudiante[cantidad];
// ... for para pedir id, nombre y 3 notas ...
// ... do/while con opciones 1.Mostrar 2.Buscar por Id 3.Salir ...
```

**Lectura:** *el constructor deja el objeto listo al nacer; `CalcularPromedio()` deriva un dato nuevo; el menú recorre el arreglo y compara `estudiantes[i].Id == idBuscar`.*

## Ejemplo completo — construirlo paso a paso

*Objetivo: pasar de campos públicos a una clase lista para guardarse en archivo.*

### Paso 1 — los atributos

**Añade:** la clase y sus datos.

```csharp
class Estudiante
{
    public string Nombre;
    public int Edad;
}
```

### Paso 2 — constructor + método

**Añade:** inicialización obligatoria y cómo mostrarse.

```csharp
class Estudiante
{
    public string Nombre;
    public int Edad;

    public Estudiante(string nombre, int edad)
    {
        Nombre = nombre;
        Edad = edad;
    }

    public void MostrarInformacion()
    {
        Console.WriteLine("Nombre: " + Nombre + " / Edad: " + Edad);
    }
}
```

### Paso 3 — formato para archivo (notación completa)

**Añade:** una forma estándar de convertirse a línea de texto, que usarán las notas de Archivos.

```csharp
public string ALinea()
{
    return "Nombre: " + Nombre + "\nEdad: " + Edad;
}
```

**Cómo se lee el Paso 3:** *cada objeto sabe escribirse como las dos líneas de `datos.txt`; así crear/leer/buscar hablan el mismo idioma.*

## Errores comunes

- Usar campos `public string Nombre;` en vez de propiedades `public string Nombre { get; set; }`: funciona, pero no puedes validar después.
- `int.Parse(Console.ReadLine())` sin validar: si el usuario escribe letras, el programa muere. Usa `int.TryParse`.
- Comparar `Id == idBuscar` tal cual: `"A1"` ≠ `"a1"`. Normaliza con `Trim()` y `Equals(..., OrdinalIgnoreCase)`.
- Guardar todo en memoria (`Estudiante[]`): al cerrar el programa se pierde. El paso siguiente es [[02-crear-archivos|guardarlo en archivo]].
