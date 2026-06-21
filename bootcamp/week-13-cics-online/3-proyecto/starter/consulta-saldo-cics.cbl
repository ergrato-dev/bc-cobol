       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Consulta de Saldo (CICS Simulado)
      *> Semana 13 - CICS Fundamentos
      *> ============================================
      *> Sistema con 3 pantallas y pseudo-conversacion.
      *> REQUIERE: cuentas.idx (ejecutar crear-cuentas primero)
      *>
      *> Compilar: cobc -x -free consulta-saldo-cics.cbl
      *> Ejecutar: ./consulta-saldo-cics

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CSALDO.
       AUTHOR. ESTUDIANTE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUENTAS ASSIGN TO "cuentas.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS-CTA.

       DATA DIVISION.
       FILE SECTION.
       FD  CUENTAS.
       01  CTA-REG.
           05 CTA-ID        PIC 9(05).
           05 CTA-NOMBRE    PIC X(30).
           05 CTA-TIPO      PIC X(02).
           05 CTA-SALDO     PIC 9(07)V99.

       WORKING-STORAGE SECTION.
       01  WS-FS-CTA         PIC X(02).
           88 CTA-OK         VALUE "00".
           88 CTA-NOT-FOUND  VALUE "23".

      *> COMMAREA simulada (estado entre pantallas)
       01  WS-COMMAREA.
           05 CA-ESTADO       PIC X(01) VALUE "1".
               88 CA-MENU     VALUE "1".
               88 CA-CONSULTA VALUE "2".
               88 CA-RESULT   VALUE "3".
           05 CA-CUENTA       PIC 9(05) VALUE ZEROS.
           05 CA-OPCION       PIC 9 VALUE ZEROS.

       01  WS-SALIR           PIC X(01) VALUE "N".
       01  WS-SALDO-EDIT      PIC $$,$$9.99.
       01  WS-SEP             PIC X(40) VALUE ALL "=".
       01  WS-SUBSEP          PIC X(40) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 1: Abrir archivo indexado OPEN I-O CUENTAS
      *    Mostrar encabezado del sistema

      *    TODO 2: Loop principal PERFORM UNTIL SALIR
      *    EVALUATE TRUE
      *        WHEN CA-MENU PERFORM 1000-PANTALLA-MENU
      *        WHEN CA-CONSULTA PERFORM 2000-PANTALLA-CONSULTA
      *        WHEN CA-RESULT PERFORM 3000-PANTALLA-RESULTADO
      *    END-EVALUATE
      *    END-PERFORM.
      *    CLOSE CUENTAS.
           STOP RUN.

      *> ============================================
      *> PANTALLA 1: MENU PRINCIPAL
      *> ============================================
       1000-PANTALLA-MENU.
      *    TODO 3: Mostrar menu con bordes
      *    Opciones: 1=Consultar 2=Listar todas 9=Salir
      *    ACCEPT CA-OPCION
      *    EVALUATE CA-OPCION
      *        WHEN 1 MOVE "2" TO CA-ESTADO
      *        WHEN 2 PERFORM 1500-LISTAR-TODAS
      *        WHEN 9 MOVE "S" TO WS-SALIR
      *    END-EVALUATE
           EXIT.

       1500-LISTAR-TODAS.
      *    TODO 4: START + READ NEXT para recorrer cuentas.idx
      *    Mostrar ID, Nombre, Tipo, Saldo formateado
           EXIT.

      *> ============================================
      *> PANTALLA 2: INGRESAR CUENTA
      *> ============================================
       2000-PANTALLA-CONSULTA.
      *    TODO 5: Solicitar numero de cuenta (0=volver)
      *    ACCEPT CA-CUENTA
      *    IF CA-CUENTA = 0
      *        MOVE "1" TO CA-ESTADO
      *    ELSE
      *        MOVE "3" TO CA-ESTADO
      *    END-IF
           EXIT.

      *> ============================================
      *> PANTALLA 3: MOSTRAR RESULTADO
      *> ============================================
       3000-PANTALLA-RESULTADO.
      *    TODO 6: Leer cuentas.idx con READ KEY IS CA-CUENTA
      *    Si CTA-NOT-FOUND: mostrar "Cuenta no encontrada"
      *    Si CTA-OK: mostrar nombre, tipo, saldo formateado
      *    Esperar Enter para volver al menu
      *    MOVE "1" TO CA-ESTADO
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO
      *> ============================================
      *> Menu → Opcion 1 → Ingresar 00101 → Resultado:
      *>   Cuenta: 00101
      *>   Nombre: Juan Perez
      *>   Tipo  : CC (Cuenta Corriente)
      *>   Saldo : $ 15,000.50
      *>   Presione Enter para continuar...
