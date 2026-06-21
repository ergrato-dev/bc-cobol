# 3-proyecto — Semana 12: Procesamiento Batch Completo

## 🎯 Objetivo

Diseñar y simular un job batch bancario completo con 3 steps encadenados: validar transacciones → ordenar por cuenta → generar reporte de cierre diario. Usar COBOL para cada programa y JCL simulado para orquestación.

## 📋 Requisitos

1. ✅ **STEP 1 — VALIDAR**: Lee archivo de transacciones, valida tipos (D/R), montos > 0, genera `trans_validas.dat` y `trans_rechazadas.dat`
2. ✅ **STEP 2 — ORDENAR**: Ordena transacciones válidas por número de cuenta (usar SORT COBOL o `sort` de Linux)
3. ✅ **STEP 3 — REPORTE**: Lee transacciones ordenadas, acumula por cuenta y genera `cierre_diario.txt` con totales
4. ✅ Script `batch.sh` que orquesta los 3 steps simulando JCL
5. ✅ Control de RC entre steps: si STEP1 falla, no continuar

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-12-jcl-batch/3-proyecto/starter
bash batch.sh
cat cierre_diario.txt
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación de los 3 programas | Obligatorio |
| STEP 1: validación y separación | 25% |
| STEP 2: ordenamiento correcto | 15% |
| STEP 3: reporte con totales | 25% |
| batch.sh con control de RC | 15% |
| FILE STATUS en todos los archivos | 10% |
| Entrega de todos los archivos | 10% |
