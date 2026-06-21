       >>SOURCE FORMAT IS FREE
      *> ============================================
      *> EJERCICIO 2: Jerarquía de Factura
      *> ============================================
      *>
      *> OBJETIVO: Diseñar una estructura de datos jerárquica
      *> con niveles 01 → 05 → 10 para una factura.
      *>
      *> Compilar: cobc -x -free jerarquia-factura.cbl
      *> Ejecutar: ./jerarquia-factura

       IDENTIFICATION DIVISION.
       PROGRAM-ID. JERARQUIA.

      *> === PASO 1: Declarar la jerarquía de factura ===
      *> Niveles: 01 (raíz) → 05 (secciones) → 10 (detalles)
      *>
      *> Descomenta las siguientes 26 líneas:
      *DATA DIVISION.
      *WORKING-STORAGE SECTION.
      *01  FACTURA.
      *    05 FAC-ENCABEZADO.                       *> Nivel 05: subgrupo
      *       10 FAC-NUMERO        PIC 9(08).      *> Nivel 10: elemental
      *       10 FAC-FECHA.                         *> Nivel 10: subgrupo
      *          15 FAC-ANO        PIC 9(04).      *> Nivel 15: elemental
      *          15 FAC-MES        PIC 9(02).
      *          15 FAC-DIA        PIC 9(02).
      *    05 FAC-CLIENTE.                          *> Nivel 05: subgrupo
      *       10 FAC-CLI-ID        PIC 9(05).
      *       10 FAC-CLI-NOMBRE    PIC X(20).
      *       10 FAC-CLI-RFC       PIC X(13).
      *    05 FAC-DETALLE.                          *> Nivel 05: subgrupo
      *       10 FAC-CONCEPTO      PIC X(30).
      *       10 FAC-CANTIDAD      PIC 9(05).
      *       10 FAC-PRECIO-UNIT   PIC 9(05)V99.
      *       10 FAC-IMPORTE       PIC S9(09)V99.
      *    05 FAC-TOTALES.                          *> Nivel 05: subgrupo
      *       10 FAC-SUBTOTAL      PIC S9(09)V99.
      *       10 FAC-IVA           PIC S9(09)V99.
      *       10 FAC-TOTAL         PIC S9(09)V99.

      *> === PASO 2: Campos de edición ===
      *>
      *> Descomenta las siguientes 4 líneas:
      *01  WS-FECHA-EDIT       PIC 99/99/9999.
      *01  WS-IMPORTE-EDIT     PIC $$,$$9.99.
      *01  WS-SUBTOTAL-EDIT    PIC $$,$$9.99.
      *01  WS-TOTAL-EDIT       PIC $$,$$9.99.

      *> === PASO 3: Asignar datos usando niveles de grupo ===
      *> Puedes asignar un valor a un nivel de grupo
      *> y se distribuye a sus subordinados
      *>
      *> Descomenta las siguientes 9 líneas:
      *PROCEDURE DIVISION.
      *    DISPLAY "=== JERARQUIA DE FACTURA ===".
      *    DISPLAY " ".
      *    MOVE 20250620 TO FAC-FECHA.         *> Asigna a todo el grupo fecha
      *    MOVE 1500 TO FAC-NUMERO.
      *    MOVE 42 TO FAC-CLI-ID.
      *    MOVE "Empresa ABC SA" TO FAC-CLI-NOMBRE.
      *    MOVE "ABC-250620-XYZ" TO FAC-CLI-RFC.

      *> === PASO 4: Asignar datos de detalle ===
      *>
      *> Descomenta las siguientes 5 líneas:
      *    MOVE "Servicio de consultoria" TO FAC-CONCEPTO.
      *    MOVE 40 TO FAC-CANTIDAD.
      *    MOVE 1250.00 TO FAC-PRECIO-UNIT.
      *    COMPUTE FAC-IMPORTE = FAC-CANTIDAD * FAC-PRECIO-UNIT.
      *    MOVE FAC-IMPORTE TO FAC-SUBTOTAL.

      *> === PASO 5: Calcular totales ===
      *>
      *> Descomenta las siguientes 3 líneas:
      *    COMPUTE FAC-IVA = FAC-SUBTOTAL * 0.16.
      *    COMPUTE FAC-TOTAL = FAC-SUBTOTAL + FAC-IVA.
      *    DISPLAY " ".

      *> === PASO 6: Mostrar factura formateada ===
      *>
      *> Descomenta las siguientes 18 líneas:
      *    MOVE FAC-FECHA TO WS-FECHA-EDIT.
      *    MOVE FAC-IMPORTE TO WS-IMPORTE-EDIT.
      *    MOVE FAC-SUBTOTAL TO WS-SUBTOTAL-EDIT.
      *    MOVE FAC-TOTAL TO WS-TOTAL-EDIT.
      *    DISPLAY "Factura No: " FAC-NUMERO.
      *    DISPLAY "Fecha     : " WS-FECHA-EDIT.
      *    DISPLAY "Cliente   : " FAC-CLI-NOMBRE.
      *    DISPLAY "RFC       : " FAC-CLI-RFC.
      *    DISPLAY "Concepto  : " FAC-CONCEPTO.
      *    DISPLAY "Cantidad  : " FAC-CANTIDAD.
      *    DISPLAY "Precio    : " FAC-PRECIO-UNIT.
      *    DISPLAY "Importe   : " WS-IMPORTE-EDIT.
      *    DISPLAY "------------------------------".
      *    DISPLAY "Subtotal  : " WS-SUBTOTAL-EDIT.
      *    DISPLAY "IVA (16%) : " FAC-IVA.
      *    DISPLAY "TOTAL     : " WS-TOTAL-EDIT.
      *    DISPLAY " ".
      *    STOP RUN.

      *> === RESULTADO ESPERADO ===
      *> === JERARQUIA DE FACTURA ===
      *>
      *> Factura No: 00001500
      *> Fecha     : 20/06/2025
      *> Cliente   : Empresa ABC SA
      *> RFC       : ABC-250620-XYZ
      *> Concepto  : Servicio de consultoria
      *> Cantidad  : 00040
      *> Precio    : 0125000
      *> Importe   : $ 50,000.00
      *> ------------------------------
      *> Subtotal  : $ 50,000.00
      *> IVA (16%) : 0000800000
      *> TOTAL     : $ 58,000.00
