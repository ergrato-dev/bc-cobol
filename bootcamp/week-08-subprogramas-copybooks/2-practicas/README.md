# 2-practicas — Semana 08: Subprogramas y COPYBOOKS

Ejercicios guiados con CALL, LINKAGE SECTION y COPY.

## 📋 Ejercicios

| # | Archivos | Concepto |
|---|----------|----------|
| 1 | `calculadora-modular.cbl` + `sumar.cbl` + `restar.cbl` | CALL, LINKAGE, USING |
| 2 | `copybooks/validaciones.cpy` + `usar-validaciones.cbl` | COPY, COPYBOOK de validación |
| 3 | `fecha-util.cbl` | Subprograma de utilidad de fechas |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-08-subprogramas-copybooks/2-practicas

# Ejercicio 1: compilar múltiples archivos juntos
cobc -x -free calculadora-modular.cbl sumar.cbl restar.cbl -o calculadora
./calculadora

# Ejercicio 2: compilar con copybook
cobc -x -free usar-validaciones.cbl -o validador
./validador

# Ejercicio 3: compilar con subprograma
cobc -x -free fecha-util.cbl fecha-test.cbl -o fecha-test
./fecha-test
```
