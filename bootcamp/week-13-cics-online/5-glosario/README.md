# Glosario — Semana 13: CICS Fundamentos

## B

**BMS (Basic Mapping Support)**
Lenguaje para definir pantallas 3270 en CICS. Genera mapas físicos (DSECT) y simbólicos (COPYBOOK).

## C

**CICS (Customer Information Control System)**
Monitor de teleproceso (TP Monitor) de IBM para transacciones online en mainframes.

**COMMAREA (Communication Area)**
Bloque de memoria que CICS pasa entre transacciones para mantener estado (pseudo-conversación).

## D

**DFHRESP**
Macro que define constantes para códigos de respuesta CICS: NORMAL, NOTFND, MAPFAIL, DUPREC.

## E

**EXEC CICS ... END-EXEC**
Delimitadores de comandos CICS dentro de programas COBOL.

**ENDBR**
Finaliza una navegación (browse) iniciada con STARTBR.

## M

**MAP**
Definición de pantalla 3270. Contiene campos de entrada (UNPROT) y salida (PROT).

**MAPFAIL**
Código de respuesta que indica que no se recibieron datos del mapa (usuario presionó Enter sin ingresar datos).

**MAPSET**
Conjunto de mapas relacionados, compilados juntos en una librería BMS.

## P

**Pseudo-Conversación**
Técnica CICS donde el programa termina y se vuelve a cargar entre pantallas, usando COMMAREA para mantener estado.

## R

**RECEIVE MAP**
Comando CICS para leer datos ingresados por el usuario en una pantalla.

**RESP / RESP2**
Campos de respuesta de comandos CICS. RESP=0 es éxito. RESP2 da detalle adicional del error.

**RETURN TRANSID**
Comando CICS que termina la transacción actual y especifica con qué TRANSID continuar.

**RIDFLD (Record Identification Field)**
Campo que contiene la clave del registro en operaciones de archivo CICS.

## S

**SEND MAP**
Comando CICS para enviar una pantalla formateada al terminal.

**SEND TEXT**
Comando CICS para enviar texto simple (no formateado) al terminal.

**STARTBR (Start Browse)**
Inicia una navegación secuencial sobre un archivo VSAM en CICS.

## T

**TRANSID (Transaction ID)**
Código de 1-4 caracteres que identifica una transacción en CICS. El usuario lo ingresa para iniciar una función.

## U

**UPDATE (READ option)**
Opción de READ FILE que lee un registro con intención de modificarlo (bloquea el registro).

## V

**VSAM (Virtual Storage Access Method)**
Sistema de archivos usado en mainframes. CICS accede a archivos VSAM (KSDS, ESDS, RRDS).
