# 3-proyecto — Semana 13: Consulta de Saldo CICS

## 🎯 Objetivo

Crear un sistema de consulta de saldo bancario con interfaz simulada CICS: pantalla de menú, pantalla de ingreso de cuenta, pantalla de resultado con COMMAREA simulada, usando archivo indexado para persistencia.

## 📋 Requisitos

1. ✅ **Pantalla MENU**: Opciones consultar saldo, listar cuentas, salir
2. ✅ **Pantalla CONSULTA**: Ingresar número de cuenta
3. ✅ **Pantalla RESULTADO**: Mostrar nombre, saldo, tipo de cuenta
4. ✅ **Pseudo-conversación**: Usar variable de estado (COMMAREA simulada)
5. ✅ **Datos**: Leer de archivo indexado `cuentas.idx` (CREAR PRIMERO)
6. ✅ **Pantallas formateadas**: Bordes, campos alineados, moneda editada

## 🗂️ Archivos

```
starter/
├── crear-cuentas.cbl       # Poblar cuentas.idx con 6 cuentas
├── consulta-saldo-cics.cbl # Sistema CICS simulado con 3 pantallas
└── README.md
```

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-13-cics-online/3-proyecto/starter
cobc -x -free crear-cuentas.cbl && ./crear-cuentas
cobc -x -free consulta-saldo-cics.cbl && ./consulta-saldo-cics
```

## 📊 Rúbrica

| Criterio | Peso |
|----------|------|
| Compilación sin errores | Obligatorio |
| 3 pantallas con estados (COMMAREA simulada) | 25% |
| Lectura correcta de archivo indexado | 20% |
| Pantallas formateadas profesionalmente | 15% |
| Navegación entre pantallas (menú→consulta→resultado→menú) | 15% |
| Validación de entrada y errores | 15% |
| Código organizado en párrafos | 10% |
