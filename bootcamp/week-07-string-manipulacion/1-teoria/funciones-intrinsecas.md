# Funciones Intrínsecas — LENGTH, TRIM y Más

## 🎯 Objetivos

- Usar FUNCTION para operaciones sobre strings
- Medir longitud con FUNCTION LENGTH
- Eliminar espacios con FUNCTION TRIM
- Convertir mayúsculas/minúsculas
- Convertir entre texto y número con NUMVAL/NUMVAL-C

---

## 1. FUNCTION LENGTH

Devuelve la longitud de un campo (incluyendo espacios de relleno):

```cobol
       01  WS-NOMBRE    PIC X(30) VALUE "Juan".
       01  WS-LEN       PIC 9(03).
       
           COMPUTE WS-LEN = FUNCTION LENGTH(WS-NOMBRE).
      *> WS-LEN = 30 (el tamaño del PIC, no del contenido)
```

Para medir longitud "real" (sin espacios):

```cobol
           COMPUTE WS-LEN = FUNCTION LENGTH(
               FUNCTION TRIM(WS-NOMBRE)).
      *> WS-LEN = 4
```

---

## 2. FUNCTION TRIM

Elimina espacios al inicio y final:

```cobol
       01  WS-TEXTO     PIC X(20) VALUE "   Hola   ".
       
           DISPLAY "[" FUNCTION TRIM(WS-TEXTO) "]".
      *> [Hola]
```

### TRIM con dirección

```cobol
           FUNCTION TRIM(WS-TEXTO)           *> Ambos lados (default)
           FUNCTION TRIM(WS-TEXTO LEADING)   *> Solo inicio
           FUNCTION TRIM(WS-TEXTO TRAILING)  *> Solo final
```

---

## 3. FUNCTION UPPER-CASE / LOWER-CASE

```cobol
       01  WS-TEXTO     PIC X(20) VALUE "Cobol Es Genial".
       
           DISPLAY FUNCTION UPPER-CASE(WS-TEXTO).
      *> "COBOL ES GENIAL"
       
           DISPLAY FUNCTION LOWER-CASE(WS-TEXTO).
      *> "cobol es genial"
```

---

## 4. FUNCTION NUMVAL / NUMVAL-C

Convierte texto a número:

```cobol
       01  WS-TEXTO-NUM PIC X(10) VALUE "0012345.67".
       01  WS-NUM       PIC 9(07)V99.
       
           COMPUTE WS-NUM = FUNCTION NUMVAL(WS-TEXTO-NUM).
      *> WS-NUM = 12345.67
```

NUMVAL-C acepta formato con signo y moneda:

```cobol
       01  WS-MONTO-TXT PIC X(15) VALUE "$ 12,345.67 CR".
       01  WS-MONTO     PIC S9(07)V99.
       
           COMPUTE WS-MONTO = FUNCTION NUMVAL-C(WS-MONTO-TXT).
      *> WS-MONTO = -12345.67 (CR indica crédito/negativo)
```

---

## 5. Otras Funciones Útiles

| Función | Descripción | Ejemplo |
|---------|-------------|---------|
| `FUNCTION REVERSE` | Invierte la cadena | `"HOLA"` → `"ALOH"` |
| `FUNCTION CHAR(x)` | Carácter por posición ASCII | `FUNCTION CHAR(65)` → `"A"` |
| `FUNCTION ORD("A")` | Posición ASCII de un carácter | `FUNCTION ORD("A")` → `65` |
| `FUNCTION SUBSTITUTE` | Reemplaza subcadenas | Sustituye todas las ocurrencias |
| `FUNCTION MAX` | Máximo de varios valores | `FUNCTION MAX(WS-A, WS-B, WS-C)` |
| `FUNCTION MIN` | Mínimo de varios valores | `FUNCTION MIN(WS-A, WS-B)` |
| `FUNCTION INTEGER(x)` | Parte entera | `FUNCTION INTEGER(3.7)` → `3` |
| `FUNCTION MOD(x,y)` | Módulo | `FUNCTION MOD(17, 5)` → `2` |

---

## 6. Combinar Funciones

```cobol
      *> Obtener la longitud real (sin espacios)
           COMPUTE WS-LEN =
               FUNCTION LENGTH(FUNCTION TRIM(WS-TEXTO)).
       
      *> Convertir a mayúsculas y quitar espacios
           MOVE FUNCTION TRIM(FUNCTION UPPER-CASE(WS-NOMBRE))
               TO WS-NOMBRE-LIMPIO.
       
      *> Extraer iniciales
           MOVE FUNCTION UPPER-CASE(WS-NOMBRE(1:1))
               TO WS-INICIAL.
```

---

## 7. SUBSTITUTE (COBOL 2002+)

Reemplaza todas las ocurrencias de una subcadena:

```cobol
       01  WS-TEXTO     PIC X(30) VALUE "Hola MUNDO MUNDO".
       
           MOVE FUNCTION SUBSTITUTE(WS-TEXTO "MUNDO" "COBOL")
               TO WS-RESULTADO.
      *> "Hola COBOL COBOL"
```

---

## ✅ Checklist

- [ ] Medir longitud con FUNCTION LENGTH
- [ ] Limpiar espacios con FUNCTION TRIM
- [ ] Convertir mayúsculas/minúsculas
- [ ] Convertir texto a número con FUNCTION NUMVAL
- [ ] Combinar funciones en una expresión

## 📚 Recursos

- [GnuCOBOL Intrinsic Functions](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Intrinsic-functions)
- [IBM COBOL Intrinsic Functions](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=functions-intrinsic)
