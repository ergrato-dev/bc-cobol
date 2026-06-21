# WRITE ADVANCING — Control de Impresión

## 🎯 Objetivos

- Controlar el avance de línea con BEFORE/AFTER ADVANCING
- Manejar saltos de página con PAGE
- Escribir líneas en blanco
- Simular control de impresora en entorno Linux

---

## 1. WRITE Simple (Sin Avance Explícito)

```cobol
       WRITE REPORTE-REG FROM WS-LINEA.
```

Escribe una línea en el archivo. En LINE SEQUENTIAL, cada WRITE genera una línea nueva.

---

## 2. WRITE BEFORE ADVANCING

Avanza líneas **antes** de escribir:

```cobol
      *> Avanzar 1 línea (comportamiento normal)
       WRITE REPORTE-REG FROM WS-LINEA
           BEFORE ADVANCING 1 LINE.
       
      *> Avanzar 2 líneas (deja 1 en blanco)
       WRITE REPORTE-REG FROM WS-TITULO
           BEFORE ADVANCING 2 LINES.
       
      *> Ir a nueva página
       WRITE REPORTE-REG FROM WS-ENCABEZADO
           BEFORE ADVANCING PAGE.
```

---

## 3. WRITE AFTER ADVANCING

Avanza líneas **después** de escribir:

```cobol
      *> Escribir y luego avanzar 2 líneas (deja espacio después)
       WRITE REPORTE-REG FROM WS-TITULO
           AFTER ADVANCING 2 LINES.
       
      *> Escribir y luego ir a nueva página
       WRITE REPORTE-REG FROM WS-PIE
           AFTER ADVANCING PAGE.
       
      *> No avanzar (sobrescribir misma línea)
       WRITE REPORTE-REG FROM WS-LINEA
           AFTER ADVANCING 0 LINES.
```

---

## 4. BEFORE vs AFTER

| Cláusula | Cuándo avanza | Uso típico |
|----------|--------------|------------|
| `BEFORE ADVANCING` | Antes de escribir | Encabezados de página, títulos |
| `AFTER ADVANCING` | Después de escribir | Espaciado entre secciones, pie de página |

```cobol
      *> BEFORE: el espacio va arriba de la línea
       WRITE REP-REG FROM WS-TITULO
           BEFORE ADVANCING 3 LINES.
      *> ← 2 líneas en blanco
      *> ← TÍTULO aquí
       
      *> AFTER: el espacio va abajo de la línea
       WRITE REP-REG FROM WS-TITULO
           AFTER ADVANCING 3 LINES.
      *> ← TÍTULO aquí
      *> ← 2 líneas en blanco
```

---

## 5. Números de Página

El control de página requiere una variable de contador:

```cobol
       WORKING-STORAGE SECTION.
       01  WS-NUM-PAGINA    PIC 9(03) VALUE ZEROS.
       01  WS-LIN-PAGINA    PIC 9(03) VALUE 99.    *> Fuerza nueva página
       01  WS-MAX-LINEAS    PIC 9(03) VALUE 60.     *> Líneas por página
       
       01  WS-ENCABEZADO.
           05 FILLER PIC X(50) VALUE "REPORTE DE CUENTAS".
           05 FILLER PIC X(10) VALUE "PAG: ".
           05 WS-PAG-EDIT PIC Z(02)9.
       
       PROCEDURE DIVISION.
           ADD 1 TO WS-NUM-PAGINA.
           MOVE WS-NUM-PAGINA TO WS-PAG-EDIT.
           WRITE REP-REG FROM WS-ENCABEZADO
               AFTER ADVANCING PAGE.
           MOVE 1 TO WS-LIN-PAGINA.    *> Reiniciar contador de líneas
```

### Verificar si necesita nueva página

```cobol
           IF WS-LIN-PAGINA > WS-MAX-LINEAS
               PERFORM 8000-NUEVA-PAGINA
           END-IF.
```

---

## 6. Párrafo de Nueva Página

```cobol
       8000-NUEVA-PAGINA.
           ADD 1 TO WS-NUM-PAGINA.
           MOVE WS-NUM-PAGINA TO WS-PAG-EDIT.
           WRITE REP-REG FROM WS-ENCABEZADO
               AFTER ADVANCING PAGE.
           MOVE 0 TO WS-LIN-PAGINA.
           WRITE REP-REG FROM WS-SEPARADOR.
           WRITE REP-REG FROM WS-TITULOS-COLUMNAS.
           ADD 2 TO WS-LIN-PAGINA.
```

---

## 7. Líneas en Blanco

```cobol
      *> Escribir 3 líneas en blanco
           MOVE SPACES TO WS-LINEA-BLANCO.
           WRITE REP-REG FROM WS-LINEA-BLANCO
               BEFORE ADVANCING 3 LINES.
```

---

## 8. En Linux/LINE SEQUENTIAL

En GnuCOBOL con LINE SEQUENTIAL:

- `BEFORE ADVANCING 1 LINE` = nueva línea (equivale a `\n`)
- `BEFORE ADVANCING PAGE` = salto de página (`\f` o múltiples `\n`)
- `AFTER ADVANCING 0 LINES` = no agrega `\n` (sobrescribe)

> 📝 Para reportes, LINE SEQUENTIAL es suficiente. El control de página se simula con líneas en blanco.

---

## ✅ Checklist

- [ ] Usar WRITE BEFORE/AFTER ADVANCING para control de líneas
- [ ] Crear encabezado con número de página
- [ ] Implementar nueva página automática cada N líneas
- [ ] Escribir líneas en blanco con ADVANCING
- [ ] Mantener contador de líneas por página

## 📚 Recursos

- [IBM COBOL WRITE Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-write-statement)
- [GnuCOBOL WRITE ADVANCING](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#WRITE)
