# 3-proyecto — Semana 08: Sistema Bancario Modular

## 🎯 Objetivo

Construir un sistema bancario con arquitectura modular usando subprogramas (CALL) y COPYBOOKS compartidos. Cuatro módulos independientes que comparten estructuras de datos vía COPYBOOKS.

## 📋 Módulos

| Módulo | Archivo | Función |
|--------|---------|---------|
| Principal | `banco-principal.cbl` | Menú y orquestación |
| Subprograma | `consultar.cbl` | Consulta de cuenta por ID |
| Subprograma | `depositar.cbl` | Depósito en cuenta |
| Subprograma | `retirar.cbl` | Retiro con validación de saldo |
| COPYBOOK | `copybooks/cuentas.cpy` | Layout de cuenta + 88-level compartidos |
| COPYBOOK | `copybooks/errores.cpy` | Códigos de FILE STATUS |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-08-subprogramas-copybooks/3-proyecto/starter
cobc -x -free banco-principal.cbl consultar.cbl depositar.cbl retirar.cbl -o banco
./banco
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores (4 archivos + copybooks) | Obligatorio |
| COPYBOOK compartido entre todos los módulos | 20% |
| CALL con USING correcto en cada módulo | 15% |
| LINKAGE SECTION correcta en cada subprograma | 15% |
| Consultar funcionando | 15% |
| Depositar funcionando | 15% |
| Retirar con validación de saldo | 15% |
| FILE STATUS robusto | 5% |
