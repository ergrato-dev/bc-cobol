       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Leer Archivo y Mostrar
      *> ============================================
      *> Aprende ENVIRONMENT DIVISION, FILE SECTION,
      *> OPEN INPUT, READ con AT END, FILE STATUS.
      *>
      *> Compilar: cobc -x -free leer-archivo.cbl
      *> Ejecutar: ./leer-archivo
      *> Datos:    clientes.dat (debe estar en la misma carpeta)

       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEER.

      *> === PASO 1: ENVIRONMENT DIVISION ===
      *> Descomenta las siguientes 8 líneas:
      *ENVIRONMENT DIVISION.
      *INPUT-OUTPUT SECTION.
      *FILE-CONTROL.
      *    SELECT CLIENTES ASSIGN TO "clientes.dat"
      *        ORGANIZATION IS LINE SEQUENTIAL
      *        FILE STATUS IS WS-FS-CLI.
      *DATA DIVISION.
      *FILE SECTION.

      *> === PASO 2: FD y layout del registro ===
      *> Según el archivo clientes.dat:
      *>   Columnas 1-5  : ID (numérico)
      *>   Columnas 6-30 : Nombre (alfanumérico)
      *>   Columnas 31-39: Saldo (numérico, 7 enteros + 2 decimales)
      *>
      *> Descomenta las siguientes 7 líneas:
      *FD  CLIENTES.
      *01  CLI-REG.
      *    05 CLI-ID       PIC 9(05).
      *    05 CLI-NOMBRE   PIC X(25).
      *    05 CLI-SALDO    PIC 9(07)V99.

      *> === PASO 3: WORKING-STORAGE ===
      *> Descomenta las siguientes 9 líneas:
      *WORKING-STORAGE SECTION.
      *01  WS-FS-CLI        PIC X(02).
      *    88 CLI-OK        VALUE "00".
      *    88 CLI-EOF       VALUE "10".
      *    88 CLI-NO-FILE   VALUE "35".
      *01  WS-CONTADOR      PIC 9(05) VALUE ZEROS.
      *01  WS-SALDO-EDIT    PIC $$,$$9.99.
      *01  WS-SEPARADOR     PIC X(50) VALUE ALL "=".
      *01  WS-SUBSEPARADOR  PIC X(50) VALUE ALL "-".

      *> === PASO 4: Abrir archivo ===
      *> Descomenta las siguientes 11 líneas:
      *PROCEDURE DIVISION.
      *MAIN.
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY "    LECTOR DE ARCHIVO DE CLIENTES".
      *    DISPLAY WS-SEPARADOR.
      *    DISPLAY " ".
      *    OPEN INPUT CLIENTES.
      *    IF CLI-NO-FILE
      *        DISPLAY "ERROR: Archivo clientes.dat no encontrado"
      *        STOP RUN
      *    END-IF.

      *> === PASO 5: Leer registro por registro ===
      *> Descomenta las siguientes 18 líneas:
      *    DISPLAY "ID     Nombre                    Saldo".
      *    DISPLAY WS-SUBSEPARADOR.
      *    PERFORM UNTIL CLI-EOF
      *        READ CLIENTES
      *            AT END
      *                SET CLI-EOF TO TRUE
      *            NOT AT END
      *                ADD 1 TO WS-CONTADOR
      *                MOVE CLI-SALDO TO WS-SALDO-EDIT
      *                DISPLAY CLI-ID "  "
      *                        CLI-NOMBRE "  "
      *                        WS-SALDO-EDIT
      *        END-READ
      *    END-PERFORM.

      *> === PASO 6: Resumen y cierre ===
      *> Descomenta las siguientes 6 líneas:
      *    DISPLAY WS-SUBSEPARADOR.
      *    DISPLAY "Total de clientes: " WS-CONTADOR.
      *    DISPLAY " ".
      *    CLOSE CLIENTES.
      *    DISPLAY "Archivo procesado exitosamente.".
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> ID     Nombre                    Saldo
      *> ------------------------------------------
      *> 00001  Juan Perez                $ 15,000.00
      *> 00002  Maria Garcia              $ 25,000.00
      *> 00003  Carlos Lopez              $ 10,000.75
      *> 00004  Ana Martinez              $ 50,000.00
      *> 00005  Pedro Rodriguez           $  3,500.25
      *> ------------------------------------------
      *> Total de clientes: 00005
