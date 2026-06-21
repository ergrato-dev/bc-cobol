# 2-practicas — Semana 05: Archivos Indexados

Ejercicios guiados con CRUD sobre archivos indexados.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `crear-indexado.cbl` | Crear archivo indexado, poblar con WRITE |
| 2 | `consulta-aleatoria.cbl` | READ por clave, ACCESS MODE RANDOM |
| 3 | `mantenimiento.cbl` | START, DELETE, REWRITE, DYNAMIC |

## ⚠️ Importante

Los archivos indexados (`*.idx`) se generan en disco. Si re-ejecutas `crear-indexado`, el archivo se sobrescribe. Para conservar datos, ejecuta `crear-indexado` solo una vez.

## 🚀 Ejecutar

```bash
docker compose exec cobol bash
cd bootcamp/week-05-archivos-indexados/2-practicas
cobc -x -free crear-indexado.cbl && ./crear-indexado
cobc -x -free consulta-aleatoria.cbl && ./consulta-aleatoria
cobc -x -free mantenimiento.cbl && ./mantenimiento
```
