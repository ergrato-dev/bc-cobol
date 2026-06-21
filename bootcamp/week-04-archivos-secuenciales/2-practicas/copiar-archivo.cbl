       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Copiar Archivo
      *> ============================================
      *> Aprende OPEN INPUT/OUTPUT, READ, WRITE,
      *> FILE STATUS en entrada y salida.
      *>
      *> Compilar: cobc -x -free copiar-archivo.cbl
      *> Ejecutar: ./copiar-archivo
      *> Genera:   clientes_copia.dat

       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPIAR.

      *> === PASO 1: Declarar ambos archivos en FILE-CONTROL ===
      *> Descomenta las siguientes 13 líneas:
      *ENVIRONMENT DIVISION.
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *    SELECT CLIENTES-E ASSIGN TO "clientes.dat"
      *        ORGANIZATION IS LINE SEQUENTIAL
      *        FILE STATUS IS WS-FS-ENT.
      *    SELECT CLIENTES-S ASSIGN TO "clientes_copia.dat"
      *        ORGANIZATION IS LINE SEQUENTIAL
      *        FILE STATUS IS WS-FS-SAL.
      *DATA DIVISION.
      *FILE SECTION.
      *FD  CLIENTES-E.
      *01  REG-ENT          PIC X(39).

      *> === PASO 2: FD de salida y WORKING-STORAGE ===
      *> Descomenta las siguientes 20 líneas:
      *FD  CLIENTES-S.
      *01  REG-SAL          PIC X(39).
      *WORKING-STORAGE SECTION.
      *01  WS-FS-ENT         PIC X(02).
      *    88 ENT-OK         VALUE "00".
      *    88 ENT-EOF        VALUE "10".
      *    88 ENT-NO-FILE    VALUE "35".
      *01  WS-FS-SAL         PIC X(02).
      *    88 SAL-OK         VALUE "00".
      *01  WS-CONT-LEIDOS    PIC 9(05) VALUE ZEROS.
      *01  WS-CONT-ESCRITOS  PIC 9(05) VALUE ZEROS.
      *01  WS-REG-EDIT.
      *    05 WS-REG-ID      PIC 9(05).
      *    05 WS-REG-NOMBRE  PIC X(25).
      *    05 WS-REG-SALDO   PIC 9(07)V99.

      *> === PASO 3: Abrir archivos ===
      *> Descomenta las siguientes 13 líneas:
      *PROCEDURE DIVISION.
      *MAIN.
      *    DISPLAY "=== COPIADOR DE ARCHIVOS ===".
      *    DISPLAY " ".
      *    OPEN INPUT CLIENTES-E.
      *    IF ENT-NO-FILE
      *        DISPLAY "ERROR: clientes.dat no encontrado"
      *        STOP RUN
      *    END-IF.
      *    OPEN OUTPUT CLIENTES-S.
      *    IF NOT SAL-OK
      *        DISPLAY "ERROR: No se pudo crear clientes_copia.dat"
      *        CLOSE CLIENTES-E
      *        STOP RUN
      *    END-IF.

      *> === PASO 4: Leer y copiar ===
      *> WRITE ... FROM copia el contenido de una variable
      *>
      *> Descomenta las siguientes 11 líneas:
      *    PERFORM UNTIL ENT-EOF
      *        READ CLIENTES-E INTO WS-REG-EDIT
      *            AT END
      *                SET ENT-EOF TO TRUE
      *            NOT AT END
      *                ADD 1 TO WS-CONT-LEIDOS
      *                WRITE REG-SAL FROM WS-REG-EDIT
      *                IF SAL-OK
      *                    ADD 1 TO WS-CONT-ESCRITOS
      *                END-IF
      *        END-READ
      *    END-PERFORM.

      *> === PASO 5: Cerrar y mostrar resumen ===
      *> Descomenta las siguientes 7 líneas:
      *    CLOSE CLIENTES-E.
      *    CLOSE CLIENTES-S.
      *    DISPLAY " ".
      *    DISPLAY "Registros leidos  : " WS-CONT-LEIDOS.
      *    DISPLAY "Registros escritos: " WS-CONT-ESCRITOS.
      *    DISPLAY "Archivo generado  : clientes_copia.dat".
      *    STOP RUN.

      *> === VERIFICAR ===
      *> diff clientes.dat clientes_copia.dat
      *> (no debe mostrar diferencias)
