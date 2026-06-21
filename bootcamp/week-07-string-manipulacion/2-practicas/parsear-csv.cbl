       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Parsear CSV con UNSTRING
      *> ============================================
      *> Lee datos.dat, parsea cada línea con UNSTRING
      *> y cuenta campos con TALLYING.
      *>
      *> Compilar: cobc -x -free parsear-csv.cbl
      *> Ejecutar: ./parsear-csv

       IDENTIFICATION DIVISION.
       PROGRAM-ID. PARSE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *> === PASO 1: Declarar archivo ===
      *> Descomenta las siguientes 5 líneas:
      *    SELECT DATOS ASSIGN TO "datos.dat"
      *        ORGANIZATION IS LINE SEQUENTIAL
      *        FILE STATUS IS WS-FS.
      *DATA DIVISION.
      *FILE SECTION.
      *FD  DATOS.

      *> === PASO 2: Layout y WORKING-STORAGE ===
      *> Descomenta las siguientes 20 líneas:
      *01  REG-DATOS       PIC X(80).
      *WORKING-STORAGE SECTION.
      *01  WS-FS            PIC X(02).
      *    88 DATOS-OK      VALUE "00".
      *    88 DATOS-EOF     VALUE "10".
      *01  WS-CONT-REG      PIC 9(03) VALUE ZEROS.
      *01  WS-CAMPOS.
      *    05 WS-NOMBRE     PIC X(20).
      *    05 WS-APELLIDO   PIC X(20).
      *    05 WS-PAIS       PIC X(05).
      *    05 WS-TELEFONO   PIC X(15).
      *01  WS-CUENTA-CAMPOS PIC 9(03) VALUE ZEROS.
      *01  WS-DELIM         PIC X(01) VALUE SPACES.
      *01  WS-SEP           PIC X(60) VALUE ALL "-".

       PROCEDURE DIVISION.
      *> === PASO 3: Abrir archivo ===
      *> Descomenta las siguientes 6 líneas:
      *MAIN.
      *    DISPLAY "=== PARSEADOR CSV ===".
      *    DISPLAY " ".
      *    OPEN INPUT DATOS.
      *    IF NOT DATOS-OK
      *        DISPLAY "ERROR: datos.dat no encontrado"
      *        STOP RUN

      *> === PASO 4: Leer y parsear cada línea ===
      *> Descomenta las siguientes 21 líneas:
      *    END-IF.
      *    DISPLAY "Nombre             Apellido    Pais  Telefono".
      *    DISPLAY WS-SEP.
      *    PERFORM UNTIL DATOS-EOF
      *        READ DATOS
      *            AT END SET DATOS-EOF TO TRUE
      *            NOT AT END
      *                ADD 1 TO WS-CONT-REG
      *                MOVE SPACES TO WS-CAMPOS
      *                MOVE ZEROS TO WS-CUENTA-CAMPOS
      *                UNSTRING REG-DATOS
      *                    DELIMITED BY ","
      *                    INTO WS-NOMBRE   DELIMITER IN WS-DELIM
      *                         WS-APELLIDO
      *                         WS-PAIS
      *                         WS-TELEFONO
      *                    TALLYING IN WS-CUENTA-CAMPOS
      *                END-UNSTRING

      *> === PASO 5: Mostrar resultado del parseo ===
      *> Descomenta las siguientes 7 líneas:
      *                DISPLAY FUNCTION TRIM(WS-NOMBRE) "  "
      *                        FUNCTION TRIM(WS-APELLIDO) "  "
      *                        FUNCTION TRIM(WS-PAIS) "  "
      *                        FUNCTION TRIM(WS-TELEFONO)
      *        END-READ
      *    END-PERFORM.
      *    DISPLAY WS-SEP.

      *> === PASO 6: Cerrar y mostrar resumen ===
      *> Descomenta las siguientes 3 líneas:
      *    DISPLAY "Lineas procesadas: " WS-CONT-REG.
      *    CLOSE DATOS.
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Nombre    Apellido   Pais  Telefono
      *> Juan      Perez      MX    555-0101
      *> Maria     Garcia     AR    555-0102
      *> ...
      *> Lineas procesadas: 005
