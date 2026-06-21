# 3-proyecto — Semana 11: Sistema de Clientes con SQL

## 🎯 Objetivo

Crear un sistema CRUD completo para CLIENTES usando SQL embebido con PostgreSQL: consultar, listar con cursor, insertar, modificar estado y eliminar con control de transacciones.

## 📋 Requisitos

1. ✅ Menú con 5 opciones: Consultar, Listar, Insertar, Modificar estado, Eliminar
2. ✅ Consultar por ID: SELECT INTO con host variables
3. ✅ Listar todos: DECLARE CURSOR, OPEN, FETCH, CLOSE
4. ✅ Insertar nuevo: INSERT con parámetros, validar duplicados
5. ✅ Modificar estado (A/I): UPDATE con verificación SQLCODE
6. ✅ Eliminar: DELETE con confirmación
7. ✅ SQLCODE en cada operación, ROLLBACK en errores

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-11-sql-embebido/3-proyecto/starter
cobc -x -free sistema-clientes-db.cbl && ./sistema-clientes-db
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| SELECT INTO para consulta | 15% |
| CURSOR para listar | 20% |
| INSERT parametrizado | 15% |
| UPDATE con verificación | 15% |
| DELETE con precaución | 10% |
| SQLCODE en cada operación | 15% |
| Código organizado en párrafos | 10% |
