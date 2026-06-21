# USAGE Clause — Optimización de Almacenamiento

## 🎯 Objetivos

- Elegir el formato interno de almacenamiento adecuado
- Diferenciar DISPLAY, COMP (binario) y COMP-3 (decimal empaquetado)
- Optimizar espacio para grandes volúmenes de datos

---

## 1. ¿Qué es USAGE?

USAGE define **cómo se almacena** un dato internamente en memoria. No afecta cómo se ve en pantalla, solo su representación binaria.

```cobol
       01  WS-NOMBRE    PIC X(30) USAGE DISPLAY.   *> Almacenamiento por defecto
       01  WS-CONTADOR  PIC 9(05) USAGE COMP.      *> Binario nativo
       01  WS-MONTO     PIC S9(07)V99 USAGE COMP-3.*> Decimal empaquetado
```

> 📝 Si no se especifica USAGE, el valor por defecto es DISPLAY.

---

## 2. Tipos de USAGE

### DISPLAY (por defecto)

Cada dígito o carácter ocupa **1 byte**. Es el formato más simple pero menos eficiente para números grandes.

```cobol
       01  WS-EDAD      PIC 9(03) USAGE DISPLAY.
      *> Ocupa 3 bytes: '0' '2' '5'
      *> Valor 25 se almacena como caracteres ASCII: 30 32 35 (hex)
```

| Ventajas | Desventajas |
|----------|-------------|
| Legible en debug | Ineficiente para cálculos |
| No requiere conversión para DISPLAY | Mayor uso de memoria |
| Ideal para campos chicos | Más lento en operaciones aritméticas |

### COMP (Binario / COMPUTATIONAL)

Almacena el valor en **binario nativo** de la CPU. Más rápido para cálculos.

```cobol
       01  WS-CONTADOR  PIC 9(05) USAGE COMP.
      *> Ocupa 4 bytes (en arquitectura 32/64 bits)
      *> Rango: 0 a 99999
```

| PIC 9(n) | Bytes (COMP) | Rango aproximado |
|----------|-------------|------------------|
| PIC 9(01) a 9(04) | 2 | 0 a 65535 |
| PIC 9(05) a 9(09) | 4 | 0 a ~2 mil millones |
| PIC 9(10) a 9(18) | 8 | 0 a ~9 trillones |

```cobol
      *> Buenos candidatos para COMP:
       01  WS-NUM-REGISTROS    PIC 9(07) USAGE COMP.   *> Contador grande
       01  WS-INDICE           PIC 9(03) USAGE COMP.   *> Índice de tabla
       01  WS-SECUENCIA        PIC 9(09) USAGE COMP.   *> Número de secuencia
```

### COMP-3 (Decimal Empaquetado / PACKED-DECIMAL)

Cada 2 dígitos ocupan **1 byte** (empaquetados). El último nibble guarda el signo. Ideal para datos financieros y archivos.

```cobol
       01  WS-SALDO      PIC S9(07)V99 USAGE COMP-3.
      *> 9 dígitos = 5 bytes (4 pares de dígitos + 1 byte con signo)
      *> Sin COMP-3: 9 bytes (DISPLAY)
      *> Ahorro: casi 50%
```

| PIC | Bytes DISPLAY | Bytes COMP-3 |
|-----|--------------|-------------|
| PIC 9(05) | 5 | 3 |
| PIC S9(07)V99 | 9 | 5 |
| PIC S9(13)V99 | 15 | 8 |

```cobol
      *> Buenos candidatos para COMP-3:
       01  WS-MONTO       PIC S9(09)V99 USAGE COMP-3.  *> Montos financieros
       01  WS-IMPORTE     PIC S9(07)V99 USAGE COMP-3.  *> Importes de factura
```

> 💡 Regla práctica: Usa **COMP** para contadores e índices. Usa **COMP-3** para montos financieros y campos de archivos.

---

## 3. Tabla Comparativa

| Característica | DISPLAY | COMP | COMP-3 |
|---------------|---------|------|--------|
| Almacenamiento | ASCII/EBCDIC | Binario | Decimal empaquetado |
| Eficiencia espacio | Baja | Alta (números grandes) | Alta (datos financieros) |
| Velocidad aritmética | Lenta | Muy rápida | Rápida |
| Conversión para DISPLAY | Directa | Automática | Automática |
| Uso típico | Campos chicos, textos | Contadores, índices | Montos, archivos |

---

## 4. Conversión Automática

COBOL convierte automáticamente entre USAGE al hacer MOVE o cálculos:

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-MONTO-COMP3   PIC S9(07)V99 USAGE COMP-3 VALUE 12345.67.
       01  WS-MONTO-EDIT    PIC $$,$$9.99.
       
       PROCEDURE DIVISION.
      *> Conversión automática COMP-3 → DISPLAY editado
           MOVE WS-MONTO-COMP3 TO WS-MONTO-EDIT.
           DISPLAY "Monto: " WS-MONTO-EDIT.
      *> Monto: $ 12,345.67
```

---

## 5. Buenas Prácticas

1. ✅ Usa **COMP** para: contadores de PERFORM, índices de tabla, secuencias
2. ✅ Usa **COMP-3** para: montos, saldos, importes almacenados en archivos
3. ✅ Usa **DISPLAY** para: nombres, direcciones, códigos alfanuméricos, campos chicos
4. ❌ No uses COMP para campos con decimales (usa COMP-3)
5. ❌ No uses COMP-3 para texto ni alfanumérico (solo numérico con S)

---

## ✅ Checklist

- [ ] Declarar un contador con `USAGE COMP`
- [ ] Declarar un monto financiero con `USAGE COMP-3`
- [ ] Explicar la diferencia de bytes entre DISPLAY y COMP-3 para `PIC S9(09)V99`
- [ ] Hacer MOVE de un campo COMP-3 a uno de edición
- [ ] Identificar qué USAGE usar para cada caso

## 📚 Recursos

- [GnuCOBOL USAGE Clause](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#USAGE)
- [IBM COBOL USAGE Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-usage-clause)
