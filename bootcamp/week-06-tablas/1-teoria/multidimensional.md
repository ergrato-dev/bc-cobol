# Tablas Multidimensionales — OCCURS Anidado

## 🎯 Objetivos

- Declarar tablas 2D y 3D con OCCURS anidado
- Recorrer con PERFORM VARYING anidado
- Usar SEARCH en el nivel correcto
- Aplicar a casos reales: tarifas, calendarios, catálogos

---

## 1. Tabla Bidimensional (2D)

Una tabla 2D tiene filas y columnas, como una hoja de cálculo.

```cobol
      *> Tabla de tarifas: 5 productos × 12 meses
       01  WS-TARIFAS.
           05 WS-PRODUCTO OCCURS 5 TIMES.          *> Filas
              10 WS-MES OCCURS 12 TIMES.           *> Columnas
                 15 WS-TARIFA PIC 9(05)V99.
```

### Acceso

```cobol
           MOVE 1500.50 TO WS-TARIFA(3, 6).
      *> Producto 3, Mes 6 = $1,500.50
       
           DISPLAY WS-TARIFA(1, 12).
      *> Producto 1, Mes 12
```

### Recorrido completo

```cobol
           PERFORM VARYING WS-P FROM 1 BY 1
                   UNTIL WS-P > 5
               PERFORM VARYING WS-M FROM 1 BY 1
                       UNTIL WS-M > 12
                   DISPLAY "Prod " WS-P
                           " Mes " WS-M
                           " = " WS-TARIFA(WS-P, WS-M)
               END-PERFORM
           END-PERFORM.
```

---

## 2. Tabla Tridimensional (3D)

Agrega una tercera dimensión:

```cobol
      *> Ventas: 10 sucursales × 5 productos × 12 meses
       01  WS-VENTAS.
           05 WS-SUCURSAL OCCURS 10 TIMES.
              10 WS-PROD OCCURS 5 TIMES.
                 15 WS-MES OCCURS 12 TIMES.
                    20 WS-MONTO PIC 9(09)V99.
```

### Acceso

```cobol
           MOVE WS-MONTO(3, 2, 6) TO WS-EDIT.
      *> Sucursal 3, Producto 2, Mes 6
```

---

## 3. Tabla 2D con Registros Completos

```cobol
      *> Tabla de amortización: 24 cuotas con detalle
       01  WS-AMORTIZACION.
           05 WS-CUOTA OCCURS 24 TIMES.
              10 WS-CUOTA-NUM   PIC 9(03).
              10 WS-CUOTA-VALOR PIC 9(09)V99.
              10 WS-CUOTA-INT   PIC 9(09)V99.
              10 WS-CUOTA-CAP   PIC 9(09)V99.
              10 WS-CUOTA-SALDO PIC 9(09)V99.
       
           PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > 24
               DISPLAY WS-CUOTA-NUM(WS-I) " | "
                       WS-CUOTA-VALOR(WS-I) " | "
                       WS-CUOTA-INT(WS-I) " | "
                       WS-CUOTA-CAP(WS-I) " | "
                       WS-CUOTA-SALDO(WS-I)
           END-PERFORM.
```

---

## 4. SEARCH en Tablas Multidimensionales

Solo puedes hacer SEARCH en **un nivel** de la tabla. Debes elegir en qué dimensión buscar:

```cobol
       01  WS-PRODUCTOS.
           05 WS-PROD OCCURS 10 TIMES
               INDEXED BY PROD-IDX.
              10 WS-PROD-ID   PIC 9(05).
              10 WS-PRECIOS.
                 15 WS-PRECIO OCCURS 3 TIMES       *> 3 monedas
                     INDEXED BY PREC-IDX.
                    20 WS-MONTO PIC 9(07)V99.
       
      *> Buscar un producto (SEARCH en nivel producto)
           SET PROD-IDX TO 1.
           SEARCH WS-PROD
               AT END DISPLAY "No encontrado"
               WHEN WS-PROD-ID(PROD-IDX) = WS-BUSCAR
                   DISPLAY "Precio USD: "
                           WS-MONTO(PROD-IDX, 1)
           END-SEARCH.
```

---

## 5. Inicialización de Tablas Multidimensionales

```cobol
      *> Poblar tabla de tarifas con datos
           PERFORM VARYING WS-P FROM 1 BY 1
                   UNTIL WS-P > 5
               PERFORM VARYING WS-M FROM 1 BY 1
                       UNTIL WS-M > 12
                   COMPUTE WS-TARIFA(WS-P, WS-M) =
                       WS-TARIFA-BASE(WS-P)
                       * (1 + WS-M * 0.01)        *> +1% por mes
               END-PERFORM
           END-PERFORM.
```

---

## 6. Buenas Prácticas

1. ✅ No exceder 3 dimensiones (se vuelve difícil de mantener)
2. ✅ Usar nombres descriptivos para los índices: `PROD-IDX`, `MES-IDX`
3. ✅ Pre-calcular tamaños de tabla en variables para PERFORM
4. ❌ No usar OCCURS en nivel 01
5. ❌ No usar VALUE en tablas (inicializar con PERFORM)

---

## ✅ Checklist

- [ ] Declarar tabla 2D con OCCURS anidado
- [ ] Acceder con dos subíndices: `TABLA(fila, col)`
- [ ] Recorrer con PERFORM VARYING anidado
- [ ] Inicializar tabla 2D con datos calculados
- [ ] Usar SEARCH en el nivel adecuado de la tabla

## 📚 Recursos

- [IBM COBOL OCCURS Nested](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-occurs-clause)
- [GnuCOBOL Table Handling](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Table-handling)
