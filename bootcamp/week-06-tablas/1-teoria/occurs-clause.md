# OCCURS Clause — Declaración de Tablas

## 🎯 Objetivos

- Declarar tablas (arrays) con OCCURS
- Diferenciar tamaño fijo (TIMES) y variable (DEPENDING ON)
- Acceder a elementos por subíndice
- Inicializar y recorrer tablas con PERFORM VARYING

---

## 1. ¿Qué es OCCURS?

OCCURS define una **tabla** (array) de elementos repetidos con la misma estructura. Es el equivalente a un array en otros lenguajes.

```cobol
      *> Python: tasas = [0.0, 0.0, 0.0, 0.0, 0.0]
       01  WS-TASAS.
           05 WS-TASA PIC 9V99 OCCURS 5 TIMES.
```

Cada elemento se accede por subíndice:

```cobol
           MOVE 3.50 TO WS-TASA(1).   *> Primer elemento
           MOVE 5.00 TO WS-TASA(2).   *> Segundo elemento
           DISPLAY WS-TASA(3).         *> Tercer elemento
```

---

## 2. OCCURS con Grupo (Registros en Tabla)

```cobol
      *> Tabla de 100 clientes, cada uno con ID, nombre y saldo
       01  WS-CLIENTES.
           05 WS-CLIENTE OCCURS 100 TIMES.
              10 WS-CLI-ID       PIC 9(05).
              10 WS-CLI-NOMBRE   PIC X(30).
              10 WS-CLI-SALDO    PIC S9(07)V99.
```

Acceso con subíndice:

```cobol
           MOVE 1042 TO WS-CLI-ID(5).
           MOVE "Laura" TO WS-CLI-NOMBRE(5).
           MOVE 50000 TO WS-CLI-SALDO(5).
       
           DISPLAY "Cliente 5: " WS-CLI-ID(5)
                   " " WS-CLI-NOMBRE(5)
                   " " WS-CLI-SALDO(5).
```

---

## 3. OCCURS DEPENDING ON (Tamaño Variable)

El tamaño de la tabla se determina en tiempo de ejecución:

```cobol
       01  WS-CANT-ITEMS       PIC 9(03) VALUE 5.
       01  WS-ITEMS.
           05 WS-ITEM OCCURS 1 TO 100 TIMES
               DEPENDING ON WS-CANT-ITEMS.
              10 WS-ITEM-ID    PIC 9(05).
              10 WS-ITEM-PRECIO PIC 9(07)V99.
```

| Característica | OCCURS n TIMES | OCCURS 1 TO n DEPENDING ON |
|---------------|---------------|---------------------------|
| Tamaño | Fijo en compilación | Variable en ejecución |
| Memoria reservada | n elementos | Máximo n, usa según variable |
| PERFORM VARYING | `UNTIL I > n` | `UNTIL I > WS-CANT` |

---

## 4. Recorrer Tablas con PERFORM VARYING

```cobol
       01  WS-I               PIC 9(03) USAGE COMP.
       01  WS-SUMA            PIC S9(09)V99 VALUE ZEROS.
       
           PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > 100
               ADD WS-CLI-SALDO(WS-I) TO WS-SUMA
           END-PERFORM.
```

### Inicializar toda la tabla

```cobol
           PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > 100
               MOVE ZEROS TO WS-CLI-ID(WS-I)
               MOVE SPACES TO WS-CLI-NOMBRE(WS-I)
               MOVE ZEROS TO WS-CLI-SALDO(WS-I)
           END-PERFORM.
```

---

## 5. Subíndice vs Índice

### Subíndice (numérico)

```cobol
       01  WS-I           PIC 9(03) USAGE COMP.
           DISPLAY WS-TASA(WS-I).
```

- Ocupa una variable en WORKING-STORAGE
- Más lento (referencia indirecta)
- Simple de entender

### Índice (INDEXED BY)

```cobol
       01  WS-TASAS.
           05 WS-TASA PIC 9V99 OCCURS 10 TIMES
               INDEXED BY WS-IDX.
       
           SET WS-IDX TO 1.
           DISPLAY WS-TASA(WS-IDX).
```

- Interno del compilador, más rápido
- Se manipula con SET, no con MOVE
- Requiere INDEXED BY en la declaración OCCURS

> 📝 Para tablas pequeñas (< 1000 elementos), la diferencia de velocidad es insignificante. Usa subíndices para simplicidad.

---

## 6. Reglas de OCCURS

1. ❌ No usar OCCURS en nivel 01 (debe ser 02-49)
2. ❌ No usar VALUE en elementos con OCCURS (inicializa con PERFORM)
3. ✅ Puedes tener OCCURS anidados (tablas 2D, 3D)
4. ✅ OCCURS en FILE SECTION solo para tablas internas, no en FD
5. ✅ DEPENDING ON debe ser una variable entera positiva

```cobol
      *> ✅ CORRECTO
       01  WS-TABLA.
           05 WS-FILA OCCURS 10 TIMES.     *> Nivel 05
              10 WS-COL OCCURS 5 TIMES.    *> Nivel 10 anidado
                 15 WS-CELDA PIC 9(05).
       
      *> ❌ INCORRECTO
      *01  WS-MAL OCCURS 10 TIMES.         *> OCCURS no en 01
      *    05 WS-CAMPO PIC X(10).
```

---

## ✅ Checklist

- [ ] Declarar tabla con OCCURS n TIMES
- [ ] Declarar tabla con OCCURS DEPENDING ON
- [ ] Acceder a elementos por subíndice: `WS-TABLA(3)`
- [ ] Recorrer tabla con PERFORM VARYING
- [ ] Inicializar tabla completa con PERFORM VARYING
- [ ] Diferenciar OCCURS TIMES de OCCURS DEPENDING ON

## 📚 Recursos

- [GnuCOBOL OCCURS Clause](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#OCCURS)
- [IBM COBOL OCCURS Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-occurs-clause)
