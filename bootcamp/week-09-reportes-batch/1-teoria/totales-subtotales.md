# Totales y Subtotales — Acumuladores

## 🎯 Objetivos

- Acumular totales durante el procesamiento
- Generar subtotales por grupo
- Inicializar y reiniciar acumuladores
- Evitar errores de precisión con COMP-3

---

## 1. Totales Simples (Final del Reporte)

Acumular durante el loop y mostrar al final:

```cobol
       WORKING-STORAGE SECTION.
       01  WS-TOTAL-GENERAL   PIC S9(12)V99 USAGE COMP-3 VALUE ZEROS.
       01  WS-CONT-REG        PIC 9(07) USAGE COMP VALUE ZEROS.
       
       PROCEDURE DIVISION.
           PERFORM UNTIL EOF
               READ DATOS-FILE
                   AT END SET EOF TO TRUE
                   NOT AT END
                       ADD 1 TO WS-CONT-REG
                       ADD CTA-SALDO TO WS-TOTAL-GENERAL
               END-READ
           END-PERFORM.
           
           DISPLAY "Total cuentas : " WS-CONT-REG.
           DISPLAY "Total saldos  : " WS-TOTAL-GENERAL.
```

---

## 2. Subtotales por Grupo (Break Control)

Agrupar registros por una categoría y mostrar subtotales cuando cambia:

```cobol
       WORKING-STORAGE SECTION.
       01  WS-TIPO-ACTUAL      PIC X(02) VALUE SPACES.
       01  WS-TIPO-ANTERIOR    PIC X(02) VALUE SPACES.
       01  WS-SUBTOTAL         PIC S9(12)V99 USAGE COMP-3 VALUE ZEROS.
       01  WS-CONT-GRUPO       PIC 9(07) USAGE COMP VALUE ZEROS.
```

### Lógica de ruptura

```cobol
           MOVE CTA-TIPO TO WS-TIPO-ACTUAL.
           
           IF WS-TIPO-ACTUAL NOT = WS-TIPO-ANTERIOR
               AND WS-TIPO-ANTERIOR NOT = SPACES
               PERFORM 5000-SUBTOTAL-GRUPO
           END-IF.
           
           ADD CTA-SALDO TO WS-SUBTOTAL.
           ADD 1 TO WS-CONT-GRUPO.
```

### Párrafo de subtotal

```cobol
       5000-SUBTOTAL-GRUPO.
           MOVE WS-SUBTOTAL TO WS-SUB-EDIT.
           DISPLAY WS-SEPARADOR.
           DISPLAY "Subtotal " WS-TIPO-ANTERIOR ": " WS-SUB-EDIT.
           DISPLAY "Cuentas  : " WS-CONT-GRUPO.
           DISPLAY WS-SEPARADOR.
           ADD WS-SUBTOTAL TO WS-TOTAL-GENERAL.
           ADD WS-CONT-GRUPO TO WS-CONT-TOTAL.
           MOVE ZEROS TO WS-SUBTOTAL.
           MOVE ZEROS TO WS-CONT-GRUPO.
```

---

## 3. Múltiples Niveles de Ruptura

```cobol
      *> Nivel 1: Sucursal → Nivel 2: Tipo de cuenta
       01  WS-SUC-ACTUAL     PIC 9(03).
       01  WS-SUC-ANTERIOR   PIC 9(03).
       01  WS-TIPO-ACTUAL    PIC X(02).
       01  WS-TIPO-ANTERIOR  PIC X(02).
       
       01  WS-SUBTOTAL-TIPO  PIC S9(12)V99 COMP-3.
       01  WS-SUBTOTAL-SUC   PIC S9(12)V99 COMP-3.
       
           IF WS-SUC-ACTUAL NOT = WS-SUC-ANTERIOR
               PERFORM 5000-RUPTURA-NIVEL-1    *> Ruptura mayor
           ELSE
               IF WS-TIPO-ACTUAL NOT = WS-TIPO-ANTERIOR
                   PERFORM 5100-RUPTURA-NIVEL-2 *> Ruptura menor
               END-IF
           END-IF.
```

---

## 4. Control de Ruptura con Archivos Ordenados

El archivo DEBE estar ordenado por la clave de ruptura:

```
Sucursal 01, Tipo CC ← grupo 1
Sucursal 01, Tipo CC
Sucursal 01, Tipo CA ← ruptura: cambió tipo
Sucursal 01, Tipo CA
Sucursal 02, Tipo CC ← ruptura: cambió sucursal
Sucursal 02, Tipo CC
```

Si el archivo no está ordenado, los subtotales serán incorrectos.

---

## 5. Inicialización de Acumuladores

```cobol
      *> Al inicio del programa
           MOVE ZEROS TO WS-TOTAL-GENERAL.
           MOVE ZEROS TO WS-SUBTOTAL.
           MOVE ZEROS TO WS-SUBTOTAL-SUC.
       
      *> Después de cada ruptura
           MOVE ZEROS TO WS-SUBTOTAL.       *> Reiniciar subtotal del grupo
           MOVE ZEROS TO WS-CONT-GRUPO.     *> Reiniciar contador del grupo
       
      *> Al cambiar de sucursal (ruptura mayor)
           MOVE ZEROS TO WS-SUBTOTAL-SUC.   *> Reiniciar subtotal sucursal
```

---

## 6. Formateo de Totales

```cobol
       01  WS-TOTAL-EDIT      PIC $$$,$$$,$$9.99.
       
           MOVE WS-TOTAL-GENERAL TO WS-TOTAL-EDIT.
           DISPLAY "TOTAL GENERAL: " WS-TOTAL-EDIT.
```

### Línea de totales en el reporte

```cobol
       01  WS-LINEA-TOTAL.
           05 FILLER PIC X(30) VALUE SPACES.
           05 FILLER PIC X(15) VALUE "TOTAL:".
           05 WS-LTOTAL PIC $$$,$$$,$$9.99.
```

---

## ✅ Checklist

- [ ] Acumular total general con ADD durante el loop
- [ ] Detectar cambio de grupo para subtotales
- [ ] Inicializar acumuladores antes del loop y después de cada ruptura
- [ ] El archivo debe estar ordenado por la clave de ruptura
- [ ] Usar COMP-3 para acumuladores financieros (precisión)

## 📚 Recursos

- [IBM COBOL Arithmetic Statements](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-arithmetic)
- [GnuCOBOL Arithmetic](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Arithmetic)
