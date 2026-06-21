       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO - STEP 3: REPORTE
      *> ============================================
      *> Lee trans_ordenadas.dat, acumula por cuenta
      *> y genera cierre_diario.txt
      *>
      *> Compilar: cobc -x -free reporte.cbl
      *> Ejecutar: ./reporte

       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPORTE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-E  ASSIGN TO "trans_ordenadas.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT REPORTE-S ASSIGN TO "cierre_diario.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  TRANS-E.  01 TRANS-REG    PIC X(80).
       FD  REPORTE-S. 01 REP-REG     PIC X(70).

       WORKING-STORAGE SECTION.
       01  WS-FS-ENT         PIC X(02).
           88 ENT-EOF        VALUE "10".
       01  WS-TIPO           PIC X(01).
       01  WS-CUENTA         PIC X(05).
       01  WS-MONTO-TXT      PIC X(10).
       01  WS-MONTO-NUM      PIC 9(07)V99.
       01  WS-CTA-ACTUAL     PIC X(05).
       01  WS-CTA-ANTERIOR   PIC X(05).
       01  WS-TOT-DEB        PIC 9(12)V99 VALUE ZEROS.
       01  WS-TOT-CRED       PIC 9(12)V99 VALUE ZEROS.
       01  WS-CONT-REG       PIC 9(05) VALUE ZEROS.
       01  WS-CONT-CTA       PIC 9(05) VALUE ZEROS.
       01  WS-DEB-EDIT       PIC $$,$$9.99.
       01  WS-CRED-EDIT      PIC $$,$$9.99.
       01  WS-SEP            PIC X(70) VALUE ALL "=".
       01  WS-SUBSEP         PIC X(70) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT TRANS-E.
           OPEN OUTPUT REPORTE-S.

           WRITE REP-REG FROM WS-SEP.
           MOVE "       CIERRE DIARIO - REPORTE DE TRANSACCIONES"
               TO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SEP.
           MOVE "CUENTA    TOTAL DEBITOS    TOTAL CREDITOS"
               TO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SUBSEP.

           READ TRANS-E AT END SET ENT-EOF TO TRUE
               NOT AT END
                   PERFORM 2000-EXTRAER-CAMPOS
                   MOVE WS-CUENTA TO WS-CTA-ANTERIOR
                   MOVE WS-TIPO TO WS-TIPO
           END-READ.

           PERFORM UNTIL ENT-EOF
               ADD 1 TO WS-CONT-REG
               MOVE WS-CUENTA TO WS-CTA-ACTUAL

               IF WS-CTA-ACTUAL NOT = WS-CTA-ANTERIOR
                   PERFORM 3000-IMPRIMIR-CUENTA
               END-IF

               IF WS-TIPO = "D"
                   ADD WS-MONTO-NUM TO WS-TOT-DEB
               ELSE
                   ADD WS-MONTO-NUM TO WS-TOT-CRED
               END-IF

               READ TRANS-E AT END SET ENT-EOF TO TRUE
                   NOT AT END PERFORM 2000-EXTRAER-CAMPOS
               END-READ
           END-PERFORM.

           PERFORM 3000-IMPRIMIR-CUENTA.

           WRITE REP-REG FROM WS-SEP.
           MOVE "Total cuentas procesadas: 0" TO REP-REG.
           MOVE WS-CONT-CTA TO REP-REG(27:5).
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SEP.

           CLOSE TRANS-E. CLOSE REPORTE-S.
           DISPLAY "Reporte generado: cierre_diario.txt".
           DISPLAY "Registros: " WS-CONT-REG.
           DISPLAY "Cuentas  : " WS-CONT-CTA.
           STOP RUN.

       2000-EXTRAER-CAMPOS.
           UNSTRING TRANS-REG DELIMITED BY "|"
               INTO WS-TIPO WS-CUENTA WS-MONTO-TXT.
           COMPUTE WS-MONTO-NUM =
               FUNCTION NUMVAL(WS-MONTO-TXT).

       3000-IMPRIMIR-CUENTA.
           IF WS-TOT-DEB > 0 OR WS-TOT-CRED > 0
               ADD 1 TO WS-CONT-CTA
               MOVE WS-TOT-DEB TO WS-DEB-EDIT
               MOVE WS-TOT-CRED TO WS-CRED-EDIT
               MOVE WS-CTA-ANTERIOR TO REP-REG
               WRITE REP-REG FROM REP-REG
               MOVE ZEROS TO WS-TOT-DEB WS-TOT-CRED
           END-IF.
           MOVE WS-CTA-ACTUAL TO WS-CTA-ANTERIOR.
