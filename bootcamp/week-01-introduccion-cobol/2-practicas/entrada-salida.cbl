       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Entrada y Salida (ACCEPT / DISPLAY)
      *> ============================================
      *>
      *> OBJETIVO: Interactuar con el usuario usando
      *> ACCEPT (leer del teclado) y DISPLAY (mostrar en pantalla).
      *>
      *> Instrucciones:
      *>   - Descomenta cada paso por separado
      *>   - Compila y ejecuta después de cada paso
      *>
      *> Compilar: cobc -x -free entrada-salida.cbl
      *> Ejecutar: ./entrada-salida

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ENTRADA.

      *> === PASO 1: Declarar variables en DATA DIVISION ===
      *> PIC X(30) = campo alfanumérico de 30 caracteres
      *> PIC 9(03) = campo numérico de 3 dígitos
      *> VALUE SPACES = inicializa con espacios
      *> VALUE ZEROS  = inicializa con ceros
      *>
      *> Descomenta las siguientes 5 líneas:
      *DATA DIVISION.
      *WORKING-STORAGE SECTION.
      *01  WS-NOMBRE      PIC X(30) VALUE SPACES.
      *01  WS-EDAD        PIC 9(03) VALUE ZEROS.
      *01  WS-CIUDAD      PIC X(20) VALUE SPACES.

       PROCEDURE DIVISION.

      *> === PASO 2: Pedir datos al usuario ===
      *> ACCEPT lee una línea del teclado
      *> DISPLAY muestra texto en pantalla
      *>
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY "==========================================".
      *    DISPLAY "    SISTEMA DE REGISTRO DE USUARIO".
      *    DISPLAY "==========================================".
      *    DISPLAY " ".
      *    DISPLAY "Ingrese su nombre: " WITH NO ADVANCING.

      *> === PASO 3: Leer nombre y edad ===
      *> WITH NO ADVANCING deja el cursor en la misma línea
      *> ACCEPT espera entrada del usuario (presionar Enter)
      *>
      *> Descomenta las siguientes 4 líneas:
      *    ACCEPT WS-NOMBRE.
      *    DISPLAY "Ingrese su edad: " WITH NO ADVANCING.
      *    ACCEPT WS-EDAD.
      *    DISPLAY "Ingrese su ciudad: " WITH NO ADVANCING.

      *> === PASO 4: Leer ciudad y mostrar resumen ===
      *>
      *> Descomenta las siguientes 6 líneas:
      *    ACCEPT WS-CIUDAD.
      *    DISPLAY " ".
      *    DISPLAY "==========================================".
      *    DISPLAY "    DATOS INGRESADOS".
      *    DISPLAY "==========================================".
      *    DISPLAY "Nombre : " WS-NOMBRE.

      *> === PASO 5: Mostrar edad y ciudad ===
      *> COBOL elimina ceros a la izquierda al mostrar números
      *>
      *> Descomenta las siguientes 2 líneas:
      *    DISPLAY "Edad   : " WS-EDAD " años".
      *    DISPLAY "Ciudad : " WS-CIUDAD.

      *> === PASO 6: Despedida y finalizar ===
      *>
      *> Descomenta las siguientes 3 líneas:
      *    DISPLAY "==========================================".
      *    DISPLAY "Gracias por registrarte, " WS-NOMBRE "!".
      *    STOP RUN.

      *> === RESULTADO ESPERADO (ejemplo) ===
      *> ==========================================
      *>     SISTEMA DE REGISTRO DE USUARIO
      *> ==========================================
      *>
      *> Ingrese su nombre: Juan
      *> Ingrese su edad: 25
      *> Ingrese su ciudad: Mexico
      *>
      *> ==========================================
      *>     DATOS INGRESADOS
      *> ==========================================
      *> Nombre : Juan
      *> Edad   : 025 años
      *> Ciudad : Mexico
      *> ==========================================
      *> Gracias por registrarte, Juan!
