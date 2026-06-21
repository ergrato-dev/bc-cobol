# Estructura de un Reporte Profesional

## 🎯 Objetivos

- Diseñar reportes con encabezado, detalle y pie
- Alinear columnas y formatear campos
- Implementar paginación profesional
- Construir líneas con STRING y campos de edición

---

## 1. Las Tres Zonas de un Reporte

Todo reporte profesional tiene tres zonas:

```
┌─────────────────────────────────┐
│         ENCABEZADO              │ ← Título, fecha, página, columnas
├─────────────────────────────────┤
│         DETALLE                 │ ← Registro 1
│         DETALLE                 │ ← Registro 2
│         DETALLE                 │ ← Registro N
├─────────────────────────────────┤
│         PIE                     │ ← Totales, fecha de emisión
└─────────────────────────────────┘
```

---

## 2. Encabezado (HEADER)

### Encabezado de Reporte (una vez al inicio)

```cobol
       01  WS-HEAD-REPORTE.
           05 FILLER PIC X(30) VALUE SPACES.
           05 FILLER PIC X(20) VALUE "BANCO CENTRAL".
           05 FILLER PIC X(10) VALUE SPACES.
           05 FILLER PIC X(05) VALUE "FECHA".
       
       01  WS-HEAD-FECHA.
           05 FILLER PIC X(30) VALUE SPACES.
           05 FILLER PIC X(20) VALUE "REPORTE DE CUENTAS".
           05 FILLER PIC X(10) VALUE SPACES.
           05 WS-HFECHA PIC 99/99/9999.
```

### Encabezado de Página (se repite en cada página)

```cobol
       01  WS-HEAD-PAGINA.
           05 FILLER PIC X(40) VALUE "CUENTAS ACTIVAS".
           05 FILLER PIC X(05) VALUE "PAG: ".
           05 WS-HPAG PIC Z(02)9.
```

### Títulos de Columnas

```cobol
       01  WS-HEAD-COLUMNAS.
           05 FILLER PIC X(08) VALUE "CUENTA".
           05 FILLER PIC X(27) VALUE "NOMBRE".
           05 FILLER PIC X(13) VALUE "SALDO".
           05 FILLER PIC X(08) VALUE "ESTADO".
```

---

## 3. Detalle (DETAIL)

Cada registro del archivo genera una línea:

```cobol
       01  WS-LINEA-DETALLE.
           05 FILLER PIC X(02) VALUE SPACES.
           05 WS-LCTA    PIC Z(04)9.
           05 FILLER PIC X(02) VALUE SPACES.
           05 WS-LNOMBRE PIC X(25).
           05 FILLER PIC X(02) VALUE SPACES.
           05 WS-LSALDO  PIC $$,$$9.99.
           05 FILLER PIC X(02) VALUE SPACES.
           05 WS-LESTADO PIC X(08).
```

### Escribir línea de detalle

```cobol
           MOVE CTA-ID TO WS-LCTA.
           MOVE CTA-NOMBRE TO WS-LNOMBRE.
           MOVE CTA-SALDO TO WS-LSALDO.
           IF CTA-ACTIVA
               MOVE "ACTIVA" TO WS-LESTADO
           ELSE
               MOVE "INACTIVA" TO WS-LESTADO
           END-IF.
           WRITE REP-REG FROM WS-LINEA-DETALLE.
           ADD 1 TO WS-LIN-PAGINA.
```

---

## 4. Pie (FOOTER)

### Pie de Página

```cobol
       01  WS-PIE-PAGINA.
           05 FILLER PIC X(50) VALUE SPACES.
           05 FILLER PIC X(20) VALUE "--- CONTINUA ---".
```

### Pie de Reporte (totales finales)

```cobol
       01  WS-PIE-REPORTE.
           05 FILLER PIC X(30) VALUE SPACES.
           05 FILLER PIC X(20) VALUE "TOTAL REGISTROS: ".
           05 WS-PTOT PIC ZZ,ZZ9.
```

---

## 5. Párrafos del Generador de Reporte

```cobol
       PROCEDURE DIVISION.
       MAIN.
           PERFORM 1000-ABRIR.
           PERFORM 2000-ENCABEZADO.
           PERFORM 3000-PROCESAR UNTIL EOF.
           PERFORM 4000-PIE-REPORTE.
           PERFORM 9000-CERRAR.
           STOP RUN.
       
       1000-ABRIR.
           OPEN INPUT DATOS-FILE.
           OPEN OUTPUT REPORTE-FILE.
       
       2000-ENCABEZADO.
           ADD 1 TO WS-NUM-PAGINA.
           MOVE WS-NUM-PAGINA TO WS-HPAG.
           WRITE REP-REG FROM WS-HEAD-REPORTE
               AFTER ADVANCING PAGE.
           WRITE REP-REG FROM WS-HEAD-FECHA.
           WRITE REP-REG FROM WS-SEPARADOR.
           WRITE REP-REG FROM WS-HEAD-COLUMNAS.
           WRITE REP-REG FROM WS-SEPARADOR.
       
       3000-PROCESAR.
           READ DATOS-FILE AT END SET EOF TO TRUE
               NOT AT END
                   IF WS-LIN-PAGINA > 55
                       PERFORM 3500-PIE-PAGINA
                       PERFORM 2000-ENCABEZADO
                   END-IF
                   PERFORM 3200-ESCRIBIR-DETALLE
           END-READ.
       
       4000-PIE-REPORTE.
           WRITE REP-REG FROM WS-SEPARADOR.
           MOVE WS-CONT-REG TO WS-PTOT.
           WRITE REP-REG FROM WS-PIE-REPORTE.
```

---

## 6. Alineación de Columnas

### Usando FILLER para espaciado

```cobol
       01  WS-LINEA.
           05 FILLER PIC X(01) VALUE SPACES.    *> Margen izquierdo
           05 WS-COL1    PIC X(15).
           05 FILLER PIC X(03) VALUE SPACES.    *> Espacio entre columnas
           05 WS-COL2    PIC Z(04)9.
```

### Usando una plantilla de 132 columnas

```cobol
       01  WS-REPORTE-132.
           05 WS-R132-ID     PIC X(06).   *> Cols 1-6
           05 WS-R132-NOMBRE PIC X(30).   *> Cols 7-36
           05 WS-R132-SALDO  PIC X(15).   *> Cols 37-51
           05 FILLER         PIC X(81).   *> Resto
```

---

## ✅ Checklist

- [ ] Diseñar encabezado de reporte (título, fecha)
- [ ] Diseñar títulos de columnas
- [ ] Diseñar línea de detalle con formato
- [ ] Diseñar pie de reporte con totales
- [ ] Implementar paginación automática
- [ ] Alinear columnas con FILLER

## 📚 Recursos

- [IBM COBOL Report Writer](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=features-report-writer)
- [GnuCOBOL Report Generation](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Report-Writer)
