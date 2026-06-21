       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO FINAL - STEP 4: REPORTE CIERRE
      *> ============================================
      *> Lee cuentas.idx y genera cierre_diario.txt
      *>
      *> Compilar: cobc -x -free -I copybooks reporte-cierre.cbl -o reporte
      *> Ejecutar: ./reporte

       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPCIERRE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MAE-FILE  ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS.
           SELECT REPORTE   ASSIGN TO "cierre_diario.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  MAE-FILE. COPY "copybooks/cuentas.cpy".
       FD  REPORTE.  01 REP-REG PIC X(70).

       WORKING-STORAGE SECTION.
       COPY "copybooks/errores.cpy".

       01  WS-CONT           PIC 9(05) VALUE ZEROS.
       01  WS-TOT-GENERAL    PIC S9(12)V99 VALUE ZEROS.
       01  WS-SALDO-EDIT     PIC $$,$$$,$$9.99.
       01  WS-TOTAL-EDIT     PIC $$$,$$$,$$9.99.

       01  WS-SEP            PIC X(70) VALUE ALL "=".
       01  WS-SUBSEP         PIC X(70) VALUE ALL "-".
       01  WS-LINEA-DET.
           05 WS-LID         PIC 9(05).
           05 FILLER         PIC X(03).
           05 WS-LNOMBRE     PIC X(25).
           05 FILLER         PIC X(03).
           05 WS-LSALDO      PIC $$,$$$,$$9.99.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== GENERANDO REPORTE DE CIERRE ===".
           OPEN INPUT MAE-FILE.
           OPEN OUTPUT REPORTE.

           WRITE REP-REG FROM WS-SEP.
           MOVE "       CIERRE DIARIO - ESTADO DE CUENTAS" TO REP-REG.
           WRITE REP-REG.
           MOVE "       Fecha: 2026-06-20" TO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SEP.
           MOVE "ID     NOMBRE                     SALDO"
               TO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SUBSEP.

           MOVE ZEROS TO CTA-ID.
           START MAE-FILE KEY IS GREATER THAN CTA-ID
               INVALID KEY CONTINUE
               NOT INVALID KEY
                   PERFORM UNTIL FS-EOF
                       READ MAE-FILE NEXT RECORD
                           AT END SET FS-EOF TO TRUE
                           NOT AT END
                               MOVE CTA-ID TO WS-LID
                               MOVE CTA-NOMBRE TO WS-LNOMBRE
                               MOVE CTA-SALDO TO WS-LSALDO
                               WRITE REP-REG FROM WS-LINEA-DET
                               ADD CTA-SALDO TO WS-TOT-GENERAL
                               ADD 1 TO WS-CONT
                       END-READ
                   END-PERFORM
           END-START.

           WRITE REP-REG FROM WS-SUBSEP.
           MOVE WS-TOT-GENERAL TO WS-TOTAL-EDIT.
           STRING "TOTAL GENERAL: " WS-TOTAL-EDIT
               "  (" WS-CONT " cuentas)"
               INTO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SEP.

           CLOSE MAE-FILE REPORTE.
           DISPLAY "Reporte: cierre_diario.txt".
           DISPLAY "Cuentas: " WS-CONT.
           DISPLAY "Total  : " WS-TOTAL-EDIT.
           STOP RUN.
