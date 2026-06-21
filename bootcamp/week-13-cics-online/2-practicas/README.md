# 2-practicas — Semana 13: CICS Fundamentos

Ejercicios que simulan comportamiento CICS con programas COBOL interactivos.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `hola-cics.cbl` | SEND TEXT simulado, estructura de programa CICS |
| 2 | `consulta-cics.cbl` | SEND MAP + RECEIVE MAP simulados |
| 3 | `transaccion-cics.cbl` | Pseudo-conversación, COMMAREA simulada |

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-13-cics-online/2-practicas
cobc -x -free hola-cics.cbl && ./hola-cics
cobc -x -free consulta-cics.cbl && ./consulta-cics
cobc -x -free transaccion-cics.cbl && ./transaccion-cics
```
