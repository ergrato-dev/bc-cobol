      *> ============================================
      *> COPYBOOK: cuentas.cpy
      *> Layout de cuenta bancaria
      *> Compartido por: batch/validar, batch/actualizar,
      *> batch/reporte-cierre, online/consulta-online
      *> ============================================

       01  REG-CUENTA.
           05 CTA-ID          PIC 9(05).
           05 CTA-NOMBRE      PIC X(30).
           05 CTA-TIPO        PIC X(02).
               88 CTA-CC      VALUE "CC".
               88 CTA-CA      VALUE "CA".
               88 CTA-PF      VALUE "PF".
           05 CTA-SALDO       PIC S9(09)V99.
           05 CTA-ESTADO      PIC X(01).
               88 CTA-ACTIVA  VALUE "A".
           05 FILLER          PIC X(10) VALUE SPACES.
