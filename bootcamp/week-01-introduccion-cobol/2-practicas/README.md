# 2-practicas — Semana 01: Introducción a COBOL

Ejercicios guiados paso a paso. Descomenta el código para aprender.

## 📋 Ejercicios

| # | Archivo | Concepto |
|---|---------|----------|
| 1 | `hola-mundo.cbl` | Primer programa: DISPLAY, estructura de 4 divisiones |
| 2 | `entrada-salida.cbl` | Interacción: ACCEPT y DISPLAY |
| 3 | `estructura-completa.cbl` | Programa con todas las divisiones y párrafos |

## 🚀 Cómo ejecutar

Todos los comandos se ejecutan **dentro del contenedor Docker**:

```bash
# Entrar al contenedor
docker compose exec cobol bash

# Ir a la carpeta de prácticas
cd bootcamp/week-01-introduccion-cobol/2-practicas

# Compilar y ejecutar cualquier ejercicio
cobc -x -free hola-mundo.cbl && ./hola-mundo
```

---

## Instrucciones

1. Lee el README del ejercicio
2. Abre el archivo `.cbl` correspondiente
3. **Descomenta** las líneas indicadas
4. Guarda, compila y ejecuta
5. Compara el resultado con lo esperado en este README
