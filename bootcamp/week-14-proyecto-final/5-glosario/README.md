# Glosario — Semana 14: Proyecto Final

## A

**Arquitectura Modular**
Diseño de software dividido en módulos independientes (batch, online, SQL) que comparten COPYBOOKS.

**Archivo Maestro (Master File)**
Archivo indexado que contiene el estado actual de las cuentas. Se actualiza en el batch diario.

## B

**batch.sh**
Script que simula JCL para orquestar los steps del procesamiento batch: validar → ordenar → actualizar → reporte.

**Batch (Procesamiento)**
Ejecución programada y automatizada de programas. Típicamente nocturno, procesa grandes volúmenes.

## C

**Capa de Datos**
Conjunto de archivos y base de datos que persisten la información: cuentas.idx, transacciones.dat, PostgreSQL.

**CICS Simulado**
Emulación de pantallas CICS usando DISPLAY/ACCEPT con variable de estado (COMMAREA simulada).

**COPYBOOK Compartido**
Archivo .cpy incluido en múltiples programas con COPY. Garantiza estructuras de datos idénticas.

**Ciclo de Vida Diario**
Flujo completo: online (día) → batch (noche) → reporte → nuevo día.

## I

**Integración Batch-Online**
Sistema donde el módulo online genera transacciones durante el día y el batch las procesa en la noche.

## M

**Módulo Batch**
Conjunto de programas que ejecutan el procesamiento nocturno: validar, ordenar, actualizar, reporte.

**Módulo Online**
Programa interactivo que simula CICS para consultas en tiempo real durante el día.

## O

**Orquestación**
Coordinación de la ejecución de múltiples programas en secuencia, con control de errores entre steps.

## P

**Procesamiento por Lotes (Batch Processing)**
Ejecución de programas sin interacción, típicamente en horario nocturno.

**Pseudo-Conversación**
Técnica que mantiene estado entre pantallas usando una variable de control.

## R

**Reporte de Cierre**
Documento generado al final del batch que resume el estado de todas las cuentas.

**RETURN-CODE (RC)**
Código numérico que un programa retorna al sistema. 0 = éxito. Usado para control de flujo entre steps.

## S

**Saldos Actualizados**
Resultado de aplicar débitos y créditos del día al saldo anterior de cada cuenta.

**STEP**
Cada etapa del procesamiento batch. Un job típico tiene 3-5 steps encadenados.

## T

**test.sh**
Script de pruebas de integración que ejecuta todo el sistema y verifica resultados con diff.
