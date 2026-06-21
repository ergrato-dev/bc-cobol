       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Ordenar Clientes
      *> ============================================
      *> SORT USING/GIVING con ASCENDING KEY
      *>
      *> Compilar: cobc -x -free ordenar-clientes.cbl
      *> Ejecutar: ./ordenar-clientes

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ORDCLI.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ENTRADA  ASSIGN TO "clientes.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SALIDA   ASSIGN TO "clientes_ord.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SORT-WK  ASSIGN TO "sortwork.tmp".

       DATA DIVISION.
       FILE SECTION.
       FD  ENTRADA.
       01  ENT-REG.
           05 ENT-NOMBRE   PIC X(25).
           05 ENT-SALDO    PIC 9(07)V99.

       FD  SALIDA.
       01  SAL-REG.
           05 SAL-NOMBRE   PIC X(25).
           05 SAL-SALDO    PIC 9(07)V99.

       SD  SORT-WK.
       01  SORT-REG.
           05 SORT-NOMBRE  PIC X(25).
           05 SORT-SALDO   PIC 9(07)V99.

       WORKING-STORAGE SECTION.
       01  WS-SALDO-EDIT    PIC $$,$$9.99.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== ORDENANDO CLIENTES POR NOMBRE ===".
           DISPLAY " ".

      *> === PASO 1: Mostrar datos originales ===
           DISPLAY "Antes del SORT:".
           OPEN INPUT ENTRADA.
           PERFORM 3 TIMES
               READ ENTRADA AT END CONTINUE END-READ
               MOVE ENT-SALDO TO WS-SALDO-EDIT
               DISPLAY "  " ENT-NOMBRE " " WS-SALDO-EDIT
           END-PERFORM.
           CLOSE ENTRADA.

      *> === PASO 2: SORT ASCENDING por nombre ===
           SORT SORT-WK
               ASCENDING KEY SORT-NOMBRE
               USING ENTRADA
               GIVING SALIDA.

      *> === PASO 3: Mostrar resultado ===
           DISPLAY " ".
           DISPLAY "Despues del SORT:".
           OPEN INPUT SALIDA.
           PERFORM UNTIL EXIT
               READ SALIDA AT END EXIT PERFORM END-READ
               MOVE SAL-SALDO TO WS-SALDO-EDIT
               DISPLAY "  " SAL-NOMBRE " " WS-SALDO-EDIT
           END-PERFORM.
           CLOSE SALIDA.
           DISPLAY " ".
           DISPLAY "Archivo generado: clientes_ord.dat".
           STOP RUN.
