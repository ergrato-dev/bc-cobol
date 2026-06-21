# Glosario — Semana 06: Tablas y Arrays

## A

**ASCENDING KEY**
Cláusula de OCCURS que declara que la tabla está ordenada ascendentemente por ese campo. Requerido para SEARCH ALL.

## D

**DEPENDING ON**
Cláusula de OCCURS que permite tamaño variable de tabla. El tamaño real se determina en tiempo de ejecución.

**DESCENDING KEY**
Cláusula de OCCURS que declara orden descendente. Requerido para SEARCH ALL en orden inverso.

## E

**END-SEARCH**
Cierre obligatorio del bloque SEARCH o SEARCH ALL.

## I

**INDEXED BY**
Cláusula de OCCURS que declara un índice interno para la tabla. Requerido para SEARCH y SEARCH ALL.

**Índice (Index)**
Variable interna del compilador asociada a una tabla OCCURS. Se manipula con SET, más rápido que subíndice.

## O

**OCCURS**
Cláusula que define una tabla (array) de elementos repetidos con la misma estructura.

**OCCURS DEPENDING ON**
Variante de OCCURS con tamaño determinado en ejecución. Máximo definido, real según variable.

## P

**PERFORM VARYING**
Estructura de loop ideal para recorrer tablas. Equivalente a un for loop con variable de control.

## S

**SEARCH**
Búsqueda secuencial en tabla. Recorre elemento por elemento. O(n). No requiere tabla ordenada.

**SEARCH ALL**
Búsqueda binaria en tabla ordenada. O(log n). Requiere ASCENDING/DESCENDING KEY.

**SET**
Verbo para manipular índices: `SET idx TO 5`, `SET idx UP BY 1`, `SET var TO idx`.

**Subíndice (Subscript)**
Variable entera PIC 9 usada como índice de tabla. Más simple pero menos eficiente que INDEXED BY.

## U

**USAGE IS INDEX**
Tipo de dato especial para declarar índices como variables independientes.

## V

**VARYING (SEARCH)**
Cláusula de SEARCH que permite usar un índice externo en lugar del declarado en INDEXED BY.

## W

**WHEN (SEARCH)**
Cláusula de SEARCH/SEARCH ALL que define la condición de búsqueda.
