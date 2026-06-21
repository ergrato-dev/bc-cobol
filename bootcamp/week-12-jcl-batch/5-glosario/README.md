# Glosario — Semana 12: JCL Fundamentos

## B

**Batch Processing**
Ejecución de programas sin interacción del usuario. Típicamente nocturno, procesa grandes volúmenes.

## C

**CATLG**
Parámetro DISP que guarda y cataloga el dataset en el sistema al cerrar normalmente.

**CLASS**
Parámetro del JOB que asigna clase de ejecución (A=normal, B=baja prioridad, T=test).

**COND**
Parámetro EXEC que controla si un step se ejecuta según el código de retorno de steps anteriores.

## D

**DCB (Data Control Block)**
Parámetro DD que define el formato del archivo: RECFM, LRECL, BLKSIZE.

**DD (Data Definition)**
Statement JCL que asocia un archivo físico (DSN) con un nombre lógico usado en COBOL (SELECT).

**DELETE (DISP)**
Elimina el dataset al cerrar (normalmente usado en status de error).

**DISP**
Parámetro DD que controla la disposición del dataset: inicio, fin normal, fin con error.

**DSN (Dataset Name)**
Nombre del archivo en el sistema. Segmentos separados por puntos: `NOMINA.MAESTRO.DATOS`.

## E

**EXEC**
Statement JCL que define un step de ejecución: programa a ejecutar (PGM=), parámetros (PARM=).

## J

**JCL (Job Control Language)**
Lenguaje para ejecutar trabajos batch en mainframes IBM. Define qué programas ejecutar y qué archivos usar.

**JOB**
Statement principal que inicia un trabajo batch. Contiene información contable y parámetros de ejecución.

## K

**KEEP**
Parámetro DISP que conserva el dataset sin catalogarlo.

## N

**NEW**
Parámetro DISP que crea un dataset nuevo (no debe existir previamente).

## P

**PARM**
Parámetro EXEC que pasa argumentos al programa COBOL.

**PASS**
Parámetro DISP que pasa el dataset al siguiente step como temporal.

**PEND**
Cierra la definición de un PROC.

**PROC**
Procedimiento JCL reutilizable. Se define con parámetros simbólicos y se invoca desde jobs.

## R

**REGION**
Parámetro EXEC que limita la memoria disponible para el step.

**RETURN-CODE (RC)**
Código numérico que el programa COBOL retorna al sistema. 0=éxito, >0=error.

## S

**SHR**
Parámetro DISP que abre un dataset existente en modo compartido (solo lectura).

**SYSOUT**
Destino de salida del sistema (spool de impresión). `SYSOUT=*` es la salida estándar.
