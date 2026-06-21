# BY REFERENCE vs BY CONTENT — Modos de Paso

## 🎯 Objetivos

- Diferenciar paso por referencia y por valor
- Elegir el modo adecuado según el caso
- Proteger datos del llamador con BY CONTENT

---

## 1. BY REFERENCE (Por Defecto)

El subprograma recibe la **dirección de memoria** del parámetro. Cualquier modificación en el subprograma **afecta al llamador**.

```cobol
      *> Subprograma: recibe por referencia (default)
       PROCEDURE DIVISION USING LK-SALDO.
           COMPUTE LK-SALDO = LK-SALDO * 1.10.  *> +10%
           EXIT PROGRAM.
       
      *> Llamador:
           DISPLAY "Saldo antes: " WS-SALDO.    *> 1000
           CALL "ACTUALIZA" USING WS-SALDO.
           DISPLAY "Saldo despues: " WS-SALDO.  *> 1100 (¡modificado!)
```

### Equivalente explícito

```cobol
       PROCEDURE DIVISION USING BY REFERENCE LK-SALDO.
```

---

## 2. BY CONTENT (Por Valor/Copia)

El subprograma recibe una **copia** del parámetro. Las modificaciones **no afectan al llamador**.

```cobol
      *> Subprograma: recibe por valor
       PROCEDURE DIVISION USING BY CONTENT LK-SALDO.
       
      *> Llamador:
           CALL "ACTUALIZA" USING BY CONTENT WS-SALDO.
      *> WS-SALDO no se modifica
```

---

## 3. Comparativa

| Característica | BY REFERENCE | BY CONTENT |
|---------------|-------------|------------|
| Mecanismo | Dirección de memoria | Copia del valor |
| Modifica al llamador | ✅ Sí | ❌ No |
| Rendimiento | Más rápido (sin copia) | Copia al inicio |
| Seguridad | Menor (efecto colateral) | Mayor (aislado) |
| Uso típico | Modificar el parámetro | Solo lectura, proteger datos |
| Default | ✅ Sí | ❌ No (debe ser explícito) |

---

## 4. Cuándo Usar Cada Modo

### BY REFERENCE (default)

```cobol
      *> El subprograma DEBE modificar el parámetro
           CALL "CALCULAR-INTERES" USING WS-SALDO WS-INTERES.
      *> WS-SALDO e WS-INTERES serán modificados
```

### BY CONTENT

```cobol
      *> El subprograma solo necesita LEER el parámetro
           CALL "VALIDAR-CLIENTE"
               USING BY CONTENT WS-CLI-ID
                     WS-RESULTADO.
      *> WS-CLI-ID está protegido, WS-RESULTADO es salida
```

---

## 5. Mezclar Modos

Puedes combinar BY REFERENCE y BY CONTENT en la misma llamada:

```cobol
           CALL "PROCESAR"
               USING BY CONTENT WS-ID          *> Solo lectura
                     BY CONTENT WS-TASA        *> Solo lectura
                     WS-RESULTADO.             *> Lectura/escritura (REF)
       
      *> Subprograma
       PROCEDURE DIVISION USING
           BY CONTENT LK-ID
           BY CONTENT LK-TASA
           BY REFERENCE LK-RESULTADO.
```

---

## 6. BY VALUE (Numéricos)

Similar a BY CONTENT pero para literales numéricos pequeños:

```cobol
           CALL "ACTUALIZAR" USING BY CONTENT WS-ID
                                   BY VALUE 10.
      *> Pasa el literal 10, no una variable
```

---

## 7. Ejemplo Práctico

```cobol
      *> Programa principal
           MOVE 1000 TO WS-SALDO.
           DISPLAY "1. Saldo inicial: " WS-SALDO.          *> 1000
           
           CALL "DEPOSITAR" USING WS-SALDO 500.
           DISPLAY "2. Despues deposito: " WS-SALDO.       *> 1500 (REF)
           
           CALL "MOSTRAR-SALDO" USING BY CONTENT WS-SALDO.
           DISPLAY "3. Despues mostrar: " WS-SALDO.        *> 1500 (CONTENT, no modifica)
```

---

## ✅ Checklist

- [ ] Usar BY REFERENCE (default) cuando el subprograma modifica el parámetro
- [ ] Usar BY CONTENT para proteger datos de solo lectura
- [ ] Combinar modos en una misma llamada
- [ ] Entender que BY REFERENCE es más rápido pero con efecto colateral

## 📚 Recursos

- [IBM COBOL USING Phrase](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=division-using-phrase)
- [GnuCOBOL CALL BY REFERENCE/CONTENT](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#CALL)
