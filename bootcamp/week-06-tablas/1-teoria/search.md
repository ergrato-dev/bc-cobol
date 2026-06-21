# SEARCH — Búsqueda Secuencial en Tablas

## 🎯 Objetivos

- Buscar elementos en una tabla con SEARCH
- Usar AT END para "no encontrado"
- Combinar WHEN con condiciones complejas
- Conocer el rendimiento O(n) de SEARCH

---

## 1. Sintaxis de SEARCH

```cobol
       SEARCH nombre-tabla
           [VARYING indice]
           [AT END sentencias...]
           WHEN condicion
               sentencias...
       END-SEARCH.
```

### Requisitos

1. La tabla debe tener `INDEXED BY`
2. El índice debe inicializarse con `SET` antes de SEARCH
3. SEARCH avanza el índice automáticamente

### Ejemplo básico

```cobol
       01  WS-CODIGOS.
           05 WS-CODIGO OCCURS 10 TIMES
               INDEXED BY COD-IDX.
              10 WS-SIGLA   PIC X(03).
              10 WS-MONEDA  PIC X(20).
       
           SET COD-IDX TO 1.
           SEARCH WS-CODIGO
               AT END
                   DISPLAY "Codigo no encontrado"
               WHEN WS-SIGLA(COD-IDX) = "USD"
                   DISPLAY "USD = " WS-MONEDA(COD-IDX)
           END-SEARCH.
```

---

## 2. Cuándo Usar SEARCH

| Caso | Recomendación |
|------|---------------|
| Tabla no ordenada | ✅ SEARCH (única opción) |
| Tabla ordenada + pocos elementos (< 50) | ✅ SEARCH (simple) |
| Tabla ordenada + muchos elementos (> 50) | ✅ SEARCH ALL (binaria) |

---

## 3. SEARCH con Múltiples WHEN

```cobol
           SET COD-IDX TO 1.
           SEARCH WS-CODIGO
               AT END
                   DISPLAY "Moneda no soportada"
               WHEN WS-SIGLA(COD-IDX) = "USD"
                   MOVE "Dolar estadounidense" TO WS-DESC
               WHEN WS-SIGLA(COD-IDX) = "EUR"
                   MOVE "Euro" TO WS-DESC
               WHEN WS-SIGLA(COD-IDX) = "MXN"
                   MOVE "Peso mexicano" TO WS-DESC
           END-SEARCH.
```

---

## 4. SEARCH VARYING (Con Otro Índice)

Permite que SEARCH use un índice diferente al declarado en la tabla:

```cobol
       01  WS-TABLA.
           05 WS-ELEM OCCURS 50 INDEXED BY TAB-IDX.
              10 WS-CODIGO PIC X(05).
       
       01  WS-IDX-EXT   USAGE IS INDEX.
       
           SET WS-IDX-EXT TO 1.
           SEARCH WS-ELEM VARYING WS-IDX-EXT
               AT END ...
               WHEN WS-CODIGO(WS-IDX-EXT) = WS-BUSCAR
                   ...
           END-SEARCH.
```

---

## 5. SEARCH con Registros (No Solo Campos Simples)

```cobol
       01  WS-PRODUCTOS.
           05 WS-PROD OCCURS 100 INDEXED BY PROD-IDX.
              10 WS-PROD-ID     PIC 9(05).
              10 WS-PROD-NOMBRE PIC X(30).
              10 WS-PROD-PRECIO PIC 9(07)V99.
       
           SET PROD-IDX TO 1.
           SEARCH WS-PROD
               AT END
                   DISPLAY "Producto no encontrado"
               WHEN WS-PROD-ID(PROD-IDX) = WS-BUSCAR
                   DISPLAY "Encontrado: "
                           WS-PROD-NOMBRE(PROD-IDX)
                           " $" WS-PROD-PRECIO(PROD-IDX)
           END-SEARCH.
```

---

## 6. Tabla No Llena (DEPENDING ON)

```cobol
       01  WS-CANT-ACTUAL     PIC 9(03) VALUE 25.
       01  WS-ITEMS.
           05 WS-ITEM OCCURS 1 TO 100
               DEPENDING ON WS-CANT-ACTUAL
               INDEXED BY ITEM-IDX.
              10 WS-ITEM-ID   PIC 9(05).
       
           SET ITEM-IDX TO 1.
           SEARCH WS-ITEM
               AT END
                   DISPLAY "No encontrado en " WS-CANT-ACTUAL " items"
               WHEN WS-ITEM-ID(ITEM-IDX) = WS-BUSCAR
                   DISPLAY "Encontrado en posicion " ITEM-IDX
           END-SEARCH.
```

---

## ✅ Checklist

- [ ] Declarar tabla con INDEXED BY
- [ ] Inicializar índice con SET antes de SEARCH
- [ ] Manejar AT END para "no encontrado"
- [ ] Usar WHEN con condiciones de búsqueda
- [ ] Elegir SEARCH para tablas no ordenadas o pequeñas

## 📚 Recursos

- [IBM COBOL SEARCH Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-search-statement)
- [GnuCOBOL SEARCH](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#SEARCH)
