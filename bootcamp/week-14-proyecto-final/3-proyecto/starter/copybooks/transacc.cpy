      *> ============================================
      *> COPYBOOK: transacc.cpy
      *> Layout de transaccion bancaria
      *> ============================================

       01  REG-TRANSACCION.
           05 TRANS-TIPO       PIC X(01).
               88 TRANS-DEBITO  VALUE "D".
               88 TRANS-CREDITO VALUE "C".
               88 TRANS-VALIDO  VALUE "D" "C".
           05 TRANS-CUENTA     PIC 9(05).
           05 TRANS-MONTO      PIC 9(09)V99.
           05 TRANS-DESCRIP    PIC X(20).
           05 TRANS-FECHA      PIC 9(08).

       01  WS-TRANS-CSV        PIC X(50).
       01  WS-TRANS-MONTO-TXT  PIC X(10).
