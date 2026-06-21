# Rendimiento y Archivos Temporales de SORT

## 🎯 Objetivos

- Configurar archivos de trabajo para SORT (SORTWK)
- Optimizar ordenamiento de grandes volúmenes
- Comprender límites de memoria
- Elegir entre SORT interno y externo

---

## 1. ¿Dónde se Almacenan los Datos Durante el SORT?

GnuCOBOL usa archivos temporales para el sort. Por defecto se crean en el directorio actual con nombres como `sortwork.tmp`.

```bash
# Después de ejecutar un SORT, verifica:
ls -la sortwork*
# sortwork.tmp  (desaparece al terminar)
```

---

## 2. Archivos SORTWK (Sort Work Files)

Para grandes volúmenes, puedes especificar múltiples archivos de trabajo:

```cobol
       FILE-CONTROL.
           SELECT SORT-WK1 ASSIGN TO "sortwk01.tmp".
           SELECT SORT-WK2 ASSIGN TO "sortwk02.tmp".
           SELECT SORT-WK3 ASSIGN TO "sortwk03.tmp".
       
      *> En Linux, puedes usar ramdisk para mejor rendimiento:
      *> SELECT SORT-WK1 ASSIGN TO "/dev/shm/sortwk01.tmp".
```

### ¿Cuántos SORTWK necesitas?

| Volumen de datos | Archivos SORTWK |
|-----------------|-----------------|
| < 1M registros | 1 (default) |
| 1M - 10M | 2-3 |
| > 10M | 4-6 |

---

## 3. Memoria vs Disco

GnuCOBOL intenta ordenar en memoria. Si los datos no caben, usa archivos temporales:

```bash
# Aumentar memoria disponible para el proceso
ulimit -m 1048576    # 1 GB

# Ejecutar con más memoria
COB_SORT_MEMORY=500M cobc -x -free programa.cbl
```

### Señales de que necesitas más memoria

- El SORT tarda mucho más de lo esperado
- Ves archivos `sortwork*` crecer y decrecer
- Alto uso de disco durante la ejecución

---

## 4. Estrategias de Optimización

### Filtrar antes de ordenar (INPUT PROCEDURE)

```cobol
      *> ❌ Mal: ordenar TODO y luego filtrar
           SORT SORT-WK ... USING ENTRADA GIVING TEMP.
           *> Luego leer TEMP y filtrar...
       
      *> ✅ Bien: filtrar en INPUT PROCEDURE
           SORT SORT-WK ...
               INPUT PROCEDURE IS FILTRAR-Y-ORDENAR
               GIVING SALIDA.
      *> Solo los registros que pasan el filtro se ordenan
```

### Ordenar solo los campos necesarios

```cobol
      *> ❌ Mal: SD con registro completo de 500 bytes
       SD  SORT-WK.
       01  SORT-REG  PIC X(500).       *> 500 bytes por registro
       
      *> ✅ Bien: SD solo con clave + puntero
       SD  SORT-WK.
       01  SORT-REG.
           05 SORT-CLAVE  PIC 9(05).   *> Solo 5 bytes
           05 SORT-RESTO   PIC X(495). *> El resto
```

---

## 5. SORT Interno (En Memoria) con Tablas OCCURS

Para volúmenes pequeños, cargar en tabla OCCURS y ordenar manualmente puede ser más rápido:

```cobol
      *> Cargar en tabla
       01  WS-TABLA.
           05 WS-REG OCCURS 1000 TIMES
               INDEXED BY WS-IDX.
              10 WS-ID    PIC 9(05).
              10 WS-DATO  PIC X(50).
       
      *> Ordenar con algoritmo de burbuja (solo para pocos registros)
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > WS-CANT
               PERFORM VARYING WS-J FROM WS-I BY 1
                       UNTIL WS-J > WS-CANT
                   IF WS-ID(WS-J) < WS-ID(WS-I)
                       MOVE WS-REG(WS-I) TO WS-TEMP
                       MOVE WS-REG(WS-J) TO WS-REG(WS-I)
                       MOVE WS-TEMP TO WS-REG(WS-J)
                   END-IF
               END-PERFORM
           END-PERFORM.
```

> ⚠️ Solo para tablas pequeñas (< 1000 registros). Para más, usa SORT nativo.

---

## 6. Recomendaciones

| Volumen | Estrategia |
|---------|------------|
| < 500 registros | Tabla OCCURS + ordenamiento manual |
| 500 - 100K | SORT con USING/GIVING |
| 100K - 1M | SORT con INPUT PROCEDURE (filtrar antes) |
| > 1M | SORT con múltiples SORTWK |

---

## ✅ Checklist

- [ ] Usar SORT nativo para > 500 registros
- [ ] Filtrar con INPUT PROCEDURE antes de ordenar
- [ ] Configurar múltiples SORTWK para grandes volúmenes
- [ ] Considerar tabla OCCURS para volúmenes muy pequeños

## 📚 Recursos

- [GnuCOBOL SORT Performance](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#SORT)
- [IBM COBOL SORTWK](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-sort-statement)
