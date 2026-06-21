       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: SEARCH vs SEARCH ALL
      *> ============================================
      *> Compara búsqueda secuencial (SEARCH) y
      *> binaria (SEARCH ALL) en tabla de clientes.
      *>
      *> Compilar: cobc -x -free busqueda-cliente.cbl
      *> Ejecutar: ./busqueda-cliente

       IDENTIFICATION DIVISION.
       PROGRAM-ID. BUSCAR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Dos tablas — una ordenada, otra no ===
      *> Descomenta las siguientes 16 líneas:
      *01  WS-CLIENTES.
      *    05 WS-CLI OCCURS 8 TIMES
      *        ASCENDING KEY IS WS-CLI-ID
      *        INDEXED BY CLI-IDX.
      *       10 WS-CLI-ID     PIC 9(05).
      *       10 WS-CLI-NOMBRE PIC X(25).
      *       10 WS-CLI-SALDO  PIC 9(07)V99.
      *01  WS-I             PIC 9(03) VALUE ZEROS.
      *01  WS-ID-BUSCAR     PIC 9(05) VALUE ZEROS.
      *01  WS-CONT-COMP     PIC 9(05) VALUE ZEROS.  *> Contador comparaciones
      *01  WS-SALDO-EDIT    PIC $$,$$9.99.
      *01  WS-SEP           PIC X(50) VALUE ALL "=".

       PROCEDURE DIVISION.
      *> === PASO 2: Cargar datos ORDENADOS por ID ===
      *> CLAVE: los IDs deben estar en orden para SEARCH ALL
      *>
      *> Descomenta las siguientes 26 líneas:
      *MAIN.
      *    MOVE 00101 TO WS-CLI-ID(1).
      *    MOVE "Juan Perez" TO WS-CLI-NOMBRE(1).
      *    MOVE 15000.00 TO WS-CLI-SALDO(1).
      *    MOVE 00102 TO WS-CLI-ID(2).
      *    MOVE "Maria Garcia" TO WS-CLI-NOMBRE(2).
      *    MOVE 25000.00 TO WS-CLI-SALDO(2).
      *    MOVE 00201 TO WS-CLI-ID(3).
      *    MOVE "Carlos Lopez" TO WS-CLI-NOMBRE(3).
      *    MOVE 10000.75 TO WS-CLI-SALDO(3).
      *    MOVE 00202 TO WS-CLI-ID(4).
      *    MOVE "Ana Martinez" TO WS-CLI-NOMBRE(4).
      *    MOVE 50000.00 TO WS-CLI-SALDO(4).
      *    MOVE 00301 TO WS-CLI-ID(5).
      *    MOVE "Luis Diaz" TO WS-CLI-NOMBRE(5).
      *    MOVE 7500.00 TO WS-CLI-SALDO(5).
      *    MOVE 00302 TO WS-CLI-ID(6).
      *    MOVE "Elena Rojas" TO WS-CLI-NOMBRE(6).
      *    MOVE 32000.00 TO WS-CLI-SALDO(6).
      *    MOVE 00401 TO WS-CLI-ID(7).
      *    MOVE "Pedro Solis" TO WS-CLI-NOMBRE(7).
      *    MOVE 18000.00 TO WS-CLI-SALDO(7).
      *    MOVE 00402 TO WS-CLI-ID(8).
      *    MOVE "Sofia Rios" TO WS-CLI-NOMBRE(8).
      *    MOVE 42000.00 TO WS-CLI-SALDO(8).

      *> === PASO 3: Mostrar tabla y buscar con SEARCH ALL ===
      *> Descomenta las siguientes 23 líneas:
      *    DISPLAY WS-SEP.
      *    DISPLAY "    BUSQUEDA DE CLIENTES (SEARCH ALL)".
      *    DISPLAY WS-SEP.
      *    DISPLAY " ".
      *    DISPLAY "Clientes cargados:".
      *    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 8
      *        DISPLAY "  " WS-CLI-ID(WS-I) " "
      *                WS-CLI-NOMBRE(WS-I)
      *    END-PERFORM.
      *    DISPLAY " ".
      *    PERFORM UNTIL WS-ID-BUSCAR = 999
      *        DISPLAY "ID a buscar (0=salir): "
      *                WITH NO ADVANCING
      *        ACCEPT WS-ID-BUSCAR
      *        IF WS-ID-BUSCAR = 0
      *            MOVE 999 TO WS-ID-BUSCAR
      *        ELSE
      *            SEARCH ALL WS-CLI
      *                AT END
      *                    DISPLAY "  Cliente no encontrado"
      *                WHEN WS-CLI-ID(CLI-IDX) = WS-ID-BUSCAR
      *                    MOVE WS-CLI-SALDO(CLI-IDX)
      *                        TO WS-SALDO-EDIT
      *                    DISPLAY "  Encontrado: "
      *                            WS-CLI-NOMBRE(CLI-IDX)
      *                            " Saldo: " WS-SALDO-EDIT
      *            END-SEARCH
      *        END-IF
      *    END-PERFORM.

      *> === PASO 4: Demostrar SEARCH secuencial ===
      *> Descomenta las siguientes 18 líneas:
      *    DISPLAY " ".
      *    DISPLAY WS-SEP.
      *    DISPLAY "Demostracion SEARCH secuencial".
      *    DISPLAY "(busca primer cliente con saldo > 20000)".
      *    MOVE 0 TO WS-CONT-COMP.
      *    SET CLI-IDX TO 1.
      *    SEARCH WS-CLI
      *        AT END
      *            DISPLAY "  Ninguno supera 20000"
      *        WHEN WS-CLI-SALDO(CLI-IDX) > 20000
      *            ADD 1 TO WS-CONT-COMP
      *            DISPLAY "  Encontrado: "
      *                    WS-CLI-NOMBRE(CLI-IDX)
      *            DISPLAY "  Comparaciones: " WS-CONT-COMP
      *    END-SEARCH.
      *    DISPLAY " ".
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Al buscar ID=00302:
      *>   Encontrado: Elena Rojas Saldo: $ 32,000.00
      *> SEARCH secuencial:
      *>   Encontrado: Maria Garcia (primera con saldo>20000)
