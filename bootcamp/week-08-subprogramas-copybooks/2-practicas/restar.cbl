       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> SUBPROGRAMA: RESTAR
      *> ============================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RESTAR.

       DATA DIVISION.
       LINKAGE SECTION.
       01  LK-A        PIC 9(05).
       01  LK-B        PIC 9(05).
       01  LK-R        PIC S9(10).

       PROCEDURE DIVISION USING LK-A LK-B LK-R.
           COMPUTE LK-R = LK-A - LK-B.
           EXIT PROGRAM.
