       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> SUBPROGRAMA: retirar.cbl
      *> Resta monto del saldo, valida fondos
      *> ============================================
      *> TODO: Completar LINKAGE, lógica y validación

       IDENTIFICATION DIVISION.
       PROGRAM-ID. RETIRAR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-SALDO-EDIT    PIC $$,$$9.99.

      *LINKAGE SECTION.
      *01  LK-CUENTA.
      *    05 LK-ID          PIC 9(05).
      *    05 LK-NOMBRE      PIC X(25).
      *    05 LK-SALDO       PIC S9(07)V99.
      *    05 LK-TIPO        PIC X(02).
      *    05 LK-ESTADO      PIC X(01).
      *01  LK-MONTO          PIC 9(07)V99.
      *01  LK-COD-ERROR      PIC X(02).

      *PROCEDURE DIVISION USING LK-CUENTA LK-MONTO LK-COD-ERROR.
       PROCEDURE DIVISION.
      *    MOVE "00" TO LK-COD-ERROR
      *    IF LK-MONTO > LK-SALDO
      *        MOVE "02" TO LK-COD-ERROR   *> COD-SIN-FONDOS
      *    ELSE
      *        SUBTRACT LK-MONTO FROM LK-SALDO
      *        Mostrar confirmación
      *    END-IF
           EXIT PROGRAM.
