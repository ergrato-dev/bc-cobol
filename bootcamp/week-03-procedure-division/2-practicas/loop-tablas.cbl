       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Loops con PERFORM
      *> ============================================
      *> Aprende PERFORM VARYING, UNTIL, TIMES
      *> y PERFORM anidado.
      *>
      *> Compilar: cobc -x -free loop-tablas.cbl
      *> Ejecutar: ./loop-tablas

       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOOPS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Variables para loops ===
      *> Descomenta las siguientes 4 líneas:
      *01  WS-I           PIC 9(03) VALUE ZEROS.
      *01  WS-J           PIC 9(03) VALUE ZEROS.
      *01  WS-LIMITE      PIC 9(03) VALUE 10.
      *01  WS-SUMA        PIC 9(05) VALUE ZEROS.

       PROCEDURE DIVISION.

      *> === PASO 2: PERFORM TIMES (repetir N veces) ===
      *> Descomenta las siguientes 6 líneas:
      *MAIN.
      *    DISPLAY "=== DEMOSTRACION DE LOOPS COBOL ===".
      *    DISPLAY " ".
      *    DISPLAY "1. PERFORM 3 TIMES:".
      *    PERFORM 1000-SALUDO 3 TIMES.
      *    DISPLAY " ".

      *> === PASO 3: PERFORM VARYING (for loop) ===
      *> FROM inicio BY paso UNTIL condición
      *>
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY "2. PERFORM VARYING (1 al 5):".
      *    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 5
      *        COMPUTE WS-J = WS-I * WS-I
      *        DISPLAY "  " WS-I " al cuadrado = " WS-J
      *    END-PERFORM.

      *> === PASO 4: PERFORM UNTIL con acumulador ===
      *> Descomenta las siguientes 9 líneas:
      *    DISPLAY " ".
      *    DISPLAY "3. PERFORM UNTIL (suma hasta exceder 20):".
      *    MOVE 1 TO WS-I.
      *    MOVE 0 TO WS-SUMA.
      *    PERFORM UNTIL WS-SUMA > 20
      *        ADD WS-I TO WS-SUMA
      *        DISPLAY "  Sumo " WS-I " → suma = " WS-SUMA
      *        ADD 1 TO WS-I
      *    END-PERFORM.
      *    DISPLAY "  Total acumulado: " WS-SUMA.

      *> === PASO 5: Regresivo con VARYING ===
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY " ".
      *    DISPLAY "4. Cuenta regresiva:".
      *    PERFORM VARYING WS-I FROM 5 BY -1 UNTIL WS-I = 0
      *        DISPLAY "  " WS-I "..."
      *    END-PERFORM.
      *    DISPLAY "  Despegue!".

      *> === PASO 6: PERFORM anidado (tabla de multiplicar) ===
      *> Descomenta las siguientes 12 líneas:
      *    DISPLAY " ".
      *    DISPLAY "5. Tabla de multiplicar del 7:".
      *    DISPLAY "   Multiplicando | Resultado".
      *    DISPLAY "   --------------|----------".
      *    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 10
      *        COMPUTE WS-J = 7 * WS-I
      *        IF WS-J < 10
      *            DISPLAY "   " WS-I "             |  " WS-J
      *        ELSE
      *            DISPLAY "   " WS-I "             | " WS-J
      *        END-IF
      *    END-PERFORM.
      *    DISPLAY " ".
      *    STOP RUN.

      *> === PASO 7: Párrafo auxiliar para PERFORM TIMES ===
      *> Descomenta las siguientes 4 líneas:
      *1000-SALUDO.
      *    ADD 1 TO WS-I.
      *    DISPLAY "  Saludo #" WS-I ": Hola COBOL!".
      *    EXIT.

      *> === RESULTADO ESPERADO (resumen) ===
      *> 1. PERFORM 3 TIMES:
      *>   Saludo #1: Hola COBOL!
      *>   Saludo #2: Hola COBOL!
      *>   Saludo #3: Hola COBOL!
      *>
      *> 2. PERFORM VARYING (1 al 5):
      *>   1 al cuadrado = 1
      *>   ...
      *>   5 al cuadrado = 25
      *>
      *> 3. PERFORM UNTIL (suma hasta exceder 20):
      *>   Sumo 1 → suma = 001
      *>   ...
      *>   Sumo 6 → suma = 021
      *>   Total acumulado: 00021
      *>
      *> 4. Cuenta regresiva:
      *>   5... 4... 3... 2... 1... Despegue!
      *>
      *> 5. Tabla de multiplicar del 7:
      *>   1 | 7, 2 | 14, ..., 10 | 70
