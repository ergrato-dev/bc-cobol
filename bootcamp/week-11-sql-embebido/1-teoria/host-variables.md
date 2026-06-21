# Host Variables — Puente COBOL ↔ SQL

## 🎯 Objetivos

- Declarar variables COBOL para intercambio con SQL
- Mapear tipos de datos COBOL a tipos SQL
- Evitar errores comunes de tipo y tamaño
- Pasar múltiples valores en una sentencia

---

## 1. ¿Qué es una Host Variable?

Una host variable es una variable COBOL que se usa dentro de una sentencia SQL. SQL lee o escribe en ella.

```cobol
      *> WS-ID y WS-NOMBRE son host variables
       EXEC SQL
           SELECT NOMBRE INTO :WS-NOMBRE
           FROM CLIENTES WHERE ID_CLIENTE = :WS-ID
       END-EXEC.
```

---

## 2. Mapeo de Tipos COBOL ↔ SQL

| COBOL PIC | Tipo SQL recomendado | Notas |
|-----------|---------------------|-------|
| `PIC X(n)` | VARCHAR(n), CHAR(n) | Texto |
| `PIC 9(n)` | INTEGER, NUMERIC(n) | Entero sin signo |
| `PIC S9(n) COMP` | INTEGER | Entero con signo |
| `PIC S9(n)V99 COMP-3` | DECIMAL, NUMERIC | Monetario |
| `PIC 9(n)V99` | DECIMAL, NUMERIC | Decimal sin signo |
| `PIC X(10)` | DATE (como texto) | Fecha en formato texto |

---

## 3. Declaración de Host Variables

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
      *> Variables para tabla CLIENTES
       01  WS-CLI-ID        PIC S9(09) USAGE COMP.
       01  WS-CLI-NOMBRE    PIC X(50).
       01  WS-CLI-APELLIDO  PIC X(50).
       01  WS-CLI-EMAIL     PIC X(100).
       01  WS-CLI-ESTADO    PIC X(01).
       
      *> Variables para tabla CUENTAS
       01  WS-CTA-ID        PIC S9(09) USAGE COMP.
       01  WS-CTA-ID-CLI    PIC S9(09) USAGE COMP.
       01  WS-CTA-TIPO      PIC X(02).
       01  WS-CTA-SALDO     PIC S9(12)V99 USAGE COMP-3.
       01  WS-CTA-MONEDA    PIC X(03).
```

---

## 4. Uso en Sentencias SQL

### SELECT INTO (leer de la BD)

```cobol
      *> SQL escribe en las host variables
           MOVE 1 TO WS-CLI-ID.
           EXEC SQL
               SELECT NOMBRE, APELLIDO, EMAIL
               INTO :WS-CLI-NOMBRE, :WS-CLI-APELLIDO, :WS-CLI-EMAIL
               FROM CLIENTES
               WHERE ID_CLIENTE = :WS-CLI-ID
           END-EXEC.
```

### INSERT (enviar a la BD)

```cobol
      *> SQL lee de las host variables
           MOVE "Nuevo" TO WS-CLI-NOMBRE.
           MOVE "Cliente" TO WS-CLI-APELLIDO.
           MOVE "nuevo@email.com" TO WS-CLI-EMAIL.
       
           EXEC SQL
               INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL)
               VALUES (:WS-CLI-NOMBRE, :WS-CLI-APELLIDO, :WS-CLI-EMAIL)
           END-EXEC.
```

### UPDATE

```cobol
           EXEC SQL
               UPDATE CUENTAS
               SET SALDO = SALDO + :WS-MONTO
               WHERE ID_CUENTA = :WS-CTA-ID
           END-EXEC.
```

---

## 5. INDICATOR Variables (Valores NULL)

SQL tiene NULL. COBOL no. Para manejar NULLs se usan variables indicadoras:

```cobol
       01  WS-CLI-EMAIL     PIC X(100).
       01  WS-CLI-EMAIL-NULL PIC S9(04) USAGE COMP.  *> Indicador
       
           EXEC SQL
               SELECT EMAIL INTO :WS-CLI-EMAIL :WS-CLI-EMAIL-NULL
               FROM CLIENTES WHERE ID_CLIENTE = :WS-CLI-ID
           END-EXEC.
       
           IF WS-CLI-EMAIL-NULL = -1
               DISPLAY "Email es NULL"
           END-IF.
```

| Valor Indicador | Significado |
|----------------|-------------|
| 0 | Valor no NULL |
| -1 | Valor NULL |
| > 0 | Valor truncado (longitud original) |

---

## 6. Errores Comunes

### Tipo incompatible

```cobol
      *> ❌ PIC X(30) en COBOL, INTEGER en SQL
       01  WS-NOMBRE    PIC X(30).
       EXEC SQL
           SELECT ID_CLIENTE INTO :WS-NOMBRE ...   *> ERROR
       END-EXEC.
```

### Tamaño insuficiente

```cobol
      *> ❌ VARCHAR(50) en BD, PIC X(20) en COBOL
       01  WS-NOMBRE    PIC X(20).
       EXEC SQL
           SELECT NOMBRE INTO :WS-NOMBRE ...  *> Truncado
       END-EXEC.
```

---

## ✅ Checklist

- [ ] Declarar host variables con PIC compatible al tipo SQL
- [ ] Usar `:variable` para referenciar en SQL
- [ ] Mapear INTEGER a `PIC S9(09) COMP`
- [ ] Mapear DECIMAL a `PIC S9(n)V99 COMP-3`
- [ ] Usar variables indicadoras para NULL

## 📚 Recursos

- [IBM DB2 Host Variables](https://www.ibm.com/docs/en/db2-for-zos/12?topic=applications-host-variables)
- [PostgreSQL Embedded SQL](https://www.postgresql.org/docs/16/ecpg.html)
