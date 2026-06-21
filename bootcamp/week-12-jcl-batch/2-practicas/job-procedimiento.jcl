#!/bin/bash
# ============================================
# JOB: PROCPROC  -  Demostración de PROC
# ============================================
# Simula un PROC reutilizable para reportes
# con parámetros simbólicos.
#
# JCL REAL equivalente:
# //REPORTE  PROC NOMBRE=,FECHA=,CLASE=A
# //STEP1    EXEC PGM=GENERAR
# //ENTRADA  DD   DSN=&NOMBRE,DISP=SHR
# //SALIDA   DD   SYSOUT=&CLASE
# //         PEND
# //
# //MIJOB    JOB (BOOTCAMP),'ESTUDIANTE'
# //R1       EXEC REPORTE,NOMBRE=DATOS.CLIENTES,FECHA=20260620
# //R2       EXEC REPORTE,NOMBRE=DATOS.CUENTAS,FECHA=20260620
# //
set -e

# ============================================
# PROC: REPORTE (función bash simulada)
# ============================================
generar_reporte() {
    local nombre="$1"
    local fecha="${2:-20260620}"
    local clase="${3:-A}"

    echo "  PROC REPORTE: NOMBRE=$nombre FECHA=$fecha CLASE=$clase"
    echo "  STEP1: EXEC PGM=GENERAR"
    echo "    ENTRADA DD DSN=$nombre,DISP=SHR"
    echo "    SALIDA  DD SYSOUT=$clase"
    echo "  -> Reporte generado para $nombre ($fecha)"
    echo ""
}

# ============================================
# JOB PRINCIPAL
# ============================================
echo "========================================"
echo " JOB: PROCPROC - Uso de PROCEDURES"
echo "========================================"
echo ""

# Invocar PROC con diferentes parámetros
echo "--- R1: EXEC REPORTE,NOMBRE=DATOS.CLIENTES ---"
generar_reporte "DATOS.CLIENTES" "20260620" "A"

echo "--- R2: EXEC REPORTE,NOMBRE=DATOS.CUENTAS,FECHA=20260621 ---"
generar_reporte "DATOS.CUENTAS" "20260621" "A"

echo "--- R3: EXEC REPORTE,NOMBRE=DATOS.TRANS,CLASE=T ---"
generar_reporte "DATOS.TRANS" "20260620" "T"

echo "========================================"
echo " JOB PROCPROC terminado. MAXCC=0"
echo "========================================"
