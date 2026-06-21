       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Inicialización y Control de Estados
      *> ============================================
      *>
      *> OBJETIVO: Usar VALUE, constantes figurativas,
      *> 88-level e INITIALIZE.
      *>
      *> Compilar: cobc -x -free inicializacion.cbl
      *> Ejecutar: ./inicializacion

       IDENTIFICATION DIVISION.
       PROGRAM-ID. INICIALI.

      *> === PASO 1: Declarar variables con VALUE ===
      *> VALUE = valor inicial (se asigna al cargar el programa)
      *> SPACES, ZEROS = constantes figurativas
      *> ALL "x" = relleno de caracteres
      *>
      *> Descomenta las siguientes 10 líneas:
      *DATA DIVISION.
      *WORKING-STORAGE SECTION.
      *01  WS-TITULO        PIC X(40) VALUE " SISTEMA DE CUENTAS ".
      *01  WS-SEPARADOR     PIC X(40) VALUE ALL "=".
      *01  WS-SUBSEPARADOR  PIC X(40) VALUE ALL "-".
      *01  WS-NOMBRE        PIC X(30) VALUE SPACES.
      *01  WS-SALDO         PIC S9(07)V99 VALUE ZEROS.
      *01  WS-INTENTOS      PIC 9(02) VALUE 3.

      *> === PASO 2: 88-level para estados ===
      *> Descomenta las siguientes 10 líneas:
      *01  WS-ESTADO         PIC X(01).
      *    88 CUENTA-ACTIVA      VALUE "A".
      *    88 CUENTA-INACTIVA    VALUE "I".
      *    88 CUENTA-BLOQUEADA   VALUE "B".
      *01  WS-TIPO-TRANS     PIC X(01).
      *    88 ES-DEPOSITO        VALUE "D".
      *    88 ES-RETIRO          VALUE "R".
      *    88 ES-CONSULTA        VALUE "C".
      *    88 TRANSACCION-VALIDA VALUE "D" "R" "C".

      *> === PASO 3: Inicializar y mostrar ===
      *>
      *> Descomenta las siguientes 16 líneas:
      *PROCEDURE DIVISION.
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY WS-TITULO.
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY " ".
      *    DISPLAY "Variables inicializadas automaticamente:".
      *    DISPLAY "  Nombre  : '" WS-NOMBRE "'".
      *    DISPLAY "  Saldo   : " WS-SALDO.
      *    DISPLAY "  Intentos: " WS-INTENTOS.
      *    DISPLAY " ".
      *    DISPLAY "Cambiando valores con MOVE...".
      *    MOVE "Carlos Mendoza" TO WS-NOMBRE.
      *    MOVE 50000.00 TO WS-SALDO.
      *    DISPLAY "  Nombre  : '" WS-NOMBRE "'".
      *    DISPLAY "  Saldo   : " WS-SALDO.

      *> === PASO 4: Usar INITIALIZE para limpiar ===
      *> INITIALIZE restaura valores por defecto según tipo
      *>
      *> Descomenta las siguientes 6 líneas:
      *    DISPLAY " ".
      *    DISPLAY "Ejecutando INITIALIZE...".
      *    INITIALIZE WS-NOMBRE WS-SALDO.
      *    DISPLAY "  Nombre  : '" WS-NOMBRE "'".
      *    DISPLAY "  Saldo   : " WS-SALDO.
      *    DISPLAY " ".

      *> === PASO 5: Demostrar 88-level ===
      *> SET asigna el valor definido en el 88
      *>
      *> Descomenta las siguientes 13 líneas:
      *    DISPLAY WS-SUBSEPARADOR.
      *    DISPLAY "Demostracion de 88-level:".
      *    DISPLAY WS-SUBSEPARADOR.
      *    SET CUENTA-ACTIVA TO TRUE.
      *    IF CUENTA-ACTIVA
      *        DISPLAY "Estado cuenta: ACTIVO"
      *    END-IF.
      *    SET ES-DEPOSITO TO TRUE.
      *    IF ES-DEPOSITO
      *        DISPLAY "Tipo transaccion: DEPOSITO"
      *    END-IF.
      *    IF TRANSACCION-VALIDA
      *        DISPLAY "La transaccion ES valida"
      *    END-IF.

      *> === PASO 6: Finalizar ===
      *>
      *> Descomenta las siguientes 2 líneas:
      *    DISPLAY " ".
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> ========================================
      *>  SISTEMA DE CUENTAS
      *> ========================================
      *>
      *> Variables inicializadas automaticamente:
      *>   Nombre  : '                              '
      *>   Saldo   : 000000000
      *>   Intentos: 03
      *>
      *> Cambiando valores con MOVE...
      *>   Nombre  : 'Carlos Mendoza'
      *>   Saldo   : 005000000
      *>
      *> Ejecutando INITIALIZE...
      *>   Nombre  : '                              '
      *>   Saldo   : 000000000
      *>
      *> ----------------------------------------
      *> Demostracion de 88-level:
      *> ----------------------------------------
      *> Estado cuenta: ACTIVO
      *> Tipo transaccion: DEPOSITO
      *> La transaccion ES valida
