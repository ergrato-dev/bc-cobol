# SQLCODE y SQLSTATE — Manejo de Errores SQL

## 🎯 Objetivos

- Interpretar SQLCODE después de cada operación
- Usar SQLSTATE para diagnóstico detallado
- Implementar manejo de errores robusto
- Diferenciar "no data" de errores reales

---

## 1. SQLCODE — Código de Retorno

SQLCODE es un número entero que indica el resultado de la última operación SQL:

```cobol
       01  WS-SQLCODE       PIC S9(09) USAGE COMP.
       
           EXEC SQL SELECT ... END-EXEC.
           
           EVALUATE WS-SQLCODE
               WHEN 0
                   DISPLAY "OK"
               WHEN 100
                   DISPLAY "No se encontraron datos"
               WHEN OTHER
                   DISPLAY "ERROR SQL: " WS-SQLCODE
           END-EVALUATE.
```

---

## 2. Valores de SQLCODE

| SQLCODE | Significado | Acción |
|---------|-------------|--------|
| 0 | Operación exitosa | Continuar |
| 100 | No se encontraron datos (NOT FOUND) | Normal en FETCH al terminar |
| > 0 | Warning (ej: dato truncado) | Revisar pero continuar |
| < 0 | Error | Abortar o ROLLBACK |

### Ejemplos

```cobol
      *> SELECT devuelve 100 si no hay registro
           EXEC SQL
               SELECT NOMBRE INTO :WS-NOMBRE
               FROM CLIENTES WHERE ID_CLIENTE = 99999
           END-EXEC.
           IF WS-SQLCODE = 100
               DISPLAY "Cliente no encontrado"
           END-IF.
       
      *> INSERT devuelve < 0 si hay error (ej: duplicado)
           EXEC SQL
               INSERT INTO CLIENTES (ID_CLIENTE, NOMBRE)
               VALUES (:WS-ID, :WS-NOMBRE)
           END-EXEC.
           IF WS-SQLCODE < 0
               DISPLAY "Error insertando: " WS-SQLCODE
           END-IF.
```

---

## 3. SQLSTATE — Código Estándar

SQLSTATE es un código alfanumérico de 5 caracteres, estándar ISO/ANSI:

```cobol
       01  WS-SQLSTATE      PIC X(05).
       
           EXEC SQL SELECT ... END-EXEC.
           
           EVALUATE WS-SQLSTATE
               WHEN "00000"
                   DISPLAY "OK"
               WHEN "02000"
                   DISPLAY "No data found"
               WHEN "23505"
                   DISPLAY "Duplicate key"
               WHEN OTHER
                   DISPLAY "SQLSTATE: " WS-SQLSTATE
           END-EVALUATE.
```

### SQLSTATE Comunes

| SQLSTATE | Significado |
|----------|-------------|
| `00000` | Éxito |
| `02000` | No data found |
| `23505` | Violación de clave única |
| `23503` | Violación de foreign key |
| `22001` | Dato truncado |
| `22012` | División por cero |
| `08001` | Error de conexión |

---

## 4. Manejo Robusto con 88-level

```cobol
       01  WS-SQLCODE       PIC S9(09) USAGE COMP.
           88 SQL-OK         VALUE 0.
           88 SQL-NOT-FOUND  VALUE 100.
           88 SQL-ERROR      VALUE -999 THRU -1.
           88 SQL-WARNING    VALUE 1 THRU 99.
       
           EXEC SQL SELECT ... END-EXEC.
           
           EVALUATE TRUE
               WHEN SQL-OK
                   CONTINUE
               WHEN SQL-NOT-FOUND
                   DISPLAY "Registro no existe"
               WHEN SQL-ERROR
                   DISPLAY "ERROR SQL: " WS-SQLCODE
                   EXEC SQL ROLLBACK END-EXEC
               WHEN SQL-WARNING
                   DISPLAY "WARNING SQL: " WS-SQLCODE
           END-EVALUATE.
```

---

## 5. Patrón de Verificación Post-Operación

```cobol
      *> Macro mental: después de cada EXEC SQL, verificar
       
           EXEC SQL
               UPDATE CUENTAS SET SALDO = SALDO - :WS-MONTO
               WHERE ID_CUENTA = :WS-CTA
           END-EXEC.
           
           IF SQL-ERROR
               DISPLAY "Error actualizando cuenta " WS-CTA
               EXEC SQL ROLLBACK END-EXEC
               PERFORM 9000-TERMINAR-ERROR
           END-IF.
```

---

## 6. SQLCA — SQL Communication Area

Estructura que contiene información detallada del diagnóstico:

```cobol
      *> Incluir el SQLCA
           EXEC SQL INCLUDE SQLCA END-EXEC.
       
      *> Acceso a campos del SQLCA
           DISPLAY "SQLCODE : " SQLCODE.
           DISPLAY "SQLSTATE: " SQLSTATE.
           DISPLAY "SQLERRMC: " SQLERRMC.  *> Mensaje de error
           DISPLAY "SQLERRD(3): " SQLERRD(3).  *> Filas afectadas
```

---

## ✅ Checklist

- [ ] Verificar SQLCODE después de cada EXEC SQL
- [ ] Usar 88-level para condiciones: SQL-OK, SQL-NOT-FOUND, SQL-ERROR
- [ ] Diferenciar "no data" (100) de error real (< 0)
- [ ] Hacer ROLLBACK ante error en transacción
- [ ] Usar SQLCA para diagnóstico detallado

## 📚 Recursos

- [IBM DB2 SQLCODE Reference](https://www.ibm.com/docs/en/db2-for-zos/12?topic=codes-sql)
- [PostgreSQL Error Codes](https://www.postgresql.org/docs/16/errcodes-appendix.html)
