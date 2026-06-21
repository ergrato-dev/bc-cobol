#!/bin/bash
# ============================================
# JOB: BATCHDIA - Procesamiento Batch Diario
# Simulacion JCL para COBOL
# ============================================
set -e

echo "============================================"
echo " JOB: BATCHDIA - Procesamiento Diario"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================"
echo ""

# Compilar todo
echo "--- Compilando modulos ---"
cd batch
cobc -x -free -I ../copybooks init-maestro.cbl -o init-maestro 2>/dev/null
cobc -x -free -I ../copybooks validar.cbl -o validar 2>/dev/null
cobc -x -free -I ../copybooks actualizar.cbl -o actualizar 2>/dev/null
cobc -x -free -I ../copybooks reporte-cierre.cbl -o reporte 2>/dev/null
cd ../online
cobc -x -free -I ../copybooks consulta-online.cbl -o consulta 2>/dev/null
cd ..
echo "Compilacion OK"
echo ""

# STEP 0: Inicializar maestro
echo "--- STEP 0: INICIALIZAR MAESTRO ---"
cd batch
./init-maestro
cd ..

# STEP 1: Validar
echo ""
echo "--- STEP 1: VALIDAR TRANSACCIONES ---"
cd batch
./validar
rc=$?
cd ..

if [ $rc -ne 0 ]; then
    echo "JOB ABORTADO: STEP 1 fallo RC=$rc"
    exit $rc
fi

# STEP 2: Ordenar
echo ""
echo "--- STEP 2: ORDENAR ---"
if [ -f trans_validas.dat ]; then
    sort -t'|' -k2,2 trans_validas.dat > trans_ordenadas.dat
    echo "Registros ordenados: $(wc -l < trans_ordenadas.dat)"
else
    echo "ERROR: trans_validas.dat no existe"
    exit 8
fi

# STEP 3: Actualizar maestro
echo ""
echo "--- STEP 3: ACTUALIZAR MAESTRO ---"
cd batch
./actualizar
cd ..

# STEP 4: Reporte
echo ""
echo "--- STEP 4: REPORTE CIERRE ---"
cd batch
./reporte
cd ..

echo ""
echo "============================================"
echo " JOB BATCHDIA completado exitosamente"
echo " Archivos generados:"
echo "   trans_validas.dat"
echo "   trans_rechazadas.dat"
echo "   trans_ordenadas.dat"
echo "   cierre_diario.txt"
echo "============================================"
