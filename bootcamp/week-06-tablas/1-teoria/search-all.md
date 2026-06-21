# SEARCH ALL — Búsqueda Binaria

## 🎯 Objetivos

- Implementar búsqueda binaria con SEARCH ALL
- Declarar ASCENDING/DESCENDING KEY en OCCURS
- Comprender el rendimiento O(log n) de SEARCH ALL
- Saber cuándo usar SEARCH ALL en lugar de SEARCH

---

## 1. ¿Por Qué SEARCH ALL?

SEARCH hace búsqueda secuencial: recorre elemento por elemento. Para 10,000 registros, en promedio 5,000 comparaciones.

SEARCH ALL hace búsqueda binaria: divide el espacio de búsqueda a la mitad en cada paso. Para 10,000 registros, solo ~14 comparaciones.

| Elementos | SEARCH (promedio) | SEARCH ALL (máximo) |
|-----------|------------------|---------------------|
| 10 | 5 | 4 |
| 100 | 50 | 7 |
| 1,000 | 500 | 10 |
| 10,000 | 5,000 | 14 |
| 1,000,000 | 500,000 | 20 |

---

## 2. Requisitos de SEARCH ALL

1. La tabla debe tener `ASCENDING KEY` o `DESCENDING KEY`
2. Los datos deben estar **ordenados** según la clave declarada
3. La tabla debe tener `INDEXED BY`

```cobol
       01  WS-TASAS.
           05 WS-TASA OCCURS 50 TIMES
               ASCENDING KEY IS WS-PLAZO
               INDEXED BY TASA-IDX.
              10 WS-PLAZO  PIC 9(03).       *> Clave de ordenamiento
              10 WS-VALOR  PIC 9V99.        *> Valor asociado
```

---

## 3. Sintaxis de SEARCH ALL

```cobol
       SEARCH ALL nombre-tabla
           AT END sentencias...
           WHEN condicion
               sentencias...
       END-SEARCH.
```

> ⚠️ La condición en WHEN **debe** usar la clave ASCENDING/DESCENDING. Solo se permite `=` (igualdad) o `IS EQUAL TO`.

```cobol
           SEARCH ALL WS-TASA
               AT END
                   DISPLAY "Plazo no encontrado"
               WHEN WS-PLAZO(TASA-IDX) = WS-BUSCAR
                   DISPLAY "Tasa: " WS-VALOR(TASA-IDX) "%"
           END-SEARCH.
```

> 📝 No necesitas inicializar el índice con SET. SEARCH ALL lo hace automáticamente.

---

## 4. Ejemplo Completo: Tabla de Tasas por Plazo

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Tabla ORDENADA por plazo (ASCENDING)
       01  WS-TASAS-CRED.
           05 WS-TRAMO OCCURS 6 TIMES
               ASCENDING KEY IS WS-MIN-PLAZO
               INDEXED BY TRAMO-IDX.
              10 WS-MIN-PLAZO   PIC 9(03).    *> Plazo mínimo del tramo
              10 WS-MAX-PLAZO   PIC 9(03).    *> Plazo máximo del tramo
              10 WS-TASA-TRAMO  PIC 9V99.     *> Tasa del tramo
       
      *> Datos cargados (deben estar en orden):
      *> Tramo 1: plazo 1-12,   tasa 5.00%
      *> Tramo 2: plazo 13-24,  tasa 7.50%
      *> Tramo 3: plazo 25-36,  tasa 9.00%
      *> Tramo 4: plazo 37-48,  tasa 10.50%
      *> Tramo 5: plazo 49-60,  tasa 12.00%
      *> Tramo 6: plazo 61-72,  tasa 14.00%
       
       01  WS-PLAZO-BUSCAR    PIC 9(03).
       
       PROCEDURE DIVISION.
           DISPLAY "Plazo deseado (meses): " WITH NO ADVANCING.
           ACCEPT WS-PLAZO-BUSCAR.
           
           SEARCH ALL WS-TRAMO
               AT END
                   DISPLAY "Plazo fuera de rango"
               WHEN WS-MIN-PLAZO(TRAMO-IDX) <= WS-PLAZO-BUSCAR
               AND WS-MAX-PLAZO(TRAMO-IDX) >= WS-PLAZO-BUSCAR
      *>        ↑ Esto no funcionaría: SEARCH ALL solo permite =
      *>          con la clave ASCENDING.
      *>          Solución: buscar por MIN y luego verificar MAX.
                   DISPLAY "Tasa: " WS-TASA-TRAMO(TRAMO-IDX) "%"
           END-SEARCH.
```

> ⚠️ **Limitación importante**: SEARCH ALL solo permite `WHEN clave = valor`. Para condiciones de rango como el ejemplo anterior, debes buscar el tramo inicial y luego verificar manualmente, o usar SEARCH secuencial.

---

## 5. Estrategia: SEARCH ALL para Clave Exacta

SEARCH ALL brilla con búsquedas de igualdad exacta:

```cobol
       01  WS-CATALOGO.
           05 WS-PROD OCCURS 500 TIMES
               ASCENDING KEY IS WS-PROD-ID
               INDEXED BY PROD-IDX.
              10 WS-PROD-ID     PIC 9(05).
              10 WS-PROD-NOMBRE PIC X(30).
              10 WS-PROD-PRECIO PIC 9(07)V99.
       
           SEARCH ALL WS-PROD
               AT END
                   DISPLAY "Producto no existe"
               WHEN WS-PROD-ID(PROD-IDX) = WS-ID-BUSCAR
                   DISPLAY WS-PROD-NOMBRE(PROD-IDX)
                   DISPLAY "$" WS-PROD-PRECIO(PROD-IDX)
           END-SEARCH.
```

---

## 6. ¿SEARCH o SEARCH ALL?

```
¿Tabla ordenada por la clave de búsqueda?
├── NO  → SEARCH (secuencial)
└── SÍ  → ¿Más de 50 elementos?
          ├── NO  → SEARCH (simple, no requiere ASCENDING KEY)
          └── SÍ  → SEARCH ALL (binaria, más rápida)
```

---

## ✅ Checklist

- [ ] Declarar ASCENDING KEY o DESCENDING KEY en OCCURS
- [ ] Cargar los datos en orden según la clave declarada
- [ ] Usar SEARCH ALL con WHEN clave = valor
- [ ] Manejar AT END para clave no encontrada
- [ ] Elegir SEARCH ALL para tablas grandes (> 50) ordenadas

## 📚 Recursos

- [IBM COBOL SEARCH ALL Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-search-all-statement)
- [GnuCOBOL SEARCH ALL](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#SEARCH-ALL)
