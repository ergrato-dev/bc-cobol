# 2-practicas — Semana 10: SORT y MERGE

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `ordenar-clientes.cbl` | SORT USING/GIVING, ASCENDING/DESCENDING |
| 2 | `ordenar-con-filtro.cbl` | INPUT PROCEDURE, RELEASE, OUTPUT PROCEDURE |
| 3 | `fusion-archivos.cbl` | MERGE de 2 sucursales, RETURN |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-10-sort-merge/2-practicas
cobc -x -free ordenar-clientes.cbl && ./ordenar-clientes
cobc -x -free ordenar-con-filtro.cbl && ./ordenar-con-filtro
cobc -x -free fusion-archivos.cbl && ./fusion-archivos
```
