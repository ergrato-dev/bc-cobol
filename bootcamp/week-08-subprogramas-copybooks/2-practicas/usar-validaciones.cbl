       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Usar COPYBOOK de validaciones
      *> ============================================
      *> Demuestra cómo incluir un COPYBOOK y usar
      *> sus 88-level en el programa.
      *>
      *> Compilar: cobc -x -free usar-validaciones.cbl -o validador
      *> Ejecutar: ./validador

       IDENTIFICATION DIVISION.
       PROGRAM-ID. USACPY.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Incluir COPYBOOK ===
      *> Descomenta la siguiente línea:
      *COPY "copybooks/validaciones.cpy".

      *> === PASO 2: Variables locales ===
      *> Descomenta las siguientes 5 líneas:
      *01  WS-OPCION        PIC 9 VALUE ZEROS.
      *01  WS-CODIGO        PIC X(02) VALUE SPACES.
      *01  WS-TIPO          PIC X(01) VALUE SPACES.
      *01  WS-ESTADO        PIC X(01) VALUE SPACES.
      *01  WS-SEP           PIC X(40) VALUE ALL "=".

       PROCEDURE DIVISION.
      *> === PASO 3: Menú de validación ===
      *> Descomenta las siguientes 10 líneas:
      *MAIN.
      *    DISPLAY WS-SEP.
      *    DISPLAY "    VALIDADOR (usa COPYBOOK)".
      *    DISPLAY WS-SEP.
      *    DISPLAY " ".
      *    DISPLAY "1. Simular FILE STATUS OK".
      *    DISPLAY "2. Simular FILE STATUS EOF".
      *    DISPLAY "3. Validar tipo transaccion".
      *    DISPLAY "4. Validar estado cuenta".
      *    DISPLAY "Opcion: " WITH NO ADVANCING.
      *    ACCEPT WS-OPCION.

      *> === PASO 4: Evaluar opción usando 88-level del COPYBOOK ===
      *> Descomenta las siguientes 22 líneas:
      *    EVALUATE WS-OPCION
      *        WHEN 1
      *            MOVE "00" TO WS-FS-GEN
      *            IF FS-OK DISPLAY "FILE STATUS: OK" END-IF
      *        WHEN 2
      *            MOVE "10" TO WS-FS-GEN
      *            IF FS-EOF DISPLAY "FILE STATUS: EOF" END-IF
      *        WHEN 3
      *            DISPLAY "Tipo (D/R/T): " WITH NO ADVANCING
      *            ACCEPT WS-TIPO
      *            MOVE WS-TIPO TO WS-TIPO-TRANS
      *            IF TRANS-VALIDA
      *                DISPLAY "Transaccion VALIDA"
      *            ELSE
      *                DISPLAY "Transaccion INVALIDA"
      *            END-IF
      *        WHEN 4
      *            DISPLAY "Estado (A/I/B): " WITH NO ADVANCING
      *            ACCEPT WS-ESTADO
      *            MOVE WS-ESTADO TO WS-ESTADO-CTA
      *            EVALUATE TRUE
      *                WHEN CTA-ACTIVA DISPLAY "Cuenta ACTIVA"
      *                WHEN CTA-INACTIVA DISPLAY "Cuenta INACTIVA"
      *                WHEN CTA-BLOQUEADA DISPLAY "Cuenta BLOQUEADA"
      *                WHEN OTHER DISPLAY "Estado desconocido"
      *            END-EVALUATE
      *    END-EVALUATE.
           STOP RUN.

      *> === DEMOSTRACIÓN ===
      *> Opción 3, tipo = D:
      *>   Transaccion VALIDA
      *> Opción 4, estado = B:
      *>   Cuenta BLOQUEADA
