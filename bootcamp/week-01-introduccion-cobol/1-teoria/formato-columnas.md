# Formato de Columnas: Fixed vs Free

## 🎯 Objetivos

- Comprender el formato tradicional de columnas COBOL
- Usar `>>SOURCE FORMAT IS FREE` para formato moderno
- Escribir comentarios correctamente en ambos formatos

---

## 1. Formato Fijo (Tradicional)

COBOL nació en la era de las tarjetas perforadas (80 columnas). El formato fijo refleja esta herencia:

```
Columnas: 1....6 7 8....11 12...............................72 73......80
          |area | |area| |           area B                | |area   |
          |sec  | | A  | |                                 | |ident  |
```

| Columnas | Nombre | Uso |
|----------|--------|-----|
| 1-6 | Número de secuencia | Opcional, para ordenar tarjetas |
| 7 | Área de indicador | `*` comentario, `-` continuación, `D` debug |
| 8-11 | Área A | Divisiones, secciones, párrafos, 01, 77, FD |
| 12-72 | Área B | Sentencias, niveles 02-49 |
| 73-80 | Área de identificación | Opcional, ignorada por el compilador |

### Ejemplo en formato fijo

```
000010 IDENTIFICATION DIVISION.
000020 PROGRAM-ID. FIXED.
000030 DATA DIVISION.
000040 WORKING-STORAGE SECTION.
000050 01  WS-NOMBRE PIC X(30).
000060 PROCEDURE DIVISION.
000070     DISPLAY "Formato fijo".
000080     STOP RUN.
```

> 📝 Los números de secuencia son opcionales en GnuCOBOL. Puedes omitirlos.

---

## 2. Formato Libre (Moderno)

A partir de COBOL 2002, existe el **formato libre** que elimina las restricciones de columnas:

```cobol
>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. LIBRE.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-NOMBRE PIC X(30).
PROCEDURE DIVISION.
    DISPLAY "Formato libre".
    STOP RUN.
```

### Características del formato libre

- ✅ Sin restricción de columnas — el código empieza donde quieras
- ✅ Líneas de hasta 255 caracteres
- ✅ Comentarios con `*> ` (guion + asterisco + mayor que + espacio)
- ✅ Directiva `>>SOURCE FORMAT IS FREE` debe ser la primera línea
- ✅ Indentación libre (recomendado 4 espacios)

> 🎯 **Este bootcamp usa exclusivamente formato libre.** Es más amigable para principiantes y compatible con editores modernos.

---

## 3. Comentarios

### Formato fijo

```
000010*> Esto es un comentario en área A (asterisco en columna 7)
000020*> Esto es otro comentario
```

### Formato libre

```cobol
*> Esto es un comentario de línea completa
    DISPLAY "Hola"  *> Esto es un comentario inline
```

### Tipos de comentarios

| Símbolo | Significado |
|---------|-------------|
| `*> ` | Comentario normal (formato libre) |
| `*` (col 7) | Comentario normal (formato fijo) |
| `D` (col 7) | Línea de debugging (solo compila con `-fdebug`) |
| `-` (col 7) | Continuación de literal de línea anterior |

### Ejemplos de continuación

```cobol
*> Continuar un literal largo:
    DISPLAY "Este es un mensaje muy largo que no cabe "
          & "en una sola línea".

*> Formato fijo: guion en columna 7
000010     DISPLAY "Este es un mensaje muy largo que"
000020-            " continúa en la siguiente línea".
```

---

## 4. Convenciones de Indentación

En este bootcamp usamos:

```cobol
>>SOURCE FORMAT IS FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. CONVENCIONES.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-EJEMPLO.
    05 WS-CAMPO1    PIC X(10).
    05 WS-CAMPO2    PIC 9(05).

PROCEDURE DIVISION.
    DISPLAY "Divisiones al margen izquierdo".
    DISPLAY "Sentencias indentadas con 4 espacios".
    
    IF WS-CAMPO2 > 0
        DISPLAY "Bloque IF indentado con 4 espacios más"
    END-IF.
    
    STOP RUN.
```

### Reglas

- ✅ Divisiones y secciones: columna 1 (sin indentar)
- ✅ Sentencias: 4 espacios de indentación
- ✅ Bloques (IF, PERFORM): 4 espacios adicionales por nivel
- ✅ PICTURE alineados para legibilidad
- ✅ Máximo 72 caracteres por línea (buena práctica incluso en libre)

---

## 5. Conversión entre Formatos

Si encuentras código legacy en formato fijo, puedes convertirlo:

```bash
# Opción 1: Agregar la directiva al inicio
echo ">>SOURCE FORMAT IS FREE" > programa.cbl
cat programa-fixed.cbl >> programa.cbl

# Opción 2: Compilar con flag -free
cobc -x -free programa-fixed.cbl
# Esto ignora las restricciones de columnas
```

---

## ✅ Checklist

- [ ] Identificar las 4 áreas de columnas en formato fijo
- [ ] Escribir `>>SOURCE FORMAT IS FREE` como primera línea
- [ ] Usar `*> ` para comentarios en formato libre
- [ ] Aplicar indentación consistente (4 espacios)
- [ ] Compilar con `cobc -x -free`

## 📚 Recursos

- [GnuCOBOL Source Format](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Source-format)
- [COBOL 2002 Free Format Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=programs-source-format)
