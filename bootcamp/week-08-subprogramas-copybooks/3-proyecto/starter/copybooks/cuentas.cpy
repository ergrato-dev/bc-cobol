      *> ============================================
      *> COPYBOOK: cuentas.cpy
      *> Layout de cuenta bancaria + 88-level
      *> Compartido por banco-principal, consultar,
      *> depositar y retirar.
      *> ============================================

       01  REG-CUENTA.
           05 CTA-ID          PIC 9(05).
           05 CTA-NOMBRE      PIC X(25).
           05 CTA-SALDO       PIC S9(07)V99.
           05 CTA-TIPO        PIC X(02).
               88 CTA-CC      VALUE "CC".
               88 CTA-CA      VALUE "CA".
           05 CTA-ESTADO      PIC X(01).
               88 CTA-ACTIVA  VALUE "A".
               88 CTA-INACTIVA VALUE "I".
