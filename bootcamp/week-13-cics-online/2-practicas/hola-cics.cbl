       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Hola CICS (simulado)
      *> ============================================
      *> Simula EXEC CICS SEND TEXT con DISPLAY.
      *> Muestra estructura típica de programa CICS.
      *>
      *> Compilar: cobc -x -free hola-cics.cbl
      *> Ejecutar: ./hola-cics

       IDENTIFICATION DIVISION.
       PROGRAM-ID. HOLACICS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === Simulación de EXEC CICS SEND TEXT ===
       01  WS-MENSAJE    PIC X(50)
           VALUE "BIENVENIDO AL SISTEMA BANCARIO CICS".

       01  WS-SEP        PIC X(50) VALUE ALL "=".

       PROCEDURE DIVISION.
       MAIN.
      *> En CICS real:
      *>   EXEC CICS SEND TEXT
      *>       FROM(WS-MENSAJE) LENGTH(50) ERASE
      *>   END-EXEC.
      *>   EXEC CICS RETURN END-EXEC.

      *> Simulación:
           DISPLAY " ".
           DISPLAY WS-SEP.
           DISPLAY " ".
           DISPLAY "    " WS-MENSAJE.
           DISPLAY " ".
           DISPLAY WS-SEP.
           DISPLAY " ".
           DISPLAY "En CICS real, esto apareceria en terminal 3270.".
           DISPLAY "El programa retornaria con EXEC CICS RETURN.".
           DISPLAY " ".
           DISPLAY "TRANSID: HOLA → Programa: HOLACICS".
           DISPLAY " ".
           STOP RUN.
