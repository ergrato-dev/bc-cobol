# 3-proyecto — Semana 10: Consolidación Diaria de Sucursales

## 🎯 Objetivo

Crear un sistema batch que reciba transacciones de 3 sucursales, las ordene, las fusione por número de cuenta (MERGE), consolide montos y genere un archivo maestro actualizado.

## 📋 Requisitos

1. ✅ Leer 3 archivos de sucursales (ya ordenados por cuenta)
2. ✅ MERGE de los 3 archivos en uno solo ordenado
3. ✅ OUTPUT PROCEDURE: consolidar montos por cuenta (acumular débitos/créditos)
4. ✅ Generar archivo maestro consolidado `maestro_consolidado.dat`
5. ✅ Generar reporte de la consolidación `reporte_consolidacion.txt`
6. ✅ Mostrar totales: cuentas procesadas, monto total

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-10-sort-merge/3-proyecto/starter
cobc -x -free consolidacion-diaria.cbl && ./consolidacion-diaria
cat maestro_consolidado.dat
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| MERGE correcto de 3 sucursales | 20% |
| OUTPUT PROCEDURE con RETURN | 15% |
| Consolidación por cuenta | 20% |
| Archivo maestro generado | 15% |
| Reporte con totales | 15% |
| FILE STATUS en entradas y salidas | 10% |
| Código organizado en párrafos | 5% |
