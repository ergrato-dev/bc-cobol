       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Fusionar Sucursales (MERGE)
      *> ============================================
      *> MERGE 2 archivos de transacciones por cuenta
      *>
      *> Los archivos YA DEBEN ESTAR ORDENADOS por cuenta
      *> Compilar: cobc -x -free fusion-archivos.cbl
      *> Ejecutar: ./fusion-archivos

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FUSION.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SUC1     ASSIGN TO "sucursal1.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SUC2     ASSIGN TO "sucursal2.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CONSOL   ASSIGN TO "consolidado.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT MERGE-WK ASSIGN TO "mergework.tmp".

       DATA DIVISION.
       FILE SECTION.
       FD  SUC1.   01 S1-REG.
           05 S1-CUENTA   PIC 9(05).
           05 S1-TIPO     PIC X(01).
           05 S1-MONTO    PIC 9(07)V99.

       FD  SUC2.   01 S2-REG.
           05 S2-CUENTA   PIC 9(05).
           05 S2-TIPO     PIC X(01).
           05 S2-MONTO    PIC 9(07)V99.

       FD  CONSOL. 01 CON-REG.
           05 CON-CUENTA  PIC 9(05).
           05 CON-MONTO   PIC 9(07)V99.

       SD  MERGE-WK.
       01  MERGE-REG.
           05 MERGE-CUENTA PIC 9(05).
           05 FILLER       PIC X(08).

       WORKING-STORAGE SECTION.
       01  WS-CONT          PIC 9(05) VALUE ZEROS.
       01  WS-ACUM          PIC 9(12)V99 VALUE ZEROS.
       01  WS-CUENTA-ACT    PIC 9(05) VALUE ZEROS.
       01  WS-MONTO-EDIT    PIC $$,$$9.99.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== FUSION DE SUCURSALES ===".
           DISPLAY " ".

           MERGE MERGE-WK
               ASCENDING KEY MERGE-CUENTA
               USING SUC1 SUC2
               OUTPUT PROCEDURE IS 2000-CONSOLIDAR.

           DISPLAY "Consolidado generado: consolidado.dat".
           STOP RUN.

       2000-CONSOLIDAR.
           OPEN OUTPUT CONSOL.
           PERFORM UNTIL MERGE-EOF
               RETURN MERGE-WK
                   AT END SET MERGE-EOF TO TRUE
                   NOT AT END
                       ADD 1 TO WS-CONT
                       MOVE MERGE-REG(1:5) TO WS-CUENTA-ACT
                       DISPLAY "Procesando cuenta: " WS-CUENTA-ACT
                       ADD MERGE-REG(6:8) TO WS-ACUM
                       MOVE WS-CUENTA-ACT TO CON-CUENTA
                       MOVE WS-ACUM TO CON-MONTO
                       WRITE CON-REG
               END-RETURN
           END-PERFORM.
           CLOSE CONSOL.

           MOVE WS-ACUM TO WS-MONTO-EDIT.
           DISPLAY "Total movimientos: " WS-CONT.
           DISPLAY "Monto total      : " WS-MONTO-EDIT.
