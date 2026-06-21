# Procedimientos JCL — PROC y PEND

## 🎯 Objetivos

- Definir procedimientos con PROC
- Pasar parámetros simbólicos
- Reutilizar lógica de job con catálogo de PROCs
- Sobrescribir DD desde el EXEC que llama al PROC

---

## 1. ¿Qué es un PROC?

Un **PROC** (Procedure) es un bloque reutilizable de JCL. Similar a una función o macro. Se define una vez y se invoca desde múltiples jobs.

```jcl
//ORDENAR  PROC DSNENT=,DSNSAL=
//PASO1    EXEC PGM=SORT
//SORTIN   DD   DSN=&DSNENT,DISP=SHR
//SORTOUT  DD   DSN=&DSNSAL,DISP=(NEW,CATLG)
//         PEND
```

---

## 2. Parámetros Simbólicos

Los parámetros empiezan con `&` y se definen en la línea PROC:

```jcl
//REPORTE  PROC NOMBRE=,         *> Parámetro obligatorio (sin default)
//             FECHA=20260620,    *> Parámetro con valor default
//             CLASE=A            *> Parámetro con valor default
//STEP1    EXEC PGM=GENERAR
//ENTRADA  DD   DSN=&NOMBRE,DISP=SHR
//REPSAL   DD   SYSOUT=&CLASE
//         PEND
```

### Invocar el PROC

```jcl
//MIJOB    JOB (1234),'PROGRAMADOR'
//R1       EXEC REPORTE,NOMBRE=DATOS.CLIENTES
//R2       EXEC REPORTE,NOMBRE=DATOS.CUENTAS,FECHA=20260621
```

---

## 3. PROC con Múltiples Steps

```jcl
//BATCHDIA PROC FECHA=,DATOS=
//*********************************************************************
//* PROC de procesamiento batch diario
//*********************************************************************
//VALIDAR  EXEC PGM=VALITRANS
//TRANS    DD   DSN=&DATOS,DISP=SHR
//*
//ORDENAR  EXEC PGM=SORT
//SORTIN   DD   DSN=*.VALIDAR.TRANS
//SORTOUT  DD   DSN=&&ORDENADO,DISP=(NEW,PASS)
//SYSIN    DD   *
  SORT FIELDS=(1,5,CH,A)
/*
//*
//ACTUALIZ EXEC PGM=ACTMAESTRO
//TRANS    DD   DSN=&&ORDENADO,DISP=(OLD,DELETE)
//MAESTRO  DD   DSN=CUENTAS.MAESTRO(&FECHA),DISP=OLD
//         PEND
```

---

## 4. Catálogo de PROCs

Los PROCs se guardan en librerías del sistema (PROCLIB). Se invocan por nombre sin necesidad de volver a definirlos:

```jcl
//MIJOB    JOB (BANCO),'DIARIO'
//PASO     EXEC PROC=CALCINT,DIAS=30
```

---

## 5. Sobrescribir DD del PROC

Puedes sobrescribir un DD al invocar el PROC:

```jcl
//MIJOB    JOB ...
//R1       EXEC REPORTE,NOMBRE=DATOS.CLIENTES
//STEP1.ENTRADA DD DSN=DATOS.ALTERNATIVO,DISP=SHR
```

La notación `STEP1.ENTRADA` sobrescribe el DD ENTRADA dentro del step STEP1 del PROC.

---

## 6. Simulación en Linux

```bash
#!/bin/bash
# Simulación de PROC: función bash reutilizable

proceso_batch() {
    local fecha=$1
    local archivo=$2

    echo "PROC BATCH: fecha=$fecha archivo=$archivo"
    
    # Step 1: Validar
    cobc -x -free validar.cbl && ./validar "$archivo"
    
    # Step 2: Ordenar
    sort -k1,5 "$archivo" > "${archivo}_ord"
    
    # Step 3: Actualizar
    cobc -x -free actualizar.cbl && ./actualizar "${archivo}_ord"
    
    echo "PROC BATCH completado."
}

# Invocar PROC
proceso_batch "20260620" "trans_diarias.dat"
proceso_batch "20260621" "trans_diarias2.dat"
```

---

## ✅ Checklist

- [ ] Definir PROC con parámetros simbólicos
- [ ] Invocar PROC desde un job con valores para los parámetros
- [ ] Usar PEND para cerrar el PROC
- [ ] Sobrescribir DDs al invocar: `STEPNAME.DDNAME`
- [ ] Simular PROC con funciones bash

## 📚 Recursos

- [IBM JCL PROC Statement](https://www.ibm.com/docs/en/zos/2.5?topic=statements-proc)
- [IBM JCL Cataloged Procedures](https://www.ibm.com/docs/en/zos/2.5?topic=procedures-cataloged)
