# Glosario — Semana 05: Archivos Indexados

## A

**ACCESS MODE**
Define cómo se accede al archivo: SEQUENTIAL, RANDOM o DYNAMIC.

**ALTERNATE RECORD KEY**
Clave secundaria de búsqueda en un archivo indexado. Permite duplicados con `WITH DUPLICATES`.

## D

**DELETE**
Verbo que elimina el registro actual (previamente leído con READ) de un archivo indexado.

**DYNAMIC (ACCESS MODE)**
Modo de acceso más flexible. Permite tanto READ NEXT (secuencial) como READ por clave (aleatorio) y START.

**DUPLICATE KEY (STATUS 22)**
FILE STATUS que indica que la clave ya existe al intentar WRITE. También se usa en ALTERNATE KEY sin WITH DUPLICATES.

## I

**INDEXED (ORGANIZATION)**
Organización de archivo que indexa registros por clave primaria. Permite acceso secuencial y aleatorio.

**INVALID KEY**
Cláusula de READ/WRITE/DELETE/REWRITE/START que se ejecuta cuando la operación falla (clave no encontrada, duplicada, etc.).

**I-O (OPEN mode)**
Modo de apertura que permite lectura y escritura (READ, REWRITE, DELETE). Requerido para modificar registros.

## N

**NOT INVALID KEY**
Cláusula que se ejecuta cuando la operación de archivo indexado es exitosa.

## R

**RANDOM (ACCESS MODE)**
Modo de acceso solo por clave. No permite READ NEXT.

**READ ... KEY IS**
Sintaxis para leer un registro específico por clave en modo RANDOM o DYNAMIC.

**RECORD KEY**
Clave primaria de un archivo indexado. Debe ser única para cada registro.

**REWRITE**
Verbo que reemplaza el registro actual con nuevos valores. No permite cambiar la RECORD KEY.

## S

**SEQUENTIAL (ACCESS MODE)**
Modo de acceso secuencial. Solo permite READ NEXT. Es el modo por defecto.

**START**
Verbo que posiciona el cursor en un registro específico. Se usa con KEY IS GREATER THAN (o >=) para luego leer secuencialmente con READ NEXT.

**STATUS 22**
Clave duplicada (WRITE) o ALTERNATE KEY duplicada sin WITH DUPLICATES.

**STATUS 23**
Registro no encontrado (READ con KEY específica).

## W

**WITH DUPLICATES**
Cláusula de ALTERNATE RECORD KEY que permite valores repetidos en la clave alterna.
