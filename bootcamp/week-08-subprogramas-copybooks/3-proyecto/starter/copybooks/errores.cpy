      *> ============================================
      *> COPYBOOK: errores.cpy
      *> Códigos de FILE STATUS y error
      *> ============================================

       01  WS-FS             PIC X(02).
           88 FS-OK          VALUE "00".
           88 FS-EOF         VALUE "10".
           88 FS-NO-FILE     VALUE "35".
           88 FS-DUP         VALUE "22".
           88 FS-NOT-FOUND   VALUE "23".

       01  WS-COD-ERROR      PIC X(02).
           88 COD-OK         VALUE "00".
           88 COD-NOT-FOUND  VALUE "01".
           88 COD-SIN-FONDOS VALUE "02".
           88 COD-INACTIVA   VALUE "03".
           88 COD-INVALIDO   VALUE "99".
