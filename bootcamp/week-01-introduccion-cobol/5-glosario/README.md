# Glosario — Semana 01: Introducción a COBOL

Términos clave ordenados alfabéticamente.

## A

**ACCEPT**
Verbo COBOL que lee datos del teclado (entrada estándar). Equivalente a `input()` en Python o `scanf()` en C.

**Área A**
Columnas 8 a 11 en formato fijo. Aquí van divisiones, secciones, párrafos, niveles 01 y 77.

**Área B**
Columnas 12 a 72 en formato fijo. Aquí van sentencias y niveles 02-49.

## C

**CODASYL**
Conference on Data Systems Languages. Comité que creó COBOL en 1959.

**COBOL**
Common Business Oriented Language. Lenguaje de programación orientado a negocios, creado en 1959.

## D

**DATA DIVISION**
Tercera división de un programa COBOL. Define todas las variables y estructuras de datos del programa.

**DISPLAY**
Verbo COBOL que muestra texto o variables en pantalla (salida estándar). Equivalente a `print()` en Python.

## E

**ENVIRONMENT DIVISION**
Segunda división de un programa COBOL. Describe el entorno de hardware y archivos del programa.

## F

**Formato fijo (Fixed format)**
Formato tradicional COBOL con restricciones de columnas (1-6, 7, 8-11, 12-72, 73-80).

**Formato libre (Free format)**
Formato moderno COBOL (2002+) sin restricciones de columnas. Se activa con `>>SOURCE FORMAT IS FREE`.

## G

**GnuCOBOL**
Compilador COBOL open source (antes OpenCOBOL). Traduce COBOL a C y luego compila con GCC. Es el compilador usado en este bootcamp.

## I

**IDENTIFICATION DIVISION**
Primera división de un programa COBOL. Identifica el programa con PROGRAM-ID.

## M

**MOVE**
Verbo COBOL que asigna un valor a una variable. Equivalente a `=` en otros lenguajes.

## N

**Nivel 01 (01-level)**
Nivel más alto en la jerarquía de datos COBOL. Define un registro o grupo principal.

**Nivel 77 (77-level)**
Variable elemental independiente, no subordinada a ningún grupo.

**Nivel 88 (88-level)**
Condition name. Define una condición booleana asociada a una variable.

## P

**Párrafo (Paragraph)**
Bloque de código en PROCEDURE DIVISION con un nombre. Se ejecuta con PERFORM.

**PERFORM**
Verbo COBOL que transfiere el control a un párrafo y luego retorna. Similar a llamar una función.

**PIC / PICTURE**
Cláusula que define el tipo y tamaño de un dato en COBOL.

**PROCEDURE DIVISION**
Cuarta división de un programa COBOL. Contiene las instrucciones ejecutables.

**PROGRAM-ID**
Nombre del programa, definido en IDENTIFICATION DIVISION.

## S

**STOP RUN**
Sentencia que termina la ejecución del programa COBOL.

## V

**VALUE**
Cláusula que asigna un valor inicial a una variable en DATA DIVISION.

**VALUE ZEROS**
Inicializa una variable numérica con ceros.

**VALUE SPACES**
Inicializa una variable alfanumérica con espacios.

## W

**WORKING-STORAGE SECTION**
Sección de DATA DIVISION donde se declaran las variables de trabajo del programa.

**WS- (prefijo)**
Convención para nombrar variables en WORKING-STORAGE (ej: WS-NOMBRE, WS-EDAD).
