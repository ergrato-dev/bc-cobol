       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Procesador de Transacciones
      *> Semana 07 - Manipulación de Strings
      *> ============================================
      *> Lee transacciones.dat, parsea con UNSTRING,
      *> valida y separa en archivos de salida.
      *>
      *> Compilar: cobc -x -free procesador-transacciones.cbl
      *> Ejecutar: ./procesador-transacciones
      *> Entrada:  transacciones.dat
      *> Salida:   validas.dat, rechazadas.dat

       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROCTRANS.
       AUTHOR. ESTUDIANTE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANS-E ASSIGN TO "transacciones.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT VALIDAS-S ASSIGN TO "validas.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-VAL.
           SELECT RECHAZADAS-S ASSIGN TO "rechazadas.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-REJ.

       DATA DIVISION.
       FILE SECTION.
       FD  TRANS-E.
       01  TRANS-REG        PIC X(80).

       FD  VALIDAS-S.
       01  VAL-REG          PIC X(80).

       FD  RECHAZADAS-S.
       01  REJ-REG          PIC X(80).

       WORKING-STORAGE SECTION.

      *> === FILE STATUS ===
       01  WS-FS-ENT         PIC X(02).
           88 ENT-OK         VALUE "00".
           88 ENT-EOF        VALUE "10".
       01  WS-FS-VAL         PIC X(02).
       01  WS-FS-REJ         PIC X(02).

      *> === CAMPOS PARSEADOS ===
       01  WS-TIPO           PIC X(01).
       01  WS-CUENTA         PIC X(05).
       01  WS-MONTO-TXT      PIC X(10).
       01  WS-MONEDA         PIC X(03).
       01  WS-FECHA          PIC X(08).

      *> === VALIDACIÓN ===
       01  WS-MONTO-NUM      PIC 9(09)V99 VALUE ZEROS.
       01  WS-ES-VALIDO      PIC X(01).
           88 TRANS-VALIDA   VALUE "S".

      *> === CONTADORES ===
       01  WS-CONT-TOTAL     PIC 9(05) VALUE ZEROS.
       01  WS-CONT-VALIDAS   PIC 9(05) VALUE ZEROS.
       01  WS-CONT-RECHAZ    PIC 9(05) VALUE ZEROS.

      *> === REPORTE ===
       01  WS-LINEA-OUT      PIC X(80).
       01  WS-MONTO-EDIT     PIC $$,$$9.99.
       01  WS-SEP            PIC X(60) VALUE ALL "=".

      *> === UNSTRING ===
       01  WS-CUENTA-CAMPOS  PIC 9(02).
       01  WS-RAZON          PIC X(30).

       PROCEDURE DIVISION.
       MAIN.
           PERFORM 1000-ABRIR.
           PERFORM 2000-PROCESAR UNTIL ENT-EOF.
           PERFORM 3000-RESUMEN.
           PERFORM 9000-CERRAR.
           STOP RUN.

      *> ============================================
      *> TODO 1: ABRIR ARCHIVOS
      *> ============================================
       1000-ABRIR.
           DISPLAY WS-SEP.
           DISPLAY "    PROCESADOR DE TRANSACCIONES".
           DISPLAY WS-SEP.
      *    OPEN INPUT TRANS-E
      *    IF error → STOP RUN
      *    OPEN OUTPUT VALIDAS-S
      *    OPEN OUTPUT RECHAZADAS-S
           EXIT.

      *> ============================================
      *> TODO 2: PROCESAR CADA LÍNEA
      *> ============================================
       2000-PROCESAR.
           READ TRANS-E
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   ADD 1 TO WS-CONT-TOTAL
                   MOVE SPACES TO WS-TIPO WS-CUENTA
                                  WS-MONTO-TXT WS-MONEDA
                                  WS-FECHA

      *            TODO: Parsear línea con UNSTRING
      *            UNSTRING TRANS-REG
      *                DELIMITED BY "|"
      *                INTO WS-TIPO
      *                     WS-CUENTA
      *                     WS-MONTO-TXT
      *                     WS-MONEDA
      *                     WS-FECHA
      *            END-UNSTRING

      *            TODO: Limpiar datos
      *            MOVE FUNCTION TRIM(FUNCTION UPPER-CASE(WS-TIPO))
      *                TO WS-TIPO
      *            ... (mismo para moneda)

      *            TODO: Validar
      *            MOVE "S" TO WS-ES-VALIDO
      *            Validar tipo (D, R o T)
      *            Validar monto > 0 con FUNCTION NUMVAL
      *            Validar moneda = 3 chars
      *            Validar fecha = 8 dígitos

      *            TODO: Escribir en archivo correspondiente
      *            IF TRANS-VALIDA
      *                ADD 1 TO WS-CONT-VALIDAS
      *                WRITE VAL-REG FROM TRANS-REG
      *            ELSE
      *                ADD 1 TO WS-CONT-RECHAZ
      *                WRITE REJ-REG FROM TRANS-REG
      *            END-IF
           END-READ.
           EXIT.

      *> ============================================
      *> TODO 3: RESUMEN
      *> ============================================
       3000-RESUMEN.
           DISPLAY " ".
           DISPLAY "Total procesadas : " WS-CONT-TOTAL.
           DISPLAY "Trans. validas   : " WS-CONT-VALIDAS.
           DISPLAY "Trans. rechazadas: " WS-CONT-RECHAZ.
           DISPLAY " ".
           DISPLAY "Archivos generados:".
           DISPLAY "  validas.dat".
           DISPLAY "  rechazadas.dat".
           EXIT.

      *> ============================================
      *> TODO 4: CERRAR
      *> ============================================
       9000-CERRAR.
           CLOSE TRANS-E.
           CLOSE VALIDAS-S.
           CLOSE RECHAZADAS-S.

      *> ============================================
      *> RESULTADO ESPERADO
      *> ============================================
      *> Total: 8 líneas
      *> Válidas: 5 (D=3, R=2, T=1 con monto OK)
      *> Rechazadas: 3
      *>   Línea 4: tipo "X" inválido
      *>   Línea 5: monto "ABC123" no numérico
      *>   Línea 6: monto negativo
