      *> ============================================
      *> COPYBOOK: validaciones.cpy
      *> Validaciones reutilizables para múltiples programas
      *> ============================================
      *>
      *> USO:
      *>   COPY "copybooks/validaciones.cpy".
      *>
      *> Proporciona:
      *>   - 88-level para códigos de error
      *>   - 88-level para estados
      *>   - 88-level para tipos de transacción

       01  WS-FS-GEN         PIC X(02).
           88 FS-OK          VALUE "00".
           88 FS-EOF         VALUE "10".
           88 FS-NO-FILE     VALUE "35".
           88 FS-DUP         VALUE "22".
           88 FS-NOT-FOUND   VALUE "23".

       01  WS-TIPO-TRANS     PIC X(01).
           88 TRANS-DEPOSITO    VALUE "D".
           88 TRANS-RETIRO      VALUE "R".
           88 TRANS-TRANSFER    VALUE "T".
           88 TRANS-VALIDA      VALUE "D" "R" "T".

       01  WS-ESTADO-CTA     PIC X(01).
           88 CTA-ACTIVA        VALUE "A".
           88 CTA-INACTIVA      VALUE "I".
           88 CTA-BLOQUEADA     VALUE "B".

       01  WS-VALIDACION     PIC X(01).
           88 DATOS-VALIDOS     VALUE "S".
           88 DATOS-INVALIDOS   VALUE "N".
