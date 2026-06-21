       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO FINAL - STEP 1: VALIDAR
      *> ============================================
      *> Lee data/transacciones.dat, valida tipo y monto,
      *> separa en trans_validas.dat y trans_rechazadas.dat
      *>
      *> Compilar: cobc -x -free -I copybooks validar.cbl -o validar
      *> Ejecutar: ./validar

       IDENTIFICATION DIVISION.
       PROGRAM-ID. VALIDAR.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-E  ASSIGN TO "data/transacciones.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.
           SELECT VAL-S    ASSIGN TO "trans_validas.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REJ-S    ASSIGN TO "trans_rechazadas.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  TRANS-E. 01 E-REG PIC X(60).
       FD  VAL-S.   01 V-REG PIC X(60).
       FD  REJ-S.   01 R-REG PIC X(60).

       WORKING-STORAGE SECTION.
       COPY "copybooks/errores.cpy".
       COPY "copybooks/transacc.cpy".

       01  WS-CONT-TOTAL     PIC 9(05) VALUE ZEROS.
       01  WS-CONT-VAL       PIC 9(05) VALUE ZEROS.
       01  WS-CONT-REJ       PIC 9(05) VALUE ZEROS.

       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT TRANS-E.
           OPEN OUTPUT VAL-S REJ-S.

           PERFORM UNTIL FS-EOF
               READ TRANS-E AT END SET FS-EOF TO TRUE
                   NOT AT END
                       ADD 1 TO WS-CONT-TOTAL
                       MOVE E-REG TO WS-TRANS-CSV
                       INITIALIZE REG-TRANSACCION

                       UNSTRING WS-TRANS-CSV
                           DELIMITED BY "|"
                           INTO TRANS-TIPO
                                TRANS-CUENTA
                                WS-TRANS-MONTO-TXT
                                TRANS-DESCRIP
                       END-UNSTRING

                       COMPUTE TRANS-MONTO =
                           FUNCTION NUMVAL(WS-TRANS-MONTO-TXT)

                       IF TRANS-VALIDO AND TRANS-MONTO > 0
                           MOVE E-REG TO V-REG
                           WRITE V-REG
                           ADD 1 TO WS-CONT-VAL
                       ELSE
                           MOVE E-REG TO R-REG
                           WRITE R-REG
                           ADD 1 TO WS-CONT-REJ
                       END-IF
               END-READ
           END-PERFORM.

           CLOSE TRANS-E VAL-S REJ-S.
           DISPLAY "Total procesadas : " WS-CONT-TOTAL.
           DISPLAY "Trans. validas   : " WS-CONT-VAL.
           DISPLAY "Trans. rechazadas: " WS-CONT-REJ.
           MOVE 0 TO RETURN-CODE.
           STOP RUN.
