# PICTURE Clause — Diseño de Datos

## 🎯 Objetivos

- Diseñar campos de datos con PICTURE (PIC)
- Diferenciar tipos: alfabético, numérico, alfanumérico
- Usar símbolos de edición para formato profesional

---

## 1. ¿Qué es PICTURE?

PICTURE (abreviado PIC) define el **tipo**, **tamaño** y **formato** de un dato en COBOL. Es el equivalente a declarar el tipo de una variable.

```cobol
       01  WS-NOMBRE    PIC X(30).      *> Alfanumérico, 30 caracteres
       01  WS-EDAD      PIC 9(03).      *> Numérico, 3 dígitos
       01  WS-ACTIVO    PIC A.          *> Alfabético, 1 carácter
```

---

## 2. Símbolos de Datos (Data Symbols)

| Símbolo | Significado | Ejemplo | Valor válido |
|---------|-------------|---------|-------------|
| `9` | Dígito numérico (0-9) | `PIC 9(05)` | `00123` |
| `X` | Cualquier carácter (alfanumérico) | `PIC X(20)` | `"Juan Pérez"` |
| `A` | Solo letras (A-Z, espacio) | `PIC A(10)` | `"JUAN"` |
| `S` | Signo (+ o -) para números | `PIC S9(04)` | `-0123` |
| `V` | Punto decimal implícito | `PIC 9(05)V99` | `0012345` = 123.45 |

### Números con signo (S)

```cobol
       01  WS-TEMPERATURA  PIC S9(03).    *> Rango: -999 a +999
       01  WS-SALDO        PIC S9(07)V99. *> Saldo con signo y 2 decimales
```

> ⚠️ El signo `S` no ocupa un carácter en pantalla. Se almacena internamente.

### Decimales implícitos (V)

```cobol
       01  WS-PRECIO       PIC 9(05)V99.
      *> Si WS-PRECIO = 1234567, el valor real es 12345.67
      *> La V marca dónde va el punto decimal, no ocupa espacio
```

---

## 3. Símbolos de Edición (Editing Symbols)

La edición convierte datos internos en formato legible para humanos (reportes, pantallas).

| Símbolo | Significado | Ejemplo | Resultado |
|---------|-------------|---------|-----------|
| `Z` | Supresión de ceros a la izquierda | `PIC Z(05)9` | `   123` |
| `*` | Reemplaza ceros con asteriscos (cheques) | `PIC *(05)9` | `***123` |
| `,` | Separador de miles | `PIC Z,ZZ9` | ` 1,234` |
| `.` | Punto decimal explícito | `PIC Z,ZZ9.99` | ` 1,234.56` |
| `$` | Signo de moneda flotante | `PIC $$,$$9.99` | `$1,234.56` |
| `-` | Signo negativo flotante | `PIC -,--9.99` | `-1,234.56` |
| `+` | Signo positivo/negativo | `PIC +,++9.99` | `+1,234.56` |
| `CR` | Crédito (contabilidad) | `PIC Z,ZZ9.99CR` | `1,234.56CR` |
| `DB` | Débito (contabilidad) | `PIC Z,ZZ9.99DB` | `1,234.56DB` |
| `B` | Espacio en blanco insertado | `PIC 99B99B99` | `12 34 56` |
| `0` | Cero insertado | `PIC 990099` | `120034` |
| `/` | Barra insertada (fechas) | `PIC 99/99/99` | `12/31/24` |

### Ejemplos completos

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Campos internos (no editados) — para cálculos
       01  WS-SALDO-REAL     PIC S9(07)V99 VALUE 1234567.
      *> Valor interno: 001234567 = $12,345.67
       
       01  WS-CANTIDAD       PIC 9(05)      VALUE 123.
      *> Valor interno: 00123
       
      *> Campos de edición — para mostrar en pantalla/reporte
       01  WS-SALDO-EDIT     PIC $$,$$9.99.
      *> Muestra: $ 12,345.67
       
       01  WS-CANT-EDIT      PIC ZZ,ZZ9.
      *> Muestra:      123
       01  WS-CANT-ASTER     PIC **,**9.
      *> Muestra: ****123
       01  WS-CANT-ZERO      PIC 00,009.
      *> Muestra: 00,123
```

### MOVE entre campos internos y de edición

```cobol
       PROCEDURE DIVISION.
           MOVE 1234567 TO WS-SALDO-REAL.        *> Valor interno
           MOVE WS-SALDO-REAL TO WS-SALDO-EDIT.  *> Se edita automáticamente
           DISPLAY "Saldo: " WS-SALDO-EDIT.
      *> Saldo: $ 12,345.67
```

---

## 4. Reglas de PICTURE

1. **Máximo 30 caracteres** en la cláusula PIC
2. El **número de repeticiones** va entre paréntesis: `PIC 9(05)`
3. Puedes repetir sin paréntesis: `PIC 99999` (equivale a `PIC 9(05)`)
4. Para campos de edición, el paréntesis encierra la parte numérica: `PIC Z(05)9`
5. `V` solo puede aparecer **una vez** en un PIC numérico
6. `S` debe ser el **primer** carácter en un PIC numérico

### Combinaciones válidas

```cobol
       01  WS-A  PIC X(100).           *> OK: alfanumérico
       01  WS-B  PIC A(20).            *> OK: alfabético
       01  WS-C  PIC 9(05).            *> OK: numérico entero
       01  WS-D  PIC S9(07)V99.        *> OK: numérico con signo y decimal
       01  WS-E  PIC $$,$$9.99.        *> OK: edición moneda
       01  WS-F  PIC Z,ZZ9.            *> OK: edición supresión ceros
      *01  WS-G  PIC X(10)9(05).       *> ERROR: no mezclar X con 9
      *01  WS-H  PIC 9(05)V9(03)V9.    *> ERROR: solo una V
```

---

## 5. Tamaños y Rangos Comunes

| PIC | Bytes | Rango / Capacidad |
|-----|-------|------------------|
| `PIC X(10)` | 10 | 10 caracteres |
| `PIC 9(02)` | 2 | 0 a 99 |
| `PIC 9(04)` | 4 | 0 a 9999 |
| `PIC 9(07)V99` | 9 | 0.00 a 9999999.99 |
| `PIC S9(03)` | 3 | -999 a +999 |
| `PIC S9(09)V99` | 11 | -999999999.99 a +999999999.99 |

---

## ✅ Checklist

- [ ] Declarar un campo alfanumérico con `PIC X(n)`
- [ ] Declarar un campo numérico con decimales (`V`)
- [ ] Declarar un campo con signo (`S`)
- [ ] Crear un campo de edición para mostrar moneda (`$`)
- [ ] Crear un campo de edición con supresión de ceros (`Z`)
- [ ] Mover un valor interno a un campo de edición y mostrarlo

## 📚 Recursos

- [GnuCOBOL PICTURE Clause](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#PICTURE)
- [IBM COBOL PICTURE Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-picture-clause)
