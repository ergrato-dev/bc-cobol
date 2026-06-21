       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO FINAL - Consulta Online (CICS simulado)
      *> ============================================
      *> Sistema interactivo con 3 pantallas simulando
      *> CICS: Menu, Consulta, Resultado.
      *> Usa cuentas.idx como fuente de datos.
      *>
      *> Compilar: cobc -x -free -I copybooks consulta-online.cbl -o consulta
      *> Ejecutar: ./consulta

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSULTA.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MAE-FILE  ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  MAE-FILE. COPY "copybooks/cuentas.cpy".

       WORKING-STORAGE SECTION.
       COPY "copybooks/errores.cpy".

       01  WS-ESTADO         PIC X(01) VALUE "1".
           88 ST-MENU        VALUE "1".
           88 ST-CONSULTA    VALUE "2".
           88 ST-RESULTADO   VALUE "3".
           88 ST-SQL         VALUE "4".

       01  WS-OPCION         PIC 9 VALUE ZEROS.
       01  WS-SALIR          PIC X(01) VALUE "N".
       01  WS-CUENTA-BUSCAR  PIC 9(05) VALUE ZEROS.
       01  WS-SALDO-EDIT     PIC $$,$$$,$$9.99.
       01  WS-SEP            PIC X(42) VALUE ALL "=".
       01  WS-SUBSEP         PIC X(42) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT MAE-FILE.

      *> Simulacion de COMMAREA: loop con variable de estado
           PERFORM UNTIL WS-SALIR = "S"
               EVALUATE TRUE
                   WHEN ST-MENU
                       PERFORM 1000-PANTALLA-MENU
                   WHEN ST-CONSULTA
                       PERFORM 2000-PANTALLA-CONSULTA
                   WHEN ST-RESULTADO
                       PERFORM 3000-PANTALLA-RESULTADO
                   WHEN ST-SQL
                       PERFORM 4000-PANTALLA-SQL
               END-EVALUATE
           END-PERFORM.

           CLOSE MAE-FILE.
           STOP RUN.

       1000-PANTALLA-MENU.
           DISPLAY " ".
           DISPLAY "+==========================================+".
           DISPLAY "|  SISTEMA BANCARIO - CONSULTA ONLINE     |".
           DISPLAY "+==========================================+".
           DISPLAY "|                                          |".
           DISPLAY "|  1. Consultar saldo por cuenta           |".
           DISPLAY "|  2. Buscar cliente (SQL)                 |".
           DISPLAY "|  9. Salir                                |".
           DISPLAY "|                                          |".
           DISPLAY "+==========================================+".
           DISPLAY "Opcion: " WITH NO ADVANCING.
           ACCEPT WS-OPCION.

           EVALUATE WS-OPCION
               WHEN 1 MOVE "2" TO WS-ESTADO
               WHEN 2 MOVE "4" TO WS-ESTADO
               WHEN 9 MOVE "S" TO WS-SALIR
           END-EVALUATE.

       2000-PANTALLA-CONSULTA.
           DISPLAY " ".
           DISPLAY "+------------------------------------------+".
           DISPLAY "|  CONSULTA DE SALDO                      |".
           DISPLAY "+------------------------------------------+".
           DISPLAY "|  Ingrese numero de cuenta (0=Volver):    |".
           DISPLAY "+------------------------------------------+".
           DISPLAY "Cuenta: " WITH NO ADVANCING.
           ACCEPT WS-CUENTA-BUSCAR.

           IF WS-CUENTA-BUSCAR = 0
               MOVE "1" TO WS-ESTADO
           ELSE
               MOVE "3" TO WS-ESTADO
           END-IF.

       3000-PANTALLA-RESULTADO.
           MOVE WS-CUENTA-BUSCAR TO CTA-ID.
           READ MAE-FILE KEY IS CTA-ID
               INVALID KEY
                   DISPLAY " ".
                   DISPLAY "*** CUENTA NO ENCONTRADA ***"
               NOT INVALID KEY
                   IF CTA-ACTIVA
                       MOVE CTA-SALDO TO WS-SALDO-EDIT
                       DISPLAY " ".
                       DISPLAY "+==========================================+".
                       DISPLAY "|  RESULTADO DE CONSULTA                  |".
                       DISPLAY "+==========================================+".
                       DISPLAY "|  Cuenta: " CTA-ID.
                       DISPLAY "|  Nombre: " CTA-NOMBRE.
                       DISPLAY "|  Tipo  : " CTA-TIPO.
                       DISPLAY "|  Saldo : " WS-SALDO-EDIT.
                       DISPLAY "|  Estado: ACTIVA".
                       DISPLAY "+==========================================+".
                   ELSE
                       DISPLAY "*** CUENTA INACTIVA ***".
           END-READ.

           DISPLAY " ".
           DISPLAY "Presione Enter para continuar...".
           ACCEPT WS-OPCION.
           MOVE "1" TO WS-ESTADO.

       4000-PANTALLA-SQL.
           DISPLAY " ".
           DISPLAY "+------------------------------------------+".
           DISPLAY "|  CONSULTA SQL (PostgreSQL)              |".
           DISPLAY "+------------------------------------------+".
           DISPLAY "|  ID Cliente:                             |".
           DISPLAY "+------------------------------------------+".
           DISPLAY "ID: " WITH NO ADVANCING.
           ACCEPT WS-CUENTA-BUSCAR.
           DISPLAY " ".
           DISPLAY "(En produccion: EXEC SQL SELECT...)". 
           DISPLAY "Datos simulados para ID " WS-CUENTA-BUSCAR.
           DISPLAY "Presione Enter para continuar...".
           ACCEPT WS-OPCION.
           MOVE "1" TO WS-ESTADO.
