# Cursores — Consultas Multi-Fila

## 🎯 Objetivos

- Declarar cursores para consultas con múltiples resultados
- Abrir, leer y cerrar cursores correctamente
- Procesar conjuntos de datos fila por fila
- Combinar cursores con PERFORM UNTIL

---

## 1. ¿Por Qué Cursores?

SELECT INTO solo funciona para **1 fila**. Cuando la consulta devuelve múltiples filas, necesitas un **cursor**:

```cobol
      *> ❌ Esto falla si hay más de 1 cliente
       EXEC SQL
           SELECT NOMBRE INTO :WS-NOMBRE FROM CLIENTES
       END-EXEC.
       
      *> ✅ Para múltiples filas: usar cursor
```

---

## 2. Ciclo de Vida de un Cursor

```
DECLARE CURSOR → OPEN → FETCH (loop) → CLOSE
```

| Paso | Sentencia | Descripción |
|------|-----------|-------------|
| 1 | `DECLARE CURSOR` | Define la consulta |
| 2 | `OPEN` | Ejecuta la consulta |
| 3 | `FETCH` | Lee una fila |
| 4 | Repetir FETCH hasta SQLCODE = 100 |
| 5 | `CLOSE` | Libera el cursor |

---

## 3. DECLARE CURSOR

```cobol
           EXEC SQL
               DECLARE CURSOR-CLIENTES CURSOR FOR
                   SELECT ID_CLIENTE, NOMBRE, APELLIDO, EMAIL
                   FROM CLIENTES
                   WHERE ESTADO = 'A'
                   ORDER BY APELLIDO, NOMBRE
           END-EXEC.
```

> 📝 DECLARE CURSOR debe ir en WORKING-STORAGE o antes del OPEN. No ejecuta la consulta, solo la define.

---

## 4. OPEN — Ejecutar el Cursor

```cobol
           EXEC SQL
               OPEN CURSOR-CLIENTES
           END-EXEC.
           
           IF WS-SQLCODE NOT = 0
               DISPLAY "Error al abrir cursor: " WS-SQLCODE
               STOP RUN
           END-IF.
```

---

## 5. FETCH — Leer Fila por Fila

```cobol
           PERFORM UNTIL WS-SQLCODE = 100         *> 100 = NO DATA FOUND
               EXEC SQL
                   FETCH CURSOR-CLIENTES
                   INTO :WS-CLI-ID, :WS-CLI-NOMBRE,
                        :WS-CLI-APELLIDO, :WS-CLI-EMAIL
               END-EXEC
               
               EVALUATE WS-SQLCODE
                   WHEN 0
                       DISPLAY WS-CLI-ID " " WS-CLI-NOMBRE
                           " " WS-CLI-APELLIDO
                   WHEN 100
                       DISPLAY "--- Fin de datos ---"
                   WHEN OTHER
                       DISPLAY "Error FETCH: " WS-SQLCODE
               END-EVALUATE
           END-PERFORM.
```

---

## 6. CLOSE — Liberar el Cursor

```cobol
           EXEC SQL
               CLOSE CURSOR-CLIENTES
           END-EXEC.
```

---

## 7. Programa Completo con Cursor

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LISTACLI.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CLI-ID        PIC S9(09) USAGE COMP.
       01  WS-CLI-NOMBRE    PIC X(50).
       01  WS-CLI-APELLIDO  PIC X(50).
       01  WS-SQLCODE       PIC S9(09) USAGE COMP.
       01  WS-CONT          PIC 9(05) VALUE ZEROS.
       
      *> Declaración del cursor
           EXEC SQL
               DECLARE C-CLIENTES CURSOR FOR
                   SELECT ID_CLIENTE, NOMBRE, APELLIDO
                   FROM CLIENTES
                   ORDER BY ID_CLIENTE
           END-EXEC.
       
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=== LISTADO DE CLIENTES ===".
           
           EXEC SQL OPEN C-CLIENTES END-EXEC.
           IF WS-SQLCODE = 0
               PERFORM UNTIL WS-SQLCODE = 100
                   EXEC SQL FETCH C-CLIENTES INTO
                       :WS-CLI-ID, :WS-CLI-NOMBRE,
                       :WS-CLI-APELLIDO END-EXEC
                   IF WS-SQLCODE = 0
                       ADD 1 TO WS-CONT
                       DISPLAY WS-CLI-ID " " WS-CLI-NOMBRE
                   END-IF
               END-PERFORM
               EXEC SQL CLOSE C-CLIENTES END-EXEC
           END-IF.
           
           DISPLAY "Total: " WS-CONT " clientes".
           STOP RUN.
```

---

## 8. Cursores con Parámetros

```cobol
           EXEC SQL
               DECLARE C-MOVIMIENTOS CURSOR FOR
                   SELECT TIPO, MONTO, FECHA
                   FROM TRANSACCIONES
                   WHERE ID_CUENTA = :WS-ID-CUENTA
                   ORDER BY FECHA DESC
           END-EXEC.
```

Al hacer OPEN, SQL usa el valor actual de `WS-ID-CUENTA`:

```cobol
           MOVE 101 TO WS-ID-CUENTA.
           EXEC SQL OPEN C-MOVIMIENTOS END-EXEC.
      *> El cursor muestra solo transacciones de la cuenta 101
```

---

## ✅ Checklist

- [ ] Declarar cursor con DECLARE CURSOR FOR SELECT
- [ ] Abrir con OPEN (ejecuta la consulta)
- [ ] Leer con FETCH en loop (PERFORM UNTIL SQLCODE = 100)
- [ ] Cerrar con CLOSE al terminar
- [ ] Usar parámetros en el WHERE para filtrar

## 📚 Recursos

- [IBM DB2 Cursors](https://www.ibm.com/docs/en/db2-for-zos/12?topic=applications-cursors)
- [PostgreSQL ECPG Cursors](https://www.postgresql.org/docs/16/ecpg.html)
