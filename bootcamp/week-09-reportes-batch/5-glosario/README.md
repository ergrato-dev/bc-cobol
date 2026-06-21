# Glosario — Semana 09: Reportes Profesionales

## A

**AFTER ADVANCING**
Cláusula de WRITE que avanza líneas después de escribir. Para espaciado posterior.

## B

**BEFORE ADVANCING**
Cláusula de WRITE que avanza líneas antes de escribir. Para títulos y encabezados.

**Break Control**
Técnica que detecta cambios en una clave de agrupación para imprimir subtotales. También llamado control de ruptura.

## C

**CR / DB (PICTURE)**
Símbolos de edición contable: CR (crédito), DB (débito). Se agregan al final del número.

## D

**Detalle (Detail)**
Zona del reporte que muestra cada registro individual, una línea por registro.

## E

**Edición (Editing)**
Transformación de un dato interno a formato legible: moneda, fechas, supresión de ceros.

**Encabezado (Header)**
Zona del reporte con título, fecha, página y nombres de columnas. Se imprime al inicio y al cambiar de página.

## F

**FILLER**
Palabra reservada para campos sin nombre explícito. Se usa para padding, espaciado y alineación en reportes.

## L

**Línea en blanco**
Se genera con `WRITE ... BEFORE ADVANCING 2 LINES` (avanza 1 extra, dejando 1 en blanco).

## P

**PAGE (ADVANCING)**
Salto de página: `WRITE ... BEFORE ADVANCING PAGE`. En LINE SEQUENTIAL equivale a nueva hoja.

**Paginación**
Control automático de salto de página cuando se alcanza un máximo de líneas (ej. 60 líneas).

**Pie (Footer)**
Zona final del reporte con totales generales, fecha de emisión y leyendas de cierre.

## R

**Ruptura (Break)**
Momento en que cambia una clave de agrupación. Dispara la impresión de subtotales y el reseteo de acumuladores.

## S

**$ (PICTURE)**
Símbolo de moneda en edición. `$$,$$9.99` = signo flotante. `$Z,ZZ9.99` = signo fijo.

**Subtotal**
Total parcial de un grupo de registros. Se imprime en cada ruptura.

## Z

**Z (PICTURE)**
Suprime ceros a la izquierda reemplazándolos por espacios.

***** (PICTURE)**
Suprime ceros a la izquierda reemplazándolos por asteriscos (protección en cheques).
