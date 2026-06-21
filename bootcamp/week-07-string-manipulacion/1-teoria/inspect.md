# INSPECT — Análisis y Reemplazo de Caracteres

## 🎯 Objetivos

- Contar ocurrencias con INSPECT TALLYING
- Reemplazar caracteres con INSPECT REPLACING
- Convertir caracteres con INSPECT CONVERTING
- Combinar todas las formas en una sola sentencia

---

## 1. INSPECT TALLYING (Contar)

Cuenta ocurrencias de caracteres o patrones:

```cobol
       01  WS-TEXTO      PIC X(30) VALUE "COBOL-ES-GENIAL".
       01  WS-CUENTA     PIC 9(03) VALUE ZEROS.
       
           INSPECT WS-TEXTO
               TALLYING WS-CUENTA FOR ALL "-".
      *> WS-CUENTA = 2
```

### Variantes de TALLYING

| Cláusula | Significado | Ejemplo |
|----------|-------------|---------|
| `ALL "x"` | Cuenta todas las ocurrencias de "x" | `ALL ","` → comas |
| `LEADING "x"` | Cuenta ocurrencias al inicio | `LEADING "0"` → ceros iniciales |
| `CHARACTERS` | Cuenta todos los caracteres | `CHARACTERS BEFORE "."` |
| `FIRST "x"` | Cuenta desde el primero | `FIRST "@"` |

```cobol
       01  WS-TEXTO      PIC X(20) VALUE "000123".
       
           INSPECT WS-TEXTO
               TALLYING WS-CEROS FOR LEADING "0".
      *> WS-CEROS = 3
       
           INSPECT WS-TEXTO
               TALLYING WS-CUENTA FOR CHARACTERS
               BEFORE INITIAL ".".
      *> Cuenta caracteres antes del primer punto
```

---

## 2. INSPECT REPLACING (Reemplazar)

Reemplaza caracteres en el mismo campo:

```cobol
       01  WS-TEXTO      PIC X(30) VALUE "HOLA-MUNDO".
       
           INSPECT WS-TEXTO
               REPLACING ALL "-" BY " ".
      *> WS-TEXTO = "HOLA MUNDO"
```

### Variantes de REPLACING

```cobol
      *> Reemplazar todos los dígitos por "*"
           INSPECT WS-TEXTO
               REPLACING ALL "0" BY "*"
                         ALL "1" BY "*"
                         ALL "2" BY "*".
       
      *> Reemplazar ceros iniciales por espacios
           INSPECT WS-NUMERO
               REPLACING LEADING "0" BY " ".
      *> "000123" → "   123"
       
      *> Reemplazar primer espacio por ":"
           INSPECT WS-TEXTO
               REPLACING FIRST " " BY ":".
      *> "Juan Perez" → "Juan:Perez"
```

---

## 3. INSPECT CONVERTING (Conversión)

Convierte un conjunto de caracteres en otro (mapeo 1 a 1):

```cobol
       01  WS-TEXTO      PIC X(30) VALUE "a1b2c3".
       
           INSPECT WS-TEXTO
               CONVERTING "abc" TO "ABC".
      *> WS-TEXTO = "A1B2C3"
       
           INSPECT WS-TEXTO
               CONVERTING "0123456789" TO "ABCDEFGHIJ".
      *> Mapea cada dígito a una letra
```

---

## 4. TALLYING + REPLACING en Una Sentencia

```cobol
           INSPECT WS-TEXTO
               TALLYING WS-CUENTA FOR ALL ","
               REPLACING ALL "," BY ";".
      *> Cuenta comas Y las reemplaza por punto y coma
```

---

## 5. BEFORE/AFTER (Limitar el Alcance)

```cobol
       01  WS-EMAIL      PIC X(40) VALUE "juan@empresa.com".
       01  WS-LOCAL      PIC 9(03) VALUE ZEROS.
       
           INSPECT WS-EMAIL
               TALLYING WS-LOCAL FOR CHARACTERS
               BEFORE INITIAL "@".
      *> WS-LOCAL = 4 ("juan" tiene 4 caracteres antes de @)
```

```cobol
      *> Reemplazar solo lo que está después del "@"
           INSPECT WS-EMAIL
               REPLACING ALL "a" BY "X"
               AFTER INITIAL "@".
      *> "juan@empresX.com"
```

---

## 6. Ejemplos Prácticos

### Limpiar espacios múltiples

```cobol
      *> Reemplazar múltiples espacios por uno solo
           INSPECT WS-TEXTO
               REPLACING ALL "  " BY " ".     *> Necesitas repetir
```

### Contar campos en CSV

```cobol
           INSPECT WS-LINEA-CSV
               TALLYING WS-CANT-CAMPOS FOR ALL ","
               BEFORE INITIAL " ".
           ADD 1 TO WS-CANT-CAMPOS.
      *> 4 comas = 5 campos
```

### Validar formato

```cobol
           INSPECT WS-TELEFONO
               TALLYING WS-DIGITOS FOR ALL "0" "1" "2" "3"
                       "4" "5" "6" "7" "8" "9".
           IF WS-DIGITOS = 10
               DISPLAY "Telefono valido"
           END-IF.
```

### Enmascarar datos sensibles

```cobol
      *> Enmascarar parte de un número de tarjeta
           INSPECT WS-TARJETA
               REPLACING ALL "0" BY "*"
                         ALL "1" BY "*"
                         ALL "2" BY "*"
                         ALL "3" BY "*"
                         ALL "4" BY "*"
                         ALL "5" BY "*"
                         ALL "6" BY "*"
                         ALL "7" BY "*"
                         ALL "8" BY "*"
                         ALL "9" BY "*"
               BEFORE INITIAL " ".
      *> "1234 5678 9012 3456" → "**** 5678 9012 3456"
```

---

## ✅ Checklist

- [ ] Contar ocurrencias con INSPECT TALLYING FOR ALL
- [ ] Reemplazar con INSPECT REPLACING ALL
- [ ] Eliminar ceros iniciales con REPLACING LEADING
- [ ] Convertir mayúsculas/minúsculas con CONVERTING
- [ ] Limitar alcance con BEFORE/AFTER
- [ ] Usar TALLYING + REPLACING combinados

## 📚 Recursos

- [IBM COBOL INSPECT Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-inspect-statement)
- [GnuCOBOL INSPECT](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#INSPECT)
