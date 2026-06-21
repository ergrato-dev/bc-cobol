       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Crear Archivo Indexado
      *> ============================================
      *> Crea clientes.idx y lo pobla con 5 registros.
      *> Demuestra RECORD KEY, WRITE, duplicados.
      *>
      *> Compilar: cobc -x -free crear-indexado.cbl
      *> Ejecutar: ./crear-indexado
      *> Genera:   clientes.idx

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREAIDX.

      *> === PASO 1: ENVIRONMENT y FILE-CONTROL ===
      *> Descomenta las siguientes 10 líneas:
      *ENVIRONMENT DIVISION.
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *    SELECT CLIENTES ASSIGN TO "clientes.idx"
      *        ORGANIZATION IS INDEXED
      *        ACCESS MODE IS SEQUENTIAL
      *        RECORD KEY IS CLI-ID
      *        FILE STATUS IS WS-FS-CLI.
      *DATA DIVISION.
      *FILE SECTION.
      *FD  CLIENTES.

      *> === PASO 2: Layout y WORKING-STORAGE ===
      *> Descomenta las siguientes 12 líneas:
      *01  CLI-REG.
      *    05 CLI-ID       PIC 9(05).
      *    05 CLI-NOMBRE   PIC X(25).
      *    05 CLI-SALDO    PIC 9(07)V99.
      *WORKING-STORAGE SECTION.
      *01  WS-FS-CLI        PIC X(02).
      *    88 CLI-OK        VALUE "00".
      *    88 CLI-DUP       VALUE "22".
      *01  WS-CONT          PIC 9(02) VALUE ZEROS.
      *01  WS-I             PIC 9(02) VALUE ZEROS.

      *> === PASO 3: Abrir y escribir registros ===
      *> Descomenta las siguientes 20 líneas:
      *PROCEDURE DIVISION.
      *MAIN.
      *    DISPLAY "=== CREANDO ARCHIVO INDEXADO ===".
      *    OPEN OUTPUT CLIENTES.
      *    IF NOT CLI-OK
      *        DISPLAY "ERROR al crear archivo: " WS-FS-CLI
      *        STOP RUN
      *    END-IF.
      *    MOVE 101 TO CLI-ID.
      *    MOVE "Juan Perez" TO CLI-NOMBRE.
      *    MOVE 15000.00 TO CLI-SALDO.
      *    WRITE CLI-REG.
      *    IF CLI-DUP
      *        DISPLAY "ID duplicado: " CLI-ID
      *    END-IF.
      *    ADD 1 TO WS-CONT.

      *> === PASO 4: Escribir más registros ===
      *> Descomenta las siguientes 28 líneas:
      *    MOVE 202 TO CLI-ID.
      *    MOVE "Maria Garcia" TO CLI-NOMBRE.
      *    MOVE 25000.00 TO CLI-SALDO.
      *    WRITE CLI-REG.
      *    ADD 1 TO WS-CONT.
      *    MOVE 303 TO CLI-ID.
      *    MOVE "Carlos Lopez" TO CLI-NOMBRE.
      *    MOVE 10000.75 TO CLI-SALDO.
      *    WRITE CLI-REG.
      *    ADD 1 TO WS-CONT.
      *    MOVE 404 TO CLI-ID.
      *    MOVE "Ana Martinez" TO CLI-NOMBRE.
      *    MOVE 50000.00 TO CLI-SALDO.
      *    WRITE CLI-REG.
      *    ADD 1 TO WS-CONT.
      *    MOVE 505 TO CLI-ID.
      *    MOVE "Pedro Rodriguez" TO CLI-NOMBRE.
      *    MOVE 3500.25 TO CLI-SALDO.
      *    WRITE CLI-REG.
      *    ADD 1 TO WS-CONT.

      *> === PASO 5: Intentar duplicado y cerrar ===
      *> Descomenta las siguientes 10 líneas:
      *    DISPLAY " ".
      *    DISPLAY "Intentando insertar ID 303 (duplicado)...".
      *    MOVE 303 TO CLI-ID.
      *    MOVE "Duplicado" TO CLI-NOMBRE.
      *    MOVE 0 TO CLI-SALDO.
      *    WRITE CLI-REG.
      *    IF CLI-DUP
      *        DISPLAY "ERROR: ID 303 ya existe (STATUS 22)".
      *    END-IF.
      *    DISPLAY "Registros insertados: " WS-CONT.

      *> === PASO 6: Recorrer secuencialmente ===
      *> Leer todos los registros para verificar orden
      *>
      *> Descomenta las siguientes 15 líneas:
      *    CLOSE CLIENTES.
      *    DISPLAY " ".
      *    DISPLAY "--- Verificando archivo ---".
      *    OPEN INPUT CLIENTES.
      *    PERFORM UNTIL WS-I >= 5
      *        READ CLIENTES NEXT RECORD
      *            AT END
      *                MOVE 99 TO WS-I
      *            NOT AT END
      *                ADD 1 TO WS-I
      *                DISPLAY CLI-ID " " CLI-NOMBRE " " CLI-SALDO
      *        END-READ
      *    END-PERFORM.
      *    CLOSE CLIENTES.
      *    DISPLAY "Archivo creado: clientes.idx".
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Nota: los registros se muestran ordenados por clave
      *> 00101 Juan Perez 00001500000
      *> 00202 Maria Garcia 00002500000
      *> 00303 Carlos Lopez 00001000075
      *> 00404 Ana Martinez 00005000000
      *> 00505 Pedro Rodriguez 00000350025
