       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Reporte Agrupado (Break Control)
      *> ============================================
      *> Agrupa por tipo de cuenta (CC/CA/PF) y
      *> muestra subtotales con control de ruptura.
      *>
      *> Compilar: cobc -x -free reporte-agrupado.cbl
      *> Ejecutar: ./reporte-agrupado

       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPGRUPO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUENTAS-E ASSIGN TO "cuentas.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT REPORTE-S ASSIGN TO "cuentas_tipo.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  CUENTAS-E.
       01  CTA-REG.
           05 CTA-SUC       PIC 9(03).
           05 CTA-ID        PIC 9(02).
           05 CTA-NOMBRE    PIC X(25).
           05 CTA-TIPO      PIC X(02).
           05 CTA-SALDO     PIC 9(07)V99.
           05 CTA-ESTADO    PIC X(01).

       FD  REPORTE-S.
       01  REP-REG          PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-FS-ENT         PIC X(02).
           88 ENT-OK         VALUE "00".
           88 ENT-EOF        VALUE "10".
       01  WS-TIPO-ACTUAL    PIC X(02) VALUE SPACES.
       01  WS-TIPO-ANTERIOR  PIC X(02) VALUE SPACES.
       01  WS-SUBTOTAL       PIC S9(12)V99 COMP-3 VALUE ZEROS.
       01  WS-CONT-GRUPO     PIC 9(07) COMP VALUE ZEROS.
       01  WS-TOTAL-GENERAL  PIC S9(12)V99 COMP-3 VALUE ZEROS.
       01  WS-TOTAL-CUENTAS  PIC 9(07) VALUE ZEROS.
       01  WS-SALDO-EDIT     PIC $$,$$9.99.
       01  WS-SUB-EDIT       PIC $$$,$$9.99.
       01  WS-SEP            PIC X(80) VALUE ALL "=".
       01  WS-SUBSEP         PIC X(80) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT CUENTAS-E.
           OPEN OUTPUT REPORTE-S.

      *> Encabezado del reporte
           WRITE REP-REG FROM WS-SEP.
           MOVE "REPORTE AGRUPADO POR TIPO DE CUENTA" TO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SUBSEP.

      *> Leer primer registro
           READ CUENTAS-E
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   MOVE CTA-TIPO TO WS-TIPO-ANTERIOR
                   DISPLAY "Procesando tipo: " CTA-TIPO "..."
           END-READ.

           PERFORM UNTIL ENT-EOF
               MOVE CTA-TIPO TO WS-TIPO-ACTUAL

               IF WS-TIPO-ACTUAL NOT = WS-TIPO-ANTERIOR
                   PERFORM 2000-RUPTURA
               END-IF

               ADD CTA-SALDO TO WS-SUBTOTAL
               ADD 1 TO WS-CONT-GRUPO

               READ CUENTAS-E
                   AT END SET ENT-EOF TO TRUE
               END-READ
           END-PERFORM.

      *> Última ruptura (último grupo)
           PERFORM 2000-RUPTURA.

      *> Total general
           WRITE REP-REG FROM WS-SEP.
           MOVE WS-TOTAL-GENERAL TO WS-SUB-EDIT.
           STRING "TOTAL GENERAL: " WS-SUB-EDIT
                  " (" WS-TOTAL-CUENTAS " cuentas)"
                  INTO REP-REG.
           WRITE REP-REG.
           WRITE REP-REG FROM WS-SEP.

           CLOSE CUENTAS-E.
           CLOSE REPORTE-S.
           DISPLAY "Reporte: cuentas_tipo.txt".
           STOP RUN.

      *> Párrafo de ruptura
       2000-RUPTURA.
           IF WS-CONT-GRUPO > 0
               MOVE WS-SUBTOTAL TO WS-SUB-EDIT
               STRING "  Tipo " WS-TIPO-ANTERIOR
                      " | Subt: " WS-SUB-EDIT
                      " | Ctas: " WS-CONT-GRUPO
                      INTO REP-REG
               WRITE REP-REG
               WRITE REP-REG FROM WS-SUBSEP
               ADD WS-SUBTOTAL TO WS-TOTAL-GENERAL
               ADD WS-CONT-GRUPO TO WS-TOTAL-CUENTAS
               MOVE ZEROS TO WS-SUBTOTAL
               MOVE ZEROS TO WS-CONT-GRUPO
           END-IF.
           MOVE WS-TIPO-ACTUAL TO WS-TIPO-ANTERIOR.
