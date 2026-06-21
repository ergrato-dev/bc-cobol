       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Hola Mundo COBOL
      *> ============================================
      *>
      *> OBJETIVO: Escribir tu primer programa COBOL usando
      *> las 4 divisiones y el verbo DISPLAY.
      *>
      *> Instrucciones:
      *>   - Descomenta cada sección una por una
      *>   - No descomentes todo de golpe
      *>   - Compila después de cada paso
      *>
      *> Compilar: cobc -x -free hola-mundo.cbl
      *> Ejecutar: ./hola-mundo

      *> === PASO 1: IDENTIFICATION DIVISION ===
      *> Todo programa COBOL empieza con esta división.
      *> Solo PROGRAM-ID es obligatorio.
      *>
      *> Descomenta las siguientes 3 líneas:
      *IDENTIFICATION DIVISION.
      *PROGRAM-ID. HOLA.
      *AUTHOR. ESTUDIANTE.

      *> === PASO 2: DATA DIVISION ===
      *> Aquí declaramos nuestras variables.
      *> WORKING-STORAGE es para variables de trabajo.
      *>
      *> Descomenta las siguientes 5 líneas:
      *DATA DIVISION.
      *WORKING-STORAGE SECTION.
      *01  WS-MENSAJE     PIC X(30) VALUE "Hola mundo desde COBOL".
      *01  WS-CONTADOR    PIC 9(02) VALUE 1.

      *> === PASO 3: PROCEDURE DIVISION ===
      *> Aquí va el código ejecutable.
      *> DISPLAY muestra texto en pantalla.
      *> STOP RUN termina el programa.
      *>
      *> Descomenta las siguientes 4 líneas:
      *PROCEDURE DIVISION.
      *    DISPLAY "==========================================".
      *    DISPLAY WS-MENSAJE.
      *    DISPLAY "==========================================".

      *> === PASO 4: Mostrar variable numérica ===
      *> COBOL convierte automáticamente PIC 9 a texto.
      *>
      *> Descomenta las siguientes 2 líneas:
      *    DISPLAY "Intento numero: " WS-CONTADOR.
      *    DISPLAY " ".

      *> === PASO 5: Finalizar el programa ===
      *> STOP RUN es obligatorio. No olvides el punto final.
      *>
      *> Descomenta la siguiente línea:
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> ==========================================
      *> Hola mundo desde COBOL
      *> ==========================================
      *> Intento numero: 01
      *>
