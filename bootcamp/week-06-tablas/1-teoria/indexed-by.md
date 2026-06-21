# INDEXED BY — Índices de Tabla

## 🎯 Objetivos

- Declarar índices con INDEXED BY
- Manipular índices con SET, no con MOVE
- Diferenciar índices de subíndices
- Usar USAGE IS INDEX para índices externos

---

## 1. ¿Qué es INDEXED BY?

INDEXED BY asocia un **índice interno** a una tabla OCCURS. El índice es una variable especial que el compilador optimiza para acceso rápido.

```cobol
       01  WS-CLIENTES.
           05 WS-CLI OCCURS 100 TIMES
               INDEXED BY CLI-IDX.
              10 WS-CLI-ID     PIC 9(05).
              10 WS-CLI-NOMBRE PIC X(30).
```

---

## 2. SET para Manipular Índices

Los índices no se manipulan con MOVE. Se usa SET:

```cobol
      *> Asignar valor al índice
           SET CLI-IDX TO 1.               *> Posición 1
           SET CLI-IDX TO 50.              *> Posición 50
       
      *> Incrementar / decrementar
           SET CLI-IDX UP BY 1.            *> CLI-IDX = CLI-IDX + 1
           SET CLI-IDX DOWN BY 1.          *> CLI-IDX = CLI-IDX - 1
       
      *> Guardar índice en variable entera
           SET WS-I TO CLI-IDX.            *> WS-I = posición actual
       
      *> Restaurar índice desde variable
           SET CLI-IDX TO WS-I.            *> CLI-IDX = WS-I
```

---

## 3. Recorrer con Índice

```cobol
           SET CLI-IDX TO 1.
           PERFORM VARYING CLI-IDX FROM 1 BY 1
                   UNTIL CLI-IDX > 100
               DISPLAY WS-CLI-NOMBRE(CLI-IDX)
           END-PERFORM.
```

> 📝 Con `PERFORM VARYING`, puedes usar el índice directamente como variable de control.

---

## 4. Subíndice vs Índice — Comparativa

```cobol
      *> Con SUBÍNDICE (variable PIC 9)
       01  WS-SUB       PIC 9(03) USAGE COMP.
           PERFORM VARYING WS-SUB FROM 1 BY 1
                   UNTIL WS-SUB > 100
               ADD WS-SALDO(WS-SUB) TO WS-TOTAL
           END-PERFORM.
       
      *> Con ÍNDICE (INDEXED BY)
       01  WS-TABLA.
           05 WS-SALDO PIC S9(07)V99 OCCURS 100
               INDEXED BY SALDO-IDX.
           PERFORM VARYING SALDO-IDX FROM 1 BY 1
                   UNTIL SALDO-IDX > 100
               ADD WS-SALDO(SALDO-IDX) TO WS-TOTAL
           END-PERFORM.
```

| Característica | Subíndice (PIC 9) | Índice (INDEXED BY) |
|---------------|-------------------|---------------------|
| Declaración | `WS-I PIC 9(03) COMP` | `INDEXED BY nombre` |
| Asignación | `MOVE 5 TO WS-I` | `SET nombre TO 5` |
| Memoria | Ocupa variable WORKING-STORAGE | Interno del compilador |
| Velocidad | Normal | Más rápido |
| Uso con SEARCH | No obligatorio | Obligatorio |
| Uso con SEARCH ALL | No obligatorio | Obligatorio |

---

## 5. Índices para SEARCH y SEARCH ALL

SEARCH y SEARCH ALL requieren INDEXED BY:

```cobol
       01  WS-TASAS.
           05 WS-TASA OCCURS 10 TIMES
               ASCENDING KEY IS WS-PLAZO
               INDEXED BY TASA-IDX.
              10 WS-PLAZO  PIC 9(03).
              10 WS-VALOR  PIC 9V99.
       
           SET TASA-IDX TO 1.
           SEARCH WS-TASA
               AT END DISPLAY "No encontrado"
               WHEN WS-PLAZO(TASA-IDX) = WS-BUSCADO
                   DISPLAY "Tasa: " WS-VALOR(TASA-IDX)
           END-SEARCH.
```

---

## 6. USAGE IS INDEX

Para declarar un índice como variable independiente (compartir entre tablas):

```cobol
       01  WS-IDX-GLOBAL   USAGE IS INDEX.
       
           SET WS-IDX-GLOBAL TO CLI-IDX.      *> Guardar
           SET PROD-IDX TO WS-IDX-GLOBAL.      *> Restaurar
```

---

## ✅ Checklist

- [ ] Declarar tabla con INDEXED BY
- [ ] Usar SET para asignar/incrementar índice
- [ ] Usar índice en PERFORM VARYING
- [ ] Guardar índice en variable con `SET var TO idx`
- [ ] Conocer que SEARCH y SEARCH ALL requieren INDEXED BY

## 📚 Recursos

- [IBM COBOL INDEXED BY Clause](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=data-indexed-by-phrase)
- [GnuCOBOL INDEXED BY](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#INDEXED)
