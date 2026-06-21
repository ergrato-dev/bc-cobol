       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Consulta con SEND/RECEIVE MAP
      *> ============================================
      *> Simula RECEIVE MAP (pide cuenta) y
      *> SEND MAP (muestra resultado).
      *>
      *> Compilar: cobc -x -free consulta-cics.cbl
      *> Ejecutar: ./consulta-cics

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSCICS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> Simulación de MAP de entrada (RECEIVE MAP → INTO)
       01  WS-MAP-ENTRADA.
           05 WS-ME-CUENTA    PIC X(08).      *> Campo input

      *> Simulación de MAP de salida (SEND MAP → FROM)
       01  WS-MAP-SALIDA.
           05 WS-MS-TITULO    PIC X(30) VALUE "    CONSULTA DE CUENTA".
           05 WS-MS-CUENTA    PIC X(08).
           05 WS-MS-NOMBRE    PIC X(30).

      *> Datos simulados
       01  WS-CUENTA-NUM     PIC 9(05) VALUE ZEROS.
       01  WS-CUENTA-NOM     PIC X(30).
       01  WS-RESP           PIC 9(02) VALUE ZEROS.
       01  WS-SEP            PIC X(50) VALUE ALL "=".

       PROCEDURE DIVISION.
       MAIN.
      *> === SEND MAP (mostrar pantalla inicial) ===
      *> EXEC CICS SEND MAP("CONSULTA") MAPSET("BANCO") ERASE END-EXEC
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════════╗".
           DISPLAY "║     CONSULTA DE CUENTA              ║".
           DISPLAY "╠══════════════════════════════════════╣".
           DISPLAY "║                                      ║".

      *> === RECEIVE MAP (leer entrada del usuario) ===
      *> EXEC CICS RECEIVE MAP("CONSULTA") INTO(MAP-ENTRADA) RESP(RESP)
           DISPLAY "║ Ingrese numero de cuenta:            ║".
           DISPLAY "╚══════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Cuenta: " WITH NO ADVANCING.
           ACCEPT WS-CUENTA-NUM.

      *> Validar entrada (simular RESP)
           IF WS-CUENTA-NUM = 0
               MOVE 1 TO WS-RESP
               DISPLAY "ERROR: Cuenta invalida"
           END-IF.

      *> Buscar cuenta (simular EXEC CICS READ FILE)
           EVALUATE WS-CUENTA-NUM
               WHEN 101
                   MOVE "Juan Perez" TO WS-CUENTA-NOM
               WHEN 202
                   MOVE "Maria Garcia" TO WS-CUENTA-NOM
               WHEN OTHER
                   MOVE "NO ENCONTRADA" TO WS-CUENTA-NOM
           END-EVALUATE.

      *> === SEND MAP (mostrar resultado) ===
      *> EXEC CICS SEND MAP("RESULT") MAPSET("BANCO") FROM(MAP-SALIDA)
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════════╗".
           DISPLAY "║     RESULTADO DE CONSULTA           ║".
           DISPLAY "╠══════════════════════════════════════╣".
           DISPLAY "║ Cuenta: " WS-CUENTA-NUM.
           DISPLAY "║ Nombre: " WS-CUENTA-NOM.
           DISPLAY "╚══════════════════════════════════════╝".

           STOP RUN.
