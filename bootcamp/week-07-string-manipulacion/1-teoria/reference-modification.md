# Reference Modification — Acceso Parcial a Campos

## 🎯 Objetivos

- Acceder a subcadenas con referencia de modificación
- Extraer porciones de campos sin STRING/UNSTRING
- Usar sintaxis `variable(inicio:longitud)`

---

## 1. Sintaxis

```cobol
       variable(inicio:longitud)
```

| Parámetro | Significado |
|-----------|-------------|
| `inicio` | Posición desde donde empezar (1 = primer carácter) |
| `longitud` | Cantidad de caracteres a tomar |

```cobol
       01  WS-TEXTO   PIC X(20) VALUE "COBOL PROGRAMMING".
       
           DISPLAY WS-TEXTO(1:5).     *> "COBOL"
           DISPLAY WS-TEXTO(7:11).    *> "PROGRAMMING"
           DISPLAY WS-TEXTO(1:1).     *> "C"
```

---

## 2. Casos de Uso Comunes

### Extraer ID de una línea

```cobol
       01  WS-REGISTRO PIC X(39) VALUE "00001Juan Perez              00001500000".
       
           MOVE WS-REGISTRO(1:5) TO WS-ID.
      *> WS-ID = "00001"
```

### Extraer nombre

```cobol
           MOVE WS-REGISTRO(6:25) TO WS-NOMBRE.
      *> WS-NOMBRE = "Juan Perez               "
```

### Extraer fecha en partes

```cobol
       01  WS-FECHA   PIC X(08) VALUE "20260620".
       
           MOVE WS-FECHA(1:4) TO WS-ANO.    *> "2026"
           MOVE WS-FECHA(5:2) TO WS-MES.    *> "06"
           MOVE WS-FECHA(7:2) TO WS-DIA.    *> "20"
```

---

## 3. Reference Modification en WRITE

```cobol
       01  WS-LINEA-REPORTE PIC X(132) VALUE SPACES.
       
           MOVE "CLIENTE" TO WS-LINEA-REPORTE(1:7).
           MOVE WS-NOMBRE TO WS-LINEA-REPORTE(10:30).
           MOVE WS-SALDO-EDIT TO WS-LINEA-REPORTE(45:15).
       
           WRITE REP-REG FROM WS-LINEA-REPORTE.
```

---

## 4. Combinar con FUNCTION LENGTH

```cobol
      *> Tomar desde posición 5 hasta el final
           MOVE WS-TEXTO(5:FUNCTION LENGTH(WS-TEXTO) - 4) TO WS-RESTO.
```

---

## 5. Lado Izquierdo (Modificar)

```cobol
           MOVE "XXXX" TO WS-TARJETA(13:4).
      *> Enmascara los últimos 4 dígitos de la tarjeta
```

---

## ✅ Checklist

- [ ] Extraer subcadena con `variable(inicio:largo)`
- [ ] Modificar una porción con MOVE a posición específica
- [ ] Combinar con FUNCTION LENGTH para rango dinámico

## 📚 Recursos

- [IBM COBOL Reference Modification](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-reference-modification)
