       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Consolidación Diaria de Sucursales
      *> Semana 10 - SORT y MERGE
      *> ============================================
      *> MERGE de 3 sucursales, OUTPUT PROCEDURE
      *> para consolidar por cuenta.
      *>
      *> REQUIERE: sucursal_a.dat, _b.dat, _c.dat
      *> (ya ordenados por cuenta)
      *>
      *> Compilar: cobc -x -free consolidacion-diaria.cbl
      *> Ejecutar: ./consolidacion-diaria

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSOLIDA.
       AUTHOR. ESTUDIANTE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SUC-A    ASSIGN TO "sucursal_a.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SUC-B    ASSIGN TO "sucursal_b.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SUC-C    ASSIGN TO "sucursal_c.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT MAESTRO  ASSIGN TO "maestro_consolidado.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORTE  ASSIGN TO "reporte_consolidacion.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT MERGE-WK ASSIGN TO "mergework.tmp".

       DATA DIVISION.
       FILE SECTION.
       FD  SUC-A.  01 SA-REG PIC X(14).
       FD  SUC-B.  01 SB-REG PIC X(14).
       FD  SUC-C.  01 SC-REG PIC X(14).

       FD  MAESTRO.
       01  MAE-REG.
           05 MAE-CUENTA   PIC 9(05).
           05 MAE-TOT-DEB  PIC 9(07)V99.
           05 MAE-TOT-CRED PIC 9(07)V99.

       FD  REPORTE.
       01  REP-REG         PIC X(70).

       SD  MERGE-WK.
       01  MERGE-REG.
           05 MERGE-CUENTA PIC 9(05).
           05 MERGE-TIPO   PIC X(01).
           05 MERGE-MONTO  PIC 9(07)V99.

       WORKING-STORAGE SECTION.
       01  WS-REG-MOV.
           05 WS-MOV-CUENTA  PIC 9(05).
           05 WS-MOV-TIPO    PIC X(01).
               88 MOV-DEBITO VALUE "D".
               88 MOV-CREDITO VALUE "A".
           05 WS-MOV-MONTO   PIC 9(07)V99.

       01  WS-CUENTA-ACT     PIC 9(05) VALUE ZEROS.
       01  WS-CUENTA-ANT     PIC 9(05) VALUE ZEROS.
       01  WS-ACUM-DEB       PIC 9(12)V99 VALUE ZEROS.
       01  WS-ACUM-CRED      PIC 9(12)V99 VALUE ZEROS.
       01  WS-CONT-CUENTAS   PIC 9(05) VALUE ZEROS.
       01  WS-CONT-MOV       PIC 9(05) VALUE ZEROS.

       01  WS-SEP            PIC X(70) VALUE ALL "=".
       01  WS-SUBSEP         PIC X(70) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== CONSOLIDACION DIARIA ===".
           DISPLAY " ".

      *    TODO 1: MERGE de las 3 sucursales
      *    MERGE MERGE-WK
      *        ASCENDING KEY MERGE-CUENTA
      *        USING SUC-A SUC-B SUC-C
      *        OUTPUT PROCEDURE IS 2000-CONSOLIDAR

      *    TODO 2: Si MERGE falla, mostrar error
           STOP RUN.

      *> ============================================
      *> TODO 3: OUTPUT PROCEDURE — Consolidar
      *> ============================================
      *2000-CONSOLIDAR.
      *    OPEN OUTPUT MAESTRO.
      *    OPEN OUTPUT REPORTE.
      *    Escribir encabezado de reporte
      *
      *    PERFORM UNTIL MERGE-EOF
      *        RETURN MERGE-WK
      *            AT END SET MERGE-EOF TO TRUE
      *            NOT AT END
      *                ADD 1 TO WS-CONT-MOV
      *                MOVE MERGE-REG TO WS-REG-MOV
      *                MOVE WS-MOV-CUENTA TO WS-CUENTA-ACT
      *
      *                Detectar cambio de cuenta:
      *                IF WS-CUENTA-ACT NOT = WS-CUENTA-ANT
      *                    AND WS-CUENTA-ANT NOT = ZEROS
      *                    PERFORM 3000-GUARDAR-CUENTA
      *                END-IF
      *
      *                Acumular por tipo:
      *                IF MOV-DEBITO
      *                    ADD WS-MOV-MONTO TO WS-ACUM-DEB
      *                ELSE
      *                    ADD WS-MOV-MONTO TO WS-ACUM-CRED
      *                END-IF
      *        END-RETURN
      *    END-PERFORM.
      *
      *    PERFORM 3000-GUARDAR-CUENTA.  *> Última cuenta
      *    Cerrar archivos

      *> ============================================
      *> TODO 4: Guardar cuenta consolidada
      *> ============================================
      *3000-GUARDAR-CUENTA.
      *    ADD 1 TO WS-CONT-CUENTAS
      *    MOVE WS-CUENTA-ANT TO MAE-CUENTA
      *    MOVE WS-ACUM-DEB TO MAE-TOT-DEB
      *    MOVE WS-ACUM-CRED TO MAE-TOT-CRED
      *    WRITE MAE-REG
      *    Escribir línea en reporte
      *    Resetear acumuladores
      *    MOVE WS-CUENTA-ACT TO WS-CUENTA-ANT

      *> ============================================
      *> RESULTADO ESPERADO (maestro_consolidado.dat)
      *> ============================================
      *> 00101: Débitos $800, Créditos $1,700
      *> 00202: Débitos $200, Créditos $5,000
      *> 00303: Débitos $500, Créditos $10,000
      *> 00404: Débitos $100, Créditos $2,500
      *> 00505: Débitos $150, Créditos $7,500
