       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 1: Consulta SQL Simple
      *> ============================================
      *> SELECT INTO con host variables.
      *> Verifica SQLCODE después de cada operación.
      *>
      *> Requiere PostgreSQL corriendo en db:5432
      *> Compilar: cobc -x -free consulta-simple.cbl
      *> Ejecutar: ./consulta-simple

       IDENTIFICATION DIVISION.
       PROGRAM-ID. SQLCONS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Host variables ===
      *> Descomenta las siguientes 7 líneas:
      *01  WS-CLI-ID        PIC 9(05) VALUE ZEROS.
      *01  WS-CLI-NOMBRE    PIC X(50) VALUE SPACES.
      *01  WS-CLI-APELLIDO  PIC X(50) VALUE SPACES.
      *01  WS-CLI-EMAIL     PIC X(100) VALUE SPACES.
      *01  WS-SQLCODE       PIC S9(09) USAGE COMP.
      *    88 SQL-OK         VALUE 0.
      *    88 SQL-NOT-FOUND  VALUE 100.

      *> === PASO 2: Conexión a la BD ===
      *> Variables de entorno configuradas en docker-compose
      *> Descomenta las siguientes 9 líneas:
      *PROCEDURE DIVISION.
      *MAIN.
      *    DISPLAY "=== CONSULTA SQL EMBEBIDO ===".
      *    DISPLAY " ".
      *    EXEC SQL
      *        CONNECT TO :WS-DB-NAME USER :WS-DB-USER
      *    END-EXEC.
      *    IF NOT SQL-OK
      *        DISPLAY "Error de conexion: " WS-SQLCODE
      *        STOP RUN
      *    END-IF.

      *> === PASO 3: Consultar un cliente específico ===
      *> Descomenta las siguientes 12 líneas:
      *    DISPLAY "Consultando cliente ID=1...".
      *    MOVE 1 TO WS-CLI-ID.
      *    EXEC SQL
      *        SELECT NOMBRE, APELLIDO, EMAIL
      *        INTO :WS-CLI-NOMBRE, :WS-CLI-APELLIDO,
      *             :WS-CLI-EMAIL
      *        FROM CLIENTES
      *        WHERE ID_CLIENTE = :WS-CLI-ID
      *    END-EXEC.
      *    EVALUATE TRUE
      *        WHEN SQL-OK
      *            DISPLAY "Encontrado: "
      *                    WS-CLI-NOMBRE " " WS-CLI-APELLIDO

      *> === PASO 4: Mostrar email y probar NOT FOUND ===
      *> Descomenta las siguientes 12 líneas:
      *            DISPLAY "Email     : " WS-CLI-EMAIL
      *        WHEN SQL-NOT-FOUND
      *            DISPLAY "Cliente " WS-CLI-ID " no encontrado"
      *    END-EVALUATE.
      *    DISPLAY " ".
      *    DISPLAY "Consultando cliente inexistente ID=99999...".
      *    MOVE 99999 TO WS-CLI-ID.
      *    EXEC SQL
      *        SELECT NOMBRE INTO :WS-CLI-NOMBRE
      *        FROM CLIENTES WHERE ID_CLIENTE = :WS-CLI-ID
      *    END-EXEC.
      *    IF SQL-NOT-FOUND
      *        DISPLAY "Correcto: cliente no encontrado (SQLCODE=100)"
      *    END-IF.

      *> === PASO 5: Contar total de clientes ===
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY " ".
      *    DISPLAY "--- Totales ---".
      *    EXEC SQL
      *        SELECT COUNT(*) INTO :WS-CLI-ID
      *        FROM CLIENTES
      *    END-EXEC.
      *    DISPLAY "Total clientes en BD: " WS-CLI-ID.
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> Encontrado: Juan Perez
      *> Email     : juan@email.com
      *> Correcto: cliente no encontrado (SQLCODE=100)
      *> Total clientes en BD: 00005
