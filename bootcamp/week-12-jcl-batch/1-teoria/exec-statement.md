# EXEC Statement — Ejecución de Programas

## 🎯 Objetivos

- Definir steps de ejecución con EXEC
- Pasar parámetros con PARM
- Controlar flujo con COND
- Usar REGION para límites de memoria

---

## 1. Estructura del EXEC

```jcl
//STEPNAME EXEC PGM=PROGRAMA,
//             PARM='parametros',
//             COND=(0,NE),
//             REGION=8M,
//             TIME=(0,30)
```

| Parámetro | Significado | Ejemplo |
|-----------|-------------|---------|
| `PGM=` | Programa a ejecutar | `PGM=ORDENAR` |
| `PARM=` | Parámetros al programa | `PARM='20260620'` |
| `COND=` | Condición para ejecutar | `COND=(0,NE)` |
| `REGION=` | Memoria máxima | `REGION=8M` |
| `TIME=` | Tiempo máximo | `TIME=(0,30)` = 30 seg |
| `ADDRSPC=` | Espacio de direcciones | `ADDRSPC=VIRT` |

---

## 2. PARM — Pasar Argumentos

En COBOL, se reciben en LINKAGE SECTION:

```jcl
//STEP010  EXEC PGM=PROCESAR,PARM='20260620'
```

**Programa COBOL:**

```cobol
       LINKAGE SECTION.
       01  LK-PARM.
           05 LK-PARM-LEN   PIC S9(04) COMP.
           05 LK-PARM-DATA  PIC X(08).
       
       PROCEDURE DIVISION USING LK-PARM.
           DISPLAY "Fecha recibida: " LK-PARM-DATA.
```

---

## 3. COND — Control de Flujo entre Steps

COND determina si un step se ejecuta o se salta según el código de retorno de steps anteriores:

```jcl
//STEP1    EXEC PGM=VALIDAR
//STEP2    EXEC PGM=PROCESAR,COND=(0,NE,STEP1)
//STEP3    EXEC PGM=LIMPIAR,COND=ONLY
```

### Operadores COND

| COND | Significado |
|------|-------------|
| `COND=(0,NE)` | Ejecutar si ningún step anterior retornó 0 |
| `COND=(4,GT)` | Ejecutar si ningún step anterior retornó > 4 |
| `COND=(8,LE,STEP1)` | Ejecutar si STEP1 retornó ≤ 8 |
| `COND=ONLY` | Ejecutar SOLO si un step anterior falló |
| `COND=EVEN` | Ejecutar incluso si un step anterior falló |

### Códigos de Retorno COBOL → COND

```cobol
      *> En COBOL, usar RETURN-CODE
           MOVE 0 TO RETURN-CODE.     *> Éxito
           MOVE 8 TO RETURN-CODE.     *> Error
           STOP RUN.
```

---

## 4. IF/THEN/ELSE (JCL Moderno)

JCL moderno soporta IF/ELSE en lugar de COND:

```jcl
//STEP1    EXEC PGM=VALIDAR
//IFOK     IF STEP1.RC = 0 THEN
//STEP2    EXEC PGM=PROCESAR
//OKEND    ENDIF
//IFERR    IF STEP1.RC > 0 THEN
//STEPERR  EXEC PGM=NOTIFICAR
//EREND    ENDIF
```

---

## 5. Multi-Step Job

```jcl
//BATCHDIA JOB (BANCO),'PROCESO DIARIO',CLASS=A
//*********************************************************************
//* PASO 1: Validar transacciones del día
//*********************************************************************
//VALIDAR  EXEC PGM=VALITRANS
//ENTRADA  DD   DSN=TRANS.DIARIAS,DISP=SHR
//ERRORES  DD   DSN=TRANS.ERRORES,DISP=(NEW,CATLG,DELETE)
//*********************************************************************
//* PASO 2: Si validación OK, actualizar maestro
//*********************************************************************
//ACTUALIZ IF VALIDAR.RC = 0 THEN
//ACTMAE   EXEC PGM=ACTMAESTRO
//MAEANT   DD   DSN=CUENTAS.MAESTRO,DISP=OLD
//MAENVO   DD   DSN=CUENTAS.MAESTRO.NUEVO,DISP=(NEW,CATLG,DELETE)
//TRANSOK  DD   DSN=TRANS.DIARIAS,DISP=SHR
//ACTEND   ENDIF
//*********************************************************************
//* PASO 3: Generar reporte de cierre
//*********************************************************************
//REPORTE  EXEC PGM=REPDIARIO,COND=EVEN
//ENTRADA  DD   DSN=CUENTAS.MAESTRO.NUEVO,DISP=SHR
//REPSAL   DD   SYSOUT=*
```

---

## 6. Simulación en Linux

```bash
#!/bin/bash
# Simulación de job multi-step

rc=0

echo "=== STEP 1: VALIDAR ==="
cobc -x -free validar.cbl && ./validar
rc=$?

if [ $rc -eq 0 ]; then
    echo "=== STEP 2: ACTUALIZAR MAESTRO ==="
    cobc -x -free actualizar.cbl && ./actualizar
fi

echo "=== STEP 3: REPORTE (siempre) ==="
cobc -x -free reporte.cbl && ./reporte

echo "JOB completado con RC=$rc"
```

---

## ✅ Checklist

- [ ] Escribir EXEC PGM= para ejecutar un programa COBOL
- [ ] Pasar parámetros con PARM=
- [ ] Controlar flujo con COND o IF/THEN/ELSE
- [ ] Usar RETURN-CODE en COBOL para comunicar resultado

## 📚 Recursos

- [IBM JCL EXEC Statement](https://www.ibm.com/docs/en/zos/2.5?topic=statements-exec)
- [IBM JCL IF/THEN/ELSE](https://www.ibm.com/docs/en/zos/2.5?topic=statements-if-then-else)
