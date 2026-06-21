# 3-proyecto — Semana 09: Estado de Cuenta Bancario

## 🎯 Objetivo

Crear un programa que lea un archivo de movimientos, los agrupe por cuenta, calcule saldos y genere un estado de cuenta profesional con encabezado, detalle por tipo (cargos/abonos) y resumen final.

## 📋 Requisitos

1. ✅ Leer `movimientos.dat` (cuenta, tipo, monto, descripción, fecha)
2. ✅ Control de ruptura por número de cuenta
3. ✅ Subtotales: total cargos, total abonos por cuenta
4. ✅ Saldo inicial simulado ($10,000 para todas las cuentas)
5. ✅ Reporte con encabezado por cuenta, detalle, y pie
6. ✅ Formateo profesional: moneda, fechas, alineación
7. ✅ Archivo de salida: `estado_cuenta.txt`

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-09-reportes-batch/3-proyecto/starter
cobc -x -free estado-cuenta.cbl && ./estado-cuenta
cat estado_cuenta.txt
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Control de ruptura por cuenta | 20% |
| Subtotales cargos/abonos correctos | 20% |
| Cálculo de saldo final | 15% |
| Formato profesional (moneda, fechas) | 15% |
| Encabezado/detalle/pie por cuenta | 15% |
| Archivo de salida generado | 10% |
| FILE STATUS y párrafos organizados | 5% |
