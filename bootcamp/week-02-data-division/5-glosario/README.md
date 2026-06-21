# Glosario — Semana 02: DATA DIVISION

Términos clave ordenados alfabéticamente.

## C

**COMP / COMPUTATIONAL**
USAGE que almacena números en binario nativo. Rápido para cálculos, ideal para contadores e índices.

**COMP-3 / PACKED-DECIMAL**
USAGE que almacena números en decimal empaquetado (2 dígitos por byte). Ideal para montos financieros y archivos.

**Constante figurativa (Figurative Constant)**
Palabra reservada COBOL que representa un valor fijo: `SPACES`, `ZEROS`, `HIGH-VALUES`, `LOW-VALUES`, `ALL "x"`.

## D

**DATA DIVISION**
Tercera división de un programa COBOL. Contiene FILE SECTION, WORKING-STORAGE SECTION y LINKAGE SECTION.

**DISPLAY (USAGE)**
USAGE por defecto. Cada carácter/dígito ocupa 1 byte en formato ASCII o EBCDIC.

## E

**Elemental (Elementary item)**
Elemento de datos que tiene PIC y no tiene subordinados.

**Edición (Editing)**
Formateo de un dato interno para presentación legible (moneda, fechas, supresión de ceros).

## F

**FILLER**
Palabra reservada para campos sin nombre explícito. Se usa para padding y alineación.

**FILE SECTION**
Sección de DATA DIVISION que describe la estructura de registros de archivos (FD).

## G

**Grupo (Group item)**
Elemento de datos sin PIC que contiene subordinados. Nivel 01 o superior sin PIC.

## I

**INITIALIZE**
Verbo que restaura variables a sus valores por defecto: ZEROS para numéricos, SPACES para alfanuméricos.

## L

**LINKAGE SECTION**
Sección de DATA DIVISION que declara parámetros recibidos de un programa llamador (CALL).

## N

**Nivel (Level number)**
Número (01-49, 77, 88) que define la posición jerárquica de un dato.

**Nivel 01**
Raíz de una jerarquía de datos. Define un registro o grupo principal.

**Nivel 77**
Variable elemental independiente, no subordinada a ningún grupo.

**Nivel 88**
Condition name. Define condiciones booleanas asociadas a valores de una variable.

## P

**PIC / PICTURE**
Cláusula que define tipo, tamaño y formato de un dato.

**PIC 9**
Dígito numérico (0-9).

**PIC X**
Carácter alfanumérico (cualquier carácter).

**PIC A**
Carácter alfabético (A-Z, espacio).

**PIC S**
Signo numérico (+/-). Debe ser el primer carácter del PIC.

**PIC V**
Punto decimal implícito (no ocupa espacio).

## R

**REDEFINES**
Cláusula que permite reinterpretar la misma área de memoria con otra estructura de datos.

## S

**SET ... TO TRUE**
Verbo que asigna el valor asociado a un 88-level.

## U

**USAGE**
Cláusula que define el formato interno de almacenamiento de un dato.

## V

**VALUE**
Cláusula que asigna un valor inicial a una variable en DATA DIVISION.

## W

**WORKING-STORAGE SECTION**
Sección principal de DATA DIVISION donde se declaran variables de trabajo del programa.
