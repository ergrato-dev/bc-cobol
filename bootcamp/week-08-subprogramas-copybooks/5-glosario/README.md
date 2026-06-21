# Glosario — Semana 08: Subprogramas y COPYBOOKS

## B

**BY CONTENT**
Modo de paso de parámetros que envía una copia del valor. Las modificaciones no afectan al llamador.

**BY REFERENCE**
Modo de paso por defecto. El subprograma recibe la dirección de memoria y puede modificar el valor original.

## C

**CALL**
Verbo que invoca un subprograma externo (archivo separado).

**CANCEL**
Libera un subprograma de la memoria. Si se vuelve a llamar, se recarga con sus valores iniciales.

**COMMON PROGRAM**
Atributo de programa anidado que permite ser llamado desde cualquier programa hermano.

**CONTAINS**
Define programas anidados dentro del mismo archivo fuente. Comparten WORKING-STORAGE del padre.

**COPY / COPYBOOK**
Sentencia que incluye código fuente externo en tiempo de compilación. El archivo incluido se llama COPYBOOK (.cpy).

## E

**END PROGRAM**
Sentencia que marca el fin de un programa (principal o anidado).

**EXIT PROGRAM**
Sentencia que retorna del subprograma al llamador.

## G

**GOBACK**
Retorna al llamador. En el programa principal, equivale a STOP RUN.

## L

**LINKAGE SECTION**
Sección de DATA DIVISION exclusiva de subprogramas. Define los parámetros recibidos del llamador.

## P

**PROCEDURE DIVISION USING**
Declaración del subprograma que especifica los parámetros que recibe.

## R

**REPLACE (COPY)**
Cláusula que permite sustituir texto al incluir un COPYBOOK: `COPY "x.cpy" REPLACING ==A== BY ==B==`.

## U

**USING (CALL)**
Cláusula de CALL que especifica los parámetros enviados al subprograma.

**USING (PROCEDURE DIVISION)**
Cláusula que declara los parámetros recibidos en un subprograma.
