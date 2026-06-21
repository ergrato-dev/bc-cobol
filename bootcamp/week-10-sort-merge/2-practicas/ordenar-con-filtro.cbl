       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Filtrar + Ordenar + Reporte
      *> ============================================
      *> INPUT PROCEDURE: filtra saldos > 10000
      *> OUTPUT PROCEDURE: genera reporte top
      *>
      *> Compilar: cobc -x -free ordenar-con-filtro.cbl
      *> Ejecutar: ./ordenar-con-filtro

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ORDFILT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ENTRADA  ASSIGN TO "clientes.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORTE  ASSIGN TO "top_clientes.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SORT-WK  ASSIGN TO "sortwork.tmp".

       DATA DIVISION.
       FILE SECTION.
       FD  ENTRADA.
       01  ENT-REG.
           05 ENT-NOMBRE   PIC X(25).
           05 ENT-SALDO    PIC 9(07)V99.

       FD  REPORTE.
       01  REP-REG         PIC X(60).

       SD  SORT-WK.
       01  SORT-REG.
           05 SORT-NOMBRE  PIC X(25).
           05 SORT-SALDO   PIC 9(07)V99.

       WORKING-STORAGE SECTION.
       01  WS-FS-ENT        PIC X(02).
           88 ENT-EOF       VALUE "10".
       01  WS-CONT-FILT     PIC 9(03) VALUE ZEROS.
       01  WS-CONT-SAL      PIC 9(03) VALUE ZEROS.
       01  WS-SALDO-EDIT    PIC $$,$$9.99.
       01  WS-SEP           PIC X(60) VALUE ALL "=".

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== FILTRAR + ORDENAR + REPORTE ===".
           DISPLAY " ".

           SORT SORT-WK
               DESCENDING KEY SORT-SALDO
               INPUT PROCEDURE IS 1000-FILTRAR
               OUTPUT PROCEDURE IS 2000-REPORTE.

           DISPLAY "Filtrados : " WS-CONT-FILT.
           DISPLAY "Reportados: " WS-CONT-SAL.
           DISPLAY "Archivo: top_clientes.txt".
           STOP RUN.

      *> INPUT PROCEDURE: leer, filtrar, RELEASE
       1000-FILTRAR.
           OPEN INPUT ENTRADA.
           PERFORM UNTIL ENT-EOF
               READ ENTRADA AT END SET ENT-EOF TO TRUE
                   NOT AT END
                       IF ENT-SALDO > 10000
                           MOVE ENT-NOMBRE TO SORT-NOMBRE
                           MOVE ENT-SALDO TO SORT-SALDO
                           RELEASE SORT-REG
                           ADD 1 TO WS-CONT-FILT
                       END-IF
               END-READ
           END-PERFORM.
           CLOSE ENTRADA.

      *> OUTPUT PROCEDURE: RETURN, formatear, WRITE
       2000-REPORTE.
           OPEN OUTPUT REPORTE.
           MOVE WS-SEP TO REP-REG.
           WRITE REP-REG.
           MOVE "    TOP CLIENTES POR SALDO (DESCENDENTE)" TO REP-REG.
           WRITE REP-REG.
           MOVE WS-SEP TO REP-REG.
           WRITE REP-REG.

           PERFORM UNTIL SORT-EOF
               RETURN SORT-WK
                   AT END SET SORT-EOF TO TRUE
                   NOT AT END
                       ADD 1 TO WS-CONT-SAL
                       MOVE SORT-SALDO TO WS-SALDO-EDIT
                       STRING SORT-NOMBRE "  "
                              WS-SALDO-EDIT INTO REP-REG
                       WRITE REP-REG
               END-RETURN
           END-PERFORM.
           CLOSE REPORTE.
