       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Estructura Completa con Párrafos
      *> ============================================
      *>
      *> OBJETIVO: Escribir un programa COBOL completo con:
      *>   - Las 4 divisiones
      *>   - Múltiples párrafos en PROCEDURE DIVISION
      *>   - PERFORM para llamar párrafos
      *>   - Comentarios explicativos
      *>
      *> Instrucciones:
      *>   - Descomenta cada paso por separado
      *>
      *> Compilar: cobc -x -free estructura-completa.cbl
      *> Ejecutar: ./estructura-completa

      *> === PASO 1: IDENTIFICATION DIVISION ===
      *> Descomenta las siguientes 3 líneas:
      *IDENTIFICATION DIVISION.
      *PROGRAM-ID. COMPLETO.
      *AUTHOR. ESTUDIANTE.

      *> === PASO 2: ENVIRONMENT DIVISION ===
      *> Esta división es opcional si no usas archivos.
      *> Pero es buena práctica incluirla.
      *>
      *> Descomenta las siguientes 4 líneas:
      *ENVIRONMENT DIVISION.
      *CONFIGURATION SECTION.
      *SOURCE-COMPUTER. LINUX.
      *OBJECT-COMPUTER. LINUX.

      *> === PASO 3: DATA DIVISION ===
      *> Declara tus variables de trabajo
      *>
      *> Descomenta las siguientes 10 líneas:
      *DATA DIVISION.
      *WORKING-STORAGE SECTION.
      *01  WS-TITULO      PIC X(40) VALUE " PROGRAMA COBOL COMPLETO ".
      *01  WS-SEPARADOR   PIC X(40) VALUE ALL "=".
      *01  WS-NOMBRE      PIC X(30) VALUE SPACES.
      *01  WS-OPCION      PIC 9     VALUE ZEROS.
      *    88 OPCION-VALIDA       VALUE 1 THRU 3.
      *    88 OPCION-INVALIDA     VALUE 0 4 THRU 9.
      *01  WS-MENSAJE     PIC X(50) VALUE SPACES.

      *> === PASO 4: PROCEDURE DIVISION ===
      *> Usamos PERFORM para llamar párrafos
      *>
      *> Descomenta las siguientes 6 líneas:
      *PROCEDURE DIVISION.
      *    PERFORM 1000-INICIO.
      *    PERFORM 2000-ENTRADA.
      *    PERFORM 3000-PROCESO.
      *    PERFORM 9000-FINAL.
      *    STOP RUN.

      *> === PASO 5: Párrafo 1000-INICIO ===
      *> Muestra el encabezado del programa
      *>
      *> Descomenta las siguientes 7 líneas:
      *1000-INICIO.
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY WS-TITULO.
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY " ".
      *    DISPLAY "Bienvenido al bootcamp COBOL Zero to Hero!".
      *    DISPLAY " ".

      *> === PASO 6: Párrafo 2000-ENTRADA ===
      *> Solicita datos al usuario
      *>
      *> Descomenta las siguientes 5 líneas:
      *2000-ENTRADA.
      *    DISPLAY "Como te llamas? " WITH NO ADVANCING.
      *    ACCEPT WS-NOMBRE.
      *    DISPLAY "Elige una opcion (1-3): " WITH NO ADVANCING.
      *    ACCEPT WS-OPCION.
      *    DISPLAY " ".

      *> === PASO 7: Párrafo 3000-PROCESO ===
      *> Evalúa la opción elegida usando EVALUATE
      *> 88-level OPCION-VALIDA se usa con IF
      *>
      *> Descomenta las siguientes 19 líneas:
      *3000-PROCESO.
      *    IF OPCION-VALIDA
      *        EVALUATE WS-OPCION
      *            WHEN 1
      *                MOVE "Has elegido: Ver saldo" TO WS-MENSAJE
      *            WHEN 2
      *                MOVE "Has elegido: Depositar" TO WS-MENSAJE
      *            WHEN 3
      *                MOVE "Has elegido: Retirar"  TO WS-MENSAJE
      *        END-EVALUATE
      *    ELSE
      *        MOVE "ERROR: Opcion no valida. Debe ser 1, 2 o 3."
      *            TO WS-MENSAJE
      *    END-IF.
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY "Hola, " WS-NOMBRE "!".
      *    DISPLAY WS-MENSAJE.
      *    DISPLAY WS-SEPARADOR.

      *> === PASO 8: Párrafo 9000-FINAL ===
      *> Despedida y limpieza
      *>
      *> Descomenta las siguientes 3 líneas:
      *9000-FINAL.
      *    DISPLAY " ".
      *    DISPLAY "Gracias por usar el programa. Hasta pronto!".

      *> === RESULTADO ESPERADO (ejemplo con opción 2) ===
      *> ========================================
      *>  PROGRAMA COBOL COMPLETO
      *> ========================================
      *>
      *> Bienvenido al bootcamp COBOL Zero to Hero!
      *>
      *> Como te llamas? Ana
      *> Elige una opcion (1-3): 2
      *>
      *> ========================================
      *> Hola, Ana!
      *> Has elegido: Depositar
      *> ========================================
      *>
      *> Gracias por usar el programa. Hasta pronto!
