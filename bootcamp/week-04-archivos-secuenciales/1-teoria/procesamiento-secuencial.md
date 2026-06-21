# Procesamiento Secuencial — Patrones

## 🎯 Objetivos

- Dominar patrones de procesamiento secuencial
- Leer archivos hasta EOF con PERFORM UNTIL
- Filtrar, transformar y acumular datos de archivos
- Diseñar programas batch eficientes

---

## 1. Patrón Básico: Leer y Mostrar

El patrón más simple: abrir, leer registro por registro, mostrar, cerrar.

```cobol
       OPEN INPUT ARCHIVO.
       PERFORM UNTIL EOF
           READ ARCHIVO
               AT END SET EOF TO TRUE
               NOT AT END
                   DISPLAY REGISTRO
           END-READ
       END-PERFORM.
       CLOSE ARCHIVO.
```

---

## 2. Patrón: Copiar Archivo (Filtro Identidad)

Leer de entrada, escribir en salida sin modificar.

```cobol
       OPEN INPUT ENTRADA.
       OPEN OUTPUT SALIDA.
       
       PERFORM UNTIL ENT-EOF
           READ ENTRADA
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   WRITE SAL-REG FROM ENT-REG
                   ADD 1 TO WS-CONT
           END-READ
       END-PERFORM.
       
       CLOSE ENTRADA.
       CLOSE SALIDA.
       DISPLAY "Copiados: " WS-CONT " registros".
```

---

## 3. Patrón: Filtrar Registros

Solo copiar registros que cumplan una condición.

```cobol
       PERFORM UNTIL ENT-EOF
           READ ENTRADA
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   IF CLI-SALDO > 10000             *> Solo saldos altos
                       WRITE SAL-REG FROM ENT-REG
                       ADD 1 TO WS-CONT
                   END-IF
           END-READ
       END-PERFORM.
```

---

## 4. Patrón: Transformar Datos

Leer, modificar campos, escribir transformado.

```cobol
       PERFORM UNTIL ENT-EOF
           READ ENTRADA
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   COMPUTE SAL-NUEVO =
                       CLI-SALDO * (1 + WS-TASA / 100)  *> Aplicar interés
                   MOVE CLI-ID TO SAL-ID
                   MOVE CLI-NOMBRE TO SAL-NOMBRE
                   MOVE SAL-NUEVO TO SAL-SALDO
                   WRITE SAL-REG
           END-READ
       END-PERFORM.
```

---

## 5. Patrón: Acumular y Consolidar

Leer todo el archivo, acumular totales, mostrar resumen.

```cobol
       MOVE ZEROS TO WS-TOTAL-SALDOS.
       MOVE ZEROS TO WS-CONT-REG.
       
       PERFORM UNTIL ENT-EOF
           READ ENTRADA
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   ADD 1 TO WS-CONT-REG
                   ADD CLI-SALDO TO WS-TOTAL-SALDOS
           END-READ
       END-PERFORM.
       
       COMPUTE WS-PROMEDIO = WS-TOTAL-SALDOS / WS-CONT-REG.
       DISPLAY "Total registros : " WS-CONT-REG.
       DISPLAY "Total saldos    : " WS-TOTAL-SALDOS.
       DISPLAY "Promedio saldo  : " WS-PROMEDIO.
```

---

## 6. Patrón: Archivo de Control + Maestro

Procesar un archivo de transacciones contra un archivo maestro:

```cobol
       OPEN INPUT MAESTRO-FILE.
       OPEN INPUT TRANSACCIONES-FILE.
       OPEN OUTPUT NUEVO-MAESTRO-FILE.
       
       PERFORM UNTIL MAE-EOF AND TRANS-EOF
           IF MAE-ID = TRANS-ID
               COMPUTE MAE-SALDO = MAE-SALDO + TRANS-MONTO
               WRITE NUEVO-REG FROM MAE-REG
               READ TRANSACCIONES-FILE...
               READ MAESTRO-FILE...
           ELSE
               IF MAE-ID < TRANS-ID
                   WRITE NUEVO-REG FROM MAE-REG
                   READ MAESTRO-FILE...
               ELSE
                   DISPLAY "Transaccion huerfana: " TRANS-ID
                   READ TRANSACCIONES-FILE...
               END-IF
           END-IF
       END-PERFORM.
       
       CLOSE MAESTRO-FILE.
       CLOSE TRANSACCIONES-FILE.
       CLOSE NUEVO-MAESTRO-FILE.
```

> 📝 Este patrón (matching de archivos ordenados) es el corazón del procesamiento batch bancario. Lo veremos en detalle en semanas avanzadas.

---

## 7. Patrón: Reporte con Encabezado y Pie

```cobol
       OPEN INPUT DATOS-FILE.
       OPEN OUTPUT REPORTE-FILE.
       
      *> Encabezado
       WRITE REPORTE-REG FROM WS-ENCABEZADO.
       WRITE REPORTE-REG FROM WS-SEPARADOR.
       
      *> Detalle
       PERFORM UNTIL EOF
           READ DATOS-FILE
               AT END SET EOF TO TRUE
               NOT AT END
                   WRITE REPORTE-REG FROM CLI-REG
                   ADD CLI-SALDO TO WS-TOTAL
           END-READ
       END-PERFORM.
       
      *> Pie
       WRITE REPORTE-REG FROM WS-SEPARADOR.
       WRITE REPORTE-REG FROM WS-LINEA-TOTAL.
       
       CLOSE DATOS-FILE.
       CLOSE REPORTE-FILE.
```

---

## ✅ Checklist

- [ ] Implementar lectura secuencial con PERFORM UNTIL EOF
- [ ] Filtrar registros por condición
- [ ] Transformar datos antes de escribir
- [ ] Acumular totales de todo el archivo
- [ ] Generar reporte con encabezado, detalle y pie

## 📚 Recursos

- [GnuCOBOL File Processing](https://gnucobol.sourceforge.io/HTML/gnucobpg.html)
- [IBM COBOL File Processing](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-processing-sequential)
