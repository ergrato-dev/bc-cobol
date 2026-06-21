       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Inserción Parametrizada
      *> ============================================
      *> INSERT con parámetros desde host variables.
      *> Validación de SQLCODE, detección de duplicados.
      *>
      *> Compilar: cobc -x -free insercion-parametrizada.cbl
      *> Ejecutar: ./insercion-parametrizada

       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQLINS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Host variables ===
      *> Descomenta las siguientes 9 líneas:
      *01  WS-NOMBRE        PIC X(50).
      *01  WS-APELLIDO      PIC X(50).
      *01  WS-EMAIL         PIC X(100).
      *01  WS-TELEFONO      PIC X(20).
      *01  WS-SQLCODE       PIC S9(09) USAGE COMP.
      *    88 SQL-OK         VALUE 0.
      *    88 SQL-DUP        VALUE -803.
      *01  WS-ID-NUEVO       PIC 9(05).
      *01  WS-SEP            PIC X(50) VALUE ALL "=".

       PROCEDURE DIVISION.
      *> === PASO 2: Entrada de datos ===
      *> Descomenta las siguientes 7 líneas:
      *MAIN.
      *    DISPLAY WS-SEP.
      *    DISPLAY "    INSERTAR CLIENTE (SQL EMBEBIDO)".
      *    DISPLAY WS-SEP.
      *    DISPLAY " ".
      *    DISPLAY "Nombre  : " WITH NO ADVANCING.
      *    ACCEPT WS-NOMBRE.

      *> === PASO 3: Más entrada ===
      *> Descomenta las siguientes 6 líneas:
      *    DISPLAY "Apellido: " WITH NO ADVANCING.
      *    ACCEPT WS-APELLIDO.
      *    DISPLAY "Email   : " WITH NO ADVANCING.
      *    ACCEPT WS-EMAIL.
      *    DISPLAY "Telefono: " WITH NO ADVANCING.
      *    ACCEPT WS-TELEFONO.

      *> === PASO 4: INSERT parametrizado ===
      *> Descomenta las siguientes 12 líneas:
      *    EXEC SQL
      *        INSERT INTO CLIENTES
      *            (NOMBRE, APELLIDO, EMAIL, TELEFONO)
      *        VALUES
      *            (:WS-NOMBRE, :WS-APELLIDO,
      *             :WS-EMAIL, :WS-TELEFONO)
      *    END-EXEC.
      *    EVALUATE TRUE
      *        WHEN SQL-OK
      *            DISPLAY " ".
      *            DISPLAY "Cliente insertado correctamente"
      *            DISPLAY "Nombre: " WS-NOMBRE " " WS-APELLIDO

      *> === PASO 5: Manejo de errores ===
      *> Descomenta las siguientes 8 líneas:
      *        WHEN SQL-DUP
      *            DISPLAY "ERROR: Email duplicado"
      *        WHEN OTHER
      *            DISPLAY "ERROR SQL: " WS-SQLCODE
      *    END-EVALUATE.
      *    DISPLAY " ".
      *    DISPLAY "Verificar en BD:".
      *    DISPLAY "  psql -h db -U cobol -d bootcamp".
      *    DISPLAY "  SELECT * FROM CLIENTES;".
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Entrada: Laura, Fernandez, laura@email.com, 555-0106
      *> Salida: Cliente insertado correctamente
      *> Intentar duplicar email → ERROR: Email duplicado
