# 3-proyecto — Semana 02: Ficha de Empleado

## 🎯 Objetivo

Diseñar un sistema de ficha de empleado que demuestre dominio de DATA DIVISION: PICTURE, USAGE, VALUE, niveles jerárquicos, 88-level y campos de edición.

## 📋 Requisitos

1. ✅ Diseñar registro jerárquico de empleado (01 → 05 → 10)
2. ✅ Usar PIC correcto para cada tipo de dato (nombre, salario, fecha, etc.)
3. ✅ Usar USAGE COMP para contadores, COMP-3 para salario
4. ✅ Inicializar con VALUE y constantes figurativas
5. ✅ Usar 88-level para estado del empleado, tipo de contrato y departamento
6. ✅ Crear campos de edición para mostrar salario y fecha formateados
7. ✅ Calcular salario anual, bono e ISR

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-02-data-division/3-proyecto/starter
cobc -x -free ficha-empleado.cbl && ./ficha-empleado
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| Jerarquía de datos (3+ niveles) | 20% |
| PIC correctos (tipos y tamaños) | 20% |
| USAGE (COMP o COMP-3) | 10% |
| 88-level (al menos 2) | 15% |
| Campos de edición formateados | 15% |
| Cálculos correctos | 10% |
| Código limpio y comentado | 10% |
