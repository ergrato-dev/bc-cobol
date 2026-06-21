       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 3: Limpiar Datos con INSPECT
      *> ============================================
      *> INSPECT TALLYING, REPLACING, CONVERTING.
      *> FUNCTION TRIM, UPPER-CASE, NUMVAL.
      *>
      *> Compilar: cobc -x -free limpiar-datos.cbl
      *> Ejecutar: ./limpiar-datos

       IDENTIFICATION DIVISION.
       PROGRAM-ID. LIMPIAR.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *> === PASO 1: Datos de prueba ===
      *> Descomenta las siguientes 9 líneas:
      *01  WS-TEXTO-SUCIO   PIC X(40) VALUE "  JUAN  PEREZ  ".
      *01  WS-TELEFONO      PIC X(20) VALUE "(555) 010-1234".
      *01  WS-MONTO-TXT     PIC X(15) VALUE "$ 12,345.67".
      *01  WS-TARJETA       PIC X(19) VALUE "1234-5678-9012-3456".
      *01  WS-CONT-DIGITOS  PIC 9(03) VALUE ZEROS.
      *01  WS-CONT-GUIONES  PIC 9(03) VALUE ZEROS.
      *01  WS-MONTO-NUM     PIC 9(07)V99 VALUE ZEROS.
      *01  WS-MONTO-EDIT    PIC $$,$$9.99.
      *01  WS-SEP           PIC X(60) VALUE ALL "-".

       PROCEDURE DIVISION.
      *> === PASO 2: Limpiar espacios con INSPECT y TRIM ===
      *> Descomenta las siguientes 7 líneas:
      *MAIN.
      *    DISPLAY "=== LIMPIEZA DE DATOS ===".
      *    DISPLAY " ".
      *    DISPLAY "1. Limpieza de espacios:".
      *    DISPLAY "   Texto original : [" WS-TEXTO-SUCIO "]".
      *    INSPECT WS-TEXTO-SUCIO
      *        REPLACING ALL "  " BY " ".    *> Reduce dobles espacios
      *    DISPLAY "   Sin dobles esp : [" WS-TEXTO-SUCIO "]".

      *> No se puede eliminar todos los espacios múltiples
      *> de una sola pasada con INSPECT. TRIM resuelve:
      *    DISPLAY "   Con TRIM       : ["
      *            FUNCTION TRIM(WS-TEXTO-SUCIO) "]".

      *> === PASO 3: Contar con TALLYING ===
      *> Descomenta las siguientes 9 líneas:
      *    DISPLAY " ".
      *    DISPLAY "2. Conteo de caracteres en telefono:".
      *    DISPLAY "   Telefono: " WS-TELEFONO.
      *    INSPECT WS-TELEFONO
      *        TALLYING WS-CONT-DIGITOS
      *            FOR ALL "0" "1" "2" "3" "4"
      *                     "5" "6" "7" "8" "9".
      *    DISPLAY "   Digitos encontrados: " WS-CONT-DIGITOS.
      *    INSPECT WS-TELEFONO
      *        TALLYING WS-CONT-GUIONES FOR ALL "-".
      *    DISPLAY "   Guiones encontrados: " WS-CONT-GUIONES.

      *> === PASO 4: Convertir texto a número ===
      *> Descomenta las siguientes 8 líneas:
      *    DISPLAY " ".
      *    DISPLAY "3. Conversion texto → numero:".
      *    DISPLAY "   Monto texto: [" WS-MONTO-TXT "]".
      *    COMPUTE WS-MONTO-NUM =
      *        FUNCTION NUMVAL-C(WS-MONTO-TXT).
      *    MOVE WS-MONTO-NUM TO WS-MONTO-EDIT.
      *    DISPLAY "   Monto numerico: " WS-MONTO-NUM.
      *    DISPLAY "   Monto editado : " WS-MONTO-EDIT.

      *> === PASO 5: Enmascarar datos sensibles ===
      *> Descomenta las siguientes 12 líneas:
      *    DISPLAY " ".
      *    DISPLAY "4. Enmascaramiento de tarjeta:".
      *    DISPLAY "   Original : " WS-TARJETA.
      *    MOVE "*" TO WS-TARJETA(1:1).
      *    MOVE "*" TO WS-TARJETA(2:1).
      *    MOVE "*" TO WS-TARJETA(3:1).
      *    MOVE "*" TO WS-TARJETA(4:1).
      *    INSPECT WS-TARJETA
      *        REPLACING ALL "5" BY "*"
      *                  ALL "6" BY "*"
      *                  ALL "7" BY "*"
      *                  ALL "8" BY "*"
      *                  ALL "9" BY "*"
      *        BEFORE INITIAL " ".
      *    DISPLAY "   Enmascarado: " WS-TARJETA.

      *> === PASO 6: Mostrar en mayúsculas ===
      *> Descomenta las siguientes 5 líneas:
      *    DISPLAY " ".
      *    DISPLAY WS-SEP.
      *    DISPLAY "5. Conversion mayusculas:".
      *    DISPLAY "   Original: Juan Perez".
      *    DISPLAY "   UPPER   : "
      *            FUNCTION UPPER-CASE("Juan Perez").
           STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> 1. Limpieza: [ JUAN  PEREZ  ] → [ JUAN PEREZ ]
      *> 2. Telefono: 10 dígitos, 3 guiones
      *> 3. Monto: $ 12,345.67
      *> 4. Tarjeta: ****-****-****-3456
      *> 5. UPPER: JUAN PEREZ
