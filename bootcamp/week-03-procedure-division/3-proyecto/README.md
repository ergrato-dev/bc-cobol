# 3-proyecto — Semana 03: Calculadora de Préstamo

## 🎯 Objetivo

Crear un programa COBOL que calcule y muestre el plan de pagos de un préstamo bancario usando los verbos de PROCEDURE DIVISION: MOVE, COMPUTE, EVALUATE, PERFORM VARYING.

## 📋 Requisitos

1. ✅ Solicitar: monto del préstamo, tasa anual (%), plazo en meses
2. ✅ Validar que los datos sean positivos
3. ✅ Calcular cuota mensual con fórmula de amortización francesa
4. ✅ Mostrar tabla de amortización: período, interés, capital, saldo
5. ✅ Calcular total pagado e intereses totales
6. ✅ Usar PERFORM VARYING para cada período
7. ✅ Usar EVALUATE para clasificar el préstamo (pequeño/mediano/grande)

## Fórmula

```
cuota = monto × (tasaMensual × (1 + tasaMensual)^plazo) / ((1 + tasaMensual)^plazo - 1)
tasaMensual = tasaAnual / 12 / 100
```

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-03-procedure-division/3-proyecto/starter
cobc -x -free calculadora-prestamo.cbl && ./calculadora-prestamo
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| Entrada y validación de datos | 15% |
| Fórmula de cuota correcta | 25% |
| PERFORM VARYING para tabla | 20% |
| Cálculos por período correctos | 15% |
| EVALUATE para clasificar | 10% |
| Formato de salida profesional | 10% |
| Código organizado en párrafos | 5% |
