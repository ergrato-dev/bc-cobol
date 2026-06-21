       >>SOURCE FORMAT IS FREE
      *> PROGRAMA DE PRUEBA para fecha-util.cbl
      *> Compilar juntos: cobc -x -free fecha-util.cbl fecha-test.cbl -o fecha-test
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FECHATEST.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-FECHA-IN    PIC 9(08) VALUE 20260620.
       01  WS-VALIDO      PIC X(01).
       01  WS-FECHA-OUT   PIC X(10).

       PROCEDURE DIVISION.
           DISPLAY "Fecha entrada: " WS-FECHA-IN.
           CALL "FECHAUTIL" USING WS-FECHA-IN WS-VALIDO WS-FECHA-OUT.
           IF WS-VALIDO = "S"
               DISPLAY "Fecha valida: " WS-FECHA-OUT
           ELSE
               DISPLAY "Fecha invalida"
           END-IF.

      *> Probar fecha inválida
           MOVE 20260230 TO WS-FECHA-IN.
           CALL "FECHAUTIL" USING WS-FECHA-IN WS-VALIDO WS-FECHA-OUT.
           IF WS-VALIDO = "S"
               DISPLAY "Fecha valida: " WS-FECHA-OUT
           ELSE
               DISPLAY "Fecha invalida: " WS-FECHA-IN
           END-IF.
           STOP RUN.
