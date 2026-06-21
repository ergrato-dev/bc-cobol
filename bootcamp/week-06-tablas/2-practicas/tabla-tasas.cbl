       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Tabla de Tasas de Interés
      *> ============================================
      *> Carga tabla OCCURS con datos, recorre con
      *> PERFORM VARYING y busca con SEARCH ALL.
      *>
      *> Compilar: cobc -x -free tabla-tasas.cbl
      *> Ejecutar: ./tabla-tasas

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TASAS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Tabla con ASCENDING KEY para SEARCH ALL ===
      *> Descomenta las siguientes 8 líneas:
      *01  WS-TASAS.
      *    05 WS-TRAMO OCCURS 6 TIMES
      *        ASCENDING KEY IS WS-PLAZO-MIN
      *        INDEXED BY TRAMO-IDX.
      *       10 WS-PLAZO-MIN  PIC 9(03).
      *       10 WS-PLAZO-MAX  PIC 9(03).
      *       10 WS-TASA       PIC 9V99.
      *       10 WS-DESCRIP    PIC X(20).

      *> === PASO 2: Variables de control ===
      *> Descomenta las siguientes 5 líneas:
      *01  WS-I               PIC 9(03) VALUE ZEROS.
      *01  WS-PLAZO           PIC 9(03) VALUE ZEROS.
      *01  WS-TASA-EDIT       PIC Z9.99.
      *01  WS-LINEA           PIC X(60) VALUE ALL "-".
      *01  WS-SEP             PIC X(60) VALUE ALL "=".

       PROCEDURE DIVISION.
      *> === PASO 3: Cargar datos en la tabla ===
      *> Descomenta las siguientes 28 líneas:
      *MAIN.
      *    DISPLAY WS-SEP.
      *    DISPLAY "    TABLA DE TASAS POR PLAZO".
      *    DISPLAY WS-SEP.
      *    MOVE 1  TO WS-PLAZO-MIN(1).
      *    MOVE 12 TO WS-PLAZO-MAX(1).
      *    MOVE 5.00 TO WS-TASA(1).
      *    MOVE "Corto plazo" TO WS-DESCRIP(1).
      *    MOVE 13 TO WS-PLAZO-MIN(2).
      *    MOVE 24 TO WS-PLAZO-MAX(2).
      *    MOVE 7.50 TO WS-TASA(2).
      *    MOVE "Mediano plazo" TO WS-DESCRIP(2).
      *    MOVE 25 TO WS-PLAZO-MIN(3).
      *    MOVE 36 TO WS-PLAZO-MAX(3).
      *    MOVE 9.00 TO WS-TASA(3).
      *    MOVE "Largo plazo" TO WS-DESCRIP(3).
      *    MOVE 37 TO WS-PLAZO-MIN(4).
      *    MOVE 48 TO WS-PLAZO-MAX(4).
      *    MOVE 10.50 TO WS-TASA(4).
      *    MOVE "Largo plazo plus" TO WS-DESCRIP(4).
      *    MOVE 49 TO WS-PLAZO-MIN(5).
      *    MOVE 60 TO WS-PLAZO-MAX(5).
      *    MOVE 12.00 TO WS-TASA(5).
      *    MOVE "Extendido" TO WS-DESCRIP(5).
      *    MOVE 61 TO WS-PLAZO-MIN(6).
      *    MOVE 72 TO WS-PLAZO-MAX(6).
      *    MOVE 14.00 TO WS-TASA(6).
      *    MOVE "Maximo plazo" TO WS-DESCRIP(6).

      *> === PASO 4: Mostrar toda la tabla ===
      *> Descomenta las siguientes 9 líneas:
      *    DISPLAY " ".
      *    DISPLAY "Plazo (meses)   Tasa %   Descripcion".
      *    DISPLAY WS-LINEA.
      *    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 6
      *        MOVE WS-TASA(WS-I) TO WS-TASA-EDIT
      *        DISPLAY WS-PLAZO-MIN(WS-I) "-"
      *                WS-PLAZO-MAX(WS-I) "         "
      *                WS-TASA-EDIT "   " WS-DESCRIP(WS-I)
      *    END-PERFORM.

      *> === PASO 5: Buscar por plazo con SEARCH ALL ===
      *> Descomenta las siguientes 18 líneas:
      *    DISPLAY " ".
      *    DISPLAY WS-LINEA.
      *    DISPLAY "Ingrese plazo (meses) para consultar tasa".
      *    DISPLAY "(0 para salir)".
      *    PERFORM UNTIL WS-PLAZO = 999
      *        DISPLAY "Plazo: " WITH NO ADVANCING.
      *        ACCEPT WS-PLAZO.
      *        IF WS-PLAZO = 0
      *            MOVE 999 TO WS-PLAZO
      *        ELSE
      *            SEARCH ALL WS-TRAMO
      *                AT END
      *                    DISPLAY "Plazo " WS-PLAZO
      *                            " fuera de rango"
      *                WHEN WS-PLAZO-MIN(TRAMO-IDX)
      *                     <= WS-PLAZO
      *                     AND WS-PLAZO-MAX(TRAMO-IDX)
      *                     >= WS-PLAZO
      *                    MOVE WS-TASA(TRAMO-IDX)
      *                        TO WS-TASA-EDIT
      *                    DISPLAY "Tasa para " WS-PLAZO
      *                            " meses: " WS-TASA-EDIT "%"
      *            END-SEARCH
      *        END-IF
      *    END-PERFORM.
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Plazo (meses)   Tasa %   Descripcion
      *> 001-012          5.00    Corto plazo
      *> ...
      *> Plazo: 30
      *> Tasa para 030 meses:  9.00%
