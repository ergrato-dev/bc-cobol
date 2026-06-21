       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> PROYECTO: Sistema de Registro Profesional
      *> Semana 01 - Introducción a COBOL
      *> ============================================
      *>
      *> INSTRUCCIONES:
      *>   Completa cada TODO con tu implementación.
      *>   Usa los verbos: DISPLAY, ACCEPT, MOVE, IF, PERFORM.
      *>   Compila: cobc -x -free presentacion.cbl
      *>   Ejecuta: ./presentacion
      *>
      *> Consulta 2-practicas/ para recordar la sintaxis.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRESENTA.
       AUTHOR. ESTUDIANTE.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. LINUX.
       OBJECT-COMPUTER. LINUX.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> Variables para datos del usuario
       01  WS-NOMBRE      PIC X(30) VALUE SPACES.
       01  WS-APELLIDO    PIC X(30) VALUE SPACES.
       01  WS-EDAD        PIC 9(03) VALUE ZEROS.
       01  WS-CIUDAD      PIC X(30) VALUE SPACES.
       01  WS-PROFESION   PIC X(30) VALUE SPACES.

      *> Variables de trabajo para la presentación
       01  WS-LINEA       PIC X(50) VALUE SPACES.
       01  WS-BORDE-H     PIC X(50) VALUE ALL "═".
       01  WS-BORDE-S     PIC X(50) VALUE ALL "─".
       01  WS-NOMBRE-COMPLETO PIC X(61) VALUE SPACES.

      *> Variable para validación
       01  WS-CAMPOS-OK   PIC 9     VALUE 0.
           88 CAMPOS-LLENOS        VALUE 1.

       PROCEDURE DIVISION.

      *> ============================================
      *> Párrafo principal - orquesta el programa
      *> ============================================
       MAIN.
      *    TODO: PERFORM para llamar a 1000-INICIO
      *    TODO: PERFORM para llamar a 2000-ENTRADA
      *    TODO: PERFORM para llamar a 3000-VALIDAR
      *    TODO: IF CAMPOS-LLENOS: PERFORM 4000-PRESENTACION
      *          ELSE: PERFORM 8000-ERROR
      *    TODO: PERFORM para llamar a 9000-FINAL
           STOP RUN.

      *> ============================================
      *> Párrafo 1000-INICIO: Muestra encabezado
      *> ============================================
       1000-INICIO.
      *    TODO: Mostrar borde superior con ╔ y ╗
      *          Pista: DISPLAY "╔" WS-BORDE-H(1:48) "╗"
      *    TODO: Mostrar título centrado "SISTEMA DE REGISTRO PROFESIONAL"
      *    TODO: Mostrar borde inferior con ╚ y ╝
      *    TODO: Mostrar línea en blanco (DISPLAY " ")
           EXIT.

      *> ============================================
      *> Párrafo 2000-ENTRADA: Solicita datos al usuario
      *> ============================================
       2000-ENTRADA.
      *    TODO: Pedir nombre con DISPLAY y ACCEPT
      *    TODO: Pedir apellido con DISPLAY y ACCEPT
      *    TODO: Pedir edad con DISPLAY y ACCEPT
      *    TODO: Pedir ciudad con DISPLAY y ACCEPT
      *    TODO: Pedir profesión con DISPLAY y ACCEPT
      *    TODO: Mostrar línea en blanco
           EXIT.

      *> ============================================
      *> Párrafo 3000-VALIDAR: Verifica datos obligatorios
      *> ============================================
       3000-VALIDAR.
      *    TODO: IF WS-NOMBRE NOT = SPACES AND WS-APELLIDO NOT = SPACES
      *          THEN MOVE 1 TO WS-CAMPOS-OK
      *          ELSE MOVE 0 TO WS-CAMPOS-OK
           EXIT.

      *> ============================================
      *> Párrafo 4000-PRESENTACION: Muestra tarjeta de presentación
      *> ============================================
       4000-PRESENTACION.
      *    TODO: Construir nombre completo con STRING o MOVE
      *          Pista: STRING WS-NOMBRE DELIMITED BY "  "
      *                       " "   DELIMITED BY SIZE
      *                       WS-APELLIDO DELIMITED BY "  "
      *                 INTO WS-NOMBRE-COMPLETO
      *    TODO: Mostrar borde superior de tarjeta (╔ ═ ╗)
      *    TODO: Mostrar "TARJETA DE PRESENTACION" centrado
      *    TODO: Mostrar separador (╠ ═ ╣)
      *    TODO: Mostrar línea en blanco (║ espacios ║)
      *    TODO: Mostrar nombre completo (║   Nombre   : ... ║)
      *    TODO: Mostrar edad (║   Edad     : ... ║)
      *    TODO: Mostrar ciudad (║   Ciudad   : ... ║)
      *    TODO: Mostrar profesión (║   Profesion: ... ║)
      *    TODO: Mostrar línea en blanco (║ espacios ║)
      *    TODO: Mostrar borde inferior de tarjeta (╚ ═ ╝)
           EXIT.

      *> ============================================
      *> Párrafo 8000-ERROR: Muestra mensaje de error
      *> ============================================
       8000-ERROR.
      *    TODO: Mostrar mensaje "ERROR: Nombre y apellido son obligatorios"
      *    TODO: Mostrar mensaje "Por favor, complete todos los campos."
           EXIT.

      *> ============================================
      *> Párrafo 9000-FINAL: Despedida
      *> ============================================
       9000-FINAL.
      *    TODO: Mostrar línea en blanco
      *    TODO: Mostrar "Gracias por registrarte, " WS-NOMBRE "!"
      *    TODO: Mostrar "Bienvenido al Bootcamp COBOL Zero to Hero."
           EXIT.

      *> ============================================
      *> FIN DEL PROGRAMA - PRESENTA
      *> ============================================
