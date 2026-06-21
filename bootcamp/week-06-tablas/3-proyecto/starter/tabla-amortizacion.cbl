       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Tabla de Amortización en Memoria
      *> Semana 06 - Tablas y Arrays
      *> ============================================
      *> Calcula plan de pagos y lo almacena en
      *> OCCURS DEPENDING ON. Permite consultas.
      *>
      *> Compilar: cobc -x -free tabla-amortizacion.cbl
      *> Ejecutar: ./tabla-amortizacion

       IDENTIFICATION DIVISION.
       PROGRAM-ID. AMORTIZA.
       AUTHOR. ESTUDIANTE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === ENTRADA ===
       01  WS-MONTO          PIC 9(09)V99 VALUE ZEROS.
       01  WS-TASA-ANUAL     PIC 9(02)V99 VALUE ZEROS.
       01  WS-PLAZO          PIC 9(03) VALUE ZEROS.

      *> === CÁLCULOS ===
       01  WS-TASA-MENSUAL   PIC 9(02)V9(06) VALUE ZEROS.
       01  WS-CUOTA          PIC 9(09)V99 VALUE ZEROS.
       01  WS-SALDO          PIC 9(09)V99 VALUE ZEROS.

      *> TODO 1: Tabla de amortización con OCCURS DEPENDING ON
      *> Máximo 360 cuotas, tamaño real = WS-CANT-CUOTAS
      *> Descomenta y completa:
      *01  WS-CANT-CUOTAS     PIC 9(03) VALUE ZEROS.
      *01  WS-TABLA-AMORT.
      *    05 WS-CUOTA-DET OCCURS 1 TO 360 TIMES
      *        DEPENDING ON WS-CANT-CUOTAS
      *        ASCENDING KEY IS WS-DET-NUM
      *        INDEXED BY CUOTA-IDX.
      *       10 WS-DET-NUM        PIC 9(03).
      *       10 WS-DET-CUOTA      PIC 9(09)V99.
      *       10 WS-DET-INTERES    PIC 9(09)V99.
      *       10 WS-DET-CAPITAL    PIC 9(09)V99.
      *       10 WS-DET-SALDO      PIC 9(09)V99.

      *> === ACUMULADORES ===
       01  WS-TOTAL-PAGADO    PIC 9(12)V99 VALUE ZEROS.
       01  WS-TOTAL-INTERES   PIC 9(12)V99 VALUE ZEROS.

      *> === CAMPOS DE EDICIÓN ===
       01  WS-CUOTA-EDIT      PIC $$,$$9.99.
       01  WS-INTERES-EDIT    PIC $$,$$9.99.
       01  WS-CAPITAL-EDIT    PIC $$,$$9.99.
       01  WS-SALDO-EDIT      PIC $$,$$9.99.
       01  WS-TOTAL-EDIT      PIC $$$,$$9.99.

      *> === LOOP ===
       01  WS-I               PIC 9(03) VALUE ZEROS.
       01  WS-CONSULTA        PIC 9(03) VALUE ZEROS.
       01  WS-OPCION          PIC 9 VALUE ZEROS.
       01  WS-SEP             PIC X(70) VALUE ALL "=".
       01  WS-SUBSEP          PIC X(70) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 2: PERFORM a párrafos en orden
           STOP RUN.

      *> ============================================
      *> TODO 3: ENTRADA DE DATOS
      *> ============================================
       ENTRADA.
           DISPLAY WS-SEP.
           DISPLAY "    CALCULADORA DE AMORTIZACION".
           DISPLAY WS-SEP.
           DISPLAY " ".
      *    Solicitar monto, tasa anual, plazo en meses
      *    Validar que sean > 0
      *    MOVE WS-PLAZO TO WS-CANT-CUOTAS
           EXIT.

      *> ============================================
      *> TODO 4: CALCULAR TABLA (PERFORM VARYING)
      *> ============================================
       CALCULAR.
      *    COMPUTE WS-TASA-MENSUAL = WS-TASA-ANUAL / 12 / 100
      *    Calcular WS-CUOTA con fórmula francesa
      *    MOVE WS-MONTO TO WS-SALDO
      *    PERFORM VARYING WS-I FROM 1 BY 1
      *            UNTIL WS-I > WS-CANT-CUOTAS
      *        MOVE WS-I TO WS-DET-NUM(WS-I)
      *        COMPUTE WS-DET-INTERES(WS-I) =
      *            WS-SALDO * WS-TASA-MENSUAL
      *        COMPUTE WS-DET-CAPITAL(WS-I) =
      *            WS-CUOTA - WS-DET-INTERES(WS-I)
      *        SUBTRACT WS-DET-CAPITAL(WS-I) FROM WS-SALDO
      *        MOVE WS-SALDO TO WS-DET-SALDO(WS-I)
      *        MOVE WS-CUOTA TO WS-DET-CUOTA(WS-I)
      *        ADD WS-CUOTA TO WS-TOTAL-PAGADO
      *        ADD WS-DET-INTERES(WS-I) TO WS-TOTAL-INTERES
      *    END-PERFORM
           EXIT.

      *> ============================================
      *> TODO 5: MOSTRAR TABLA COMPLETA
      *> ============================================
       MOSTRAR.
           MOVE WS-CUOTA TO WS-CUOTA-EDIT.
           DISPLAY "Cuota mensual: " WS-CUOTA-EDIT.
           DISPLAY " ".
           DISPLAY "Cuota  Interes     Capital     Saldo".
           DISPLAY WS-SUBSEP.

      *    PERFORM VARYING WS-I FROM 1 BY 1
      *            UNTIL WS-I > WS-CANT-CUOTAS
      *          Mover campos a variables de edición
      *          DISPLAY con formato alineado
      *    END-PERFORM

      *    Mostrar totales:
      *    DISPLAY WS-SUBSEP
      *    DISPLAY "Total pagado  : " WS-TOTAL-EDIT
      *    DISPLAY "Total intereses: " WS-TOTAL-EDIT
           EXIT.

      *> ============================================
      *> TODO 6: CONSULTAR CUOTA (SEARCH ALL)
      *> ============================================
       CONSULTAR.
      *    DISPLAY "Numero de cuota a consultar: "
      *    ACCEPT WS-CONSULTA
      *    IF WS-CONSULTA > 0 AND
      *       WS-CONSULTA <= WS-CANT-CUOTAS
      *        SEARCH ALL WS-CUOTA-DET
      *            AT END DISPLAY "Error inesperado"
      *            WHEN WS-DET-NUM(CUOTA-IDX) =
      *                 WS-CONSULTA
      *                Mostrar detalle de la cuota
      *        END-SEARCH
      *    ELSE
      *        DISPLAY "Cuota fuera de rango"
      *    END-IF
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO (monto=50000, tasa=10%, plazo=6)
      *> ============================================
      *> Cuota mensual: $ 8,560.75
      *> Cuota  Interes     Capital     Saldo
      *> 001    $   416.67  $ 8,144.08  $ 41,855.92
      *> 002    $   348.80  $ 8,211.95  $ 33,643.97
      *> ...
      *> Total pagado  : $ 51,364.50
      *> Total intereses: $  1,364.50
