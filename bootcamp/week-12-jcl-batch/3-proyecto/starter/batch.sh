#!/bin/bash
# ============================================
# JOB: BATCHDIA  -  Procesamiento Batch Diario
# Simulación JCL en bash para COBOL
# ============================================
# JCL REAL equivalente:
# //BATCHDIA JOB (BANCO),'PROCESO DIARIO',CLASS=A
# //VALIDAR  EXEC PGM=VALIDAR
# //TRANS    DD   DSN=TRANS.DIARIAS,DISP=SHR
# //VAL      DD   DSN=TRANS.VALIDAS,DISP=(NEW,CATLG)
# //REJ      DD   DSN=TRANS.RECHAZADAS,DISP=(NEW,CATLG)
# //IFOK     IF   VALIDAR.RC = 0 THEN
# //ORDENAR  EXEC PGM=ORDENAR
# //REPORTE  EXEC PGM=REPORTE
# //OKEND    ENDIF
# ============================================
set -e

echo "============================================"
echo " JOB: BATCHDIA - Procesamiento Diario"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================"
echo ""

# ============================================
# STEP 1: VALIDAR
# ============================================
echo "--- STEP 1: VALIDAR TRANSACCIONES ---"
cobc -x -free validar.cbl -o validar 2>/dev/null
./validar
rc_step1=$?
echo "STEP 1 RC=$rc_step1"
echo ""

# ============================================
# Control IF STEP1.RC = 0 THEN
# ============================================
if [ $rc_step1 -ne 0 ]; then
    echo "JOB ABORTADO: STEP 1 falló con RC=$rc_step1"
    exit $rc_step1
fi

# ============================================
# STEP 2: ORDENAR
# ============================================
echo "--- STEP 2: ORDENAR ---"
if [ -f trans_validas.dat ]; then
    sort -t'|' -k2,2 trans_validas.dat > trans_ordenadas.dat
    echo "Registros ordenados: $(wc -l < trans_ordenadas.dat)"
else
    echo "ERROR: trans_validas.dat no existe"
    exit 8
fi
echo "STEP 2 RC=0"
echo ""

# ============================================
# STEP 3: REPORTE
# ============================================
echo "--- STEP 3: GENERAR REPORTE ---"
cobc -x -free reporte.cbl -o reporte 2>/dev/null
./reporte
rc_step3=$?
echo "STEP 3 RC=$rc_step3"
echo ""

echo "============================================"
echo " JOB BATCHDIA completado. MAXCC=0"
echo " Archivos generados:"
echo "   trans_validas.dat"
echo "   trans_rechazadas.dat"
echo "   trans_ordenadas.dat"
echo "   cierre_diario.txt"
echo "============================================"
