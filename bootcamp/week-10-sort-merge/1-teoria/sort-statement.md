# SORT — Ordenamiento de Archivos

## 🎯 Objetivos

- Ordenar archivos con SORT USING/GIVING
- Definir claves de ordenamiento ASCENDING/DESCENDING
- Ordenar por múltiples claves
- Usar SORT con archivos secuenciales

---

## 1. SORT Básico (USING / GIVING)

La forma más simple: archivo de entrada → ordenar → archivo de salida.

```cobol
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ENTRADA  ASSIGN TO "clientes.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SALIDA   ASSIGN TO "clientes_ord.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SORT-FILE ASSIGN TO "sortwork.tmp".
       
       DATA DIVISION.
       FILE SECTION.
       FD  ENTRADA.
       01  ENT-REG.
           05 ENT-ID       PIC 9(05).
           05 ENT-NOMBRE   PIC X(30).
           05 ENT-SALDO    PIC 9(07)V99.
       
       FD  SALIDA.
       01  SAL-REG         PIC X(39).
       
       SD  SORT-FILE.                    *> SD = Sort Description
       01  SORT-REG.
           05 SORT-ID      PIC 9(05).
           05 SORT-NOMBRE  PIC X(30).
           05 SORT-SALDO   PIC 9(07)V99.
       
       PROCEDURE DIVISION.
           SORT SORT-FILE
               ASCENDING KEY SORT-ID
               USING ENTRADA
               GIVING SALIDA.
           STOP RUN.
```

### Flujo

```
clientes.dat ──→ [SORT] ──→ clientes_ord.dat
                 ASCENDING ID
```

---

## 2. ASCENDING / DESCENDING KEY

```cobol
      *> Una clave ascendente
           SORT SORT-FILE
               ASCENDING KEY SORT-ID
               USING ENTRADA GIVING SALIDA.
       
      *> Una clave descendente
           SORT SORT-FILE
               DESCENDING KEY SORT-SALDO
               USING ENTRADA GIVING SALIDA.
       
      *> Múltiples claves (primero nombre ASC, luego saldo DESC)
           SORT SORT-FILE
               ASCENDING KEY SORT-NOMBRE
               DESCENDING KEY SORT-SALDO
               USING ENTRADA GIVING SALIDA.
```

| Cláusula | Significado | Orden |
|----------|-------------|-------|
| `ASCENDING KEY` | Menor a mayor | A→Z, 0→9 |
| `DESCENDING KEY` | Mayor a menor | Z→A, 9→0 |

---

## 3. Múltiples Claves de Ordenamiento

```cobol
      *> Ordenar por sucursal, luego tipo, luego saldo descendente
           SORT SORT-FILE
               ASCENDING KEY SORT-SUC
               ASCENDING KEY SORT-TIPO
               DESCENDING KEY SORT-SALDO
               USING ENTRADA GIVING SALIDA.
```

Resultado:

```
Suc 01, Tipo CC, Saldo $5,000   ← primera clave: suc 01, luego tipo CC
Suc 01, Tipo CC, Saldo $3,000   ← mismo suc+tipo, ordenado por saldo DESC
Suc 01, Tipo CA, Saldo $8,000   ← cambió tipo
Suc 02, Tipo CC, Saldo $1,000   ← cambió sucursal
```

---

## 4. SORT con Archivo de Salida Directo

```cobol
      *> El archivo de salida DEBE estar cerrado antes del SORT
      *> SORT lo abre, escribe y cierra automáticamente
       
           SORT SORT-FILE
               ASCENDING KEY SORT-ID
               USING ENTRADA
               GIVING SALIDA.
      *> SALIDA queda cerrado después del SORT
```

---

## 5. SORT con USING y GIVING — Programa Completo

```cobol
       >>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ORDENAR.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ENTRADA  ASSIGN TO "entrada.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SALIDA   ASSIGN TO "salida.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SORT-WK  ASSIGN TO "sortwork.tmp".
       
       DATA DIVISION.
       FILE SECTION.
       FD  ENTRADA.  01 ENT-REG PIC X(50).
       FD  SALIDA.   01 SAL-REG PIC X(50).
       SD  SORT-WK.  01 SORT-REG.
           05 SORT-CLAVE PIC 9(05).
           05 FILLER     PIC X(45).
       
       PROCEDURE DIVISION.
           DISPLAY "Ordenando archivo...".
           SORT SORT-WK
               ASCENDING KEY SORT-CLAVE
               USING ENTRADA
               GIVING SALIDA.
           DISPLAY "Completado. Ver salida.dat".
           STOP RUN.
```

---

## ✅ Checklist

- [ ] Declarar SD (Sort Description) en FILE SECTION
- [ ] Usar SORT con ASCENDING/DESCENDING KEY
- [ ] Ordenar por múltiples claves
- [ ] Usar USING y GIVING para entrada/salida directa
- [ ] El layout del SD debe coincidir con los registros a ordenar

## 📚 Recursos

- [GnuCOBOL SORT Statement](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#SORT)
- [IBM COBOL SORT Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-sort-statement)
