       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Pseudo-Conversación (COMMAREA)
      *> ============================================
      *> Simula flujo multi-pantalla con variable
      *> de estado (COMMAREA simulada).
      *>
      *> Compilar: cobc -x -free transaccion-cics.cbl
      *> Ejecutar: ./transaccion-cics

       IDENTIFICATION DIVISION.
       PROGRAM-ID. PSEUDO.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> Simulación de DFHCOMMAREA
       01  WS-COMMAREA.
           05 CA-ESTADO       PIC X(01) VALUE "1".
               88 CA-MENU     VALUE "1".
               88 CA-ENTRADA  VALUE "2".
               88 CA-RESULT   VALUE "3".
           05 CA-CUENTA       PIC 9(05) VALUE ZEROS.
           05 CA-SALDO        PIC 9(07)V99 VALUE ZEROS.
           05 CA-OPCION       PIC 9 VALUE ZEROS.

       01  WS-SALIR           PIC X(01) VALUE "N".
           88 TERMINAR        VALUE "S".
       01  WS-SALDO-EDIT      PIC $$,$$9.99.
       01  WS-SEP             PIC X(50) VALUE ALL "=".

       PROCEDURE DIVISION.
       MAIN.
      *> En CICS: EXEC CICS ADDRESS COMMAREA(WS-COMMAREA) END-EXEC
      *> Simulación: loop con variable de estado

           DISPLAY WS-SEP.
           DISPLAY "    SISTEMA CICS SIMULADO - PSEUDO-CONVERSACION".
           DISPLAY WS-SEP.

           PERFORM UNTIL TERMINAR
               EVALUATE TRUE
                   WHEN CA-MENU
                       PERFORM 1000-MOSTRAR-MENU
                   WHEN CA-ENTRADA
                       PERFORM 2000-CAPTURAR-CUENTA
                   WHEN CA-RESULT
                       PERFORM 3000-MOSTRAR-RESULTADO
               END-EVALUATE
           END-PERFORM.
           STOP RUN.

       1000-MOSTRAR-MENU.
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════╗".
           DISPLAY "║   MENU PRINCIPAL                ║".
           DISPLAY "╠══════════════════════════════════╣".
           DISPLAY "║ 1. Consultar saldo              ║".
           DISPLAY "║ 9. Salir                        ║".
           DISPLAY "╚══════════════════════════════════╝".
           DISPLAY "Opcion: " WITH NO ADVANCING.
           ACCEPT CA-OPCION.

      *> Simular RETURN TRANSID con COMMAREA
           EVALUATE CA-OPCION
               WHEN 1
                   MOVE "2" TO CA-ESTADO     *> Siguiente estado
               WHEN 9
                   MOVE "S" TO WS-SALIR
               WHEN OTHER
                   DISPLAY "Opcion invalida"
           END-EVALUATE.

       2000-CAPTURAR-CUENTA.
           DISPLAY " ".
           DISPLAY "--- CONSULTA DE SALDO ---".
           DISPLAY "Cuenta (0=volver): " WITH NO ADVANCING.
           ACCEPT CA-CUENTA.
           IF CA-CUENTA = 0
               MOVE "1" TO CA-ESTADO
           ELSE
               EVALUATE CA-CUENTA
                   WHEN 101 MOVE 15000.50 TO CA-SALDO
                   WHEN 202 MOVE 25000.00 TO CA-SALDO
                   WHEN 303 MOVE 10000.75 TO CA-SALDO
                   WHEN OTHER MOVE 0 TO CA-SALDO
               END-EVALUATE
               MOVE "3" TO CA-ESTADO     *> Siguiente estado
           END-IF.

       3000-MOSTRAR-RESULTADO.
           MOVE CA-SALDO TO WS-SALDO-EDIT.
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════╗".
           DISPLAY "║   RESULTADO DE CONSULTA         ║".
           DISPLAY "╠══════════════════════════════════╣".
           IF CA-SALDO = 0
               DISPLAY "║ CUENTA NO ENCONTRADA            ║"
           ELSE
               DISPLAY "║ Cuenta: " CA-CUENTA.
               DISPLAY "║ Saldo : " WS-SALDO-EDIT
           END-IF.
           DISPLAY "╚══════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Presione Enter para volver...".
           ACCEPT CA-OPCION FROM CONSOLE.
           MOVE "1" TO CA-ESTADO.         *> Volver a menú

      *> Resultado: flujo Menu→Capturar cuenta→Mostrar saldo→Menu
