# Semana 14: Proyecto Final — Sistema Bancario

## 🎯 Objetivos

Al finalizar esta semana, el estudiante será capaz de:

- Integrar todos los conocimientos del bootcamp en un sistema completo
- Diseñar arquitectura de sistema bancario batch + online
- Implementar procesamiento batch con JCL y COBOL
- Integrar SQL embebido para persistencia de datos
- Construir interfaces CICS para consulta de clientes
- Generar reportes profesionales de estado de cuenta
- Aplicar COPYBOOKS para compartir estructuras entre módulos
- Implementar SORT/MERGE para procesamiento de transacciones

## 📚 Contenido

### 1-teoria/

- **arquitectura-sistema.md**: Componentes batch y online, flujo de datos
- **integracion-batch-online.md**: Comunicación entre sistemas batch y CICS
- **diseno-modular.md**: COPYBOOKS compartidos, subprogramas

### 3-proyecto/

El proyecto consiste en construir un sistema bancario con los siguientes componentes:

#### Módulo Batch
1. **Procesador de transacciones** (COBOL batch vía JCL)
   - Lee archivo de transacciones del día
   - Valida cada transacción con reglas de negocio
   - Actualiza saldos en archivo maestro de cuentas
   - Genera archivo de transacciones rechazadas
   - Produce reporte de cierre diario

2. **Consolidador mensual** (SORT + MERGE)
   - Fusiona transacciones de todo el mes
   - Ordena por cuenta y fecha
   - Genera estados de cuenta por cliente
   - Calcula intereses ganados

3. **Carga de datos** (SQL embebido)
   - Lee archivo de nuevos clientes
   - Inserta en tabla CLIENTES vía EXEC SQL
   - Actualiza tabla CUENTAS con saldos iniciales

#### Módulo Online
1. **Consulta de saldo** (CICS)
   - Pantalla de ingreso de número de cuenta
   - Muestra saldo actual, últimos 5 movimientos
   - Pseudo-conversación para navegación

#### COPYBOOKS compartidos
- `CUENTAS.cpy`: Estructura de registro de cuentas
- `TRANSACC.cpy`: Estructura de registro de transacciones
- `ERRORES.cpy`: Códigos de error del sistema
- `FECHAS.cpy`: Rutinas de validación de fechas

## ⏱️ Distribución (10h)

- Diseño y planificación: 2h
- Implementación batch: 4h
- Implementación online: 2h
- Integración y testing: 2h

## 📌 Entregables

- [ ] Procesador batch de transacciones
- [ ] Reporte de cierre diario
- [ ] Estados de cuenta mensuales
- [ ] Pantalla CICS de consulta de saldo
- [ ] COPYBOOKS reutilizables
- [ ] Script `test.sh` con casos de prueba
- [ ] README del proyecto con instrucciones

## 🏆 Criterios de Aprobación Final

| Criterio | Peso | Mínimo |
|----------|------|--------|
| Compilación sin errores (`cobc -x -free`) | Obligatorio | 100% |
| FILE STATUS en todas las operaciones | 10% | 7/10 |
| SQLCODE en todas las operaciones SQL | 10% | 7/10 |
| Reporte batch formateado profesionalmente | 20% | 7/10 |
| Pantalla CICS funcional | 15% | 7/10 |
| COPYBOOKS utilizados en 2+ módulos | 10% | 7/10 |
| Script de prueba completo | 15% | 7/10 |
| Documentación del sistema | 10% | 7/10 |
| Presentación del proyecto | 10% | 7/10 |

## 🔗 Navegación

← [Semana 13](../week-13-cics-online/README.md) | [Inicio](../../README.md)
