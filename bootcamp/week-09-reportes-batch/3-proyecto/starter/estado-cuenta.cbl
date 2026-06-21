       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Estado de Cuenta Bancario
      *> Semana 09 - Reportes Profesionales
      *> ============================================
      *> Lee movimientos.dat, control de ruptura por
      *> cuenta, genera estado de cuenta profesional.
      *>
      *> Compilar: cobc -x -free estado-cuenta.cbl
      *> Ejecutar: ./estado-cuenta
      *> Salida:   estado_cuenta.txt

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ESTADOCTA.
       AUTHOR. ESTUDIANTE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MOVIM-E ASSIGN TO "movimientos.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT REPORTE-S ASSIGN TO "estado_cuenta.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-SAL.

       DATA DIVISION.
       FILE SECTION.
       FD  MOVIM-E.
       01  MOV-REG.
           05 MOV-CUENTA       PIC 9(05).
           05 MOV-TIPO         PIC X(01).
               88 ES-CARGO     VALUE "C".
               88 ES-ABONO     VALUE "A".
           05 MOV-MONTO        PIC 9(07)V99.
           05 MOV-DESCRIP      PIC X(20).
           05 MOV-FECHA        PIC 9(08).

       FD  REPORTE-S.
       01  REP-REG             PIC X(80).

       WORKING-STORAGE SECTION.

      *> FILE STATUS
       01  WS-FS-ENT           PIC X(02).
           88 ENT-OK           VALUE "00".
           88 ENT-EOF          VALUE "10".
       01  WS-FS-SAL           PIC X(02).

      *> CONTROL DE RUPTURA
       01  WS-CTA-ACTUAL       PIC 9(05) VALUE ZEROS.
       01  WS-CTA-ANTERIOR     PIC 9(05) VALUE ZEROS.

      *> SALDOS Y ACUMULADORES
       01  WS-SALDO-INICIAL    PIC S9(09)V99 VALUE 10000.00.
       01  WS-SALDO-ACTUAL     PIC S9(09)V99 VALUE ZEROS.
       01  WS-TOTAL-CARGOS     PIC S9(09)V99 COMP-3 VALUE ZEROS.
       01  WS-TOTAL-ABONOS     PIC S9(09)V99 COMP-3 VALUE ZEROS.
       01  WS-CONT-CARGOS      PIC 9(05) COMP VALUE ZEROS.
       01  WS-CONT-ABONOS      PIC 9(05) COMP VALUE ZEROS.

      *> CAMPOS DE EDICIÓN
       01  WS-MONTO-EDIT       PIC $$,$$9.99.
       01  WS-SALDO-EDIT       PIC $$,$$9.99.
       01  WS-FECHA-EDIT       PIC 99/99/9999.

      *> LÍNEAS DE REPORTE
       01  WS-SEP              PIC X(70) VALUE ALL "=".
       01  WS-SUBSEP           PIC X(70) VALUE ALL "-".

       01  WS-LINEA-DET.
           05 FILLER PIC X(02) VALUE SPACES.
           05 WS-LFECHA    PIC 99/99/9999.
           05 FILLER PIC X(03).
           05 WS-LDESC     PIC X(20).
           05 FILLER PIC X(03).
           05 WS-LTIPO     PIC X(01).
           05 FILLER PIC X(03).
           05 WS-LMONTO    PIC $$,$$9.99.

       01  WS-LINEA-SUBTOTAL.
           05 FILLER PIC X(15) VALUE SPACES.
           05 FILLER PIC X(15) VALUE "TOTAL CARGOS:".
           05 WS-LCARGOS PIC $$,$$9.99.

       01  WS-LINEA-ABONOS.
           05 FILLER PIC X(15) VALUE SPACES.
           05 FILLER PIC X(15) VALUE "TOTAL ABONOS:".
           05 WS-LABONOS PIC $$,$$9.99.

       01  WS-LINEA-SALDO.
           05 FILLER PIC X(15) VALUE SPACES.
           05 FILLER PIC X(15) VALUE "SALDO FINAL: ".
           05 WS-LSALDO PIC $$,$$9.99.

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 1: Abrir archivos
      *    TODO 2: PERFORM 2000-PROCESAR UNTIL EOF
      *    TODO 3: PERFORM 5000-RUPTURA (última cuenta)
      *    TODO 4: Cerrar archivos
           STOP RUN.

       2000-PROCESAR.
           READ MOVIM-E
               AT END SET ENT-EOF TO TRUE
               NOT AT END
      *            TODO: Detectar ruptura de cuenta
      *            IF MOV-CUENTA NOT = WS-CTA-ANTERIOR
      *                PERFORM 5000-RUPTURA
      *                PERFORM 3000-ENCABEZADO-CUENTA
      *            END-IF

      *            TODO: Acumular por tipo (C/Ab)
      *            IF ES-CARGO
      *                ADD MOV-MONTO TO WS-TOTAL-CARGOS
      *                ADD 1 TO WS-CONT-CARGOS
      *            ELSE
      *                ADD MOV-MONTO TO WS-TOTAL-ABONOS
      *                ADD 1 TO WS-CONT-ABONOS
      *            END-IF

      *            TODO: Escribir línea de detalle
      *            Formatear fecha, monto, tipo
      *            WRITE REP-REG FROM WS-LINEA-DET
           END-READ.

      *> ============================================
       3000-ENCABEZADO-CUENTA.
      *    Escribir encabezado:
      *    "ESTADO DE CUENTA #xxxxx"
      *    "Saldo inicial: $10,000.00"
      *    "FECHA      DESCRIPCION          T  MONTO"
      *    Mover saldo inicial a WS-SALDO-ACTUAL
           EXIT.

      *> ============================================
      *> TODO: RUPTURA — mostrar subtotales de la cuenta
      *> ============================================
       5000-RUPTURA.
      *    IF WS-CTA-ANTERIOR NOT = ZEROS
      *        WRITE REP-REG FROM WS-SUBSEP
      *        Mostrar total cargos y abonos
      *        COMPUTE WS-SALDO-ACTUAL = saldo inicial
      *            + WS-TOTAL-ABONOS - WS-TOTAL-CARGOS
      *        Mostrar saldo final
      *        WRITE REP-REG FROM WS-SEP
      *    END-IF
      *    RESETEAR acumuladores
      *    Actualizar WS-CTA-ANTERIOR
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO (cuenta 00101)
      *> ============================================
      *> ESTADO DE CUENTA #00101
      *> Saldo inicial: $ 10,000.00
      *> ------------------------------------------
      *> FECHA      DESCRIPCION           T  MONTO
      *> 15/06/2026 Pago servicios        C  $   500.00
      *> 16/06/2026 Deposito nomina       A  $ 1,500.00
      *> 18/06/2026 Retiro cajero         C  $   350.00
      *> 20/06/2026 Transferencia rec     A  $   500.00
      *> ------------------------------------------
      *> TOTAL CARGOS:  $   850.00
      *> TOTAL ABONOS:  $ 2,000.00
      *> SALDO FINAL:   $11,150.00
