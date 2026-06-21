       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Mantenimiento CRUD
      *> ============================================
      *> ACCESS MODE DYNAMIC: consultar, modificar,
      *> eliminar, listar rango con START.
      *>
      *> REQUIERE: clientes.idx
      *> Compilar: cobc -x -free mantenimiento.cbl
      *> Ejecutar: ./mantenimiento

       IDENTIFICATION DIVISION.
       PROGRAM-ID. MANTE.

      *> === PASO 1: DYNAMIC para máxima flexibilidad ===
      *> Descomenta las siguientes 10 líneas:
      *ENVIRONMENT DIVISION.
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *    SELECT CLIENTES ASSIGN TO "clientes.idx"
      *        ORGANIZATION IS INDEXED
      *        ACCESS MODE IS DYNAMIC
      *        RECORD KEY IS CLI-ID
      *        FILE STATUS IS WS-FS-CLI.
      *DATA DIVISION.
      *FILE SECTION.

      *> === PASO 2: FD y WORKING-STORAGE ===
      *> Descomenta las siguientes 19 líneas:
      *FD  CLIENTES.
      *01  CLI-REG.
      *    05 CLI-ID       PIC 9(05).
      *    05 CLI-NOMBRE   PIC X(25).
      *    05 CLI-SALDO    PIC 9(07)V99.
      *WORKING-STORAGE SECTION.
      *01  WS-FS-CLI        PIC X(02).
      *    88 CLI-OK        VALUE "00".
      *    88 CLI-EOF       VALUE "10".
      *    88 CLI-NOT-FOUND VALUE "23".
      *01  WS-OPCION        PIC 9 VALUE ZEROS.
      *01  WS-ID            PIC 9(05) VALUE ZEROS.
      *01  WS-SALDO-EDIT    PIC $$,$$9.99.
      *01  WS-NUEVO-SALDO   PIC 9(07)V99 VALUE ZEROS.

       PROCEDURE DIVISION.
      *> === PASO 3: Menú principal ===
      *> Descomenta las siguientes 18 líneas:
      *MAIN.
      *    OPEN I-O CLIENTES.
      *    DISPLAY "=== MANTENIMIENTO DE CLIENTES (DYNAMIC) ===".
      *    PERFORM UNTIL WS-OPCION = 9
      *        DISPLAY " ".
      *        DISPLAY "1. Consultar por ID".
      *        DISPLAY "2. Modificar saldo (+10%)".
      *        DISPLAY "3. Eliminar cliente".
      *        DISPLAY "4. Listar desde ID (START)".
      *        DISPLAY "9. Salir".
      *        DISPLAY "Opcion: " WITH NO ADVANCING.
      *        ACCEPT WS-OPCION.
      *        EVALUATE WS-OPCION
      *            WHEN 1 PERFORM 2000-CONSULTAR
      *            WHEN 2 PERFORM 3000-MODIFICAR
      *            WHEN 3 PERFORM 4000-ELIMINAR
      *            WHEN 4 PERFORM 5000-LISTAR
      *        END-EVALUATE
      *    END-PERFORM.

      *> === PASO 4: Consultar ===
      *> Descomenta las siguientes 11 líneas:
      *    CLOSE CLIENTES.
      *    STOP RUN.
      *2000-CONSULTAR.
      *    DISPLAY "ID a consultar: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    READ CLIENTES KEY IS WS-ID
      *        INVALID KEY DISPLAY "No encontrado"
      *        NOT INVALID KEY
      *            MOVE CLI-SALDO TO WS-SALDO-EDIT
      *            DISPLAY CLI-ID " " CLI-NOMBRE " " WS-SALDO-EDIT
      *    END-READ.

      *> === PASO 5: Modificar (READ + REWRITE) ===
      *> Descomenta las siguientes 14 líneas:
      *3000-MODIFICAR.
      *    DISPLAY "ID a modificar: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    READ CLIENTES KEY IS WS-ID
      *        INVALID KEY DISPLAY "No encontrado"
      *        NOT INVALID KEY
      *            MOVE CLI-SALDO TO WS-SALDO-EDIT
      *            DISPLAY "Saldo actual: " WS-SALDO-EDIT
      *            COMPUTE CLI-SALDO ROUNDED = CLI-SALDO * 1.10
      *            REWRITE CLI-REG
      *                INVALID KEY DISPLAY "Error al modificar"
      *                NOT INVALID KEY
      *                    MOVE CLI-SALDO TO WS-SALDO-EDIT
      *                    DISPLAY "Nuevo saldo : " WS-SALDO-EDIT
      *            END-REWRITE
      *    END-READ.

      *> === PASO 6: Eliminar (READ + DELETE) ===
      *> Descomenta las siguientes 9 líneas:
      *4000-ELIMINAR.
      *    DISPLAY "ID a eliminar: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    READ CLIENTES KEY IS WS-ID
      *        INVALID KEY DISPLAY "No encontrado"
      *        NOT INVALID KEY
      *            DELETE CLIENTES RECORD
      *                INVALID KEY DISPLAY "Error al eliminar"
      *                NOT INVALID KEY DISPLAY "Eliminado"
      *            END-DELETE
      *    END-READ.

      *> === PASO 7: START + READ NEXT (rango) ===
      *> Descomenta las siguientes 15 líneas:
      *5000-LISTAR.
      *    DISPLAY "Listar desde ID: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    START CLIENTES KEY IS GREATER THAN OR EQUAL TO WS-ID
      *        INVALID KEY DISPLAY "No hay registros desde ese ID"
      *        NOT INVALID KEY
      *            DISPLAY "ID     Nombre                    Saldo".
      *            DISPLAY "-----  -------------------------  ----------".
      *            PERFORM UNTIL CLI-EOF
      *                READ CLIENTES NEXT RECORD
      *                    AT END SET CLI-EOF TO TRUE
      *                    NOT AT END
      *                        MOVE CLI-SALDO TO WS-SALDO-EDIT
      *                        DISPLAY CLI-ID "  " CLI-NOMBRE
      *                                "  " WS-SALDO-EDIT
      *                END-READ
      *            END-PERFORM
      *    END-START.
      *    MOVE "N" TO WS-FS-CLI.   *> Reset EOF flag

      *> === RESULTADO ESPERADO ===
      *> Opción 2 con ID=202:
      *>   Saldo actual: $ 25,000.00
      *>   Nuevo saldo : $ 27,500.00
      *>
      *> Opción 4 desde ID=300:
      *>   00303 Carlos Lopez    $ 10,000.75
      *>   00404 Ana Martinez    $ 50,000.00
      *>   00505 Pedro Rodriguez $  3,500.25
