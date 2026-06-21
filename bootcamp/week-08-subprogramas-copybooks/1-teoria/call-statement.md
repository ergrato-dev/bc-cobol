# CALL — Invocación de Subprogramas

## 🎯 Objetivos

- Llamar subprogramas con CALL literal y CALL variable
- Pasar parámetros con USING
- Compilar y enlazar múltiples programas
- Usar CANCEL para gestionar memoria

---

## 1. Programa Principal + Subprograma

COBOL permite dividir el código en módulos independientes. Cada módulo es un programa separado con su propio PROGRAM-ID.

### Programa principal (MAIN.cbl)

```cobol
       >>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINCIPAL.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-NUM1      PIC 9(05) VALUE 100.
       01  WS-NUM2      PIC 9(05) VALUE 50.
       01  WS-RESULTADO PIC 9(10).
       
       PROCEDURE DIVISION.
           DISPLAY "Llamando a SUMAR...".
           CALL "SUMAR" USING WS-NUM1 WS-NUM2 WS-RESULTADO.
           DISPLAY "Resultado: " WS-RESULTADO.
           STOP RUN.
```

### Subprograma (SUMAR.cbl)

```cobol
       >>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUMAR.
       
       DATA DIVISION.
       LINKAGE SECTION.
       01  LK-A        PIC 9(05).
       01  LK-B        PIC 9(05).
       01  LK-R        PIC 9(10).
       
       PROCEDURE DIVISION USING LK-A LK-B LK-R.
           COMPUTE LK-R = LK-A + LK-B.
           EXIT PROGRAM.
```

### Compilación

```bash
cobc -x -free PRINCIPAL.cbl SUMAR.cbl -o principal
./principal
# Resultado: 0000000150
```

> 📝 Ambos archivos se compilan juntos. GnuCOBOL detecta las dependencias automáticamente.

---

## 2. CALL Literal vs CALL Variable

### CALL literal (nombre fijo)

```cobol
           CALL "SUMAR" USING WS-A WS-B WS-R.
```

### CALL variable (nombre dinámico)

```cobol
       01  WS-SUBPROGRAMA PIC X(10) VALUE "SUMAR".
       
           IF WS-OPERACION = "+"
               MOVE "SUMAR" TO WS-SUBPROGRAMA
           ELSE
               MOVE "RESTAR" TO WS-SUBPROGRAMA
           END-IF.
           CALL WS-SUBPROGRAMA USING WS-A WS-B WS-R.
```

---

## 3. CANCEL — Liberar Subprograma

CANCEL descarga el subprograma de memoria. Útil para liberar recursos en programas largos:

```cobol
           CALL "REPORTE-DIARIO" USING WS-FECHA.
           CANCEL "REPORTE-DIARIO".    *> Libera memoria
```

Si vuelves a llamar después de CANCEL, COBOL lo recarga en su estado inicial (variables reinicializadas).

---

## 4. EXIT PROGRAM vs GOBACK

| Sentencia | Significado |
|-----------|-------------|
| `EXIT PROGRAM` | Retorna al programa llamador |
| `GOBACK` | Retorna al llamador (o termina si es el principal) |

```cobol
       PROCEDURE DIVISION USING LK-A LK-B LK-R.
           COMPUTE LK-R = LK-A + LK-B.
           EXIT PROGRAM.
      *>  GOBACK también funciona
```

---

## 5. Pasar Parámetros entre Programas

### Programa principal

```cobol
           CALL "CALCULO" USING
               WS-MONTO
               WS-TASA
               WS-RESULTADO.
```

### Subprograma (debe coincidir)

```cobol
       DATA DIVISION.
       LINKAGE SECTION.
       01  LK-MONTO    PIC 9(07)V99.
       01  LK-TASA     PIC 9V99.
       01  LK-RESULTADO PIC 9(07)V99.
       
       PROCEDURE DIVISION USING LK-MONTO LK-TASA LK-RESULTADO.
```

> ⚠️ Los parámetros en CALL y PROCEDURE DIVISION USING deben coincidir en **cantidad, orden y tamaño**.

---

## 6. Buenas Prácticas

1. ✅ Prefijo `LK-` para parámetros en LINKAGE SECTION
2. ✅ Prefijos consistentes: `WS-` en WORKING-STORAGE, `LK-` en LINKAGE
3. ✅ Un subprograma = una responsabilidad (como una función)
4. ✅ Compilar con `-Wall` para detectar discrepancias de parámetros
5. ❌ No mezclar lógica de negocio con I/O en el mismo subprograma

---

## ✅ Checklist

- [ ] Escribir programa principal que llama a subprograma con CALL
- [ ] Declarar LINKAGE SECTION en el subprograma
- [ ] Pasar parámetros con CALL ... USING
- [ ] Compilar múltiples archivos juntos
- [ ] Usar CANCEL para liberar subprogramas

## 📚 Recursos

- [GnuCOBOL CALL Statement](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#CALL)
- [IBM COBOL CALL Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-call-statement)
