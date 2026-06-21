# Semana 11: SQL Embebido en COBOL

## 🎯 Objetivos

Al finalizar esta semana, el estudiante será capaz de:

- Integrar sentencias SQL dentro de programas COBOL con EXEC SQL
- Declarar host variables para intercambio de datos
- Implementar cursores para consultas multi-fila
- Manejar transacciones con COMMIT y ROLLBACK
- Verificar SQLCODE y SQLSTATE para control de errores
- Conectar COBOL con PostgreSQL usando SQL embebido

## 📚 Contenido

### 1-teoria/

- **introduccion-sql-embebido.md**: Conceptos, precompilador, EXEC SQL...END-EXEC
- **host-variables.md**: Declaración, correspondencia COBOL-SQL, :variable
- **cursores.md**: DECLARE CURSOR, OPEN, FETCH, CLOSE
- **transacciones.md**: COMMIT, ROLLBACK, integridad ACID
- **sqlcode-sqlstate.md**: Códigos de error, manejo de excepciones SQL

### 2-practicas/

- **consulta-simple.cbl**: SELECT con host variables
- **insercion-parametrizada.cbl**: INSERT con parámetros desde COBOL
- **cursor-clientes.cbl**: FETCH en loop con cursor

### 3-proyecto/

- **starter/sistema-clientes-db.cbl**: CRUD completo de clientes bancarios usando PostgreSQL con SQL embebido

## ⏱️ Distribución (10h)

- Teoría: 3h | Prácticas: 4h | Proyecto: 3h

## 📌 Entregables

- [ ] Consulta SQL simple desde COBOL
- [ ] Inserción parametrizada con host variables
- [ ] Proyecto CRUD con PostgreSQL completado

## 🔗 Navegación

← [Semana 10](../week-10-sort-merge/README.md) | [Semana 12 →](../week-12-jcl-batch/README.md)
