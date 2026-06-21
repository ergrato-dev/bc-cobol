# 2-practicas — Semana 09: Reportes Profesionales

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `reporte-simple.cbl` | WRITE ADVANCING, encabezado, detalle, pie, paginación |
| 2 | `reporte-agrupado.cbl` | Control de ruptura, subtotales por departamento |
| 3 | `reporte-formateado.cbl` | Edición moneda, fechas, supresión de ceros |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-09-reportes-batch/2-practicas
cobc -x -free reporte-simple.cbl && ./reporte-simple
cat cuentas_reporte.txt
```
