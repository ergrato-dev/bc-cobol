       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Calculadora de Préstamo
      *> Semana 03 - PROCEDURE DIVISION
      *> ============================================
      *> Implementa cada TODO usando:
      *>   MOVE, COMPUTE, EVALUATE, PERFORM VARYING
      *>
      *> Compilar: cobc -x -free calculadora-prestamo.cbl
      *> Ejecutar: ./calculadora-prestamo

       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRESTAMO.
       AUTHOR. ESTUDIANTE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === SEPARADORES ===
       01  WS-SEP         PIC X(50) VALUE ALL "=".
       01  WS-SUBSEP      PIC X(50) VALUE ALL "-".

      *> === DATOS DE ENTRADA ===
       01  WS-MONTO        PIC 9(09)V99 VALUE ZEROS.
       01  WS-TASA-ANUAL   PIC 9(02)V99 VALUE ZEROS.
       01  WS-PLAZO-MESES  PIC 9(03) VALUE ZEROS.

      *> === CÁLCULOS ===
       01  WS-TASA-MENSUAL PIC 9(02)V9(04) VALUE ZEROS.
       01  WS-CUOTA        PIC 9(09)V99 VALUE ZEROS.
       01  WS-SALDO        PIC 9(09)V99 VALUE ZEROS.
       01  WS-INTERES      PIC 9(09)V99 VALUE ZEROS.
       01  WS-CAPITAL      PIC 9(09)V99 VALUE ZEROS.
       01  WS-TOTAL-PAGADO PIC 9(12)V99 VALUE ZEROS.
       01  WS-INTERES-TOT  PIC 9(12)V99 VALUE ZEROS.

      *> === LOOP Y FORMATEO ===
       01  WS-PERIODO      PIC 9(03) VALUE ZEROS.
       01  WS-CUOTA-EDIT   PIC $$,$$9.99.
       01  WS-SALDO-EDIT   PIC $$,$$9.99.
       01  WS-INTERES-EDIT PIC $$,$$9.99.
       01  WS-CAPITAL-EDIT PIC $$,$$9.99.
       01  WS-TOTAL-EDIT   PIC $$$,$$9.99.
       01  WS-CLASIFICACION PIC X(20) VALUE SPACES.
       01  WS-RESULTADO     PIC 9(09) VALUE ZEROS.

      *> === 88-LEVEL para validación ===
       01  WS-VALIDO        PIC X(01) VALUE "N".
           88 DATOS-VALIDOS    VALUE "S".

       PROCEDURE DIVISION.
       MAIN.
           PERFORM 1000-ENTRADA.
           IF DATOS-VALIDOS
               PERFORM 2000-CALCULAR
               PERFORM 3000-MOSTRAR-TABLA
               PERFORM 4000-RESUMEN
           ELSE
               DISPLAY "ERROR: Datos invalidos."
           END-IF.
           STOP RUN.

      *> ============================================
      *> TODO 1: ENTRADA Y VALIDACIÓN
      *> ============================================
       1000-ENTRADA.
           DISPLAY WS-SEP.
           DISPLAY "    CALCULADORA DE PRESTAMO BANCARIO".
           DISPLAY WS-SEP.
           DISPLAY " ".

      *    TODO: Solicitar monto del préstamo con DISPLAY y ACCEPT
      *    DISPLAY "Monto del prestamo : " WITH NO ADVANCING.
      *    ACCEPT WS-MONTO.

      *    TODO: Solicitar tasa de interés anual con DISPLAY y ACCEPT
      *    DISPLAY "Tasa anual (%)     : " WITH NO ADVANCING.
      *    ACCEPT WS-TASA-ANUAL.

      *    TODO: Solicitar plazo en meses con DISPLAY y ACCEPT
      *    DISPLAY "Plazo (meses)      : " WITH NO ADVANCING.
      *    ACCEPT WS-PLAZO-MESES.

      *    TODO: Validar que todos los valores sean > 0
      *    IF WS-MONTO > 0 AND WS-TASA-ANUAL > 0
      *        AND WS-PLAZO-MESES > 0
      *        SET DATOS-VALIDOS TO TRUE
      *    END-IF.
           EXIT.

      *> ============================================
      *> TODO 2: CALCULAR CUOTA MENSUAL
      *> ============================================
       2000-CALCULAR.
      *    TODO: Calcular tasa mensual = tasa anual / 12 / 100
      *    COMPUTE WS-TASA-MENSUAL = WS-TASA-ANUAL / 12 / 100.

      *    TODO: Calcular cuota con fórmula de amortización francesa
      *          cuota = monto × t × (1+t)^n / ((1+t)^n - 1)
      *          donde t = tasa mensual, n = plazo en meses
      *    COMPUTE WS-CUOTA ROUNDED =
      *        WS-MONTO * WS-TASA-MENSUAL
      *        * (1 + WS-TASA-MENSUAL) ** WS-PLAZO-MESES
      *        / ((1 + WS-TASA-MENSUAL) ** WS-PLAZO-MESES - 1).

      *    TODO: Inicializar saldo = monto
      *    MOVE WS-MONTO TO WS-SALDO.
           EXIT.

      *> ============================================
      *> TODO 3: TABLA DE AMORTIZACIÓN
      *> ============================================
       3000-MOSTRAR-TABLA.
           MOVE WS-CUOTA TO WS-CUOTA-EDIT.
           DISPLAY " ".
           DISPLAY "Cuota mensual: " WS-CUOTA-EDIT.
           DISPLAY " ".
           DISPLAY "Per  Interes     Capital     Saldo".
           DISPLAY WS-SUBSEP.

      *    TODO: PERFORM VARYING para cada período (1 hasta plazo)
      *    PERFORM VARYING WS-PERIODO FROM 1 BY 1
      *            UNTIL WS-PERIODO > WS-PLAZO-MESES

      *        TODO: Calcular interés del período = saldo × tasa mensual
      *        COMPUTE WS-INTERES ROUNDED = WS-SALDO * WS-TASA-MENSUAL

      *        TODO: Calcular capital = cuota - interés
      *        COMPUTE WS-CAPITAL = WS-CUOTA - WS-INTERES

      *        TODO: Actualizar saldo = saldo - capital
      *        SUBTRACT WS-CAPITAL FROM WS-SALDO

      *        TODO: Acumular totales
      *        ADD WS-CUOTA TO WS-TOTAL-PAGADO
      *        ADD WS-INTERES TO WS-INTERES-TOT

      *        TODO: Mover a campos de edición y mostrar
      *        MOVE WS-INTERES TO WS-INTERES-EDIT
      *        MOVE WS-CAPITAL TO WS-CAPITAL-EDIT
      *        MOVE WS-SALDO TO WS-SALDO-EDIT
      *        DISPLAY WS-PERIODO "   "
      *                WS-INTERES-EDIT "   "
      *                WS-CAPITAL-EDIT "   "
      *                WS-SALDO-EDIT
      *    END-PERFORM.
           EXIT.

      *> ============================================
      *> TODO 4: RESUMEN Y CLASIFICACIÓN
      *> ============================================
       4000-RESUMEN.
           MOVE WS-TOTAL-PAGADO TO WS-TOTAL-EDIT.
           DISPLAY WS-SUBSEP.
           DISPLAY "Total pagado   : " WS-TOTAL-EDIT.

      *    TODO: Usar EVALUATE TRUE para clasificar préstamo
      *    EVALUATE TRUE
      *        WHEN WS-MONTO <= 50000
      *            MOVE "Prestamo pequeno" TO WS-CLASIFICACION
      *        WHEN WS-MONTO <= 200000
      *            MOVE "Prestamo mediano" TO WS-CLASIFICACION
      *        WHEN OTHER
      *            MOVE "Prestamo grande" TO WS-CLASIFICACION
      *    END-EVALUATE.
      *    DISPLAY "Clasificacion  : " WS-CLASIFICACION.
           DISPLAY " ".
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO (monto=100000, tasa=12%, plazo=12)
      *> ============================================
      *> Cuota mensual: $ 8,884.88
      *> Per  Interes     Capital     Saldo
      *> ------------------------------------------
      *> 1    $ 1,000.00  $ 7,884.88  $ 92,115.12
      *> 2    $   921.15  $ 7,963.73  $ 84,151.39
      *> ...
      *> 12   $    87.94  $ 8,796.94  $      0.00
      *> ------------------------------------------
      *> Total pagado   : $106,618.56
      *> Clasificacion  : Prestamo mediano
