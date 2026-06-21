       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Matriz de Tarifas 2D
      *> ============================================
      *> Tabla bidimensional: 4 tipos cuenta × 5 rangos
      *> Usa PERFORM VARYING anidado para cargar y mostrar.
      *>
      *> Compilar: cobc -x -free matriz-tarifas.cbl
      *> Ejecutar: ./matriz-tarifas

       IDENTIFICATION DIVISION.
       PROGRAM-ID. MATRIZ.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Tabla 2D con OCCURS anidado ===
      *> 4 tipos de cuenta × 5 rangos de saldo
      *>
      *> Descomenta las siguientes 11 líneas:
      *01  WS-TARIFAS.
      *    05 WS-TIPO OCCURS 4 TIMES.                 *> Dimensión 1: tipo
      *       10 WS-TIPO-NOMBRE  PIC X(20).
      *       10 WS-RANGO OCCURS 5 TIMES.             *> Dimensión 2: rango
      *          15 WS-RANGO-MIN   PIC 9(09).
      *          15 WS-RANGO-MAX   PIC 9(09).
      *          15 WS-COSTO       PIC 9(05)V99.
      *01  WS-P             PIC 9(03) VALUE ZEROS.    *> Índice tipo
      *01  WS-R             PIC 9(03) VALUE ZEROS.    *> Índice rango
      *01  WS-LINEA         PIC X(70) VALUE ALL "-".
      *01  WS-COSTO-EDIT    PIC $$,$$9.99.

       PROCEDURE DIVISION.
      *> === PASO 2: Cargar nombres de tipos ===
      *> Descomenta las siguientes 9 líneas:
      *MAIN.
      *    DISPLAY "=== MATRIZ DE TARIFAS BANCARIAS ===".
      *    DISPLAY " ".
      *    MOVE "Cuenta Corriente" TO WS-TIPO-NOMBRE(1).
      *    MOVE "Caja de Ahorro" TO WS-TIPO-NOMBRE(2).
      *    MOVE "Plazo Fijo" TO WS-TIPO-NOMBRE(3).
      *    MOVE "Tarjeta Credito" TO WS-TIPO-NOMBRE(4).

      *> === PASO 3: Cargar matriz con PERFORM anidado ===
      *> Descomenta las siguientes 20 líneas:
      *    PERFORM VARYING WS-P FROM 1 BY 1 UNTIL WS-P > 4
      *        PERFORM VARYING WS-R FROM 1 BY 1
      *                UNTIL WS-R > 5
      *            EVALUATE WS-R
      *                WHEN 1
      *                    MOVE 0 TO WS-RANGO-MIN(WS-P, WS-R)
      *                    MOVE 1000 TO WS-RANGO-MAX(WS-P, WS-R)
      *                WHEN 2
      *                    MOVE 1001 TO WS-RANGO-MIN(WS-P, WS-R)
      *                    MOVE 5000 TO WS-RANGO-MAX(WS-P, WS-R)
      *                WHEN 3
      *                    MOVE 5001 TO WS-RANGO-MIN(WS-P, WS-R)
      *                    MOVE 20000 TO WS-RANGO-MAX(WS-P, WS-R)
      *                WHEN 4
      *                    MOVE 20001 TO WS-RANGO-MIN(WS-P, WS-R)
      *                    MOVE 100000 TO WS-RANGO-MAX(WS-P, WS-R)
      *                WHEN 5
      *                    MOVE 100001 TO WS-RANGO-MIN(WS-P, WS-R)
      *                    MOVE 9999999 TO WS-RANGO-MAX(WS-P, WS-R)
      *            END-EVALUATE
      *            COMPUTE WS-COSTO(WS-P, WS-R) =
      *                WS-P * 5.00 + WS-R * 2.50
      *        END-PERFORM
      *    END-PERFORM.

      *> === PASO 4: Mostrar matriz ===
      *> Descomenta las siguientes 22 líneas:
      *    DISPLAY "Tipo de Cuenta        Rango 0-1K  1K-5K".
      *            "  5K-20K  20K-100K  100K+".
      *    DISPLAY WS-LINEA.
      *    PERFORM VARYING WS-P FROM 1 BY 1 UNTIL WS-P > 4
      *        DISPLAY WS-TIPO-NOMBRE(WS-P)
      *                "  " WITH NO ADVANCING
      *        PERFORM VARYING WS-R FROM 1 BY 1
      *                UNTIL WS-R > 5
      *            MOVE WS-COSTO(WS-P, WS-R)
      *                TO WS-COSTO-EDIT
      *            DISPLAY WS-COSTO-EDIT " " WITH NO ADVANCING
      *        END-PERFORM
      *        DISPLAY " "   *> Salto de línea
      *    END-PERFORM.

      *> === PASO 5: Demostrar acceso directo ===
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY " ".
      *    DISPLAY WS-LINEA.
      *    DISPLAY "Costo Cuenta Corriente (tipo 1) rango 3:".
      *    MOVE WS-COSTO(1, 3) TO WS-COSTO-EDIT.
      *    DISPLAY "  " WS-COSTO-EDIT.
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Tipo de Cuenta        Rango 0-1K  1K-5K  5K-20K  20K-100K  100K+
      *> Cuenta Corriente       $ 7.50  $10.00  $12.50    $15.00  $17.50
      *> Caja de Ahorro        $12.50  $15.00  $17.50    $20.00  $22.50
      *> Plazo Fijo            $17.50  $20.00  $22.50    $25.00  $27.50
      *> Tarjeta Credito       $22.50  $25.00  $27.50    $30.00  $32.50
