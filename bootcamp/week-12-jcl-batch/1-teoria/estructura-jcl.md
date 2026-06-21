# JCL Fundamentos — JOB Statement

## 🎯 Objetivos

- Comprender la estructura de un job JCL
- Escribir JOB statements correctamente
- Conocer los parámetros de accounting y clase
- Simular JCL en Linux con scripts bash

---

## 1. ¿Qué es JCL?

**JCL** (Job Control Language) es el lenguaje para ejecutar trabajos batch en mainframes IBM. Define qué programas ejecutar, qué archivos usar y cómo manejar los resultados.

```jcl
//NOMBREJOB JOB (ACCT-INFO),'PROGRAMADOR',
//             CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1)
//STEP1    EXEC PGM=PROGRAMA1
//ENTRADA  DD   DSN=DATOS.ENTRADA,DISP=SHR
//SALIDA   DD   DSN=DATOS.SALIDA,DISP=(NEW,CATLG,DELETE)
```

> 📝 En este bootcamp, **simulamos** JCL con scripts bash. La sintaxis que aprenderás es la real de mainframe, pero la ejecutarás en Linux.

---

## 2. Estructura de un Job

```
//NOMBREJOB JOB  ...              ← Job card
//STEP1    EXEC PGM=PROGRAMA1     ← Step 1
//DD1      DD   DSN=ARCHIVO,...   ← Data definition
//DD2      DD   DSN=ARCHIVO2,...  ← Data definition
//STEP2    EXEC PGM=PROGRAMA2     ← Step 2
//DD3      DD   DSN=ARCHIVO3,...
```

| Componente | Descripción |
|-----------|-------------|
| `//` | Columnas 1-2: inicio de sentencia JCL |
| `NOMBREJOB` | Nombre del job (máx 8 caracteres) |
| `JOB` | Palabra clave del job card |
| `EXEC` | Define un step de ejecución |
| `DD` | Data Definition: asocia archivos al programa |

---

## 3. JOB Card — El Statement Principal

```jcl
//MIJOB    JOB (1234),'MARIA GARCIA',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID,
//             REGION=4M
```

| Parámetro | Significado | Ejemplo |
|-----------|-------------|---------|
| `(1234)` | Información contable | Centro de costo |
| `'MARIA GARCIA'` | Nombre del programador | |
| `CLASS=A` | Clase de trabajo | A=prioridad normal, B=baja |
| `MSGCLASS=X` | Clase de salida de mensajes | X=default |
| `MSGLEVEL=(1,1)` | Nivel de detalle de log | (1,1)=máximo detalle |
| `NOTIFY=&SYSUID` | Usuario a notificar | &SYSUID=usuario actual |
| `REGION=4M` | Memoria máxima | 4M=4 megabytes |
| `TYPRUN=SCAN` | Solo validar sintaxis | No ejecutar |

### Clases comunes

| Clase | Propósito |
|-------|-----------|
| A | Trabajos normales |
| B | Trabajos batch nocturnos |
| C | Trabajos urgentes |
| T | Trabajos de prueba/test |

---

## 4. Simulación en Linux

Como no tenemos mainframe, simulamos JCL con scripts bash:

```bash
#!/bin/bash
# JOB: MIJOB - Simulación JCL en Linux
# STEP1: Validar datos
echo "=== STEP 1: VALIDAR ==="
cobc -x -free validar.cbl && ./validar

# STEP2: Ordenar
echo "=== STEP 2: ORDENAR ==="
sort -k1,5 entrada.dat > ordenado.dat

# STEP3: Generar reporte
echo "=== STEP 3: REPORTE ==="
cobc -x -free reporte.cbl && ./reporte

echo "JOB MIJOB completado."
```

---

## 5. Convenciones de Nombres

| Elemento | Regla | Ejemplo |
|----------|-------|---------|
| Nombre de job | 1-8 caracteres, empieza con letra | `PAGODIA` |
| Nombre de step | 1-8 caracteres | `STEP010` |
| Dataset name (DSN) | Segmentos separados por `.` | `NOMINA.MAESTRO.DATOS` |

---

## ✅ Checklist

- [ ] Identificar las partes de un job JCL: JOB, EXEC, DD
- [ ] Escribir un JOB card con parámetros básicos
- [ ] Simular un job JCL con script bash
- [ ] Nombrar jobs y steps con máximo 8 caracteres

## 📚 Recursos

- [IBM JCL Reference](https://www.ibm.com/docs/en/zos/2.5?topic=reference-job-control-language)
- [IBM JCL Tutorial](https://www.ibm.com/docs/en/zos-basic-skills)
