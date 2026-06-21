       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Crear Catálogo (datos iniciales)
      *> Semana 05 - Archivos Indexados
      *> ============================================
      *> Crea catalogo.idx con 8 productos bancarios.
      *> Ejecutar UNA SOLA VEZ antes del CRUD.
      *>
      *> Compilar: cobc -x -free crear-catalogo.cbl
      *> Ejecutar: ./crear-catalogo

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREACAT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CATALOGO ASSIGN TO "catalogo.idx"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS SEQUENTIAL
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
       01  WS-FS-CAT          PIC X(02).
           88 CAT-OK          VALUE "00".
           88 CAT-DUP         VALUE "22".
       01  WS-CONT            PIC 9(02) VALUE ZEROS.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== CREANDO CATALOGO DE PRODUCTOS ===".
           OPEN OUTPUT CATALOGO.

           MOVE 1001 TO CAT-ID.
           MOVE "Cuenta Corriente Basica" TO CAT-NOMBRE.
           MOVE "CC" TO CAT-TIPO.
           MOVE 0 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 1002 TO CAT-ID.
           MOVE "Cuenta Corriente Premium" TO CAT-NOMBRE.
           MOVE "CC" TO CAT-TIPO.
           MOVE 500.00 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 2001 TO CAT-ID.
           MOVE "Caja de Ahorro Basica" TO CAT-NOMBRE.
           MOVE "CA" TO CAT-TIPO.
           MOVE 0 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 2002 TO CAT-ID.
           MOVE "Caja de Ahorro Plus" TO CAT-NOMBRE.
           MOVE "CA" TO CAT-TIPO.
           MOVE 150.00 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 3001 TO CAT-ID.
           MOVE "Plazo Fijo 30 Dias" TO CAT-NOMBRE.
           MOVE "PF" TO CAT-TIPO.
           MOVE 1000.00 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 3002 TO CAT-ID.
           MOVE "Plazo Fijo 90 Dias" TO CAT-NOMBRE.
           MOVE "PF" TO CAT-TIPO.
           MOVE 5000.00 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 4001 TO CAT-ID.
           MOVE "Tarjeta de Credito Clasica" TO CAT-NOMBRE.
           MOVE "TC" TO CAT-TIPO.
           MOVE 800.00 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           MOVE 4002 TO CAT-ID.
           MOVE "Tarjeta de Credito Platinum" TO CAT-NOMBRE.
           MOVE "TC" TO CAT-TIPO.
           MOVE 2500.00 TO CAT-PRECIO.
           MOVE "A" TO CAT-ESTADO.
           WRITE CAT-REG. ADD 1 TO WS-CONT.

           CLOSE CATALOGO.
           DISPLAY "Productos creados: " WS-CONT.
           DISPLAY "Archivo: catalogo.idx".
           STOP RUN.
