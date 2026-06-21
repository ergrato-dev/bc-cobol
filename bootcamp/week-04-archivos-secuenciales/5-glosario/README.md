# Glosario — Semana 04: Archivos Secuenciales

## A

**ACCESS MODE**
Cláusula de SELECT que define cómo se accede al archivo: SEQUENTIAL, RANDOM, DYNAMIC.

**ASSIGN TO**
Cláusula de SELECT que asocia el nombre lógico del archivo con un archivo físico (ruta en disco).

**AT END**
Cláusula de READ que se ejecuta cuando no hay más registros (fin de archivo).

## B

**BEFORE/AFTER ADVANCING**
Cláusula de WRITE para control de salto de línea en reportes.

## C

**CLOSE**
Verbo que cierra un archivo, liberando recursos y asegurando que los datos se escriban.

## E

**ENVIRONMENT DIVISION**
Segunda división de COBOL. Contiene CONFIGURATION SECTION e INPUT-OUTPUT SECTION con FILE-CONTROL.

**EOF (End of File)**
Condición que indica que se ha llegado al final del archivo. Código FILE STATUS = "10".

**EXTEND**
Modo de apertura (OPEN EXTEND) que agrega registros al final de un archivo existente.

## F

**FD (File Description)**
Entrada en FILE SECTION que describe el layout de un archivo: nombre, tamaño, estructura de registro.

**FILE-CONTROL**
Párrafo de INPUT-OUTPUT SECTION donde se declaran los SELECT para cada archivo.

**FILE SECTION**
Sección de DATA DIVISION donde se definen los FD y SD con sus layouts de registro.

**FILE STATUS**
Variable de 2 bytes que COBOL actualiza después de cada operación de archivo. Códigos clave: 00 (OK), 10 (EOF), 35 (no encontrado).

## I

**INPUT (OPEN)**
Modo de apertura de solo lectura. El archivo debe existir.

**INPUT-OUTPUT SECTION**
Sección de ENVIRONMENT DIVISION que contiene FILE-CONTROL.

## L

**LINE SEQUENTIAL**
Organización de archivo para texto con saltos de línea. Cada línea = 1 registro.

## N

**NOT AT END**
Cláusula de READ que se ejecuta cuando se leyó un registro exitosamente.

## O

**OPEN**
Verbo que abre un archivo en un modo específico (INPUT, OUTPUT, EXTEND, I-O).

**ORGANIZATION**
Cláusula de SELECT que define el tipo de organización del archivo.

**OUTPUT (OPEN)**
Modo de apertura de solo escritura. Crea un archivo nuevo o sobrescribe uno existente.

## R

**READ**
Verbo que lee el siguiente registro de un archivo secuencial.

**RECORD SEQUENTIAL**
Organización de archivo binario con registros de largo fijo. Sin delimitadores.

## S

**SELECT**
Sentencia en FILE-CONTROL que declara un archivo lógico y sus propiedades.

## W

**WRITE**
Verbo que escribe un registro en un archivo de salida. Usa el nombre del registro 01 del FD.

**WRITE ... FROM**
Variante de WRITE que escribe el contenido de una variable de WORKING-STORAGE.
