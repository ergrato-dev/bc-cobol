# Glosario — Semana 07: Manipulación de Strings

## B

**BEFORE/AFTER (INSPECT)**
Limita el alcance de INSPECT a antes o después de un carácter específico.

## C

**CONVERTING (INSPECT)**
Convierte un conjunto de caracteres en otro (mapeo 1 a 1), como pasar de minúsculas a mayúsculas.

## D

**DELIMITED BY**
Cláusula de STRING/UNSTRING que define dónde termina el dato: SIZE (todo el campo), SPACE (hasta espacio), o un carácter específico.

**DELIMITER IN**
Cláusula de UNSTRING que guarda el delimitador encontrado en una variable.

## F

**FUNCTION**
Prefijo para funciones intrínsecas: `FUNCTION TRIM(x)`, `FUNCTION LENGTH(x)`, `FUNCTION UPPER-CASE(x)`.

**FUNCTION LENGTH**
Devuelve la longitud de un campo (tamaño del PIC).

**FUNCTION NUMVAL / NUMVAL-C**
Convierte texto a número. NUMVAL-C acepta formato con signo, moneda y crédito/débito.

**FUNCTION TRIM**
Elimina espacios al inicio y final de una cadena. Puede ser LEADING, TRAILING o ambos.

**FUNCTION UPPER-CASE / LOWER-CASE**
Convierte texto a mayúsculas o minúsculas.

## I

**INSPECT**
Verbo para analizar y modificar caracteres en un campo: contar (TALLYING), reemplazar (REPLACING) o convertir (CONVERTING).

## O

**ON OVERFLOW (STRING)**
Cláusula que se ejecuta cuando el destino no tiene suficiente espacio.

**ON OVERFLOW (UNSTRING)**
Cláusula que se ejecuta cuando hay más campos de origen que destinos.

## P

**POINTER (STRING/UNSTRING)**
Variable que controla la posición de inicio. Se actualiza automáticamente. Útil para operaciones en múltiples pasos.

## R

**Reference Modification**
Sintaxis `variable(inicio:largo)` para acceder a una subcadena sin STRING/UNSTRING.

## S

**STRING**
Verbo que concatena múltiples fuentes en una sola cadena de destino.

## T

**TALLYING (INSPECT)**
Cuenta ocurrencias de caracteres o patrones: `TALLYING cont FOR ALL "x"`.

**TALLYING (UNSTRING)**
Cuenta cuántos campos se extrajeron realmente: `TALLYING IN contador`.

## U

**UNSTRING**
Verbo que divide una cadena en múltiples campos según delimitadores.
