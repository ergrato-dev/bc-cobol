       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Consulta Aleatoria
      *> ============================================
      *> Usa ACCESS MODE RANDOM para consultar
      *> por ID específico.
      *>
      *> REQUIERE: clientes.idx (ejecutar crear-indexado primero)
      *> Compilar: cobc -x -free consulta-aleatoria.cbl
      *> Ejecutar: ./consulta-aleatoria

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSULTA.

      *> === PASO 1: Declarar archivo con ACCESS RANDOM ===
      *> Descomenta las siguientes 15 líneas:
      *ENVIRONMENT DIVISION.
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *    SELECT CLIENTES ASSIGN TO "clientes.idx"
      *        ORGANIZATION IS INDEXED
      *        ACCESS MODE IS RANDOM
      *        RECORD KEY IS CLI-ID
      *        FILE STATUS IS WS-FS-CLI.
      *DATA DIVISION.
      *FILE SECTION.
      *FD  CLIENTES.
      *01  CLI-REG.
      *    05 CLI-ID       PIC 9(05).
      *    05 CLI-NOMBRE   PIC X(25).
      *    05 CLI-SALDO    PIC 9(07)V99.

      *> === PASO 2: WORKING-STORAGE ===
      *> Descomenta las siguientes 8 líneas:
      *WORKING-STORAGE SECTION.
      *01  WS-FS-CLI        PIC X(02).
      *    88 CLI-OK        VALUE "00".
      *    88 CLI-NOT-FOUND VALUE "23".
      *    88 CLI-NO-FILE   VALUE "35".
      *01  WS-ID-BUSCAR     PIC 9(05) VALUE ZEROS.
      *01  WS-SALDO-EDIT    PIC $$,$$9.99.
      *01  WS-OPCION        PIC 9 VALUE ZEROS.

      *> === PASO 3: Loop de consulta ===
      *> Descomenta las siguientes 11 líneas:
      *PROCEDURE DIVISION.
      *MAIN.
      *    OPEN INPUT CLIENTES.
      *    IF CLI-NO-FILE
      *        DISPLAY "ERROR: clientes.idx no encontrado"
      *        DISPLAY "Ejecute primero: ./crear-indexado"
      *        STOP RUN
      *    END-IF.
      *    DISPLAY "=== CONSULTA DE CLIENTES ===".
      *    DISPLAY " ".
      *    PERFORM UNTIL WS-OPCION = 9
      *        DISPLAY "Ingrese ID (0=ver todos, 9=salir): "

      *> === PASO 4: Leer opción y consultar ===
      *> Descomenta las siguientes 22 líneas:
      *            WITH NO ADVANCING
      *        ACCEPT WS-ID-BUSCAR
      *        IF WS-ID-BUSCAR = 9
      *            MOVE 9 TO WS-OPCION
      *        ELSE
      *            IF WS-ID-BUSCAR = 0
      *                PERFORM 5000-LISTAR-TODOS
      *            ELSE
      *                READ CLIENTES KEY IS CLI-ID
      *                    INVALID KEY
      *                        DISPLAY "Cliente " WS-ID-BUSCAR
      *                                " no encontrado"
      *                    NOT INVALID KEY
      *                        MOVE CLI-SALDO TO WS-SALDO-EDIT
      *                        DISPLAY "=================================="
      *                        DISPLAY "ID     : " CLI-ID
      *                        DISPLAY "Nombre : " CLI-NOMBRE
      *                        DISPLAY "Saldo  : " WS-SALDO-EDIT
      *                        DISPLAY "=================================="
      *                END-READ
      *            END-IF
      *        END-IF.

      *> === PASO 5: Listar todos (cambia a INPUT secuencial) ===
      *> En modo RANDOM no podemos hacer READ NEXT directamente.
      *> Solución: cerramos y reabrimos, o usamos DYNAMIC.
      *> Aquí mostramos mensaje de limitación.
      *>
      *> Descomenta las siguientes 7 líneas:
      *    CLOSE CLIENTES.
      *    STOP RUN.
      *5000-LISTAR-TODOS.
      *    DISPLAY " ".
      *    DISPLAY "NOTA: ACCESS MODE RANDOM no permite READ NEXT.".
      *    DISPLAY "Use ACCESS MODE DYNAMIC para ambas operaciones.".
      *    DISPLAY " ".

      *> === RESULTADO ESPERADO (ID=303) ===
      *> ==================================
      *> ID     : 00303
      *> Nombre : Carlos Lopez
      *> Saldo  : $ 10,000.75
      *> ==================================
