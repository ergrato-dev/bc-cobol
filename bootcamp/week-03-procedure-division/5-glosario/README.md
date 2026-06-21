# Glosario — Semana 03: PROCEDURE DIVISION

## A

**ACCEPT**
Verbo que lee datos del teclado o del sistema (FROM DATE, FROM TIME).

**ADD**
Verbo para sumar: `ADD 1 TO WS-CONTADOR`.

**AND**
Operador lógico: ambas condiciones deben ser verdaderas.

## C

**COMPUTE**
Verbo que evalúa una expresión aritmética y asigna el resultado.

**CONTINUE**
Sentencia nula (no hace nada). Útil para ramas vacías de IF.

## D

**DISPLAY**
Verbo que muestra texto o variables en pantalla.

**DIVIDE**
Verbo para dividir, permite obtener residuo con REMAINDER.

## E

**ELSE**
Parte alternativa de un IF, se ejecuta cuando la condición es falsa.

**END-IF**
Cierre obligatorio del bloque IF (COBOL 85+).

**END-EVALUATE**
Cierre obligatorio del bloque EVALUATE.

**END-PERFORM**
Cierre de un PERFORM inline (sin párrafo separado).

**EVALUATE**
Estructura de decisión múltiple, equivalente a switch/case. Más potente con `EVALUATE TRUE`.

**EXIT PERFORM**
Salida anticipada de un PERFORM.

**Exponenciación (`**`)**: Operador para elevar a una potencia: `WS-A ** 3`.

## I

**IF**
Estructura de decisión condicional: `IF condicion THEN ... ELSE ... END-IF`.

**IS NUMERIC**
Condición que verifica si un campo contiene solo dígitos.

**IS NOT ZERO**
Condición que verifica si un valor es distinto de cero.

## M

**MOVE**
Verbo de asignación. Convierte automáticamente entre tipos.

**MULTIPLY**
Verbo para multiplicar: `MULTIPLY WS-A BY WS-B GIVING WS-R`.

## N

**NOT**
Operador lógico de negación.

**NEXT SENTENCE**
Transfiere control a la siguiente sentencia (obsoleto, usar CONTINUE).

## O

**OR**
Operador lógico: al menos una condición debe ser verdadera.

## P

**PERFORM**
Verbo que transfiere control a un párrafo y retorna. También se usa para loops.

**PERFORM TIMES**
Ejecuta un párrafo N veces.

**PERFORM UNTIL**
Ejecuta hasta que se cumpla una condición (chequeo al inicio).

**PERFORM VARYING**
Loop con variable de control, equivalente a un for loop.

**PERFORM THRU**
Ejecuta un rango de párrafos consecutivos.

## R

**REMAINDER**
Palabra en DIVIDE para obtener el residuo de una división.

**ROUNDED**
Redondea el resultado de una operación aritmética.

## S

**STOP RUN**
Termina la ejecución del programa.

**SUBTRACT**
Verbo para restar: `SUBTRACT 100 FROM WS-SALDO`.

## W

**WHEN**
Cláusula dentro de EVALUATE que define un caso.

**WHEN OTHER**
Cláusula default de EVALUATE (equivalente a ELSE).

**WITH NO ADVANCING**
Opción de DISPLAY que suprime el salto de línea.

**WITH TEST AFTER**
Opción de PERFORM que evalúa la condición después de ejecutar (do-while).
