# Control de Flujo: IF/ELSE y EVALUATE

## 🎯 Objetivos

- Implementar decisiones con IF/ELSE/END-IF
- Simplificar múltiples condiciones con EVALUATE
- Escribir condiciones compuestas con AND/OR/NOT
- Usar operadores relacionales correctamente

---

## 1. IF / ELSE / END-IF

```cobol
       IF condicion
           sentencias-si-verdadero
       ELSE
           sentencias-si-falso
       END-IF.
```

### Ejemplos

```cobol
      *> IF simple
           IF WS-EDAD >= 18
               DISPLAY "Mayor de edad"
           END-IF.
       
      *> IF con ELSE
           IF WS-SALDO >= WS-MONTO
               DISPLAY "Saldo suficiente"
           ELSE
               DISPLAY "Saldo insuficiente"
           END-IF.
       
      *> IF anidado
           IF WS-TIPO = "A"
               DISPLAY "Tipo A"
           ELSE
               IF WS-TIPO = "B"
                   DISPLAY "Tipo B"
               ELSE
                   DISPLAY "Tipo desconocido"
               END-IF
           END-IF.
```

> ⚠️ Siempre cierra el IF con `END-IF.` (con punto). En COBOL 85+ es obligatorio para IFs que contienen ELSE.

---

## 2. Condiciones Compuestas (AND / OR / NOT)

```cobol
      *> AND: ambas deben ser verdaderas
           IF WS-EDAD >= 18 AND WS-NACIONALIDAD = "MX"
               DISPLAY "Puede votar en Mexico"
           END-IF.
       
      *> OR: al menos una debe ser verdadera
           IF WS-CODIGO = "A" OR WS-CODIGO = "B" OR WS-CODIGO = "C"
               DISPLAY "Codigo valido"
           END-IF.
       
      *> NOT: niega la condición
           IF NOT (WS-SALDO < 0)
               DISPLAY "Saldo no negativo"
           END-IF.
      *> Equivalente a: IF WS-SALDO >= 0
```

### Paréntesis para agrupar

```cobol
           IF (WS-EDAD >= 18 AND WS-EDAD <= 65)
               AND (WS-ESTADO = "A" OR WS-ESTADO = "P")
               DISPLAY "Cliente elegible"
           END-IF.
```

---

## 3. EVALUATE — Switch/Case de COBOL

EVALUATE es más limpio que IF anidado cuando tienes múltiples condiciones.

```cobol
       EVALUATE identificador
           WHEN valor-1
               sentencias...
           WHEN valor-2
               sentencias...
           WHEN OTHER
               sentencias-default...
       END-EVALUATE.
```

### Ejemplos

```cobol
      *> EVALUATE simple (equivalente a switch)
           EVALUATE WS-OPCION
               WHEN 1
                   DISPLAY "Consultar saldo"
               WHEN 2
                   DISPLAY "Depositar"
               WHEN 3
                   DISPLAY "Retirar"
               WHEN 4
                   DISPLAY "Transferir"
               WHEN OTHER
                   DISPLAY "Opcion no valida"
           END-EVALUATE.
```

### EVALUATE con condiciones (más potente que switch)

```cobol
      *> EVALUATE TRUE — evalúa condiciones booleanas
           EVALUATE TRUE
               WHEN WS-EDAD < 18
                   MOVE "MENOR" TO WS-CATEGORIA
               WHEN WS-EDAD <= 65
                   MOVE "ADULTO" TO WS-CATEGORIA
               WHEN OTHER
                   MOVE "JUBILADO" TO WS-CATEGORIA
           END-EVALUATE.
```

### EVALUATE con múltiples sujetos

```cobol
      *> Compara WS-TIPO y WS-ESTADO simultáneamente
           EVALUATE WS-TIPO ALSO WS-ESTADO
               WHEN "CC" ALSO "A"
                   DISPLAY "Cuenta corriente activa"
               WHEN "CA" ALSO "A"
                   DISPLAY "Cuenta ahorro activa"
               WHEN "CC" ALSO "B"
                   DISPLAY "Cuenta corriente bloqueada"
               WHEN OTHER
                   DISPLAY "Combinacion no reconocida"
           END-EVALUATE.
```

---

## 4. Operadores Relacionales

| Símbolo | Significado | Palabra equivalente |
|---------|-------------|-------------------|
| `=` | Igual a | `IS EQUAL TO` |
| `>` | Mayor que | `IS GREATER THAN` |
| `<` | Menor que | `IS LESS THAN` |
| `>=` | Mayor o igual | `IS GREATER THAN OR EQUAL TO` |
| `<=` | Menor o igual | `IS LESS THAN OR EQUAL TO` |
| `<>` | Distinto de | `IS NOT EQUAL TO` |

```cobol
      *> Ambas formas son equivalentes:
           IF WS-SALDO >= 1000
           IF WS-SALDO IS GREATER THAN OR EQUAL TO 1000
```

---

## 5. IF con 88-level (Condition Names)

La forma más legible de escribir condiciones:

```cobol
       01  WS-ESTADO  PIC X(01).
           88 ACTIVO  VALUE "A".
           88 INACTIVO VALUE "I".
       
           IF ACTIVO
               DISPLAY "Cuenta activa"
           ELSE
               DISPLAY "Cuenta inactiva"
           END-IF.
```

---

## 6. CONTINUE y NEXT SENTENCE

```cobol
      *> CONTINUE: no hace nada (útil para ramas vacías)
           IF WS-VALIDO
               CONTINUE
           ELSE
               DISPLAY "Error"
           END-IF.
```

---

## ✅ Checklist

- [ ] Escribir IF con ELSE y END-IF
- [ ] Combinar condiciones con AND/OR
- [ ] Usar EVALUATE en lugar de IF anidado
- [ ] Usar EVALUATE TRUE para condiciones complejas
- [ ] Usar IF con 88-level para legibilidad
- [ ] Cerrar todos los IF con END-IF

## 📚 Recursos

- [IBM COBOL EVALUATE Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-evaluate-statement)
- [GnuCOBOL IF Statement](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#IF)
