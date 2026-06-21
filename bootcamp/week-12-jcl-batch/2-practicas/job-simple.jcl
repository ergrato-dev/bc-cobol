#!/bin/bash
# ============================================
# JOB: SIMPLE  -  Procesamiento Simple
# ============================================
# JCL REAL (equivalente en mainframe):
#
# //SIMPLE   JOB (BOOTCAMP),'ESTUDIANTE',
# //             CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1)
# //STEP1    EXEC PGM=IEBGENER
# //SYSUT1   DD   *
# ID     NOMBRE                    SALDO
# 00101  Juan Perez                00001500000
# 00202  Maria Garcia              00002500000
# //SYSUT2   DD   SYSOUT=*
# //SYSPRINT DD   SYSOUT=*
# //
set -e
echo "========================================"
echo " JOB: SIMPLE - Procesamiento Simple"
echo "========================================"
echo ""

# === STEP 1: Mostrar datos de entrada ===
echo "--- STEP 1: MOSTRAR DATOS ---"
echo "ID     NOMBRE                    SALDO"
echo "-----  ------------------------  ----------"
echo "00101  Juan Perez                00001500000"
echo "00202  Maria Garcia              00002500000"
echo "00303  Carlos Lopez              00001000075"
echo ""
echo "STEP 1 completado. RC=0"

# === STEP 2: Contar registros ===
echo "--- STEP 2: CONTAR REGISTROS ---"
echo "Total registros procesados: 3"
echo ""
echo "STEP 2 completado. RC=0"

echo "========================================"
echo " JOB SIMPLE terminado. MAXCC=0"
echo "========================================"
