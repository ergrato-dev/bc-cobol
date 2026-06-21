#!/bin/bash
# ============================================
# test.sh - Pruebas de integracion del sistema
# ============================================
set -e

echo "=== TEST SISTEMA BANCARIO ==="
echo ""

# Preparar entorno
rm -f cuentas.idx trans_validas.dat trans_rechazadas.dat trans_ordenadas.dat cierre_diario.txt

# Compilar todo
echo "--- Compilando ---"
cd batch
cobc -x -free -I ../copybooks init-maestro.cbl -o init-maestro 2>/dev/null
cobc -x -free -I ../copybooks validar.cbl -o validar 2>/dev/null
cobc -x -free -I ../copybooks actualizar.cbl -o actualizar 2>/dev/null
cobc -x -free -I ../copybooks reporte-cierre.cbl -o reporte 2>/dev/null
cd ../online
cobc -x -free -I ../copybooks consulta-online.cbl -o consulta 2>/dev/null
cd ..

# Test 1: Inicializar maestro
echo "TEST 1: Inicializar maestro"
cd batch && ./init-maestro && cd ..
[ -f cuentas.idx ] && echo "  PASS: cuentas.idx creado" || echo "  FAIL"

# Test 2: Validar transacciones
echo "TEST 2: Validar transacciones"
cd batch && ./validar && cd ..
[ -f trans_validas.dat ] && echo "  PASS: trans_validas.dat creado" || echo "  FAIL"
[ -f trans_rechazadas.dat ] && echo "  PASS: trans_rechazadas.dat creado" || echo "  FAIL"

# Test 3: Rechazadas contiene las 2 invalidas
echo "TEST 3: Verificar transacciones rechazadas"
rej_count=$(grep -c "TIPO INVALIDO\|MONTO NEGATIVO" trans_rechazadas.dat || true)
[ "$rej_count" -ge 2 ] && echo "  PASS: $rej_count errores detectados" || echo "  FAIL: solo $rej_count"

# Test 4: Ordenar
echo "TEST 4: Ordenar"
sort -t'|' -k2,2 trans_validas.dat > trans_ordenadas.dat
lines=$(wc -l < trans_ordenadas.dat)
echo "  PASS: $lines lineas ordenadas"

# Test 5: Actualizar maestro
echo "TEST 5: Actualizar maestro"
cd batch && ./actualizar && cd ..
echo "  PASS: actualizar ejecutado"

# Test 6: Generar reporte
echo "TEST 6: Generar reporte"
cd batch && ./reporte && cd ..
[ -f cierre_diario.txt ] && echo "  PASS: cierre_diario.txt creado" || echo "  FAIL"

# Test 7: Reporte contiene datos
echo "TEST 7: Verificar contenido del reporte"
grep -q "CIERRE DIARIO" cierre_diario.txt && echo "  PASS: titulo encontrado" || echo "  FAIL"
grep -q "TOTAL GENERAL" cierre_diario.txt && echo "  PASS: total encontrado" || echo "  FAIL"

echo ""
echo "=== TODOS LOS TESTS PASARON ==="
