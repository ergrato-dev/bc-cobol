# INPUT PROCEDURE / OUTPUT PROCEDURE

## 🎯 Objetivos

- Procesar datos ANTES del sort con INPUT PROCEDURE
- Procesar datos DESPUÉS del sort con OUTPUT PROCEDURE
- Filtrar, transformar y validar durante el sort
- Combinar procedimientos con USING/GIVING

---

## 1. ¿Por Qué INPUT/OUTPUT PROCEDURE?

USING y GIVING son directos pero limitados: no puedes filtrar, validar ni transformar. INPUT/OUTPUT PROCEDURE te da control total.

```
                  INPUT PROCEDURE
ENTRADA ──→ [FILTRAR] ──→ [SORT] ──→ [FORMATEAR] ──→ SALIDA
                               ↑            ↑
                         ASCENDING KEY   OUTPUT PROCEDURE
```

---

## 2. INPUT PROCEDURE — Antes del Sort

Procesa cada registro ANTES de pasarlo al sort. Ideal para filtrar y validar.

```cobol
       PROCEDURE DIVISION.
           SORT SORT-WK
               ASCENDING KEY SORT-ID
               INPUT PROCEDURE IS 1000-FILTRAR
               GIVING SALIDA.
           STOP RUN.
       
       1000-FILTRAR.
           OPEN INPUT ENTRADA.
           PERFORM UNTIL ENT-EOF
               READ ENTRADA
                   AT END SET ENT-EOF TO TRUE
                   NOT AT END
                       IF ENT-SALDO > 10000       *> Solo saldos altos
                           MOVE ENT-REG TO SORT-REG
                           RELEASE SORT-REG        *> Enviar al sort
                       END-IF
               END-READ
           END-PERFORM.
           CLOSE ENTRADA.
```

### RELEASE — Enviar al Sort

```cobol
           RELEASE SORT-REG.     *> Envía el registro al proceso de sort
```

> 📝 RELEASE es como WRITE pero para el archivo SD. Solo se usa dentro de INPUT PROCEDURE.

---

## 3. OUTPUT PROCEDURE — Después del Sort

Procesa cada registro DESPUÉS de ordenarlo. Ideal para formatear y generar reportes.

```cobol
           SORT SORT-WK
               ASCENDING KEY SORT-ID
               USING ENTRADA
               OUTPUT PROCEDURE IS 2000-GENERAR-REPORTE.
           STOP RUN.
       
       2000-GENERAR-REPORTE.
           OPEN OUTPUT REPORTE.
           PERFORM UNTIL SORT-EOF
               RETURN SORT-WK                    *> Leer del sort
                   AT END SET SORT-EOF TO TRUE
                   NOT AT END
                       MOVE SORT-ID TO WS-LID
                       MOVE SORT-SALDO TO WS-LSALDO
                       WRITE REP-REG FROM WS-LINEA
               END-RETURN
           END-PERFORM.
           CLOSE REPORTE.
```

### RETURN — Leer del Sort

```cobol
           RETURN SORT-WK
               AT END ...
               NOT AT END ...
           END-RETURN.
```

> 📝 RETURN es como READ pero para el archivo SD ordenado. Solo se usa dentro de OUTPUT PROCEDURE.

---

## 4. INPUT + OUTPUT PROCEDURE Combinados

```cobol
           SORT SORT-WK
               DESCENDING KEY SORT-SALDO
               INPUT PROCEDURE IS 1000-FILTRAR
               OUTPUT PROCEDURE IS 2000-REPORTE.
```

### Flujo completo

```
1000-FILTRAR:
  READ entrada → validar → RELEASE sort-wk
  
[SORT ASCENDING KEY]

2000-REPORTE:
  RETURN sort-wk → formatear → WRITE reporte
```

---

## 5. Ejemplo Completo: Filtrar + Ordenar + Reporte

```cobol
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "Procesando...".
           SORT SORT-WK
               DESCENDING KEY SORT-SALDO
               INPUT PROCEDURE IS 1000-FILTRAR-VALIDAR
               OUTPUT PROCEDURE IS 2000-REPORTE-TOP.
           DISPLAY "Completado.".
           STOP RUN.
       
       1000-FILTRAR-VALIDAR.
           OPEN INPUT ENTRADA.
           PERFORM UNTIL ENT-EOF
               READ ENTRADA AT END SET ENT-EOF TO TRUE
                   NOT AT END
                       IF ENT-ESTADO = "A"           *> Solo activos
                           AND ENT-SALDO > 0          *> Con saldo positivo
                           MOVE ENT-REG TO SORT-REG
                           RELEASE SORT-REG
                           ADD 1 TO WS-CONT-FILT
                       END-IF
               END-READ
           END-PERFORM.
           CLOSE ENTRADA.
       
       2000-REPORTE-TOP.
           OPEN OUTPUT REPORTE.
           WRITE REP-REG FROM WS-ENCABEZADO.
           PERFORM UNTIL SORT-EOF
               RETURN SORT-WK
                   AT END SET SORT-EOF TO TRUE
                   NOT AT END
                       ADD 1 TO WS-CONT-REP
                       MOVE SORT-ID TO WS-LID
                       MOVE SORT-SALDO TO WS-LSALDO
                       WRITE REP-REG FROM WS-LINEA-DET
               END-RETURN
           END-PERFORM.
           WRITE REP-REG FROM WS-PIE.
           CLOSE REPORTE.
```

---

## ✅ Checklist

- [ ] Usar INPUT PROCEDURE para filtrar/validar antes del sort
- [ ] Usar RELEASE para enviar registros al sort
- [ ] Usar OUTPUT PROCEDURE para procesar después del sort
- [ ] Usar RETURN para leer registros ordenados
- [ ] Combinar INPUT + OUTPUT PROCEDURE en un mismo SORT

## 📚 Recursos

- [IBM COBOL RELEASE/RETURN](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-release-statement)
- [GnuCOBOL SORT with Procedures](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#SORT)
