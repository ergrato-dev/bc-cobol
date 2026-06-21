       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Cursor — Recorrer Clientes
      *> ============================================
      *> DECLARE CURSOR, OPEN, FETCH en loop, CLOSE.
      *>
      *> Compilar: cobc -x -free cursor-clientes.cbl
      *> Ejecutar: ./cursor-clientes

       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQLCUR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Host variables ===
      *> Descomenta las siguientes 8 líneas:
      *01  WS-CLI-ID        PIC 9(05).
      *01  WS-CLI-NOMBRE    PIC X(50).
      *01  WS-CLI-APELLIDO  PIC X(50).
      *01  WS-CLI-ESTADO    PIC X(01).
      *01  WS-SQLCODE       PIC S9(09) USAGE COMP.
      *    88 SQL-OK         VALUE 0.
      *    88 SQL-NOT-FOUND  VALUE 100.
      *01  WS-CONT          PIC 9(05) VALUE ZEROS.

      *> === PASO 2: Declarar cursor ===
      *> Descomenta las siguientes 6 líneas:
      *    EXEC SQL
      *        DECLARE C-CLIENTES CURSOR FOR
      *            SELECT ID_CLIENTE, NOMBRE, APELLIDO, ESTADO
      *            FROM CLIENTES
      *            ORDER BY APELLIDO, NOMBRE
      *    END-EXEC.

       PROCEDURE DIVISION.
      *> === PASO 3: Abrir cursor ===
      *> Descomenta las siguientes 11 líneas:
      *MAIN.
      *    DISPLAY "=== LISTADO DE CLIENTES (CURSOR) ===".
      *    DISPLAY " ".
      *    DISPLAY "ID     Nombre                  Estado".
      *    DISPLAY "-----  ----------------------  ------".
      *    EXEC SQL OPEN C-CLIENTES END-EXEC.
      *    IF NOT SQL-OK
      *        DISPLAY "Error abriendo cursor: " WS-SQLCODE
      *        STOP RUN
      *    END-IF.

      *> === PASO 4: FETCH en loop ===
      *> Descomenta las siguientes 16 líneas:
      *    PERFORM UNTIL SQL-NOT-FOUND
      *        EXEC SQL
      *            FETCH C-CLIENTES INTO
      *                :WS-CLI-ID, :WS-CLI-NOMBRE,
      *                :WS-CLI-APELLIDO, :WS-CLI-ESTADO
      *        END-EXEC
      *        EVALUATE TRUE
      *            WHEN SQL-OK
      *                ADD 1 TO WS-CONT
      *                IF WS-CLI-ESTADO = "A"
      *                    MOVE "ACTIVO" TO WS-CLI-ESTADO
      *                ELSE
      *                    MOVE "INACTIVO" TO WS-CLI-ESTADO
      *                END-IF
      *                DISPLAY WS-CLI-ID "  " WS-CLI-NOMBRE
      *                        "  " WS-CLI-ESTADO
      *            WHEN SQL-NOT-FOUND
      *                CONTINUE

      *> === PASO 5: Cerrar cursor ===
      *> Descomenta las siguientes 6 líneas:
      *            WHEN OTHER
      *                DISPLAY "Error FETCH: " WS-SQLCODE
      *        END-EVALUATE
      *    END-PERFORM.
      *    EXEC SQL CLOSE C-CLIENTES END-EXEC.
      *    DISPLAY "-----  ----------------------  ------".
      *    DISPLAY "Total clientes: " WS-CONT.
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> 1  Juan Perez        ACTIVO
      *> 3  Carlos Lopez      ACTIVO
      *> 2  Maria Garcia      ACTIVO
      *> ...
      *> Total clientes: 00005
