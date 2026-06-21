       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Clasificador con EVALUATE
      *> ============================================
      *> Aprende IF/ELSE anidado, EVALUATE simple,
      *> EVALUATE TRUE y condiciones compuestas.
      *>
      *> Compilar: cobc -x -free clasificador-edad.cbl
      *> Ejecutar: ./clasificador-edad

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CLASIFICA.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Variables ===
      *> Descomenta las siguientes 5 líneas:
      *01  WS-EDAD         PIC 9(03) VALUE ZEROS.
      *01  WS-CATEGORIA    PIC X(20) VALUE SPACES.
      *01  WS-PAIS         PIC X(02) VALUE SPACES.
      *    88 PAIS-MX        VALUE "MX".
      *    88 PAIS-AR        VALUE "AR".

       PROCEDURE DIVISION.
      *> === PASO 2: Entrada de datos ===
      *> Descomenta las siguientes 3 líneas:
      *MAIN.
      *    DISPLAY "=== CLASIFICADOR DEMOGRAFICO ===".
      *    DISPLAY " ".

      *> === PASO 3: Leer edad y país ===
      *> Descomenta las siguientes 4 líneas:
      *    DISPLAY "Ingrese su edad: " WITH NO ADVANCING.
      *    ACCEPT WS-EDAD.
      *    DISPLAY "Ingrese su pais (MX/AR): " WITH NO ADVANCING.
      *    ACCEPT WS-PAIS.

      *> === PASO 4: EVALUATE TRUE para clasificar edad ===
      *> EVALUATE TRUE es la forma más elegante de
      *> evaluar múltiples condiciones no discretas.
      *>
      *> Descomenta las siguientes 11 líneas:
      *    DISPLAY " ".
      *    DISPLAY "--- Clasificacion por edad ---".
      *    EVALUATE TRUE
      *        WHEN WS-EDAD < 0
      *            MOVE "EDAD INVALIDA" TO WS-CATEGORIA
      *        WHEN WS-EDAD <= 12
      *            MOVE "NINO" TO WS-CATEGORIA
      *        WHEN WS-EDAD <= 17
      *            MOVE "ADOLESCENTE" TO WS-CATEGORIA
      *        WHEN WS-EDAD <= 64
      *            MOVE "ADULTO" TO WS-CATEGORIA
      *        WHEN OTHER
      *            MOVE "ADULTO MAYOR" TO WS-CATEGORIA
      *    END-EVALUATE.
      *    DISPLAY "Categoria: " WS-CATEGORIA.

      *> === PASO 5: IF con condiciones compuestas ===
      *> Descomenta las siguientes 8 líneas:
      *    DISPLAY " ".
      *    DISPLAY "--- Validacion de mayoria de edad ---".
      *    IF WS-EDAD >= 18
      *        DISPLAY "Eres mayor de edad."
      *        IF PAIS-MX AND WS-EDAD >= 18
      *            DISPLAY "Puedes votar en Mexico."
      *        END-IF
      *    ELSE
      *        DISPLAY "Eres menor de edad."
      *    END-IF.

      *> === PASO 6: Uso de IF NOT y condiciones de tipo ===
      *> Descomenta las siguientes 7 líneas:
      *    DISPLAY " ".
      *    DISPLAY "--- Validaciones adicionales ---".
      *    IF WS-EDAD IS NUMERIC
      *        DISPLAY "La edad ingresada es un numero valido."
      *    END-IF.
      *    IF WS-EDAD IS NOT ZERO
      *        DISPLAY "La edad no es cero."
      *    END-IF.
      *    STOP RUN.

      *> === RESULTADO ESPERADO (edad: 16, país: MX) ===
      *> --- Clasificacion por edad ---
      *> Categoria: ADOLESCENTE
      *>
      *> --- Validacion de mayoria de edad ---
      *> Eres menor de edad.
      *>
      *> --- Validaciones adicionales ---
      *> La edad ingresada es un numero valido.
      *> La edad no es cero.
