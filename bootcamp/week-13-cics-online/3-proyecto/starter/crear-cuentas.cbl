       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Crear Cuentas (datos iniciales)
      *> Crea cuentas.idx con 6 cuentas bancarias
      *> Ejecutar UNA VEZ antes del sistema CICS
      *>
      *> Compilar: cobc -x -free crear-cuentas.cbl
      *> Ejecutar: ./crear-cuentas

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREACTAS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUENTAS ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS SEQUENTIAL
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  CUENTAS.
       01  CTA-REG.
           05 CTA-ID        PIC 9(05).
           05 CTA-NOMBRE    PIC X(30).
           05 CTA-TIPO      PIC X(02).
           05 CTA-SALDO     PIC 9(07)V99.

       WORKING-STORAGE SECTION.
       01  WS-FS            PIC X(02).
       01  WS-CONT          PIC 9(02) VALUE ZEROS.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "Creando cuentas.idx...".
           OPEN OUTPUT CUENTAS.

           MOVE 00101 TO CTA-ID. MOVE "Juan Perez" TO CTA-NOMBRE.
           MOVE "CC" TO CTA-TIPO. MOVE 15000.50 TO CTA-SALDO.
           WRITE CTA-REG. ADD 1 TO WS-CONT.

           MOVE 00202 TO CTA-ID. MOVE "Maria Garcia" TO CTA-NOMBRE.
           MOVE "CA" TO CTA-TIPO. MOVE 25000.00 TO CTA-SALDO.
           WRITE CTA-REG. ADD 1 TO WS-CONT.

           MOVE 00303 TO CTA-ID. MOVE "Carlos Lopez" TO CTA-NOMBRE.
           MOVE "CC" TO CTA-TIPO. MOVE 10000.75 TO CTA-SALDO.
           WRITE CTA-REG. ADD 1 TO WS-CONT.

           MOVE 00404 TO CTA-ID. MOVE "Ana Martinez" TO CTA-NOMBRE.
           MOVE "PF" TO CTA-TIPO. MOVE 50000.00 TO CTA-SALDO.
           WRITE CTA-REG. ADD 1 TO WS-CONT.

           MOVE 00505 TO CTA-ID. MOVE "Pedro Rodriguez" TO CTA-NOMBRE.
           MOVE "CA" TO CTA-TIPO. MOVE 3500.25 TO CTA-SALDO.
           WRITE CTA-REG. ADD 1 TO WS-CONT.

           MOVE 00606 TO CTA-ID. MOVE "Laura Fernandez" TO CTA-NOMBRE.
           MOVE "CC" TO CTA-TIPO. MOVE 80000.00 TO CTA-SALDO.
           WRITE CTA-REG. ADD 1 TO WS-CONT.

           CLOSE CUENTAS.
           DISPLAY "Cuentas creadas: " WS-CONT.
           STOP RUN.
