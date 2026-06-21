# Glosario — Semana 11: SQL Embebido

## C

**CLOSE CURSOR**
Cierra un cursor liberando recursos. Siempre después de terminar de leer.

**COMMIT**
Confirma los cambios de una transacción. Los hace permanentes en la base de datos.

**CONNECT**
Establece conexión con la base de datos: `EXEC SQL CONNECT TO :db USER :user END-EXEC`.

**Cursor**
Mecanismo para procesar consultas multi-fila fila por fila. Ciclo: DECLARE → OPEN → FETCH loop → CLOSE.

## D

**DECLARE CURSOR**
Define una consulta SQL que devuelve múltiples filas. No ejecuta la consulta, solo la declara.

**DELETE (SQL)**
Elimina filas de una tabla: `DELETE FROM tabla WHERE condicion`.

## E

**EXEC SQL ... END-EXEC**
Delimitadores de sentencias SQL dentro de código COBOL.

## F

**FETCH**
Lee la siguiente fila de un cursor abierto. Avanza el cursor una posición.

## H

**Host Variable**
Variable COBOL usada dentro de sentencias SQL. Se referencia con `:` (ej: `:WS-NOMBRE`).

## I

**INSERT (SQL)**
Inserta una nueva fila en una tabla.

**INTO (SELECT)**
Cláusula que asigna los resultados a host variables: `SELECT ... INTO :var1, :var2`.

## O

**OPEN CURSOR**
Ejecuta la consulta definida en DECLARE CURSOR y posiciona el cursor antes de la primera fila.

## R

**ROLLBACK**
Deshace los cambios no confirmados de una transacción. Revierte al último COMMIT.

## S

**SELECT INTO**
Consulta que devuelve exactamente una fila. Los valores van a host variables.

**SQLCODE**
Código entero de retorno de operación SQL. 0 = OK, 100 = no data, < 0 = error.

**SQLSTATE**
Código estándar ISO de 5 caracteres para diagnóstico SQL. Ej: "00000" = OK, "02000" = no data.

**SQLCA**
SQL Communication Area. Estructura con información detallada de diagnóstico.

## U

**UPDATE (SQL)**
Modifica filas existentes: `UPDATE tabla SET col = :var WHERE condicion`.
