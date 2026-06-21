# Control de Ruptura (Break Control)

## 🎯 Objetivos

- Implementar break control de 1 y 2 niveles
- Detectar cambio de grupo eficientemente
- Generar subtotales y totales generales
- Resetear acumuladores correctamente

---

## 1. Concepto de Ruptura

Cuando procesas un archivo ordenado, una **ruptura** ocurre cuando cambia el valor de un campo clave. En ese momento debes imprimir subtotales y resetear acumuladores.

```
Clave: Tipo Cuenta
─────────────────
CC  $1,000   ←
CC  $2,000   ← grupo CC
CC  $3,000   ←
───────────────── Subtotal CC: $6,000  ← RUPTURA
CA  $5,000   ←
CA  $4,000   ← grupo CA
───────────────── Subtotal CA: $9,000  ← RUPTURA
PF  $8,000   ← grupo PF
───────────────── Subtotal PF: $8,000
═════════════════════════════════════════
TOTAL GENERAL:        $23,000
```

---

## 2. Algoritmo Básico de Ruptura

```cobol
       WORKING-STORAGE SECTION.
       01  WS-CLAVE-ACTUAL     PIC X(02).
       01  WS-CLAVE-ANTERIOR   PIC X(02) VALUE SPACES.
       01  WS-SUBTOTAL         PIC S9(12)V99 COMP-3 VALUE ZEROS.
       01  WS-CONT-GRUPO       PIC 9(07) COMP VALUE ZEROS.
```

### El archivo debe estar ordenado por la clave de ruptura

```cobol
       PROCEDURE DIVISION.
           OPEN INPUT DATOS.
           READ DATOS AT END ...
           
      *> Primera lectura — no hay ruptura en el primer registro
           MOVE REG-CLAVE TO WS-CLAVE-ANTERIOR.
           
           PERFORM UNTIL EOF
               MOVE REG-CLAVE TO WS-CLAVE-ACTUAL
               
               IF WS-CLAVE-ACTUAL NOT = WS-CLAVE-ANTERIOR
                   PERFORM 5000-RUPTURA
                   MOVE WS-CLAVE-ACTUAL TO WS-CLAVE-ANTERIOR
               END-IF
               
               ADD REG-MONTO TO WS-SUBTOTAL
               ADD 1 TO WS-CONT-GRUPO
               
               READ DATOS AT END ...
           END-PERFORM.
           
      *> Última ruptura (el último grupo no se imprime en el loop)
           PERFORM 5000-RUPTURA.
```

### Párrafo de ruptura

```cobol
       5000-RUPTURA.
           IF WS-CONT-GRUPO > 0
               MOVE WS-SUBTOTAL TO WS-SUB-EDIT
               DISPLAY WS-SEPARADOR
               DISPLAY "Grupo " WS-CLAVE-ANTERIOR
                       " Total: " WS-SUB-EDIT
                       " Cuentas: " WS-CONT-GRUPO
               ADD WS-SUBTOTAL TO WS-TOTAL-GENERAL
               ADD WS-CONT-GRUPO TO WS-CONT-TOTAL
               MOVE ZEROS TO WS-SUBTOTAL
               MOVE ZEROS TO WS-CONT-GRUPO
           END-IF.
```

---

## 3. Ruptura de Dos Niveles

```
Sucursal 01 → Tipo CC → cuenta 1
Sucursal 01 → Tipo CC → cuenta 2        ← Ruptura tipo
Sucursal 01 → Tipo CA → cuenta 3        ← Ruptura sucursal + tipo
Sucursal 02 → Tipo CC → cuenta 4
```

```cobol
       01  WS-SUC-ACTUAL      PIC 9(03).
       01  WS-SUC-ANTERIOR    PIC 9(03).
       01  WS-TIPO-ACTUAL     PIC X(02).
       01  WS-TIPO-ANTERIOR   PIC X(02).
       
       01  WS-SUBTOTAL-TIPO   PIC S9(12)V99 COMP-3.
       01  WS-SUBTOTAL-SUC    PIC S9(12)V99 COMP-3.
```

### Algoritmo de 2 niveles

```cobol
      *> Detectar ruptura mayor (sucursal)
           IF WS-SUC-ACTUAL NOT = WS-SUC-ANTERIOR
               IF WS-SUC-ANTERIOR NOT = ZEROS
                   PERFORM 5000-RUPTURA-MENOR    *> Imprimir último tipo
                   PERFORM 5100-RUPTURA-MAYOR     *> Imprimir sucursal
               END-IF
               MOVE WS-SUC-ACTUAL TO WS-SUC-ANTERIOR
               MOVE WS-TIPO-ACTUAL TO WS-TIPO-ANTERIOR
           ELSE
      *> Detectar ruptura menor (tipo)
               IF WS-TIPO-ACTUAL NOT = WS-TIPO-ANTERIOR
                   PERFORM 5000-RUPTURA-MENOR
                   MOVE WS-TIPO-ACTUAL TO WS-TIPO-ANTERIOR
               END-IF
           END-IF.
```

---

## 4. Detección de EOF + Última Ruptura

Al llegar a EOF, los últimos grupos no se han impreso:

```cobol
           PERFORM UNTIL EOF
               READ DATOS AT END
                   SET EOF TO TRUE
                   PERFORM 5000-RUPTURA-MENOR    *> Último tipo
                   PERFORM 5100-RUPTURA-MAYOR     *> Última sucursal
               NOT AT END
                   ... lógica de ruptura ...
               END-READ
           END-PERFORM.
```

---

## 5. Estructura del Archivo de Entrada

El secreto del break control está en el **ordenamiento previo**:

```bash
# Antes de ejecutar el reporte, ordenar por claves de ruptura
# En COBOL: usar SORT (semana 10)
# En Linux: sort -k1,3 -k4,5 entrada.dat > entrada_ordenada.dat
```

---

## ✅ Checklist

- [ ] Detectar cambio de grupo comparando clave actual vs anterior
- [ ] Imprimir subtotales en la ruptura
- [ ] Resetear acumuladores después de cada ruptura
- [ ] No olvidar la última ruptura (después del EOF)
- [ ] Asegurar que el archivo esté ordenado por la clave de ruptura

## 📚 Recursos

- [IBM COBOL Report Generation Patterns](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=features-report-writer)
