# Glosario — Semana 10: SORT y MERGE

## A

**ASCENDING KEY**
Cláusula de SORT/MERGE que ordena de menor a mayor (A→Z, 0→9).

## D

**DESCENDING KEY**
Cláusula de SORT/MERGE que ordena de mayor a menor (Z→A, 9→0).

## G

**GIVING**
Cláusula de SORT/MERGE que especifica el archivo de salida (se abre/escribe/cierra automáticamente).

## I

**INPUT PROCEDURE**
Procedimiento que se ejecuta ANTES del sort. Permite filtrar, validar y liberar (RELEASE) registros al SD.

## M

**MERGE**
Verbo que fusiona múltiples archivos (ya ordenados) en uno solo ordenado.

## O

**OUTPUT PROCEDURE**
Procedimiento que se ejecuta DESPUÉS del sort/merge. Permite leer (RETURN) registros ordenados y procesarlos.

## R

**RELEASE**
Verbo que envía un registro al archivo SD durante INPUT PROCEDURE. Equivalente a WRITE para SD.

**RETURN**
Verbo que lee un registro del archivo SD durante OUTPUT PROCEDURE. Equivalente a READ para SD.

## S

**SD (Sort Description)**
Descripción de archivo temporal usado por SORT/MERGE. Similar a FD pero el sistema lo gestiona automáticamente.

**SORT**
Verbo que ordena un archivo por claves ASCENDING/DESCENDING.

**SORTWK**
Archivos de trabajo temporales usados por SORT para grandes volúmenes de datos.

## U

**USING (SORT/MERGE)**
Cláusula que especifica los archivos de entrada para SORT (1 archivo) o MERGE (2+ archivos).
