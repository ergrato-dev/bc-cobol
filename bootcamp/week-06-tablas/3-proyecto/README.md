# 3-proyecto — Semana 06: Tabla de Amortización

## 🎯 Objetivo

Crear un programa que calcule y almacene una tabla de amortización de préstamo usando OCCURS, la muestre formateada y permita consultas sobre cualquier cuota.

## 📋 Requisitos

1. ✅ Tabla OCCURS para almacenar hasta 360 cuotas (30 años)
2. ✅ Usar OCCURS DEPENDING ON para tamaño variable según plazo
3. ✅ PERFORM VARYING para calcular cada cuota y llenar la tabla
4. ✅ Mostrar tabla completa formateada (cuota, interés, capital, saldo)
5. ✅ Buscar cuota específica por número con SEARCH ALL
6. ✅ Calcular totales: total pagado, total intereses
7. ✅ Mostrar resumen del préstamo

## Fórmula (Amortización Francesa)

```
cuota = monto × (t × (1+t)^n) / ((1+t)^n - 1)
t = tasa anual / 12 / 100
Interés = saldo × t
Capital = cuota - interés
Nuevo saldo = saldo - capital
```

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-06-tablas/3-proyecto/starter
cobc -x -free tabla-amortizacion.cbl && ./tabla-amortizacion
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| OCCURS DEPENDING ON correcto | 15% |
| PERFORM VARYING para llenar tabla | 20% |
| Cálculos financieros correctos | 20% |
| Tabla formateada (campos de edición) | 15% |
| SEARCH ALL para consulta por número cuota | 15% |
| Totales y resumen | 10% |
| Organización en párrafos | 5% |
