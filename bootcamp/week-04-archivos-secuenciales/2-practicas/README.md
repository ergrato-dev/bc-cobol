# 2-practicas — Semana 04: Archivos Secuenciales

Ejercicios guiados con archivos de datos incluidos.

## 📋 Ejercicios

| # | Archivo | Datos | Concepto |
|---|---------|-------|----------|
| 1 | `leer-archivo.cbl` | `clientes.dat` | READ, AT END, FILE STATUS |
| 2 | `copiar-archivo.cbl` | `clientes.dat` | OPEN, READ, WRITE, CLOSE, contador |
| 3 | `filtrar-datos.cbl` | `clientes.dat` | Filtrar, transformar, acumular |

## 🗂️ Archivos de Datos

El archivo `clientes.dat` se crea automáticamente al compilar. Contiene:

```
00001Juan Perez              00001500000
00002Maria Garcia             00002500000
00003Carlos Lopez             00001000075
00004Ana Martinez             00005000000
00005Pedro Rodriguez          00000350025
```

Formato: `ID(5) NOMBRE(25) SALDO(9)V99`

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-04-archivos-secuenciales/2-practicas
cobc -x -free leer-archivo.cbl && ./leer-archivo
```
