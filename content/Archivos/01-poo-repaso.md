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

## Atributos: qué son y dónde van

```csharp
class Estudiante
{
    public string Id;        // texto: "A1" (no se calcula, identifica)
    public string Nombre;    // texto: "Paola Rojas"
    public double Historia;  // decimal: 6.5 (las notas tienen coma)
    public int Edad;         // entero: 20 (la edad no tiene coma)
}
```

**Qué son:** *cada atributo es una cajita con nombre y tipo dentro del molde; cada objeto lleva sus propias cajitas con sus valores.*
**Dónde van:** *arriba de la clase, antes de los métodos; primero los datos, después lo que sabe hacer.*
**Por qué `double` y no `int` en notas:** *`int` trunca 6.5 a 6; `double` guarda la coma y el promedio sale bien.*

## Paréntesis: qué datos recibe cada método

```csharp
// Entre paréntesis van los DATOS DE ENTRADA (parámetros)
public Estudiante(string id, string nombre, double historia, double matematica, double lenguaje)
{
    Id = id;           // el de la IZQUIERDA es el atributo, el de la DERECHA el parámetro
    Nombre = nombre;
    Historia = historia;
}

public double CalcularPromedio()  // () vacío = no necesita datos nuevos, usa los atributos
{
    return (Historia + Matematica + Lenguaje) / 3;
}

public void MostrarInformacion()  // void = no devuelve nada, solo imprime
{
    Console.WriteLine("Promedio: " + CalcularPromedio().ToString("F2"));
}
```

**Cómo funciona:** *el constructor recibe 5 datos y los guarda en los atributos; `CalcularPromedio()` no recibe nada porque ya tiene las notas adentro; `MostrarInformacion()` llama a `CalcularPromedio()` y lo imprime con 2 decimales (`F2`).*

## Manejo de datos: memoria vs archivo

```csharp
// En MEMORIA: rápido pero se borra al cerrar
Estudiante[] curso = new Estudiante[3];
curso[0] = new Estudiante("A1", "Paola", 6.5, 5.8, 7.0);
for (int i = 0; i < curso.Length; i++)
    curso[i].MostrarInformacion();

// En ARCHIVO: lento pero permanente
File.WriteAllText(ruta, curso[0].ALinea());  // objeto -> texto -> disco
string texto = File.ReadAllText(ruta);       // disco -> texto (hay que rearmar el objeto)
```

**Lectura:** *el arreglo guarda objetos vivos; el archivo guarda texto muerto: al leer hay que reconstruir cada `Estudiante` línea por línea (eso hace Buscar con `ReadAllLines` + `for`).*

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

Y el `Main` pide la cantidad, llena un `Estudiante[]` con `for` y ofrece menú (código completo, con datos que escribe el usuario):

```csharp
Console.Write("Ingrese la cantidad de estudiantes: ");
int cantidad = int.Parse(Console.ReadLine());
Estudiante[] estudiantes = new Estudiante[cantidad];

// FOR: pide los datos N veces (uno por estudiante)
for (int i = 0; i < cantidad; i++)
{
    Console.WriteLine("\nEstudiante " + (i + 1));
    Console.Write("Ingrese identificador: ");
    string id = Console.ReadLine();
    Console.Write("Ingrese nombre: ");
    string nombre = Console.ReadLine();
    Console.Write("Ingrese nota de Historia: ");
    double historia = double.Parse(Console.ReadLine());
    Console.Write("Ingrese nota de Matemática: ");
    double matematica = double.Parse(Console.ReadLine());
    Console.Write("Ingrese nota de Lenguaje: ");
    double lenguaje = double.Parse(Console.ReadLine());
    estudiantes[i] = new Estudiante(id, nombre, historia, matematica, lenguaje);
}

// DO-WHILE + SWITCH: menú que se repite hasta elegir 3
int opcion;
do
{
    Console.WriteLine("\n===== MENÚ =====");
    Console.WriteLine("1. Mostrar todos los estudiantes");
    Console.WriteLine("2. Buscar estudiante por identificador");
    Console.WriteLine("3. Salir");
    Console.Write("Seleccione una opción: ");
    opcion = int.Parse(Console.ReadLine());

    switch (opcion)
    {
        case 1:
            Console.WriteLine("\n===== ESTUDIANTES REGISTRADOS =====");
            for (int i = 0; i < estudiantes.Length; i++)
            {
                estudiantes[i].MostrarInformacion();
            }
            break;
        case 2:
            Console.Write("\nIngrese el identificador a buscar: ");
            string idBuscar = Console.ReadLine();
            bool encontrado = false;
            // IF-ELSE: recorre y decide si coincide o no
            for (int i = 0; i < estudiantes.Length; i++)
            {
                if (estudiantes[i].Id == idBuscar)
                {
                    Console.WriteLine("\n===== ESTUDIANTE ENCONTRADO =====");
                    estudiantes[i].MostrarInformacion();
                    encontrado = true;
                    break;
                }
            }
            if (encontrado == false)
            {
                Console.WriteLine("No se encontró un estudiante con ese identificador.");
            }
            break;
        case 3:
            Console.WriteLine("Programa finalizado.");
            break;
        default:
            Console.WriteLine("Opción no válida.");
            break;
    }
} while (opcion != 3);
```

**Cómo funciona cada pieza:**
- *`for` de carga: repite `cantidad` veces; en cada vuelta pide 5 datos y guarda `estudiantes[i]`.*
- *`do/while`: muestra el menú al menos una vez y repite mientras `opcion != 3`.*
- *`switch`: `case 1` muestra todo con otro `for`; `case 2` busca con `for + if`; `default` atrapa opciones inválidas.*
- *`if/else` de búsqueda: `if (Id == idBuscar)` decide coincidencia; el `if (encontrado == false)` de afuera avisa cuando nadie coincidió.*

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
