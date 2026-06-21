       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> SUBPROGRAMA: SUMAR
      *> Recibe 3 parámetros: A, B, R
      *> Usa LINKAGE SECTION
      *> ============================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUMAR.

       DATA DIVISION.
       LINKAGE SECTION.
      *> TODO: Descomenta y completa los parámetros
       01  LK-A        PIC 9(05).
       01  LK-B        PIC 9(05).
       01  LK-R        PIC S9(10).

      *> TODO: PROCEDURE DIVISION USING con los 3 parámetros
       PROCEDURE DIVISION USING LK-A LK-B LK-R.
           COMPUTE LK-R = LK-A + LK-B.
           EXIT PROGRAM.
