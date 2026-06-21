       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Formatear Nombre
      *> ============================================
      *> STRING con DELIMITED BY SPACE, POINTER.
      *>
      *> Compilar: cobc -x -free formatear-nombre.cbl
      *> Ejecutar: ./formatear-nombre

       IDENTIFICATION DIVISION.
       PROGRAM-ID. STRFMT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Variables de entrada y salida ===
      *> Descomenta las siguientes 10 líneas:
      *01  WS-PRIMER-NOMBRE PIC X(15) VALUE SPACES.
      *01  WS-SEGUNDO-NOMBRE PIC X(15) VALUE SPACES.
      *01  WS-APELLIDO-P    PIC X(15) VALUE SPACES.
      *01  WS-APELLIDO-M    PIC X(15) VALUE SPACES.
      *01  WS-NOMBRE-COMP   PIC X(60) VALUE SPACES.
      *01  WS-PTR           PIC 9(03) USAGE COMP VALUE 1.
      *01  WS-SEP           PIC X(60) VALUE ALL "=".
      *01  WS-FICHA.
      *    05 FILLER PIC X(20) VALUE "| NOMBRE COMPLETO: ".
      *    05 WS-NOM-FICHA PIC X(35) VALUE SPACES.

       PROCEDURE DIVISION.
      *> === PASO 2: Entrada de datos ===
      *> Descomenta las siguientes 9 líneas:
      *MAIN.
      *    DISPLAY WS-SEP.
      *    DISPLAY "    FORMATEADOR DE NOMBRES".
      *    DISPLAY WS-SEP.
      *    DISPLAY " ".
      *    DISPLAY "Primer nombre  : " WITH NO ADVANCING.
      *    ACCEPT WS-PRIMER-NOMBRE.
      *    DISPLAY "Segundo nombre : " WITH NO ADVANCING.
      *    ACCEPT WS-SEGUNDO-NOMBRE.

      *> === PASO 3: Más entrada ===
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY "Apellido paterno: " WITH NO ADVANCING.
      *    ACCEPT WS-APELLIDO-P.
      *    DISPLAY "Apellido materno: " WITH NO ADVANCING.
      *    ACCEPT WS-APELLIDO-M.
      *    DISPLAY " ".

      *> === PASO 4: Concatenar con STRING ===
      *> DELIMITED BY SPACE omite espacios sobrantes
      *>
      *> Descomenta las siguientes 11 líneas:
      *    STRING WS-APELLIDO-P    DELIMITED BY SPACE
      *           " "              DELIMITED BY SIZE
      *           WS-APELLIDO-M    DELIMITED BY SPACE
      *           ", "             DELIMITED BY SIZE
      *           WS-PRIMER-NOMBRE DELIMITED BY SPACE
      *           " "              DELIMITED BY SIZE
      *           WS-SEGUNDO-NOMBRE DELIMITED BY SPACE
      *           INTO WS-NOMBRE-COMP
      *           WITH POINTER WS-PTR
      *        ON OVERFLOW
      *            DISPLAY "WARNING: Nombre truncado"
      *    END-STRING.

      *> === PASO 5: Mostrar resultados ===
      *> Descomenta las siguientes 8 líneas:
      *    DISPLAY "Resultados:".
      *    DISPLAY "  Formato ingles  : " WS-NOMBRE-COMP.
      *    MOVE 1 TO WS-PTR.
      *    MOVE SPACES TO WS-NOMBRE-COMP.
      *    STRING WS-PRIMER-NOMBRE DELIMITED BY SPACE
      *           " "              DELIMITED BY SIZE
      *           WS-APELLIDO-P    DELIMITED BY SPACE
      *           INTO WS-NOMBRE-COMP
      *           WITH POINTER WS-PTR
      *    END-STRING.
      *    DISPLAY "  Formato simple  : " WS-NOMBRE-COMP.

      *> === PASO 6: Construir ficha con referencia ===
      *> Descomenta las siguientes 5 líneas:
      *    MOVE WS-NOMBRE-COMP TO WS-NOM-FICHA.
      *    DISPLAY " ".
      *    DISPLAY "  " WS-FICHA.
      *    DISPLAY "  | INICIALES       : "
      *            WS-PRIMER-NOMBRE(1:1) "."
      *            WS-APELLIDO-P(1:1) ".".
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Entrada: Juan / Carlos / Perez / Gomez
      *> Formato ingles  : Perez Gomez, Juan Carlos
      *> Formato simple  : Juan Perez
      *> | NOMBRE COMPLETO: Juan Perez
      *> | INICIALES       : J.P.
