# 3-proyecto — Semana 07: Procesador de Transacciones Bancarias

## 🎯 Objetivo

Crear un programa que lea un archivo de transacciones bancarias, parsea cada línea con UNSTRING, normaliza los datos con INSPECT y FUNCTION, valida el contenido y genera un reporte de transacciones válidas y rechazadas.

## 📋 Requisitos

1. ✅ Leer archivo `transacciones.dat` línea por línea
2. ✅ Parsear cada línea con UNSTRING (ID, tipo, monto, moneda, fecha)
3. ✅ Limpiar y normalizar con INSPECT y FUNCTION TRIM/UPPER-CASE
4. ✅ Validar: tipo válido (D/R/T), monto > 0, moneda 3 chars, fecha formato correcto
5. ✅ Separar en archivo de válidas y archivo de rechazadas
6. ✅ Generar reporte con contadores

## Formato del archivo

```
tipo|cuenta|monto|moneda|fecha
D|00104|15000.00|USD|20260620
R|00201|5000.75|MXN|20260620
```

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-07-string-manipulacion/3-proyecto/starter
cobc -x -free procesador-transacciones.cbl && ./procesador-transacciones
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| UNSTRING con pipe delimiter | 20% |
| INSPECT/FUNCTION para limpieza | 15% |
| Validación de campos | 20% |
| Separación válidas/rechazadas | 20% |
| Reporte con contadores | 15% |
| FILE STATUS en ambos archivos de salida | 10% |
