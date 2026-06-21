# Transacciones SQL — COMMIT y ROLLBACK

## 🎯 Objetivos

- Comprender el concepto de transacción ACID
- Confirmar cambios con COMMIT
- Deshacer cambios con ROLLBACK
- Agrupar múltiples operaciones en una transacción

---

## 1. ¿Qué es una Transacción?

Una **transacción** es un conjunto de operaciones SQL que se ejecutan como una unidad atómica: o todas se completan exitosamente, o ninguna se aplica.

### Propiedades ACID

| Propiedad | Significado |
|-----------|-------------|
| **A**tomicity | Todo o nada: si una operación falla, se deshace todo |
| **C**onsistency | La BD pasa de un estado válido a otro |
| **I**solation | Transacciones concurrentes no se interfieren |
| **D**urability | Una vez confirmado, el cambio es permanente |

---

## 2. COMMIT — Confirmar Cambios

```cobol
      *> Operaciones bancarias
       EXEC SQL
           UPDATE CUENTAS SET SALDO = SALDO - :WS-MONTO
           WHERE ID_CUENTA = :WS-CTA-ORIGEN
       END-EXEC.
       
       EXEC SQL
           UPDATE CUENTAS SET SALDO = SALDO + :WS-MONTO
           WHERE ID_CUENTA = :WS-CTA-DESTINO
       END-EXEC.
       
      *> Confirmar ambas operaciones juntas
       IF WS-SQLCODE = 0
           EXEC SQL COMMIT END-EXEC
           DISPLAY "Transferencia exitosa"
       END-IF.
```

---

## 3. ROLLBACK — Deshacer Cambios

```cobol
       EXEC SQL
           UPDATE CUENTAS SET SALDO = SALDO - :WS-MONTO
           WHERE ID_CUENTA = :WS-CTA-ORIGEN
       END-EXEC.
       
       IF WS-SQLCODE = 0
           EXEC SQL
               UPDATE CUENTAS SET SALDO = SALDO + :WS-MONTO
               WHERE ID_CUENTA = :WS-CTA-DESTINO
           END-EXEC
       END-IF.
       
      *> Si la segunda actualización falló, deshacer todo
       IF WS-SQLCODE NOT = 0
           EXEC SQL ROLLBACK END-EXEC
           DISPLAY "ERROR: Transferencia cancelada"
       ELSE
           EXEC SQL COMMIT END-EXEC
           DISPLAY "Transferencia completada"
       END-IF.
```

---

## 4. Transacción Bancaria Completa

```cobol
      *> Transferencia: débito origen + crédito destino
           EXEC SQL
               SELECT SALDO INTO :WS-SALDO-ORIGEN
               FROM CUENTAS WHERE ID_CUENTA = :WS-CTA-ORIGEN
           END-EXEC.
           
           IF WS-SALDO-ORIGEN >= WS-MONTO
               EXEC SQL
                   UPDATE CUENTAS SET SALDO = SALDO - :WS-MONTO
                   WHERE ID_CUENTA = :WS-CTA-ORIGEN
               END-EXEC.
               
               EXEC SQL
                   UPDATE CUENTAS SET SALDO = SALDO + :WS-MONTO
                   WHERE ID_CUENTA = :WS-CTA-DESTINO
               END-EXEC.
               
               EXEC SQL
                   INSERT INTO TRANSACCIONES
                       (ID_CUENTA, TIPO, MONTO, DESCRIPCION)
                   VALUES (:WS-CTA-ORIGEN, 'T', :WS-MONTO, 'Transferencia')
               END-EXEC.
               
               IF WS-SQLCODE = 0
                   EXEC SQL COMMIT END-EXEC
               ELSE
                   EXEC SQL ROLLBACK END-EXEC
                   DISPLAY "Error en transferencia"
               END-IF
           END-IF.
```

---

## 5. Autocommit vs Manual

Por defecto, muchas conexiones trabajan en modo **autocommit** (cada sentencia se confirma automáticamente). Para transacciones multi-sentencia, debes desactivarlo:

```cobol
      *> Desactivar autocommit
       EXEC SQL SET AUTOCOMMIT TO OFF END-EXEC.
       
      *> ... operaciones ...
       
      *> Confirmar manualmente
       EXEC SQL COMMIT END-EXEC.
```

---

## 6. SAVEPOINT (Puntos de Guardado)

Permite deshacer parcialmente dentro de una transacción:

```cobol
       EXEC SQL SAVEPOINT INICIO END-EXEC.
       
      *> Operación 1
       EXEC SQL INSERT INTO ... END-EXEC.
       
       IF WS-SQLCODE NOT = 0
           EXEC SQL ROLLBACK TO SAVEPOINT INICIO END-EXEC
           DISPLAY "Operación revertida"
       END-IF.
       
      *> Operación 2 (continúa aunque la 1 haya fallado)
       EXEC SQL UPDATE ... END-EXEC.
       
       EXEC SQL COMMIT END-EXEC.
```

---

## ✅ Checklist

- [ ] Confirmar cambios con COMMIT
- [ ] Deshacer con ROLLBACK en caso de error
- [ ] Agrupar operaciones relacionadas en una transacción
- [ ] Verificar SQLCODE antes de COMMIT
- [ ] Usar SAVEPOINT para deshacer parcialmente

## 📚 Recursos

- [PostgreSQL Transactions](https://www.postgresql.org/docs/16/tutorial-transactions.html)
- [IBM DB2 COMMIT/ROLLBACK](https://www.ibm.com/docs/en/db2-for-zos/12?topic=statements-commit)
