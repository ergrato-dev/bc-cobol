       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Calculadora COBOL
      *> ============================================
      *> Aprende MOVE, COMPUTE, ADD, SUBTRACT,
      *> MULTIPLY y DIVIDE con REMAINDER.
      *>
      *> Compilar: cobc -x -free calculadora.cbl
      *> Ejecutar: ./calculadora

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Variables para operandos y resultados ===
      *> Descomenta las siguientes 8 líneas:
      *01  WS-NUM1         PIC 9(05) VALUE ZEROS.
      *01  WS-NUM2         PIC 9(05) VALUE ZEROS.
      *01  WS-RESULTADO    PIC 9(10) VALUE ZEROS.
      *01  WS-RESTO        PIC 9(05) VALUE ZEROS.
      *01  WS-REDIT        PIC ZZ,ZZZ,ZZ9.
      *01  WS-OPCION       PIC 9 VALUE ZEROS.
      *    88 OPCION-VALIDA   VALUE 1 THRU 6.
      *    88 OPCION-SALIR    VALUE 6.

       PROCEDURE DIVISION.
      *> === PASO 2: Menú principal ===
      *> Descomenta las siguientes 10 líneas:
      *MAIN.
      *    DISPLAY "=====================================".
      *    DISPLAY "        CALCULADORA COBOL".
      *    DISPLAY "=====================================".
      *    DISPLAY "1. Sumar".
      *    DISPLAY "2. Restar".
      *    DISPLAY "3. Multiplicar".
      *    DISPLAY "4. Dividir (con residuo)".
      *    DISPLAY "5. Exponenciacion".
      *    DISPLAY "6. Salir".

      *> === PASO 3: Leer opción y operandos ===
      *> Descomenta las siguientes 8 líneas:
      *    DISPLAY " ".
      *    DISPLAY "Elija opcion: " WITH NO ADVANCING.
      *    ACCEPT WS-OPCION.
      *    IF OPCION-SALIR
      *        DISPLAY "Adios!"
      *        STOP RUN
      *    END-IF.
      *    DISPLAY "Ingrese primer numero : " WITH NO ADVANCING.
      *    ACCEPT WS-NUM1.

      *> === PASO 4: Leer segundo número y evaluar opción ===
      *> Descomenta las siguientes 19 líneas:
      *    DISPLAY "Ingrese segundo numero: " WITH NO ADVANCING.
      *    ACCEPT WS-NUM2.
      *    DISPLAY " ".
      *    EVALUATE WS-OPCION
      *        WHEN 1
      *            COMPUTE WS-RESULTADO = WS-NUM1 + WS-NUM2
      *            DISPLAY WS-NUM1 " + " WS-NUM2 " = " WS-RESULTADO
      *        WHEN 2
      *            COMPUTE WS-RESULTADO = WS-NUM1 - WS-NUM2
      *            DISPLAY WS-NUM1 " - " WS-NUM2 " = " WS-RESULTADO
      *        WHEN 3
      *            MULTIPLY WS-NUM1 BY WS-NUM2 GIVING WS-RESULTADO
      *            DISPLAY WS-NUM1 " * " WS-NUM2 " = " WS-RESULTADO
      *        WHEN 4
      *            DIVIDE WS-NUM1 BY WS-NUM2
      *                GIVING WS-RESULTADO
      *                REMAINDER WS-RESTO
      *            DISPLAY WS-NUM1 " / " WS-NUM2 " = " WS-RESULTADO
      *            DISPLAY "Residuo: " WS-RESTO

      *> === PASO 5: Exponenciación y formato ===
      *> Descomenta las siguientes 10 líneas:
      *        WHEN 5
      *            COMPUTE WS-RESULTADO = WS-NUM1 ** WS-NUM2
      *            MOVE WS-RESULTADO TO WS-REDIT
      *            DISPLAY WS-NUM1 " ^ " WS-NUM2 " = " WS-REDIT
      *        WHEN OTHER
      *            DISPLAY "Opcion no valida"
      *    END-EVALUATE.
      *    DISPLAY " ".
      *    ADD 1 TO WS-NUM1.     *> Solo para demostrar ADD
      *    DISPLAY "Num1 + 1 = " WS-NUM1.
      *    STOP RUN.

      *> === EJEMPLO DE EJECUCIÓN ===
      *> Opción 4 con 17 / 5:
      *> 00017 / 00005 = 0000000003
      *> Residuo: 00002
      *> Num1 + 1 = 00018
