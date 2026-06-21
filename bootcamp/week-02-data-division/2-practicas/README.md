# 2-practicas — Semana 02: DATA DIVISION

Ejercicios guiados paso a paso. Descomenta el código para aprender.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `layout-cliente.cbl` | PICTURE: tipos de datos, edición, moneda |
| 2 | `jerarquia-factura.cbl` | Niveles 01-49, grupos, elementales |
| 3 | `inicializacion.cbl` | VALUE, ZEROS, SPACES, 88-level, INITIALIZE |

## 🚀 Ejecutar (dentro del contenedor Docker)

```bash
docker compose exec cobol bash
cd bootcamp/week-02-data-division/2-practicas
cobc -x -free layout-cliente.cbl && ./layout-cliente
```
