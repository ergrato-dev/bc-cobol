       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Banco Principal (orquestador)
      *> Semana 08 - Subprogramas y COPYBOOKS
      *> ============================================
      *> TODO: Completar para que llame a los 3 subprogramas
      *> usando CALL ... USING y los COPYBOOKS compartidos.
      *>
      *> Compilar todo junto:
      *> cobc -x -free banco-principal.cbl consultar.cbl
      *>          depositar.cbl retirar.cbl -o banco
      *> ./banco

       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANCO.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> TODO 1: Incluir COPYBOOKS
      *COPY "copybooks/cuentas.cpy".
      *COPY "copybooks/errores.cpy".

      *> Variables locales del principal
       01  WS-OPCION        PIC 9 VALUE ZEROS.
       01  WS-SEP           PIC X(50) VALUE ALL "=".

      *> Datos de cuenta simulados (en un sistema real vendrían de archivo)
       01  WS-CUENTA-1.
           05 FILLER PIC 9(05) VALUE 101.
           05 FILLER PIC X(25) VALUE "Juan Perez".
           05 FILLER PIC S9(07)V99 VALUE 15000.00.
           05 FILLER PIC X(02) VALUE "CC".
           05 FILLER PIC X(01) VALUE "A".
       01  WS-CUENTA-2.
           05 FILLER PIC 9(05) VALUE 202.
           05 FILLER PIC X(25) VALUE "Maria Garcia".
           05 FILLER PIC S9(07)V99 VALUE 25000.00.
           05 FILLER PIC X(02) VALUE "CA".
           05 FILLER PIC X(01) VALUE "A".

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 2: Menú principal con PERFORM UNTIL
      *    Mostrar opciones: 1=Consultar 2=Depositar 3=Retirar 9=Salir
      *    EVALUATE WS-OPCION
      *        WHEN 1 PERFORM 2000-CONSULTAR
      *        WHEN 2 PERFORM 3000-DEPOSITAR
      *        WHEN 3 PERFORM 4000-RETIRAR
      *    END-EVALUATE
           STOP RUN.

       2000-CONSULTAR.
      *    TODO 3: Solicitar ID, cargar cuenta simulada en REG-CUENTA
      *    CALL "CONSULTAR" USING REG-CUENTA WS-COD-ERROR
      *    IF COD-OK mostrar datos
           EXIT.

       3000-DEPOSITAR.
      *    TODO 4: Solicitar ID y monto, cargar cuenta, llamar subprograma
      *    CALL "DEPOSITAR" USING REG-CUENTA WS-MONTO WS-COD-ERROR
      *    Mostrar resultado
           EXIT.

       4000-RETIRAR.
      *    TODO 5: Solicitar ID y monto, cargar cuenta, llamar subprograma
      *    CALL "RETIRAR" USING REG-CUENTA WS-MONTO WS-COD-ERROR
      *    IF COD-SIN-FONDOS mostrar "Saldo insuficiente"
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO
      *> ============================================
      *> Opción 1, ID=101:
      *>   Cuenta: 00101 Juan Perez
      *>   Saldo: $ 15,000.00
      *> Opción 2, ID=101, monto=500:
      *>   Deposito exitoso. Nuevo saldo: $ 15,500.00
      *> Opción 3, ID=101, monto=99999:
      *>   ERROR: Saldo insuficiente
