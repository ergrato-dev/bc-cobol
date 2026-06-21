       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> SUBPROGRAMA: FECHA-UTIL
      *> Utilidad de validación y formateo de fechas
      *> ============================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FECHAUTIL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TEMP-ANO     PIC 9(04).
       01  WS-TEMP-MES     PIC 9(02).
       01  WS-TEMP-DIA     PIC 9(02).

       LINKAGE SECTION.
       01  LK-FECHA-ENT    PIC 9(08).       *> YYYYMMDD
       01  LK-ES-VALIDA    PIC X(01).       *> S/N
       01  LK-FECHA-EDIT    PIC X(10).       *> DD/MM/YYYY

       PROCEDURE DIVISION USING LK-FECHA-ENT
                                LK-ES-VALIDA
                                LK-FECHA-EDIT.
       MAIN.
           MOVE "N" TO LK-ES-VALIDA.
           MOVE SPACES TO LK-FECHA-EDIT.

      *> Extraer partes
           MOVE LK-FECHA-ENT(1:4) TO WS-TEMP-ANO.
           MOVE LK-FECHA-ENT(5:2) TO WS-TEMP-MES.
           MOVE LK-FECHA-ENT(7:2) TO WS-TEMP-DIA.

      *> Validar rangos básicos
           IF WS-TEMP-ANO >= 1900 AND WS-TEMP-ANO <= 2100
               AND WS-TEMP-MES >= 1 AND WS-TEMP-MES <= 12
               AND WS-TEMP-DIA >= 1 AND WS-TEMP-DIA <= 31
               MOVE "S" TO LK-ES-VALIDA
      *>        Formatear DD/MM/YYYY
               STRING LK-FECHA-ENT(7:2) DELIMITED BY SIZE
                      "/"              DELIMITED BY SIZE
                      LK-FECHA-ENT(5:2) DELIMITED BY SIZE
                      "/"              DELIMITED BY SIZE
                      LK-FECHA-ENT(1:4) DELIMITED BY SIZE
                      INTO LK-FECHA-EDIT
               END-STRING
           END-IF.

           EXIT PROGRAM.
