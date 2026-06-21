       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Reporte de Cuentas Bancarias
      *> Semana 04 - Archivos Secuenciales
      *> ============================================
      *> Lee cuentas.dat, filtra activas (A),
      *> aplica tasas por tipo y genera reporte.
      *>
      *> Compilar: cobc -x -free reporte-cuentas.cbl
      *> Ejecutar: ./reporte-cuentas
      *> Salida:   cuentas_reporte.txt

       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPCUENT.
       AUTHOR. ESTUDIANTE.

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
           05 CTA-ID       PIC 9(05).
           05 CTA-NOMBRE   PIC X(25).
           05 CTA-TIPO     PIC X(02).
           05 CTA-SALDO    PIC 9(07)V99.
           05 CTA-ESTADO   PIC X(01).

       FD  REPORTE-S.
       01  REP-REG         PIC X(80).

       WORKING-STORAGE SECTION.

      *> === FILE STATUS ===
       01  WS-FS-ENT         PIC X(02).
           88 ENT-OK         VALUE "00".
           88 ENT-EOF        VALUE "10".
           88 ENT-NO-FILE    VALUE "35".
       01  WS-FS-SAL         PIC X(02).
           88 SAL-OK         VALUE "00".

      *> === LÍNEAS DE REPORTE ===
       01  WS-ENCABEZADO.
           05 FILLER PIC X(30) VALUE SPACES.
           05 FILLER PIC X(26) VALUE "REPORTE DE CUENTAS ACTIVAS".
       01  WS-SEPARADOR     PIC X(80) VALUE ALL "=".
       01  WS-SUBSEP        PIC X(80) VALUE ALL "-".
       01  WS-LINEA-TIT.
           05 FILLER PIC X(06) VALUE "ID".
           05 FILLER PIC X(28) VALUE "NOMBRE".
           05 FILLER PIC X(08) VALUE "TIPO".
           05 FILLER PIC X(15) VALUE "SALDO ACTUAL".
           05 FILLER PIC X(08) VALUE "TASA %".
           05 FILLER PIC X(15) VALUE "NUEVO SALDO".

      *> TODO 1: Línea de detalle con campos de edición
      *> Descomenta y completa:
      *01  WS-LINEA-DET.
      *    05 FILLER PIC X(01) VALUE SPACES.
      *    05 WS-LID      PIC Z(04)9.
      *    05 FILLER PIC X(04) VALUE SPACES.
      *    05 WS-LNOMBRE  PIC X(25).
      *    05 FILLER PIC X(02) VALUE SPACES.
      *    05 WS-LTIPO    PIC X(02).
      *    05 FILLER PIC X(04) VALUE SPACES.
      *    05 WS-LSALDO   PIC $$,$$9.99.
      *    05 FILLER PIC X(06) VALUE SPACES.
      *    05 WS-LTASA    PIC Z9.9.
      *    05 FILLER PIC X(06) VALUE SPACES.
      *    05 WS-LNUEVO   PIC $$,$$9.99.

      *> === CONTADORES Y ACUMULADORES ===
       01  WS-CONT-LEIDOS    PIC 9(05) VALUE ZEROS.
       01  WS-CONT-ACTIVOS   PIC 9(05) VALUE ZEROS.
       01  WS-TOTAL-ACTUAL   PIC 9(12)V99 VALUE ZEROS.
       01  WS-TOTAL-NUEVO    PIC 9(12)V99 VALUE ZEROS.
       01  WS-TOTAL-INTERES  PIC 9(12)V99 VALUE ZEROS.

      *> === CÁLCULOS ===
       01  WS-TASA           PIC 9V999 VALUE ZEROS.
       01  WS-NUEVO-SALDO    PIC 9(09)V99 VALUE ZEROS.
       01  WS-INTERES        PIC 9(09)V99 VALUE ZEROS.

      *> === CAMPOS DE EDICIÓN PARA TOTALES ===
       01  WS-TACTUAL-EDIT   PIC $$$,$$9.99.
       01  WS-TNUEVO-EDIT    PIC $$$,$$9.99.
       01  WS-TINTERES-EDIT  PIC $$$,$$9.99.

      *> === 88-LEVEL ===
       01  WS-TIPO-VALIDO     PIC X(01) VALUE "N".
           88 TIPO-VALIDO     VALUE "S".

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 2: PERFORM a los párrafos en orden
      *          ABRIR-ARCHIVOS → PROCESAR → MOSTRAR-RESUMEN → CERRAR
           STOP RUN.

      *> ============================================
      *> TODO 3: ABRIR-ARCHIVOS
      *> ============================================
       ABRIR-ARCHIVOS.
      *    OPEN INPUT CUENTAS-E
      *    IF ENT-NO-FILE THEN mostrar error y STOP RUN
      *    OPEN OUTPUT REPORTE-S
      *    Escribir encabezado del reporte:
      *      WRITE REP-REG FROM WS-ENCABEZADO
      *      WRITE REP-REG FROM WS-SEPARADOR
      *      WRITE REP-REG FROM WS-LINEA-TIT
      *      WRITE REP-REG FROM WS-SUBSEP
           EXIT.

      *> ============================================
      *> TODO 4: PROCESAR (loop principal)
      *> ============================================
       PROCESAR.
      *    PERFORM UNTIL ENT-EOF
      *      READ CUENTAS-E AT END SET ENT-EOF TO TRUE
      *          NOT AT END
      *            ADD 1 TO WS-CONT-LEIDOS
      *            IF CTA-ESTADO = "A"
      *              ADD 1 TO WS-CONT-ACTIVOS
      *
      *              TODO: Determinar tasa según tipo
      *              EVALUATE CTA-TIPO
      *                 WHEN "CC" MOVE 0.005 TO WS-TASA  *> 0.5%
      *                 WHEN "CA" MOVE 0.030 TO WS-TASA  *> 3.0%
      *                 WHEN "PF" MOVE 0.080 TO WS-TASA  *> 8.0%
      *                 WHEN OTHER MOVE 0 TO WS-TASA
      *              END-EVALUATE
      *
      *              TODO: Calcular nuevo saldo e interés
      *              COMPUTE WS-INTERES = CTA-SALDO * WS-TASA
      *              ADD WS-INTERES TO CTA-SALDO GIVING WS-NUEVO-SALDO
      *
      *              TODO: Acumular totales
      *              ADD CTA-SALDO TO WS-TOTAL-ACTUAL
      *              ADD WS-NUEVO-SALDO TO WS-TOTAL-NUEVO
      *              ADD WS-INTERES TO WS-TOTAL-INTERES
      *
      *              TODO: Mover a línea de detalle y escribir
      *              MOVE CTA-ID TO WS-LID
      *              MOVE CTA-NOMBRE TO WS-LNOMBRE
      *              ... (completar todos los campos)
      *              WRITE REP-REG FROM WS-LINEA-DET
      *            END-IF
      *      END-READ
      *    END-PERFORM.
           EXIT.

      *> ============================================
      *> TODO 5: MOSTRAR-RESUMEN (totales en consola)
      *> ============================================
       MOSTRAR-RESUMEN.
      *    Escribir separador en reporte
      *    Mover totales a campos de edición
      *    Mostrar en consola:
      *      Total registros leídos
      *      Cuentas activas
      *      Total saldos actuales
      *      Total intereses
      *      Total saldos proyectados
           EXIT.

      *> ============================================
      *> TODO 6: CERRAR
      *> ============================================
       CERRAR.
      *    CLOSE CUENTAS-E
      *    CLOSE REPORTE-S
      *    DISPLAY "Reporte generado: cuentas_reporte.txt"
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO (cuentas con estado "A"):
      *> ============================================
      *> ID 1: Juan Perez       CC $15,000.00 → 0.5% → $15,075.00
      *> ID 2: Maria Garcia     CA $25,000.00 → 3.0% → $25,750.00
      *> ID 4: Ana Martinez     PF $50,000.00 → 8.0% → $54,000.00
      *> ID 5: Pedro Rodriguez  CA $ 3,500.25 → 3.0% → $ 3,605.26
      *> ID 7: Roberto Diaz     PF $100,000.00→ 8.0% → $108,000.00
