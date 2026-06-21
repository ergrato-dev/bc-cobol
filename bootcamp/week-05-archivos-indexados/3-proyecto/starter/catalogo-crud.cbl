       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: CRUD Catálogo de Productos
      *> Semana 05 - Archivos Indexados
      *> ============================================
      *> Menú CRUD sobre catalogo.idx con DYNAMIC.
      *> REQUIERE: ejecutar ./crear-catalogo primero.
      *>
      *> Compilar: cobc -x -free catalogo-crud.cbl
      *> Ejecutar: ./catalogo-crud

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CATCRUD.
       AUTHOR. ESTUDIANTE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CATALOGO ASSIGN TO "catalogo.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS CAT-ID
               ALTERNATE RECORD KEY IS CAT-TIPO
                   WITH DUPLICATES
               FILE STATUS IS WS-FS-CAT.

       DATA DIVISION.
       FILE SECTION.
       FD  CATALOGO.
       01  CAT-REG.
           05 CAT-ID         PIC 9(05).
           05 CAT-NOMBRE     PIC X(30).
           05 CAT-TIPO       PIC X(02).
           05 CAT-PRECIO     PIC 9(06)V99.
           05 CAT-ESTADO     PIC X(01).

       WORKING-STORAGE SECTION.

      *> FILE STATUS con 88-level
       01  WS-FS-CAT          PIC X(02).
           88 CAT-OK          VALUE "00".
           88 CAT-EOF         VALUE "10".
           88 CAT-DUP         VALUE "22".
           88 CAT-NOT-FOUND   VALUE "23".

      *> Menú y campos de trabajo
       01  WS-OPCION          PIC 9 VALUE ZEROS.
       01  WS-ID              PIC 9(05) VALUE ZEROS.
       01  WS-PRECIO-EDIT     PIC $$,$$9.99.
       01  WS-NUEVO-PRECIO    PIC 9(06)V99 VALUE ZEROS.
       01  WS-SEP             PIC X(50) VALUE ALL "=".

      *> TODO 1: Variable para ALTERNATE KEY (por tipo)
      *01  WS-TIPO-BUSCAR     PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN.
      *    TODO 2: Abrir con OPEN I-O y mostrar menú
      *    OPEN I-O CATALOGO
           PERFORM UNTIL WS-OPCION = 9
               DISPLAY " ".
               DISPLAY "=== CATALOGO DE PRODUCTOS BANCARIOS ===".
               DISPLAY "1. Consultar producto".
               DISPLAY "2. Agregar producto".
               DISPLAY "3. Modificar precio".
               DISPLAY "4. Eliminar producto".
               DISPLAY "5. Listar todos (START)".
               DISPLAY "6. Listar por tipo (ALT KEY)".
               DISPLAY "9. Salir".
               DISPLAY "Opcion: " WITH NO ADVANCING.
               ACCEPT WS-OPCION.

      *        TODO 3: EVALUATE para llamar a cada párrafo
      *        EVALUATE WS-OPCION
      *            WHEN 1 PERFORM 2000-CONSULTAR
      *            WHEN 2 PERFORM 3000-AGREGAR
      *            WHEN 3 PERFORM 4000-MODIFICAR
      *            WHEN 4 PERFORM 5000-ELIMINAR
      *            WHEN 5 PERFORM 6000-LISTAR-TODOS
      *            WHEN 6 PERFORM 7000-LISTAR-POR-TIPO
      *        END-EVALUATE
           END-PERFORM.
           CLOSE CATALOGO.
           STOP RUN.

      *> ============================================
      *> TODO 4: CONSULTAR POR ID
      *> ============================================
       2000-CONSULTAR.
      *    DISPLAY "ID del producto: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    READ CATALOGO KEY IS WS-ID
      *        INVALID KEY DISPLAY "Producto no encontrado"
      *        NOT INVALID KEY
      *            MOVE CAT-PRECIO TO WS-PRECIO-EDIT
      *            DISPLAY WS-SEP
      *            DISPLAY "ID     : " CAT-ID
      *            DISPLAY "Nombre : " CAT-NOMBRE
      *            DISPLAY "Tipo   : " CAT-TIPO
      *            DISPLAY "Precio : " WS-PRECIO-EDIT
      *            DISPLAY "Estado : " CAT-ESTADO
      *            DISPLAY WS-SEP
      *    END-READ.

      *> ============================================
      *> TODO 5: AGREGAR PRODUCTO
      *> ============================================
       3000-AGREGAR.
      *    DISPLAY "ID nuevo       : " WITH NO ADVANCING.
      *    ACCEPT CAT-ID.
      *    DISPLAY "Nombre         : " WITH NO ADVANCING.
      *    ACCEPT CAT-NOMBRE.
      *    DISPLAY "Tipo (CC/CA/PF/TC): " WITH NO ADVANCING.
      *    ACCEPT CAT-TIPO.
      *    DISPLAY "Precio         : " WITH NO ADVANCING.
      *    ACCEPT CAT-PRECIO.
      *    MOVE "A" TO CAT-ESTADO.
      *    WRITE CAT-REG
      *        INVALID KEY
      *            IF CAT-DUP
      *                DISPLAY "ERROR: ID " CAT-ID " ya existe"
      *            ELSE
      *                DISPLAY "ERROR al agregar. FS=" WS-FS-CAT
      *            END-IF
      *        NOT INVALID KEY
      *            DISPLAY "Producto agregado exitosamente"
      *    END-WRITE.

      *> ============================================
      *> TODO 6: MODIFICAR PRECIO
      *> ============================================
       4000-MODIFICAR.
      *    DISPLAY "ID a modificar: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    READ CATALOGO KEY IS WS-ID
      *        INVALID KEY DISPLAY "No encontrado"
      *        NOT INVALID KEY
      *            MOVE CAT-PRECIO TO WS-PRECIO-EDIT
      *            DISPLAY "Precio actual : " WS-PRECIO-EDIT
      *            DISPLAY "Nuevo precio  : " WITH NO ADVANCING
      *            ACCEPT WS-NUEVO-PRECIO
      *            MOVE WS-NUEVO-PRECIO TO CAT-PRECIO
      *            REWRITE CAT-REG
      *                INVALID KEY
      *                    DISPLAY "ERROR al modificar"
      *                NOT INVALID KEY
      *                    DISPLAY "Precio actualizado"
      *            END-REWRITE
      *    END-READ.

      *> ============================================
      *> TODO 7: ELIMINAR PRODUCTO
      *> ============================================
       5000-ELIMINAR.
      *    DISPLAY "ID a eliminar: " WITH NO ADVANCING.
      *    ACCEPT WS-ID.
      *    READ CATALOGO KEY IS WS-ID
      *        INVALID KEY DISPLAY "No encontrado"
      *        NOT INVALID KEY
      *            DELETE CATALOGO RECORD
      *                INVALID KEY DISPLAY "ERROR al eliminar"
      *                NOT INVALID KEY DISPLAY "Producto eliminado"
      *            END-DELETE
      *    END-READ.

      *> ============================================
      *> TODO 8: LISTAR TODOS CON START
      *> ============================================
       6000-LISTAR-TODOS.
      *    MOVE ZEROS TO CAT-ID.
      *    START CATALOGO KEY IS GREATER THAN CAT-ID
      *        INVALID KEY DISPLAY "Catalogo vacio"
      *        NOT INVALID KEY
      *            DISPLAY "ID     Nombre                         Tipo Precio"
      *            DISPLAY "-----  ------------------------------ ---- ----------"
      *            MOVE "N" TO WS-FS-CAT
      *            PERFORM UNTIL CAT-EOF
      *                READ CATALOGO NEXT RECORD
      *                    AT END SET CAT-EOF TO TRUE
      *                    NOT AT END
      *                        MOVE CAT-PRECIO TO WS-PRECIO-EDIT
      *                        DISPLAY CAT-ID " " CAT-NOMBRE " "
      *                                CAT-TIPO " " WS-PRECIO-EDIT
      *                END-READ
      *            END-PERFORM
      *    END-START.

      *> ============================================
      *> TODO 9: LISTAR POR TIPO (ALTERNATE KEY)
      *> ============================================
       7000-LISTAR-POR-TIPO.
      *    DISPLAY "Tipo (CC/CA/PF/TC): " WITH NO ADVANCING.
      *    ACCEPT WS-TIPO-BUSCAR.
      *    MOVE WS-TIPO-BUSCAR TO CAT-TIPO.
      *    READ CATALOGO KEY IS CAT-TIPO
      *        INVALID KEY
      *            DISPLAY "No hay productos de tipo " WS-TIPO-BUSCAR
      *        NOT INVALID KEY
      *            DISPLAY "Productos tipo " WS-TIPO-BUSCAR ":"
      *            MOVE "N" TO WS-FS-CAT
      *            PERFORM UNTIL CAT-EOF
      *                IF CAT-TIPO = WS-TIPO-BUSCAR
      *                    MOVE CAT-PRECIO TO WS-PRECIO-EDIT
      *                    DISPLAY CAT-ID " " CAT-NOMBRE
      *                            " " WS-PRECIO-EDIT
      *                END-IF
      *                READ CATALOGO NEXT RECORD
      *                    AT END SET CAT-EOF TO TRUE
      *                END-READ
      *            END-PERFORM
      *    END-READ.

      *> ============================================
      *> RESULTADO ESPERADO
      *> ============================================
      *> Opción 1, ID=3001:
      *>   Plazo Fijo 30 Dias  PF  $ 1,000.00
      *> Opción 6, Tipo=CC:
      *>   1001 Cuenta Corriente Basica
      *>   1002 Cuenta Corriente Premium
      *> Opción 4, ID=2002 → eliminado
      *> Opción 3, ID=4001, precio 800→950:
      *>   Tarjeta de Credito Clasica  TC  $   950.00
