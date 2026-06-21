# SQL Embebido en COBOL — Introducción

## 🎯 Objetivos

- Comprender el concepto de SQL embebido
- Escribir sentencias SQL dentro de programas COBOL
- Conectar COBOL con PostgreSQL
- Usar EXEC SQL ... END-EXEC

---

## 1. ¿Qué es SQL Embebido?

SQL embebido permite escribir sentencias SQL directamente dentro del código COBOL. El precompilador traduce las sentencias SQL a llamadas nativas y genera el programa final.

```cobol
       PROCEDURE DIVISION.
           EXEC SQL
               SELECT NOMBRE, SALDO
               INTO :WS-NOMBRE, :WS-SALDO
               FROM CLIENTES
               WHERE ID_CLIENTE = :WS-ID
           END-EXEC.
```

---

## 2. Arquitectura

```
programa.sqb ──→ [Precompilador SQL] ──→ programa.cbl ──→ [cobc] ──→ programa
                       ↓
                  SQL puro + llamadas a libpq
```

| Componente | Descripción |
|-----------|-------------|
| `programa.sqb` | Código COBOL con sentencias SQL (extensión .sqb) |
| Precompilador | Traduce EXEC SQL a llamadas C/nativas |
| `programa.cbl` | Código COBOL puro resultante |
| `cobc` | Compilador GnuCOBOL estándar |

---

## 3. Configuración en el Bootcamp

Nuestro `docker-compose.yml` ya incluye PostgreSQL:

```yaml
db:
  image: postgres:16-alpine
  environment:
    POSTGRES_USER: cobol
    POSTGRES_PASSWORD: cobol
    POSTGRES_DB: bootcamp
```

Desde el contenedor COBOL:

```bash
# Verificar conexión
docker compose exec cobol psql -h db -U cobol -d bootcamp -c "\dt"

# Lista de tablas:
#  clientes
#  cuentas
#  transacciones
```

---

## 4. Sintaxis EXEC SQL

```cobol
       EXEC SQL
           sentencia-sql
       END-EXEC.
```

### Reglas

1. Cada sentencia SQL debe estar entre `EXEC SQL` y `END-EXEC`
2. Las variables COBOL se referencian con `:` (dos puntos): `:WS-NOMBRE`
3. Los literales SQL van sin `:`
4. El punto final va después de `END-EXEC`

```cobol
      *> ✅ Correcto
       EXEC SQL
           SELECT COUNT(*) INTO :WS-CONT FROM CLIENTES
       END-EXEC.
       
      *> ❌ Incorrecto
      *EXEC SQL SELECT * FROM CLIENTES END-EXEC.   *> Falta INTO
```

---

## 5. Tipos de Sentencias SQL Soportadas

| Categoría | Sentencias | Uso |
|-----------|-----------|-----|
| Consulta simple | SELECT ... INTO | 1 fila, 1 resultado |
| Consulta multi-fila | DECLARE CURSOR, OPEN, FETCH | N filas |
| Modificación | INSERT, UPDATE, DELETE | Cambiar datos |
| Transacción | COMMIT, ROLLBACK | Control de cambios |
| Estructura | CONNECT, DISCONNECT | Conexión |

```cobol
      *> SELECT: 1 registro
       EXEC SQL
           SELECT NOMBRE INTO :WS-NOMBRE
           FROM CLIENTES WHERE ID_CLIENTE = 1
       END-EXEC.
       
      *> INSERT
       EXEC SQL
           INSERT INTO CLIENTES (NOMBRE, APELLIDO)
           VALUES (:WS-NOMBRE, :WS-APELLIDO)
       END-EXEC.
       
      *> UPDATE
       EXEC SQL
           UPDATE CUENTAS
           SET SALDO = SALDO + :WS-MONTO
           WHERE ID_CUENTA = :WS-CUENTA
       END-EXEC.
       
      *> DELETE
       EXEC SQL
           DELETE FROM CLIENTES
           WHERE ID_CLIENTE = :WS-ID
       END-EXEC.
```

---

## 6. Declaración de Host Variables

Las variables COBOL que interactúan con SQL se declaran en WORKING-STORAGE normalmente, pero deben estar en una sección especial para el precompilador:

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
           EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  WS-ID-CLIENTE   PIC 9(05).
       01  WS-NOMBRE       PIC X(50).
       01  WS-SALDO        PIC S9(09)V99 USAGE COMP-3.
       01  WS-SQLCODE       PIC S9(09) USAGE COMP.
           EXEC SQL END DECLARE SECTION END-EXEC.
```

> 📝 En GnuCOBOL con esqlOC, las variables se declaran normalmente en WORKING-STORAGE sin sección especial.

---

## 7. Compilación con SQL Embebido

```bash
# Con esqlOC (procesador SQL para GnuCOBOL)
esqlOC -static -o programa programa.sqb
cobc -x -free programa.cbl -o programa -L/usr/lib -lpq

# O en un solo paso (si esqlOC está integrado)
cobc -x -free programa.sqb -o programa
```

---

## ✅ Checklist

- [ ] Conectar al PostgreSQL del bootcamp (`psql -h db -U cobol`)
- [ ] Escribir EXEC SQL ... END-EXEC con SELECT INTO
- [ ] Usar host variables con prefijo `:`
- [ ] Verificar SQLCODE después de cada operación

## 📚 Recursos

- [GnuCOBOL esqlOC Documentation](https://gnucobol.sourceforge.io/)
- [IBM DB2 COBOL Programming Guide](https://www.ibm.com/docs/en/db2-for-zos)
- [PostgreSQL libpq Documentation](https://www.postgresql.org/docs/16/libpq.html)
