       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Layout de Cliente Bancario
      *> ============================================
      *>
      *> OBJETIVO: Diseñar un registro de cliente usando
      *> PICTURE, campos internos y campos de edición.
      *>
      *> Compilar: cobc -x -free layout-cliente.cbl
      *> Ejecutar: ./layout-cliente

       IDENTIFICATION DIVISION.
       PROGRAM-ID. LAYOUT.

      *> === PASO 1: Declarar datos internos (para cálculos) ===
      *> PIC 9(n)   = numérico puro
      *> PIC S9(n)  = numérico con signo
      *> V          = decimal implícito
      *>
      *> Descomenta las siguientes 13 líneas:
      *DATA DIVISION.
      *WORKING-STORAGE SECTION.
      *01  WS-CLIENTE.
      *    05 WS-CLI-ID         PIC 9(05).
      *    05 WS-CLI-NOMBRE     PIC X(30).
      *    05 WS-CLI-APELLIDO   PIC X(30).
      *    05 WS-CLI-SALDO      PIC S9(07)V99.      *> Puede ser negativo
      *    05 WS-CLI-TASA       PIC 9V99.           *> 3.50%
      *    05 WS-CLI-ACTIVO     PIC X(01).
      *        88 CLIENTE-ACTIVO      VALUE "A".
      *        88 CLIENTE-INACTIVO    VALUE "I".
      *        88 CLIENTE-BLOQUEADO   VALUE "B".

      *> === PASO 2: Declarar campos de edición (para pantalla) ===
      *> $$,$$9.99 = moneda flotante con supresión de ceros
      *> Z,ZZ9    = número con supresión de ceros
      *>
      *> Descomenta las siguientes 3 líneas:
      *01  WS-SALDO-EDIT     PIC $$,$$9.99.
      *01  WS-ID-EDIT        PIC ZZ,ZZ9.
      *01  WS-TASA-EDIT      PIC Z9.99.

      *> === PASO 3: PROCEDURE DIVISION ===
      *> Descomenta las siguientes 4 líneas:
      *PROCEDURE DIVISION.
      *    DISPLAY "=== LAYOUT DE CLIENTE BANCARIO ===".
      *    DISPLAY " ".
      *    DISPLAY "Estructura interna del registro:".

      *> === PASO 4: Asignar datos de prueba ===
      *> Mueve valores a los campos internos
      *>
      *> Descomenta las siguientes 5 líneas:
      *    MOVE 1024 TO WS-CLI-ID.
      *    MOVE "Maria" TO WS-CLI-NOMBRE.
      *    MOVE "Gonzalez" TO WS-CLI-APELLIDO.
      *    MOVE 1542075 TO WS-CLI-SALDO.      *> = $15,420.75
      *    MOVE 3.50 TO WS-CLI-TASA.

      *> === PASO 5: Activar el 88-level ===
      *> SET ... TO TRUE cambia el valor subyacente
      *>
      *> Descomenta la siguiente línea:
      *    SET CLIENTE-ACTIVO TO TRUE.

      *> === PASO 6: Mostrar campos internos ===
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY "ID     (interno) : " WS-CLI-ID.
      *    DISPLAY "Nombre (interno) : " WS-CLI-NOMBRE.
      *    DISPLAY "Saldo  (interno) : " WS-CLI-SALDO.
      *    DISPLAY "Tasa   (interno) : " WS-CLI-TASA.
      *    DISPLAY " ".

      *> === PASO 7: Convertir a formato de edición ===
      *> MOVE de campo interno a campo de edición aplica formato
      *>
      *> Descomenta las siguientes 7 líneas:
      *    MOVE WS-CLI-ID TO WS-ID-EDIT.
      *    MOVE WS-CLI-SALDO TO WS-SALDO-EDIT.
      *    MOVE WS-CLI-TASA TO WS-TASA-EDIT.
      *    DISPLAY "=== DATOS FORMATEADOS ===".
      *    DISPLAY "ID     : " WS-ID-EDIT.
      *    DISPLAY "Nombre : " WS-CLI-NOMBRE " " WS-CLI-APELLIDO.
      *    DISPLAY "Saldo  : " WS-SALDO-EDIT.

      *> === PASO 8: Mostrar tasa y estado ===
      *> Descomenta las siguientes 3 líneas:
      *    DISPLAY "Tasa   : " WS-TASA-EDIT "%".
      *    IF CLIENTE-ACTIVO
      *        DISPLAY "Estado : ACTIVO".

      *> === PASO 9: Finalizar ===
      *> Descomenta las siguientes 2 líneas:
      *    DISPLAY " ".
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> === LAYOUT DE CLIENTE BANCARIO ===
      *>
      *> Estructura interna del registro:
      *> ID     (interno) : 01024
      *> Nombre (interno) : Maria
      *> Saldo  (interno) : 01542075
      *> Tasa   (interno) : 350
      *>
      *> === DATOS FORMATEADOS ===
      *> ID     :   1,024
      *> Nombre : Maria Gonzalez
      *> Saldo  : $ 15,420.75
      *> Tasa   :  3.50%
      *> Estado : ACTIVO
