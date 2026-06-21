# 2-practicas — Semana 03: PROCEDURE DIVISION

Ejercicios guiados. Descomenta el código para aprender.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `calculadora.cbl` | MOVE, COMPUTE, operadores aritméticos |
| 2 | `clasificador-edad.cbl` | IF/ELSE, EVALUATE, condiciones |
| 3 | `loop-tablas.cbl` | PERFORM VARYING, UNTIL, TIMES |

## 🚀 Ejecutar (dentro del contenedor Docker)

```bash
docker compose exec cobol bash
cd bootcamp/week-03-procedure-division/2-practicas
cobc -x -free calculadora.cbl && ./calculadora
```
