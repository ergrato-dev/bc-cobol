# Verbos Básicos: MOVE, COMPUTE, DISPLAY, ACCEPT

## 🎯 Objetivos

- Dominar los cuatro verbos fundamentales de PROCEDURE DIVISION
- Comprender la conversión automática de tipos en MOVE
- Realizar operaciones aritméticas con COMPUTE
- Usar DISPLAY y ACCEPT para entrada/salida

---

## 1. MOVE — Asignación de Valores

MOVE transfiere datos de una variable (o literal) a otra. COBOL convierte automáticamente entre tipos compatibles.

```cobol
       MOVE identificador-1 TO identificador-2
```

### Reglas de conversión

| Origen | Destino | Comportamiento |
|--------|---------|---------------|
| Alfanumérico → Alfanumérico | Copia carácter por carácter, rellena con espacios si destino es más largo, trunca si es más corto |
| Numérico → Numérico | Alinea por punto decimal, rellena con ceros |
| Alfanumérico → Numérico | Convierte a número (si es válido) |
| Numérico → Alfanumérico | Convierte a texto, alinea a la derecha |
| Grupo → Grupo | Mueve como alfanumérico (sin conversión) |

```cobol
       01  WS-CHICA    PIC X(05).
       01  WS-GRANDE   PIC X(10).
       01  WS-NUM1     PIC 9(03).
       01  WS-NUM2     PIC 9(05).
       
       PROCEDURE DIVISION.
           MOVE "HOLA" TO WS-CHICA.        *> "HOLA "
           MOVE WS-CHICA TO WS-GRANDE.      *> "HOLA      " (rellena espacios)
           MOVE "ABC" TO WS-GRANDE.         *> "ABC       "
           MOVE 25 TO WS-NUM1.             *> 025
           MOVE WS-NUM1 TO WS-NUM2.         *> 00025 (completa ceros izq)
           MOVE "123" TO WS-NUM1.           *> 123 (convierte texto a número)
```

### MOVE en grupo (mueve todo el registro)

```cobol
       01  WS-CLIENTE-A.
           05 WS-A-ID       PIC 9(05).
           05 WS-A-NOMBRE   PIC X(30).
       
       01  WS-CLIENTE-B.
           05 WS-B-ID       PIC 9(05).
           05 WS-B-NOMBRE   PIC X(30).
       
           MOVE WS-CLIENTE-A TO WS-CLIENTE-B.
      *> Copia todo el registro como bloque alfanumérico
```

> ⚠️ MOVE entre grupos NO hace conversión de tipos. Se trata como bytes crudos.

---

## 2. COMPUTE — Operaciones Aritméticas

COMPUTE evalúa una expresión aritmética y asigna el resultado.

```cobol
       COMPUTE identificador = expresion
```

### Operadores aritméticos

```cobol
           COMPUTE WS-RESULTADO = WS-A + WS-B.         *> Suma
           COMPUTE WS-RESULTADO = WS-A - WS-B.         *> Resta
           COMPUTE WS-RESULTADO = WS-A * WS-B.         *> Multiplicación
           COMPUTE WS-RESULTADO = WS-A / WS-B.         *> División
           COMPUTE WS-RESULTADO = WS-A ** 2.           *> Exponenciación
```

### Expresiones compuestas

```cobol
           COMPUTE WS-TOTAL = (WS-PRECIO * WS-CANT) + WS-IMPUESTO.
           COMPUTE WS-MEDIA = (WS-A + WS-B + WS-C) / 3.
           COMPUTE WS-INTERES = WS-SALDO * (WS-TASA / 100).
           COMPUTE WS-CUOTA = WS-MONTO *
               (WS-TASA / 12) /
               (1 - (1 + WS-TASA / 12) ** -WS-PLAZOS).
```

### Precedencia

1. `**` (exponenciación)
2. `*` y `/` (multiplicación y división)
3. `+` y `-` (suma y resta)
4. Paréntesis `()` rompen la precedencia

### ROUNDED — Redondeo

```cobol
           COMPUTE WS-RESULTADO ROUNDED = WS-A / 3.
      *> 10 / 3 = 3.33 → redondeado a 3.33
```

---

## 3. ADD, SUBTRACT, MULTIPLY, DIVIDE (Alternativas a COMPUTE)

COBOL también tiene verbos individuales para cada operación:

```cobol
      *> ADD — suma
           ADD 1 TO WS-CONTADOR.
           ADD WS-IMPORTE TO WS-TOTAL.
           ADD WS-A WS-B TO WS-C GIVING WS-RESULTADO.
           
      *> SUBTRACT — resta
           SUBTRACT 100 FROM WS-SALDO.
           SUBTRACT WS-IMPUESTO FROM WS-BRUTO GIVING WS-NETO.
           
      *> MULTIPLY — multiplicación
           MULTIPLY WS-CANT BY WS-PRECIO GIVING WS-IMPORTE.
           
      *> DIVIDE — división
           DIVIDE WS-TOTAL BY WS-ITEMS GIVING WS-PROMEDIO.
           DIVIDE WS-A BY WS-B GIVING WS-COCIENTE REMAINDER WS-RESTO.
```

### ¿Cuándo usar COMPUTE vs ADD/SUBTRACT/MULTIPLY/DIVIDE?

| Situación | Recomendación |
|-----------|---------------|
| Incrementar contador (`+ 1`) | `ADD 1 TO CONTADOR` |
| Fórmula simple | `COMPUTE` |
| Fórmula compleja con paréntesis | `COMPUTE` |
| Necesitas residuo de división | `DIVIDE ... REMAINDER` |
| Operación financiera con ROUNDED | `COMPUTE ... ROUNDED` |

---

## 4. DISPLAY — Mostrar en Pantalla

```cobol
           DISPLAY "Texto literal".
           DISPLAY WS-VARIABLE.
           DISPLAY "Nombre: " WS-NOMBRE " Edad: " WS-EDAD.
           DISPLAY WS-TITULO WITH NO ADVANCING.  *> Sin salto de línea
```

### Múltiples operandos

```cobol
           DISPLAY "Cliente: " WS-ID
                   " - " WS-NOMBRE
                   " Saldo: $" WS-SALDO-EDIT.
```

### WITH NO ADVANCING

```cobol
           DISPLAY "Ingrese su nombre: " WITH NO ADVANCING.
           ACCEPT WS-NOMBRE.
      *> El cursor queda en la misma línea tras "Ingrese su nombre: "
```

---

## 5. ACCEPT — Leer del Teclado

```cobol
           ACCEPT WS-NOMBRE.                *> Lee una línea completa
           ACCEPT WS-FECHA FROM DATE.       *> Fecha del sistema (YYYYMMDD)
           ACCEPT WS-HORA FROM TIME.        *> Hora del sistema (HHMMSSFF)
```

### FROM DATE / FROM TIME

```cobol
       01  WS-FECHA-SYS   PIC 9(08).
       01  WS-HORA-SYS    PIC 9(08).
       
           ACCEPT WS-FECHA-SYS FROM DATE.   *> 20260620
           ACCEPT WS-HORA-SYS FROM TIME.    *> 14302500 (14:30:25.00)
```

---

## ✅ Checklist

- [ ] Usar MOVE para asignar entre tipos compatibles
- [ ] Usar COMPUTE con fórmula aritmética compleja
- [ ] Usar ADD para incrementar contador
- [ ] Mostrar múltiples variables con DISPLAY
- [ ] Leer entrada del usuario con ACCEPT
- [ ] Leer fecha/hora del sistema con ACCEPT FROM DATE/TIME

## 📚 Recursos

- [GnuCOBOL PROCEDURE DIVISION Verbs](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#PROCEDURE)
- [IBM COBOL MOVE Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-move-statement)
