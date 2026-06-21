# Edición de Datos para Reportes

## 🎯 Objetivos

- Aplicar formato profesional a números (moneda, miles)
- Formatear fechas para legibilidad
- Usar PIC de edición avanzada ($, Z, *, -, +, CR, DB)
- Crear campos de edición reutilizables

---

## 1. Moneda y Separadores de Miles

```cobol
       01  WS-MONTO-REAL     PIC S9(09)V99 USAGE COMP-3 VALUE 1234567.89.
       
      *> Diferentes formatos de edición
       01  WS-EDIT-BASICO    PIC Z,ZZZ,ZZ9.99.         *> " 1,234,567.89"
       01  WS-EDIT-MONEDA    PIC $Z,ZZZ,ZZ9.99.        *> "$ 1,234,567.89"
       01  WS-EDIT-FLOTANTE  PIC $$,$$$,$$9.99.        *> "  $1,234,567.89"
       01  WS-EDIT-ASTER     PIC **,***,**9.99.        *> "**1,234,567.89"
```

### MOVE de campo interno a campo de edición

```cobol
           MOVE WS-MONTO-REAL TO WS-EDIT-MONEDA.
           DISPLAY WS-EDIT-MONEDA.
      *> $ 1,234,567.89
```

---

## 2. Supresión de Ceros (Z y *)

```cobol
       01  WS-NUM           PIC 9(05) VALUE 42.
       01  WS-EDIT-Z        PIC Z(04)9.
      *> "   42"  (ceros reemplazados por espacios)
       
       01  WS-EDIT-ASTER    PIC *(04)9.
      *> "***42"  (ceros reemplazados por * — útil para cheques)
```

### Sin edición vs con edición

```cobol
           MOVE 42 TO WS-EDIT-Z.
           DISPLAY "[" WS-EDIT-Z "]".
      *> [   42]
       
           DISPLAY "[" WS-NUM "]".
      *> [00042]  ← sin editar, incómodo para leer
```

---

## 3. Signos en Reportes Financieros

```cobol
       01  WS-MONTO     PIC S9(07)V99 VALUE -1500.50.
       
       01  WS-EDIT-SIGNO-FIJO   PIC -Z,ZZ9.99.
      *> "- 1,500.50"  (signo fijo a la izquierda)
       
       01  WS-EDIT-SIGNO-FLOT   PIC --,---9.99.
      *> "   -1,500.50"  (signo flotante)
       
       01  WS-EDIT-CR           PIC Z,ZZ9.99CR.
      *> " 1,500.50CR"  (crédito contable)
       
       01  WS-EDIT-DB           PIC Z,ZZ9.99DB.
      *> " 1,500.50DB"  (débito contable)
```

---

## 4. Fechas Formateadas

```cobol
       01  WS-FECHA-INTERNA   PIC 9(08) VALUE 20260620.
       
       01  WS-FECHA-EDIT      PIC 99/99/9999.
      *> "20/06/2026"
       
       01  WS-FECHA-EDIT-GUION PIC 99-99-9999.
      *> "20-06-2026"
```

### Conversión usando Reference Modification

```cobol
           MOVE WS-FECHA-INTERNA(7:2) TO WS-FECHA-EDIT(1:2).  *> Día
           MOVE "/"                    TO WS-FECHA-EDIT(3:1).
           MOVE WS-FECHA-INTERNA(5:2) TO WS-FECHA-EDIT(4:2).  *> Mes
           MOVE "/"                    TO WS-FECHA-EDIT(6:1).
           MOVE WS-FECHA-INTERNA(1:4) TO WS-FECHA-EDIT(7:4).  *> Año
```

---

## 5. Campos de Edición Completos para Reporte

```cobol
       WORKING-STORAGE SECTION.
      *> Campos internos (para cálculos)
       01  WS-SALDO          PIC S9(09)V99 USAGE COMP-3.
       01  WS-TASA           PIC 9V99.
       01  WS-FECHA-APERT    PIC 9(08).
       
      *> Campos de edición (para reporte)
       01  WS-SALDO-EDIT     PIC $$,$$$,$$9.99.
       01  WS-TASA-EDIT      PIC Z9.99.
       01  WS-FECHA-EDIT     PIC 99/99/9999.
       
      *> Línea de detalle del reporte
       01  WS-LINEA-DET.
           05 FILLER        PIC X(02) VALUE SPACES.
           05 WS-LCTA        PIC Z(04)9.
           05 FILLER        PIC X(02) VALUE SPACES.
           05 WS-LNOMBRE    PIC X(25).
           05 FILLER        PIC X(02) VALUE SPACES.
           05 WS-LSALDO     PIC $$,$$$,$$9.99.
           05 FILLER        PIC X(02) VALUE SPACES.
           05 WS-LFECHA     PIC 99/99/9999.
```

---

## 6. Plantilla de Edición para Totales

```cobol
       01  WS-LINEA-TOTAL.
           05 FILLER PIC X(20) VALUE SPACES.
           05 FILLER PIC X(15) VALUE "TOTAL GENERAL:".
           05 WS-LTOTAL PIC $$$,$$$,$$9.99.
       
       01  WS-LINEA-SUBTOTAL.
           05 FILLER PIC X(02) VALUE SPACES.
           05 FILLER PIC X(15) VALUE "  Subtotal:".
           05 WS-LSUB PIC $$,$$$,$$9.99.
           05 FILLER PIC X(02) VALUE SPACES.
           05 FILLER PIC X(08) VALUE "Cuentas:".
           05 WS-LCONT PIC Z(03)9.
```

---

## ✅ Checklist

- [ ] Crear campo de edición para moneda con `$$,$$9.99`
- [ ] Usar `Z` para suprimir ceros a la izquierda
- [ ] Usar `CR` o `DB` para notación contable
- [ ] Formatear fechas con `/` o `-`
- [ ] Separar campos internos (COMP-3) de campos de edición (DISPLAY)

## 📚 Recursos

- [IBM COBOL PICTURE Editing](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-edited-picture-characters)
- [GnuCOBOL PICTURE Editing](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#PICTURE)
