# 2-practicas — Semana 06: Tablas y Arrays

Ejercicios guiados con tablas OCCURS, SEARCH y SEARCH ALL.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `tabla-tasas.cbl` | OCCURS, PERFORM VARYING, carga de datos |
| 2 | `busqueda-cliente.cbl` | SEARCH (secuencial), SEARCH ALL (binaria) |
| 3 | `matriz-tarifas.cbl` | Tabla 2D, OCCURS anidado, cálculo |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-06-tablas/2-practicas
cobc -x -free tabla-tasas.cbl && ./tabla-tasas
```
