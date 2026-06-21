       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO FINAL - STEP 3: ACTUALIZAR MAESTRO
      *> ============================================
      *> Lee trans_ordenadas.dat, aplica movimientos
      *> a cuentas.idx, actualiza saldos.
      *>
      *> Compilar: cobc -x -free -I copybooks actualizar.cbl -o actualizar
      *> Ejecutar: ./actualizar

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ACTMAE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-E  ASSIGN TO "trans_ordenadas.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.
           SELECT MAE-FILE  ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  TRANS-E. 01 T-REG PIC X(60).
       FD  MAE-FILE. COPY "copybooks/cuentas.cpy".

       WORKING-STORAGE SECTION.
       COPY "copybooks/errores.cpy".
       01  WS-TIPO           PIC X(01).
       01  WS-CUENTA         PIC 9(05).
       01  WS-MONTO-TXT      PIC X(10).
       01  WS-MONTO-NUM      PIC 9(09)V99.
       01  WS-CONT-ACT       PIC 9(05) VALUE ZEROS.
       01  WS-CONT-ERR       PIC 9(05) VALUE ZEROS.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== ACTUALIZANDO MAESTRO ===".
           OPEN I-O MAE-FILE.
           OPEN INPUT TRANS-E.

           PERFORM UNTIL FS-EOF
               READ TRANS-E AT END SET FS-EOF TO TRUE
                   NOT AT END
                       UNSTRING T-REG DELIMITED BY "|"
                           INTO WS-TIPO WS-CUENTA
                                WS-MONTO-TXT
                       END-UNSTRING
                       COMPUTE WS-MONTO-NUM =
                           FUNCTION NUMVAL(WS-MONTO-TXT)

                       MOVE WS-CUENTA TO CTA-ID
                       READ MAE-FILE KEY IS CTA-ID
                           INVALID KEY
                               ADD 1 TO WS-CONT-ERR
                           NOT INVALID KEY
                               IF WS-TIPO = "D"
                                   SUBTRACT WS-MONTO-NUM
                                       FROM CTA-SALDO
                               ELSE
                                   ADD WS-MONTO-NUM
                                       TO CTA-SALDO
                               END-IF
                               REWRITE REG-CUENTA
                               ADD 1 TO WS-CONT-ACT
                       END-READ
               END-READ
           END-PERFORM.

           CLOSE TRANS-E MAE-FILE.
           DISPLAY "Actualizadas : " WS-CONT-ACT.
           DISPLAY "Con error    : " WS-CONT-ERR.
           STOP RUN.
