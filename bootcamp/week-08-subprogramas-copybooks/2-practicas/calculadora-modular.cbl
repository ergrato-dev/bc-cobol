       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Calculadora Modular (PRINCIPAL)
      *> ============================================
      *> Programa principal que llama a SUMAR y RESTAR.
      *>
      *> Compilar TODO JUNTO:
      *> cobc -x -free calculadora-modular.cbl sumar.cbl restar.cbl -o calculadora
      *> ./calculadora

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCMOD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Variables compartidas ===
      *> Descomenta las siguientes 5 líneas:
      *01  WS-NUM1      PIC 9(05) VALUE ZEROS.
      *01  WS-NUM2      PIC 9(05) VALUE ZEROS.
      *01  WS-RESULTADO PIC S9(10) VALUE ZEROS.
      *01  WS-OPCION    PIC 9 VALUE ZEROS.
      *01  WS-SEP       PIC X(40) VALUE ALL "=".

       PROCEDURE DIVISION.
      *> === PASO 2: Leer operandos y opción ===
      *> Descomenta las siguientes 9 líneas:
      *MAIN.
      *    DISPLAY WS-SEP.
      *    DISPLAY "    CALCULADORA MODULAR".
      *    DISPLAY WS-SEP.
      *    DISPLAY " ".
      *    DISPLAY "Operando 1: " WITH NO ADVANCING.
      *    ACCEPT WS-NUM1.
      *    DISPLAY "Operando 2: " WITH NO ADVANCING.
      *    ACCEPT WS-NUM2.

      *> === PASO 3: Menú y CALL ===
      *> Descomenta las siguientes 13 líneas:
      *    DISPLAY "1=Sumar 2=Restar : " WITH NO ADVANCING.
      *    ACCEPT WS-OPCION.
      *    DISPLAY " ".
      *    EVALUATE WS-OPCION
      *        WHEN 1
      *            CALL "SUMAR" USING WS-NUM1 WS-NUM2 WS-RESULTADO
      *            DISPLAY WS-NUM1 " + " WS-NUM2 " = " WS-RESULTADO
      *        WHEN 2
      *            CALL "RESTAR" USING WS-NUM1 WS-NUM2 WS-RESULTADO
      *            DISPLAY WS-NUM1 " - " WS-NUM2 " = " WS-RESULTADO
      *        WHEN OTHER
      *            DISPLAY "Opcion no valida"
      *    END-EVALUATE.
      *    STOP RUN.

      *> === RESULTADO ESPERADO (5 + 3) ===
      *> 00005 + 00003 = 0000000008
