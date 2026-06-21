# 3-proyecto — Semana 04: Reporte de Cuentas

## 🎯 Objetivo

Crear un programa que lea un archivo de cuentas bancarias, filtre las cuentas activas, calcule intereses y genere un reporte formateado con encabezado, detalle y totales.

## 📋 Requisitos

1. ✅ Leer archivo `cuentas.dat` (ID, nombre, tipo, saldo, estado)
2. ✅ Filtrar solo cuentas activas (estado "A")
3. ✅ Aplicar tasa de interés según tipo de cuenta:
   - CC (Cuenta Corriente): 0.5%
   - CA (Caja de Ahorro): 3.0%
   - PF (Plazo Fijo): 8.0%
4. ✅ Calcular nuevo saldo proyectado
5. ✅ Generar reporte con encabezado, detalle y totales
6. ✅ Usar FILE STATUS, 88-level para estados válidos
7. ✅ Organizar en párrafos: ABRIR-ARCHIVOS, PROCESAR, GENERAR-REPORTE, CERRAR

## 🗂️ Archivos

```
starter/
├── cuentas.dat          # Datos de entrada (ya creado)
├── cuentas_reporte.txt  # Reporte generado por el programa
└── reporte-cuentas.cbl  # Código con TODOs
```

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-04-archivos-secuenciales/3-proyecto/starter
cobc -x -free reporte-cuentas.cbl && ./reporte-cuentas
cat cuentas_reporte.txt
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| FILE STATUS en todos los archivos | 10% |
| Filtro por estado "A" | 15% |
| EVALUATE para tasa por tipo cuenta | 15% |
| Cálculo correcto de interés | 15% |
| Reporte con encabezado/detalle/totales | 20% |
| Organización en párrafos | 15% |
| Archivo de salida generado correcto | 10% |
