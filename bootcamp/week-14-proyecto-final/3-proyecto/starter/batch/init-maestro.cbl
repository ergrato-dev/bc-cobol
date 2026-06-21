       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO FINAL - Inicializar Maestro
      *> Semana 14 - Sistema Bancario
      *> ============================================
      *> Crea cuentas.idx desde cuentas_maestro.dat
      *>
      *> Compilar: cobc -x -free -I copybooks init-maestro.cbl -o init-maestro
      *> Ejecutar: ./init-maestro

       IDENTIFICATION DIVISION.
       PROGRAM-ID. INITMAE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MAE-ENT  ASSIGN TO "data/cuentas_maestro.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.
           SELECT MAE-IDX  ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS SEQUENTIAL
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  MAE-ENT.
       01  MAE-ENT-REG    PIC X(50).

       FD  MAE-IDX.
       COPY "copybooks/cuentas.cpy".

       WORKING-STORAGE SECTION.
       COPY "copybooks/errores.cpy".
       01  WS-CONT          PIC 9(03) VALUE ZEROS.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== INICIALIZANDO MAESTRO ===".
           OPEN INPUT MAE-ENT.
           OPEN OUTPUT MAE-IDX.

           PERFORM UNTIL FS-EOF
               READ MAE-ENT AT END SET FS-EOF TO TRUE
                   NOT AT END
                       MOVE MAE-ENT-REG(1:5) TO CTA-ID
                       MOVE MAE-ENT-REG(6:30) TO CTA-NOMBRE
                       MOVE MAE-ENT-REG(36:2) TO CTA-TIPO
                       MOVE MAE-ENT-REG(38:9) TO CTA-SALDO
                       MOVE MAE-ENT-REG(48:1) TO CTA-ESTADO
                       MOVE SPACES TO FILLER
                       WRITE REG-CUENTA
                       ADD 1 TO WS-CONT
               END-READ
           END-PERFORM.

           CLOSE MAE-ENT. CLOSE MAE-IDX.
           DISPLAY "Cuentas creadas: " WS-CONT.
           DISPLAY "Archivo: cuentas.idx".
           STOP RUN.
