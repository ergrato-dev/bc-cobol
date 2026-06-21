       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Filtrar y Transformar
      *> ============================================
      *> Lee clientes.dat, filtra saldos > 10000,
      *> aplica interés del 5% y genera salida.
      *>
      *> Compilar: cobc -x -free filtrar-datos.cbl
      *> Ejecutar: ./filtrar-datos
      *> Genera:   clientes_interes.dat

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILTRAR.

      *> === PASO 1: Declarar archivos ===
      *> Descomenta las siguientes 22 líneas:
      *ENVIRONMENT DIVISION.
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *    SELECT CLIENTES-E ASSIGN TO "clientes.dat"
      *        ORGANIZATION IS LINE SEQUENTIAL
      *        FILE STATUS IS WS-FS-ENT.
      *    SELECT CLIENTES-S ASSIGN TO "clientes_interes.dat"
      *        ORGANIZATION IS LINE SEQUENTIAL
      *        FILE STATUS IS WS-FS-SAL.
      *DATA DIVISION.
      *FILE SECTION.
      *FD  CLIENTES-E.
      *01  REG-ENT.
      *    05 ENT-ID       PIC 9(05).
      *    05 ENT-NOMBRE   PIC X(25).
      *    05 ENT-SALDO    PIC 9(07)V99.
      *FD  CLIENTES-S.
      *01  REG-SAL.
      *    05 SAL-ID       PIC 9(05).
      *    05 SAL-NOMBRE   PIC X(25).
      *    05 SAL-SALDO    PIC 9(07)V99.

      *> === PASO 2: WORKING-STORAGE ===
      *> Descomenta las siguientes 9 líneas:
      *WORKING-STORAGE SECTION.
      *01  WS-FS-ENT         PIC X(02).
      *    88 ENT-OK         VALUE "00".
      *    88 ENT-EOF        VALUE "10".
      *01  WS-FS-SAL         PIC X(02).
      *    88 SAL-OK         VALUE "00".
      *01  WS-CONT-FILT      PIC 9(05) VALUE ZEROS.
      *01  WS-TASA           PIC 9V99 VALUE 1.05.  *> +5%
      *01  WS-NUEVO-SALDO    PIC 9(07)V99.

       PROCEDURE DIVISION.
      *> === PASO 3: Abrir archivos ===
      *> Descomenta las siguientes 4 líneas:
      *MAIN.
      *    DISPLAY "=== FILTRO Y TRANSFORMACION ===".
      *    OPEN INPUT CLIENTES-E.
      *    OPEN OUTPUT CLIENTES-S.

      *> === PASO 4: Leer, filtrar y transformar ===
      *> Descomenta las siguientes 21 líneas:
      *    PERFORM UNTIL ENT-EOF
      *        READ CLIENTES-E
      *            AT END
      *                SET ENT-EOF TO TRUE
      *            NOT AT END
      *                IF ENT-SALDO > 10000                *> FILTRO
      *                    MOVE ENT-ID TO SAL-ID
      *                    MOVE ENT-NOMBRE TO SAL-NOMBRE
      *                    COMPUTE WS-NUEVO-SALDO =         *> TRANSFORM
      *                        ENT-SALDO * WS-TASA
      *                    MOVE WS-NUEVO-SALDO TO SAL-SALDO
      *                    WRITE REG-SAL
      *                    ADD 1 TO WS-CONT-FILT
      *                    DISPLAY "Procesado: "
      *                            ENT-ID " " ENT-NOMBRE
      *                            " Saldo anterior: " ENT-SALDO
      *                            " -> Nuevo: " WS-NUEVO-SALDO
      *                END-IF
      *        END-READ
      *    END-PERFORM.

      *> === PASO 5: Cerrar y mostrar resumen ===
      *> Descomenta las siguientes 5 líneas:
      *    CLOSE CLIENTES-E.
      *    CLOSE CLIENTES-S.
      *    DISPLAY " ".
      *    DISPLAY "Clientes con saldo > 10000: " WS-CONT-FILT.
      *    DISPLAY "Archivo generado: clientes_interes.dat".
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Solo clientes 1, 2, 4 (saldos > 10000)
      *> Sus saldos incrementan 5%
      *> Cliente 3 (10000.75) y Cliente 5 (3500.25) NO aparecen
