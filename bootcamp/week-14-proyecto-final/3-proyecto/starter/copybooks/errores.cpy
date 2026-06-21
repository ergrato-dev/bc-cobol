      *> ============================================
      *> COPYBOOK: errores.cpy
      *> Codigos de FILE STATUS y error del sistema
      *> ============================================

       01  WS-FS               PIC X(02).
           88 FS-OK            VALUE "00".
           88 FS-EOF           VALUE "10".
           88 FS-NO-FILE       VALUE "35".
           88 FS-NOT-FOUND     VALUE "23".

       01  WS-RC               PIC 9(02) VALUE ZEROS.
           88 RC-OK            VALUE 0.
           88 RC-ERROR         VALUE 1 THRU 99.

       01  WS-COD-ERROR        PIC X(02) VALUE "00".
           88 ERR-OK           VALUE "00".
           88 ERR-TIPO-INVAL   VALUE "01".
           88 ERR-MONTO-NEG    VALUE "02".
           88 ERR-CUENTA-NF    VALUE "03".
           88 ERR-SIN-FONDOS   VALUE "04".
           88 ERR-ARCHIVO      VALUE "99".
