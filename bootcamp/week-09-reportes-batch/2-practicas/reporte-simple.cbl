       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Reporte Simple con Paginación
      *> ============================================
      *> WRITE BEFORE/AFTER ADVANCING, encabezado,
      *> detalle, pie, control de líneas por página.
      *>
      *> Compilar: cobc -x -free reporte-simple.cbl
      *> Ejecutar: ./reporte-simple
      *> Salida:   cuentas_reporte.txt

       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPSIMPLE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUENTAS-E ASSIGN TO "cuentas.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT REPORTE-S ASSIGN TO "cuentas_reporte.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-SAL.

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
       01  WS-FS-SAL         PIC X(02).

      *> === PASO 1: Variables del reporte ===
      *> Descomenta las siguientes 13 líneas:
      *01  WS-NUM-PAGINA     PIC 9(03) VALUE ZEROS.
      *01  WS-LIN-PAGINA     PIC 9(03) VALUE 99.
      *01  WS-CONT-REG       PIC 9(05) VALUE ZEROS.
      *01  WS-TOTAL-SALDOS   PIC 9(12)V99 VALUE ZEROS.
      *01  WS-SALDO-EDIT     PIC $$,$$9.99.
      *01  WS-TOTAL-EDIT     PIC $$$,$$9.99.
      *01  WS-PAG-EDIT       PIC Z(02)9.
      *01  WS-SEP            PIC X(80) VALUE ALL "=".
      *01  WS-SUBSEP         PIC X(80) VALUE ALL "-".

      *> === PASO 2: Líneas del reporte ===
      *> Descomenta las siguientes 18 líneas:
      *01  WS-HEAD-TITULO.
      *    05 FILLER PIC X(30) VALUE SPACES.
      *    05 FILLER PIC X(25) VALUE "REPORTE DE CUENTAS ACTIVAS".
      *01  WS-HEAD-PAGINA.
      *    05 FILLER PIC X(60) VALUE SPACES.
      *    05 FILLER PIC X(06) VALUE "PAG: ".
      *    05 WS-HPAG PIC Z(02)9.
      *01  WS-HEAD-COLUMNAS.
      *    05 FILLER PIC X(08) VALUE "CUENTA".
      *    05 FILLER PIC X(28) VALUE "NOMBRE".
      *    05 FILLER PIC X(06) VALUE "TIPO".
      *    05 FILLER PIC X(14) VALUE "SALDO".
      *01  WS-LINEA-DET.
      *    05 WS-LCUENTA    PIC X(08).
      *    05 FILLER        PIC X(03) VALUE SPACES.
      *    05 WS-LNOMBRE    PIC X(25).
      *    05 FILLER        PIC X(03) VALUE SPACES.
      *    05 WS-LTIPO      PIC X(02).

      *> === PASO 3: Más líneas de detalle ===
      *> Descomenta las siguientes 8 líneas:
      *    05 FILLER        PIC X(06) VALUE SPACES.
      *    05 WS-LSALDO     PIC $$,$$9.99.
      *01  WS-LINEA-TOTAL.
      *    05 FILLER PIC X(45) VALUE SPACES.
      *    05 FILLER PIC X(14) VALUE "TOTAL:".
      *    05 WS-LTOTAL PIC $$$,$$9.99.
      *01  WS-LINEA-REG.
      *    05 FILLER PIC X(40) VALUE SPACES.
      *    05 WS-LREG-EDIT PIC ZZ,ZZ9.

       PROCEDURE DIVISION.
      *> === PASO 4: Flujo principal ===
      *> Descomenta las siguientes 10 líneas:
      *MAIN.
      *    OPEN INPUT CUENTAS-E.
      *    OPEN OUTPUT REPORTE-S.
      *    PERFORM 2000-ENCABEZADO.
      *    PERFORM 3000-PROCESAR UNTIL ENT-EOF.
      *    PERFORM 4000-PIE.
      *    CLOSE CUENTAS-E.
      *    CLOSE REPORTE-S.
      *    DISPLAY "Reporte generado: cuentas_reporte.txt".
      *    DISPLAY "Registros: " WS-CONT-REG.
      *    STOP RUN.

      *> === PASO 5: Encabezado ===
      *> Descomenta las siguientes 11 líneas:
      *2000-ENCABEZADO.
      *    ADD 1 TO WS-NUM-PAGINA.
      *    MOVE WS-NUM-PAGINA TO WS-HPAG.
      *    WRITE REP-REG FROM WS-HEAD-TITULO
      *        AFTER ADVANCING PAGE.
      *    WRITE REP-REG FROM WS-HEAD-PAGINA.
      *    WRITE REP-REG FROM WS-SEP.
      *    WRITE REP-REG FROM WS-HEAD-COLUMNAS.
      *    WRITE REP-REG FROM WS-SUBSEP.
      *    ADD 5 TO WS-LIN-PAGINA.
      *    MOVE 0 TO WS-LIN-PAGINA.   *> Simplificado

      *> === PASO 6: Procesar ===
      *> Descomenta las siguientes 17 líneas:
      *3000-PROCESAR.
      *    READ CUENTAS-E
      *        AT END SET ENT-EOF TO TRUE
      *        NOT AT END
      *            ADD 1 TO WS-CONT-REG
      *            ADD CTA-SALDO TO WS-TOTAL-SALDOS
      *            MOVE WS-LCUENTA TO WS-LCUENTA
      *            MOVE CTA-NOMBRE TO WS-LNOMBRE
      *            MOVE CTA-TIPO TO WS-LTIPO
      *            MOVE CTA-SALDO TO WS-LSALDO
      *            WRITE REP-REG FROM WS-LINEA-DET
      *            ADD 1 TO WS-LIN-PAGINA
      *            IF WS-LIN-PAGINA > 35
      *                PERFORM 2000-ENCABEZADO
      *            END-IF
      *    END-READ.

      *> === PASO 7: Pie ===
      *> Descomenta las siguientes 4 líneas:
      *4000-PIE.
      *    WRITE REP-REG FROM WS-SEP.
      *    MOVE WS-TOTAL-SALDOS TO WS-LTOTAL.
      *    WRITE REP-REG FROM WS-LINEA-TOTAL.
