       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Sistema de Clientes con SQL Embebido
      *> Semana 11 - SQL Embebido
      *> ============================================
      *> CRUD sobre tabla CLIENTES (PostgreSQL).
      *> Usa EXEC SQL, cursores, host variables.
      *>
      *> Requiere PostgreSQL corriendo (docker compose)
      *> Compilar: cobc -x -free sistema-clientes-db.cbl
      *> Ejecutar: ./sistema-clientes-db

       IDENTIFICATION DIVISION.
       PROGRAM-ID. SISCLIDB.
       AUTHOR. ESTUDIANTE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> Host variables — mapean columnas de CLIENTES
       01  WS-CLI-ID        PIC 9(05) VALUE ZEROS.
       01  WS-CLI-NOMBRE    PIC X(50) VALUE SPACES.
       01  WS-CLI-APELLIDO  PIC X(50) VALUE SPACES.
       01  WS-CLI-EMAIL     PIC X(100) VALUE SPACES.
       01  WS-CLI-TELEFONO  PIC X(20) VALUE SPACES.
       01  WS-CLI-ESTADO    PIC X(01) VALUE SPACES.

      *> SQLCODE
       01  WS-SQLCODE       PIC S9(09) USAGE COMP.
           88 SQL-OK         VALUE 0.
           88 SQL-NOT-FOUND  VALUE 100.
           88 SQL-ERROR      VALUE -999 THRU -1.

      *> Menú
       01  WS-OPCION        PIC 9 VALUE ZEROS.
       01  WS-CONT          PIC 9(05) VALUE ZEROS.
       01  WS-SEP           PIC X(50) VALUE ALL "=".

      *> Declarar cursor
           EXEC SQL
               DECLARE C-TODOS CURSOR FOR
                   SELECT ID_CLIENTE, NOMBRE, APELLIDO, ESTADO
                   FROM CLIENTES
                   ORDER BY ID_CLIENTE
           END-EXEC.

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 1: Conectar a la BD
      *    EXEC SQL CONNECT ... END-EXEC
      *    IF NOT SQL-OK mostrar error, STOP RUN

      *    TODO 2: Menú principal
      *    PERFORM UNTIL WS-OPCION = 9
      *        Mostrar 1=Consultar 2=Listar 3=Insertar 4=Modificar 5=Eliminar 9=Salir
      *        ACCEPT WS-OPCION
      *        EVALUATE WS-OPCION
      *            WHEN 1 PERFORM 2000-CONSULTAR
      *            WHEN 2 PERFORM 3000-LISTAR  (cursor)
      *            WHEN 3 PERFORM 4000-INSERTAR
      *            WHEN 4 PERFORM 5000-MODIFICAR
      *            WHEN 5 PERFORM 6000-ELIMINAR
      *        END-EVALUATE
      *    END-PERFORM
      *    EXEC SQL DISCONNECT END-EXEC
           STOP RUN.

       2000-CONSULTAR.
      *    TODO 3: SELECT INTO por ID
      *    Solicitar WS-CLI-ID
      *    EXEC SQL SELECT ... INTO host-vars WHERE ID_CLIENTE = :WS-CLI-ID
      *    IF SQL-OK mostrar datos
      *    IF SQL-NOT-FOUND mensaje "no encontrado"
           EXIT.

       3000-LISTAR.
      *    TODO 4: CURSOR — OPEN, FETCH loop, CLOSE
      *    EXEC SQL OPEN C-TODOS END-EXEC
      *    PERFORM UNTIL SQL-NOT-FOUND
      *        EXEC SQL FETCH C-TODOS INTO :WS-CLI-ID, ...
      *        IF SQL-OK display
      *    END-PERFORM
      *    EXEC SQL CLOSE C-TODOS END-EXEC
           EXIT.

       4000-INSERTAR.
      *    TODO 5: INSERT parametrizado
      *    Solicitar nombre, apellido, email, teléfono
      *    EXEC SQL INSERT INTO CLIENTES (...) VALUES (:vars...)
      *    IF SQL-OK → COMMIT
      *    ELSE → ROLLBACK, mostrar error
           EXIT.

       5000-MODIFICAR.
      *    TODO 6: UPDATE estado
      *    Solicitar ID y nuevo estado (A/I)
      *    EXEC SQL UPDATE CLIENTES SET ESTADO = :WS-CLI-ESTADO WHERE ID_CLIENTE = :WS-CLI-ID
      *    Verificar SQLCODE, COMMIT o ROLLBACK
           EXIT.

       6000-ELIMINAR.
      *    TODO 7: DELETE con confirmación
      *    Solicitar ID, mostrar datos, pedir confirmación
      *    EXEC SQL DELETE FROM CLIENTES WHERE ID_CLIENTE = :WS-CLI-ID
      *    Verificar SQLCODE, COMMIT o ROLLBACK
           EXIT.

      *> ============================================
      *> RESULTADO ESPERADO
      *> ============================================
      *> Opción 1, ID=1:
      *>   ID=1, Nombre=Juan Perez, Email=juan@email.com
      *> Opción 2:
      *>   Muestra 5 clientes ordenados por ID
      *> Opción 3:
      *>   Insertar: Laura, Fernandez, laura@email.com
      *> Opción 4, ID=3, estado=I:
      *>   Carlos Lopez → INACTIVO
