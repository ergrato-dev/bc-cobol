# MERGE — Fusión de Archivos

## 🎯 Objetivos

- Fusionar múltiples archivos ordenados en uno solo
- Usar MERGE con claves ASCENDING/DESCENDING
- Combinar MERGE con OUTPUT PROCEDURE
- Procesar datos consolidados

---

## 1. Sintaxis de MERGE

```cobol
       MERGE sort-file
           ASCENDING KEY clave-1
           USING archivo-1 archivo-2 archivo-3 ...
           GIVING archivo-salida
       [OUTPUT PROCEDURE IS parrafo].
```

MERGE combina múltiples archivos de entrada (ya ordenados) en uno solo ordenado.

---

## 2. MERGE Simple (3→1)

```cobol
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SUC1    ASSIGN TO "sucursal1.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SUC2    ASSIGN TO "sucursal2.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SUC3    ASSIGN TO "sucursal3.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CONSOL  ASSIGN TO "consolidado.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT MERGE-WK ASSIGN TO "mergework.tmp".
       
       DATA DIVISION.
       FILE SECTION.
       FD  SUC1.  01 S1-REG   PIC X(39).
       FD  SUC2.  01 S2-REG   PIC X(39).
       FD  SUC3.  01 S3-REG   PIC X(39).
       FD  CONSOL. 01 CON-REG  PIC X(39).
       
       SD  MERGE-WK.
       01  MERGE-REG.
           05 MERGE-ID    PIC 9(05).
           05 MERGE-RESTO PIC X(34).
       
       PROCEDURE DIVISION.
           MERGE MERGE-WK
               ASCENDING KEY MERGE-ID
               USING SUC1 SUC2 SUC3
               GIVING CONSOL.
           STOP RUN.
```

---

## 3. MERGE con OUTPUT PROCEDURE

Para transformar el resultado de la fusión:

```cobol
           MERGE MERGE-WK
               ASCENDING KEY MERGE-ID
               USING SUC1 SUC2 SUC3
               OUTPUT PROCEDURE IS 2000-GENERAR-MAESTRO.
       
       2000-GENERAR-MAESTRO.
           OPEN OUTPUT MAESTRO.
           PERFORM UNTIL MERGE-EOF
               RETURN MERGE-WK
                   AT END SET MERGE-EOF TO TRUE
                   NOT AT END
                       WRITE MAE-REG FROM MERGE-REG
                       ADD 1 TO WS-CONT
               END-RETURN
           END-PERFORM.
           CLOSE MAESTRO.
```

---

## 4. Requisitos para MERGE

1. Los archivos de entrada DEBEN estar ordenados por la misma clave que usas en MERGE
2. Si no están ordenados, el resultado es impredecible
3. Puedes usar SORT previo para ordenar cada archivo

```bash
# Preparación (desde shell)
sort -k1,5 sucursal1.dat > s1_ord.dat
sort -k1,5 sucursal2.dat > s2_ord.dat
sort -k1,5 sucursal3.dat > s3_ord.dat
```

---

## 5. Flujo Típico: SORT + MERGE

```cobol
      *> Paso 1: Ordenar cada archivo individual
           SORT SORT-WK
               ASCENDING KEY SORT-ID
               USING SUC1 GIVING SUC1-ORD.
       
           SORT SORT-WK
               ASCENDING KEY SORT-ID
               USING SUC2 GIVING SUC2-ORD.
       
      *> Paso 2: Fusionar archivos ordenados
           MERGE MERGE-WK
               ASCENDING KEY MERGE-ID
               USING SUC1-ORD SUC2-ORD
               GIVING CONSOLIDADO.
```

---

## 6. MERGE vs SORT

| Característica | SORT | MERGE |
|---------------|------|-------|
| Entrada | 1 archivo | 2+ archivos |
| ¿Requiere entrada ordenada? | ❌ No | ✅ Sí |
| Usa INPUT PROCEDURE | ✅ Sí | ❌ No |
| Usa OUTPUT PROCEDURE | ✅ Sí | ✅ Sí |
| RELEASE / RETURN | ✅ Sí | Solo RETURN |
| Uso típico | Ordenar un archivo | Consolidar sucursales |

---

## 7. Ejemplo: Consolidación Bancaria Diaria

```cobol
      *> 5 sucursales envían sus transacciones del día
      *> Cada archivo ya viene ordenado por número de cuenta
       
           MERGE MERGE-WK
               ASCENDING KEY MERGE-CUENTA
               USING SUC1-DIA SUC2-DIA SUC3-DIA SUC4-DIA SUC5-DIA
               OUTPUT PROCEDURE IS 3000-ACTUALIZAR-MAESTRO.
       
       3000-ACTUALIZAR-MAESTRO.
           OPEN I-O MAESTRO.
           PERFORM UNTIL MERGE-EOF
               RETURN MERGE-WK
                   AT END SET MERGE-EOF TO TRUE
                   NOT AT END
                       PERFORM 3100-APLICAR-MOVIMIENTO
               END-RETURN
           END-PERFORM.
           CLOSE MAESTRO.
```

---

## ✅ Checklist

- [ ] Usar MERGE para combinar 2+ archivos ordenados
- [ ] Usar ASCENDING/DESCENDING KEY en MERGE
- [ ] Las entradas deben estar pre-ordenadas por la misma clave
- [ ] Usar OUTPUT PROCEDURE con MERGE para procesar resultado
- [ ] Usar RETURN (no READ) dentro de OUTPUT PROCEDURE

## 📚 Recursos

- [IBM COBOL MERGE Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-merge-statement)
- [GnuCOBOL MERGE](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#MERGE)
