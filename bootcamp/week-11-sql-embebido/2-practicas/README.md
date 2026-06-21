# 2-practicas — Semana 11: SQL Embebido en COBOL

Ejercicios guiados con PostgreSQL. La BD está en el servicio `db` del docker-compose.

## 📋 Prerrequisito

Las tablas ya existen en PostgreSQL (creadas por `docker/db/init.sql`):

```bash
docker compose exec cobol psql -h db -U cobol -d bootcamp -c "\dt"
# clientes, cuentas, transacciones
```

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `consulta-simple.cbl` | SELECT INTO, host variables, SQLCODE |
| 2 | `insercion-parametrizada.cbl` | INSERT parametrizado, validación |
| 3 | `cursor-clientes.cbl` | DECLARE CURSOR, OPEN, FETCH, CLOSE |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-11-sql-embebido/2-practicas
# Compilar y ejecutar (usando scripts simulados que documentan la interacción)
cobc -x -free consulta-simple.cbl && ./consulta-simple
```
