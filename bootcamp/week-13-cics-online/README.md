# Semana 13: CICS Fundamentos

## 🎯 Objetivos

Al finalizar esta semana, el estudiante será capaz de:

- Comprender la arquitectura cliente-servidor de CICS
- Identificar los componentes de una región CICS
- Escribir programas CICS con EXEC CICS
- Enviar y recibir datos de pantalla (MAPS/BMS)
- Implementar pseudo-conversación (COMMAREA)
- Manejar transacciones básicas (READ, WRITE, DELETE en archivos)

## 📚 Contenido

### 1-teoria/

- **introduccion-cics.md**: Arquitectura, regiones, transacciones, programas
- **exec-cics.md**: Sintaxis, comandos básicos, RESP y RESP2
- **mapas-bms.md**: Basic Mapping Support, campos de entrada/salida
- **pseudo-conversacion.md**: COMMAREA, estado entre transacciones
- **archivos-cics.md**: VSAM, READ, WRITE, DELETE, UPDATE, STARTBR

### 2-practicas/

- **hola-cics.cbl**: Programa CICS mínimo con SEND TEXT
- **consulta-cics.cbl**: RECEIVE MAP + SEND MAP (pantalla consulta)
- **transaccion-cics.cbl**: Pseudo-conversación con COMMAREA

### 3-proyecto/

- **starter/consulta-saldo-cics.cbl**: Sistema de consulta de saldo bancario con pantalla CICS, entrada de número de cuenta, display de saldo

## ⏱️ Distribución (10h)

- Teoría: 3h | Prácticas: 4h | Proyecto: 3h

## 📌 Entregables

- [ ] Programa CICS con SEND TEXT
- [ ] Pantalla de consulta con RECEIVE/SEND MAP
- [ ] Proyecto de consulta de saldo CICS completado

## 🔗 Navegación

← [Semana 12](../week-12-jcl-batch/README.md) | [Semana 14 →](../week-14-proyecto-final/README.md)
