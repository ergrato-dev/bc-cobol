# VALUE Clause — Inicialización de Datos

## 🎯 Objetivos

- Inicializar variables al declararlas
- Usar constantes figurativas (ZEROS, SPACES, ALL)
- Diferenciar VALUE en DATA DIVISION vs MOVE en PROCEDURE DIVISION

---

## 1. ¿Por qué Inicializar?

En COBOL, las variables **no se inicializan automáticamente** (excepto en algunas implementaciones). Siempre debes asignar un valor inicial para evitar comportamientos impredecibles.

```cobol
      *> ❌ PELIGROSO: variable sin inicializar
       01  WS-NOMBRE    PIC X(30).
      *> Puede contener basura de memoria
       
      *> ✅ CORRECTO: variable inicializada
       01  WS-NOMBRE    PIC X(30) VALUE SPACES.
```

---

## 2. VALUE con Literales

### Literales alfanuméricos

```cobol
       01  WS-TITULO    PIC X(20) VALUE "SISTEMA BANCARIO".
       01  WS-CODIGO    PIC X(03) VALUE "ABC".
       01  WS-VACIO     PIC X(50) VALUE SPACES.
```

### Literales numéricos

```cobol
       01  WS-CONTADOR  PIC 9(05) VALUE 1.
       01  WS-TASA      PIC 9V99  VALUE 1.25.   *> 1.25%
       01  WS-SALDO     PIC S9(07)V99 VALUE -500.00.
       01  WS-VACIO-NUM PIC 9(05) VALUE ZEROS.
```

> ⚠️ El literal numérico debe caber en el PIC. Si `PIC 9(03) VALUE 1000` → error de compilación.

---

## 3. Constantes Figurativas (Figurative Constants)

COBOL proporciona palabras reservadas para valores comunes:

| Constante | Significado | Uso típico |
|-----------|-------------|------------|
| `SPACE` / `SPACES` | Uno o más espacios | Limpiar campos alfanuméricos |
| `ZERO` / `ZEROS` / `ZEROES` | Uno o más ceros | Limpiar campos numéricos |
| `HIGH-VALUE` / `HIGH-VALUES` | Máximo valor del collating sequence | Delimitadores de archivos |
| `LOW-VALUE` / `LOW-VALUES` | Mínimo valor del collating sequence | Inicializar tablas vacías |
| `ALL "x"` | Rellena todo el campo con el carácter `x` | Separadores visuales |
| `QUOTE` / `QUOTES` | Comillas dobles | Construir strings con comillas |

### Ejemplos

```cobol
       01  WS-LINEA     PIC X(50) VALUE ALL "=".
      *> "=================================================="
       
       01  WS-ASTERISCO PIC X(40) VALUE ALL "*".
      *> "****************************************"
       
       01  WS-NOMBRE    PIC X(30) VALUE SPACES.
      *> 30 espacios en blanco
       
       01  WS-IMPORTE   PIC 9(07)V99 VALUE ZEROS.
      *> 0000000.00
```

---

## 4. VALUE en Niveles de Grupo

### Regla: Solo se puede usar VALUE en nivel de grupo si no tiene subordinados elementales con VALUE.

```cobol
      *> ✅ CORRECTO: VALUE solo en elementos individuales
       01  WS-CLIENTE.
           05 WS-CLI-ID       PIC 9(05) VALUE ZEROS.
           05 WS-CLI-NOMBRE   PIC X(30) VALUE SPACES.
           05 WS-CLI-SALDO    PIC S9(07)V99 VALUE ZEROS.
       
      *> ❌ INCORRECTO: VALUE en grupo con subordinados
      *01  WS-CLIENTE        VALUE SPACES.
      *    05 WS-CLI-ID       PIC 9(05).
      *    05 WS-CLI-NOMBRE   PIC X(30).
```

### Excepción: grupo sin subordinados elementales

```cobol
      *> ✅ CORRECTO: grupo sin subdivisiones
       01  WS-FECHA           VALUE "20260620".
           05 WS-ANO          PIC 9(04).
           05 WS-MES          PIC 9(02).
           05 WS-DIA          PIC 9(02).
      *> WS-ANO = 2026, WS-MES = 06, WS-DIA = 20
```

> 📝 El VALUE se asigna al grupo y se propaga a los subordinados según sus PIC.

---

## 5. VALUE vs MOVE

| Característica | VALUE | MOVE |
|---------------|-------|------|
| ¿Dónde se usa? | DATA DIVISION | PROCEDURE DIVISION |
| ¿Cuándo se ejecuta? | Al cargar el programa (una vez) | Cuando se alcanza la sentencia |
| ¿Propósito? | Valor inicial / por defecto | Cambiar valor durante ejecución |
| ¿Tamaño debe coincidir? | Sí (error de compilación si no) | Conversión automática |

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CONTADOR  PIC 9(03) VALUE 1.      *> Valor inicial: 1
       
       PROCEDURE DIVISION.
           DISPLAY "Inicio: " WS-CONTADOR.       *> 001
           MOVE 50 TO WS-CONTADOR.               *> Cambia a 50
           DISPLAY "Despues: " WS-CONTADOR.      *> 050
```

---

## 6. Inicialización en Bloque

Para inicializar muchos campos a la vez:

```cobol
       PROCEDURE DIVISION.
      *> Limpiar todo un registro
           INITIALIZE WS-CLIENTE.
      *> Equivalente a:
      *> MOVE ZEROS  TO WS-CLI-ID
      *> MOVE SPACES TO WS-CLI-NOMBRE
      *> MOVE ZEROS  TO WS-CLI-SALDO
```

`INITIALIZE` asigna:
- ZEROS a campos numéricos
- SPACES a campos alfanuméricos
- Respeta FILLER (no se modifica)

---

## ✅ Checklist

- [ ] Inicializar variables con VALUE al declararlas
- [ ] Usar ZEROS para campos numéricos, SPACES para alfanuméricos
- [ ] Crear separador con `VALUE ALL "="`
- [ ] Usar INITIALIZE para limpiar un registro completo
- [ ] Diferenciar cuándo usar VALUE vs MOVE

## 📚 Recursos

- [GnuCOBOL VALUE Clause](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#VALUE)
- [IBM COBOL VALUE Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-value-clause)
