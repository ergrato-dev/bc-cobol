       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Reporte Formateado
      *> ============================================
      *> Edición profesional: moneda, fechas, supresión
      *> de ceros, signos flotantes.
      *>
      *> Compilar: cobc -x -free reporte-formateado.cbl
      *> Ejecutar: ./reporte-formateado

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FORMATO.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Datos de prueba simulados
       01  WS-SALDO         PIC S9(09)V99 VALUE 1500750.
       01  WS-SALDO-NEG     PIC S9(09)V99 VALUE -350025.
       01  WS-FECHA         PIC 9(08) VALUE 20260620.
       01  WS-TASA           PIC 9V99 VALUE 3.50.
       01  WS-CONT           PIC 9(05) VALUE 42.

      *> Campos de edición (varios formatos)
       01  WS-EDIT-BASICO   PIC Z,ZZZ,ZZ9.99.
       01  WS-EDIT-MONEDA   PIC $$,$$$,$$9.99.
       01  WS-EDIT-ASTER    PIC **,***,**9.99.
       01  WS-EDIT-SIGNO    PIC -Z,ZZZ,ZZ9.99.
       01  WS-EDIT-CR       PIC Z,ZZZ,ZZ9.99CR.
       01  WS-EDIT-DB       PIC Z,ZZZ,ZZ9.99DB.
       01  WS-EDIT-CONT     PIC ZZ,ZZ9.
       01  WS-EDIT-TASA     PIC Z9.99.
       01  WS-EDIT-FECHA    PIC 99/99/9999.

       01  WS-SEP           PIC X(70) VALUE ALL "=".

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY WS-SEP.
           DISPLAY "    DEMOSTRACION DE FORMATOS DE EDICION".
           DISPLAY WS-SEP.
           DISPLAY " ".

      *> Formatear campos
           MOVE WS-SALDO TO WS-EDIT-BASICO.
           MOVE WS-SALDO TO WS-EDIT-MONEDA.
           MOVE WS-SALDO TO WS-EDIT-ASTER.
           MOVE WS-CONT TO WS-EDIT-CONT.
           MOVE WS-TASA TO WS-EDIT-TASA.
           MOVE WS-FECHA TO WS-EDIT-FECHA.

           DISPLAY "Valor interno : " WS-SALDO.
           DISPLAY "  Basico       : " WS-EDIT-BASICO.
           DISPLAY "  Moneda       : " WS-EDIT-MONEDA.
           DISPLAY "  Asterisco    : " WS-EDIT-ASTER.
           DISPLAY "  Contador     : " WS-EDIT-CONT.
           DISPLAY " ".

      *> Demostrar formatos de signo
           DISPLAY "--- Formatos con signo ---".
           MOVE WS-SALDO-NEG TO WS-EDIT-SIGNO.
           MOVE WS-SALDO-NEG TO WS-EDIT-CR.
           MOVE WS-SALDO TO WS-EDIT-DB.
           DISPLAY "  Neg con signo: " WS-EDIT-SIGNO.
           DISPLAY "  Neg CR       : " WS-EDIT-CR.
           DISPLAY "  Pos DB       : " WS-EDIT-DB.
           DISPLAY " ".

      *> Fecha y tasa
           DISPLAY "--- Fecha y porcentaje ---".
           DISPLAY "  Fecha interna: " WS-FECHA.
           DISPLAY "  Fecha editada: " WS-EDIT-FECHA.
           DISPLAY "  Tasa          : " WS-EDIT-TASA "%".
           DISPLAY " ".

      *> Comparativa sin edición vs con edición
           DISPLAY "--- Antes vs Despues ---".
           DISPLAY "  ID sin editar : " WS-CONT.
           DISPLAY "  ID editado    : " WS-EDIT-CONT.
           DISPLAY "  (sin editar muestra ceros a la izquierda)".
           DISPLAY " ".
           STOP RUN.
