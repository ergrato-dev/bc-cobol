# Operadores Aritméticos, Relacionales y Lógicos

## 🎯 Objetivos

- Realizar cálculos con operadores aritméticos
- Comparar valores con operadores relacionales
- Combinar condiciones con operadores lógicos
- Entender la precedencia de operadores

---

## 1. Operadores Aritméticos

| Operador | Significado | Ejemplo |
|----------|-------------|---------|
| `+` | Suma | `WS-A + WS-B` |
| `-` | Resta | `WS-A - WS-B` |
| `*` | Multiplicación | `WS-A * WS-B` |
| `/` | División | `WS-A / WS-B` |
| `**` | Exponenciación | `WS-A ** 2` |
| `+` | Unario positivo | `+WS-A` |
| `-` | Unario negativo | `-WS-A` |

### Precedencia aritmética

```
1. **       (exponenciación)
2. + -      (unario: signo positivo/negativo)
3. * /      (multiplicación, división)
4. + -      (suma, resta)
```

```cobol
           COMPUTE WS-R = WS-A + WS-B * WS-C.
      *> Equivalente a: WS-A + (WS-B * WS-C)
       
           COMPUTE WS-R = (WS-A + WS-B) * WS-C.
      *> Primero suma, luego multiplica
```

### División y Residuo

```cobol
           DIVIDE WS-TOTAL BY WS-PARTES
               GIVING WS-COCIENTE
               REMAINDER WS-RESTO.
       
           DISPLAY "Cociente: " WS-COCIENTE.
           DISPLAY "Residuo : " WS-RESTO.
```

---

## 2. Operadores Relacionales

| Símbolo | Significado | Palabra completa |
|---------|-------------|-----------------|
| `=` | Igual a | `IS EQUAL TO` |
| `>` | Mayor que | `IS GREATER THAN` |
| `<` | Menor que | `IS LESS THAN` |
| `>=` o `=>` | Mayor o igual | `IS GREATER THAN OR EQUAL TO` |
| `<=` o `=<` | Menor o igual | `IS LESS THAN OR EQUAL TO` |
| `<>` | Distinto de | `IS NOT EQUAL TO` |

### Clase de dato

| Condición | Significado |
|-----------|-------------|
| `WS-CAMPO IS NUMERIC` | Contiene solo dígitos |
| `WS-CAMPO IS ALPHABETIC` | Contiene solo letras (A-Z, espacio) |
| `WS-CAMPO IS ALPHABETIC-UPPER` | Solo mayúsculas |
| `WS-CAMPO IS ALPHABETIC-LOWER` | Solo minúsculas |

```cobol
           IF WS-EDAD IS NUMERIC AND WS-EDAD > 0
               DISPLAY "Edad valida"
           ELSE
               DISPLAY "Edad debe ser un numero positivo"
           END-IF.
```

---

## 3. Operadores Lógicos

| Operador | Significado |
|----------|-------------|
| `AND` | Verdadero si ambas condiciones son verdaderas |
| `OR` | Verdadero si al menos una es verdadera |
| `NOT` | Invierte el valor de verdad |

### Tablas de verdad

```
AND:
  TRUE  AND TRUE  → TRUE
  TRUE  AND FALSE → FALSE
  FALSE AND TRUE  → FALSE
  FALSE AND FALSE → FALSE

OR:
  TRUE  OR TRUE  → TRUE
  TRUE  OR FALSE → TRUE
  FALSE OR TRUE  → TRUE
  FALSE OR FALSE → FALSE

NOT:
  NOT TRUE  → FALSE
  NOT FALSE → TRUE
```

### Ejemplos

```cobol
      *> Validación de rango
           IF WS-EDAD >= 18 AND WS-EDAD <= 65
               DISPLAY "Edad laboral activa"
           END-IF.
       
      *> Múltiples valores válidos
           IF WS-TIPO = "CC" OR WS-TIPO = "CA" OR WS-TIPO = "PF"
               DISPLAY "Tipo de cuenta valido"
           END-IF.
       
      *> Negación
           IF NOT (WS-SALDO < WS-MONTO)
               DISPLAY "Fondos suficientes"
           END-IF.
       
      *> Combinación con paréntesis
           IF (WS-TIPO = "CC" OR WS-TIPO = "CA")
               AND WS-SALDO > 0
               AND WS-ESTADO = "A"
               DISPLAY "Cuenta operable"
           END-IF.
```

---

## 4. Signos y Condiciones de Signo

| Condición | Significado |
|-----------|-------------|
| `WS-CAMPO IS POSITIVE` | Valor mayor que 0 |
| `WS-CAMPO IS NEGATIVE` | Valor menor que 0 |
| `WS-CAMPO IS ZERO` | Valor igual a 0 |
| `WS-CAMPO IS NOT ZERO` | Valor distinto de 0 |

```cobol
           IF WS-SALDO IS NEGATIVE
               DISPLAY "Cuenta sobregirada"
           END-IF.
```

---

## 5. Precedencia Completa de Condiciones

```
1. Aritmética (dentro de COMPUTE)
2. Relacional (=, >, <, etc.)
3. NOT
4. AND
5. OR
```

```cobol
      *> Esto:
           IF WS-A > 5 AND WS-B < 10 OR WS-C = 0...
       
      *> Se evalúa como:
           IF ((WS-A > 5) AND (WS-B < 10)) OR (WS-C = 0)...
       
      *> Para cambiar el orden, usa paréntesis:
           IF WS-A > 5 AND (WS-B < 10 OR WS-C = 0)...
```

---

## 6. Operador de Concatenación (COBOL 2002+)

En GnuCOBOL puedes usar `&` para concatenar strings:

```cobol
      *> Concatenar literales
           DISPLAY "Nombre: " & WS-NOMBRE.
       
      *> Concatenar para construir mensajes
           MOVE "Cliente " & WS-ID & ": " & WS-NOMBRE
               TO WS-MENSAJE.
```

---

## ✅ Checklist

- [ ] Usar `+`, `-`, `*`, `/`, `**` en COMPUTE
- [ ] Comparar con `=`, `>`, `<`, `>=`, `<=`, `<>`
- [ ] Combinar con `AND`, `OR`, `NOT`
- [ ] Verificar tipo de dato con `IS NUMERIC`
- [ ] Usar paréntesis para controlar precedencia
- [ ] Validar rango con AND (`>= 0 AND <= 100`)

## 📚 Recursos

- [GnuCOBOL Expressions](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Expressions)
- [IBM COBOL Arithmetic Operators](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-arithmetic-operators)
