       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO - STEP 1: VALIDAR
      *> ============================================
      *> Lee transacciones.dat (formato: tipo|cuenta|monto)
      *> Separa en válidas y rechazadas
      *>
      *> Compilar: cobc -x -free validar.cbl
      *> Ejecutar: ./validar

       IDENTIFICATION DIVISION.
       PROGRAM-ID. VALIDAR.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-E  ASSIGN TO "transacciones.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT VAL-S    ASSIGN TO "trans_validas.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REJ-S    ASSIGN TO "trans_rechazadas.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  TRANS-E.  01 TRANS-REG    PIC X(80).
       FD  VAL-S.    01 VAL-REG      PIC X(80).
       FD  REJ-S.    01 REJ-REG      PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-FS-ENT         PIC X(02).
           88 ENT-OK         VALUE "00".
           88 ENT-EOF        VALUE "10".
       01  WS-TIPO           PIC X(01).
       01  WS-CUENTA         PIC X(05).
       01  WS-MONTO-TXT      PIC X(10).
       01  WS-MONTO-NUM      PIC 9(07)V99.
       01  WS-CONT-TOTAL     PIC 9(05) VALUE ZEROS.
       01  WS-CONT-VAL       PIC 9(05) VALUE ZEROS.
       01  WS-CONT-REJ       PIC 9(05) VALUE ZEROS.
       01  WS-ES-VALIDO      PIC X(01).

       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT TRANS-E.
           OPEN OUTPUT VAL-S.
           OPEN OUTPUT REJ-S.

           PERFORM UNTIL ENT-EOF
               READ TRANS-E AT END SET ENT-EOF TO TRUE
                   NOT AT END
                       ADD 1 TO WS-CONT-TOTAL
                       MOVE "N" TO WS-ES-VALIDO

                       UNSTRING TRANS-REG
                           DELIMITED BY "|"
                           INTO WS-TIPO WS-CUENTA WS-MONTO-TXT
                       END-UNSTRING

                       COMPUTE WS-MONTO-NUM =
                           FUNCTION NUMVAL(WS-MONTO-TXT)

                       IF (WS-TIPO = "D" OR WS-TIPO = "A")
                           AND WS-MONTO-NUM > 0
                           MOVE "S" TO WS-ES-VALIDO
                       END-IF

                       IF WS-ES-VALIDO = "S"
                           WRITE VAL-REG FROM TRANS-REG
                           ADD 1 TO WS-CONT-VAL
                       ELSE
                           WRITE REJ-REG FROM TRANS-REG
                           ADD 1 TO WS-CONT-REJ
                       END-IF
               END-READ
           END-PERFORM.

           CLOSE TRANS-E. CLOSE VAL-S. CLOSE REJ-S.

           DISPLAY "Total procesadas: " WS-CONT-TOTAL.
           DISPLAY "Trans. validas  : " WS-CONT-VAL.
           DISPLAY "Trans. rechazadas: " WS-CONT-REJ.
           STOP RUN.
