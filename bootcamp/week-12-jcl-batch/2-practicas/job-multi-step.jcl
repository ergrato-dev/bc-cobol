#!/bin/bash
# ============================================
# JOB: MULTISTEP  -  Procesamiento Batch Completo
# ============================================
# Simula 3 steps: validar → ordenar → reporte
# con control de flujo: si validar falla, no procesar.
#
# JCL REAL equivalente:
# //MULTI    JOB (BANCO),'PROCESO DIARIO',CLASS=A
# //VALIDAR  EXEC PGM=VALIDAR
# //ORDENAR  EXEC PGM=SORT,COND=(0,NE,VALIDAR)
# //REPORTE  EXEC PGM=GENERAR,COND=EVEN
# //
set -e

rc=0
echo "========================================"
echo " JOB: MULTISTEP - Procesamiento Batch"
echo "========================================"
echo ""

# === STEP 1: VALIDAR (PGM=VALIDAR) ===
echo "--- STEP 1: VALIDAR DATOS ---"
echo "Verificando archivo de transacciones..."

# Simular validación (siempre OK en este ejercicio)
echo "  Transacciones: 5 encontradas"
echo "  Errores       : 0"
echo "  Válidas       : 5"
rc=0
echo "STEP 1 completado. RC=$rc"
echo ""

# === Control de flujo: IF VALIDAR RC = 0 ===
if [ $rc -eq 0 ]; then
    # === STEP 2: ORDENAR (PGM=SORT) ===
    echo "--- STEP 2: ORDENAR TRANSACCIONES ---"
    echo "Ordenando por número de cuenta..."
    echo "  Entrada : 5 registros"
    echo "  Salida  : 5 registros ordenados"
    echo "STEP 2 completado. RC=0"
    echo ""
else
    echo "--- STEP 2: OMITIDO (VALIDAR falló) ---"
    echo ""
fi

# === STEP 3: REPORTE (COND=EVEN: siempre se ejecuta) ===
echo "--- STEP 3: GENERAR REPORTE ---"
echo "Generando reporte de cierre..."
echo "  Cuentas procesadas: 5"
echo "  Total débitos     : $ 12,500.00"
echo "  Total créditos    : $ 45,000.00"
echo "STEP 3 completado. RC=0"
echo ""

echo "========================================"
echo " JOB MULTISTEP terminado. MAXCC=0"
echo "========================================"
