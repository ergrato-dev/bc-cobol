# PERFORM — Ejecución de Párrafos

## 🎯 Objetivos

- Llamar párrafos con PERFORM
- Iterar con PERFORM TIMES, UNTIL, VARYING
- Organizar código en párrafos reutilizables
- Comprender el flujo de control con PERFORM THRU

---

## 1. PERFORM Simple (Llamar un Párrafo)

```cobol
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "Inicio del programa".
           PERFORM 2000-PROCESAR.
           PERFORM 3000-FINALIZAR.
           STOP RUN.
       
       2000-PROCESAR.
           DISPLAY "Procesando...".
       
       3000-FINALIZAR.
           DISPLAY "Programa terminado".
```

El flujo: MAIN → PERFORM → párrafo → retorna a MAIN → siguiente instrucción.

---

## 2. PERFORM TIMES (Repetir N Veces)

```cobol
           PERFORM 2000-MOSTRAR 5 TIMES.
       
       2000-MOSTRAR.
           DISPLAY "Iteracion: " WS-CONTADOR.
           ADD 1 TO WS-CONTADOR.
```

Salida:
```
Iteracion: 0
Iteracion: 1
Iteracion: 2
Iteracion: 3
Iteracion: 4
```

> 📝 La variable en TIMES debe ser entera. Si usas una variable, su valor se evalúa al inicio.

---

## 3. PERFORM UNTIL (Repetir Hasta Condición)

```cobol
      *> El chequeo se hace ANTES de ejecutar el párrafo
           PERFORM 2000-LEER UNTIL WS-CONTADOR > 10.
       
      *> Con EXIT (salida anticipada)
           PERFORM 2000-BUSCAR
               VARYING WS-I FROM 1 BY 1
               UNTIL WS-I > 100 OR WS-ENCONTRADO.
```

> ⚠️ PERFORM UNTIL evalúa la condición **antes** de ejecutar. Si es verdadera desde el inicio, no ejecuta ninguna vez.

### PERFORM WITH TEST AFTER (Do-While)

```cobol
      *> Ejecuta al menos UNA vez, luego evalúa
           PERFORM WITH TEST AFTER UNTIL WS-FIN = "S"
               DISPLAY "Ingrese datos"
               ACCEPT WS-DATO
               IF WS-DATO = "FIN"
                   MOVE "S" TO WS-FIN
               END-IF
           END-PERFORM.
```

---

## 4. PERFORM VARYING (For Loop)

```cobol
      *> VARYING variable FROM inicio BY incremento UNTIL condicion
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 10
               COMPUTE WS-CUADRADO = WS-I ** 2
               DISPLAY WS-I " al cuadrado = " WS-CUADRADO
           END-PERFORM.
```

Salida:
```
1 al cuadrado = 1
2 al cuadrado = 4
...
10 al cuadrado = 100
```

### Contador regresivo

```cobol
           PERFORM VARYING WS-I FROM 10 BY -1 UNTIL WS-I = 0
               DISPLAY "Cuenta regresiva: " WS-I
           END-PERFORM.
```

### PERFORM VARYING anidado (tablas 2D)

```cobol
           PERFORM VARYING WS-FILA FROM 1 BY 1 UNTIL WS-FILA > 5
               PERFORM VARYING WS-COL FROM 1 BY 1 UNTIL WS-COL > 3
                   DISPLAY "Celda[" WS-FILA "][" WS-COL "]"
               END-PERFORM
           END-PERFORM.
```

---

## 5. PERFORM THRU (Ejecutar Rango de Párrafos)

```cobol
           PERFORM 1000-INICIO THRU 1000-FIN.
       
       1000-INICIO.
           DISPLAY "Paso 1".
       1000-MEDIO.
           DISPLAY "Paso 2".
       1000-FIN.
           DISPLAY "Paso 3".
       
       2000-SIGUIENTE.
           DISPLAY "Esto NO se ejecuta con PERFORM THRU".
```

Ejecuta todos los párrafos desde INICIO hasta FIN (inclusive), en orden de aparición.

---

## 6. PERFORM ... END-PERFORM (Inline)

Equivalente a PERFORM de un párrafo, pero el código va directamente:

```cobol
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 5
               DISPLAY "Iteracion: " WS-I
               COMPUTE WS-DOBLE = WS-I * 2
               DISPLAY "Doble    : " WS-DOBLE
           END-PERFORM.
```

---

## 7. EXIT PERFORM (Salir Anticipadamente)

```cobol
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 1000
               IF WS-TABLA(WS-I) = WS-BUSCADO
                   DISPLAY "Encontrado en posicion " WS-I
                   EXIT PERFORM
               END-IF
           END-PERFORM.
```

---

## 8. Buenas Prácticas

1. ✅ Un párrafo = una responsabilidad (como una función)
2. ✅ Nombres descriptivos: `2000-CALCULAR-INTERES`, `3000-GENERAR-REPORTE`
3. ✅ Prefijos numéricos opcionales: `1000-`, `2000-`, `9000-` para errores
4. ✅ PERFORM anidado máximo 3 niveles (si es más profundo, extrae a otro párrafo)
5. ❌ No uses GO TO (obsoleto, rompe la estructura)

```cobol
      *> ✅ BIEN: estructura organizada
       MAIN.
           PERFORM 1000-INICIO.
           PERFORM 2000-PROCESO UNTIL EOF.
           PERFORM 9000-FINAL.
           STOP RUN.
       
      *> ❌ MAL: GO TO (no usar)
       MAIN.
           GO TO 2000-PROCESO.
```

---

## ✅ Checklist

- [ ] Llamar un párrafo con PERFORM simple
- [ ] Repetir N veces con PERFORM TIMES
- [ ] Iterar con condición con PERFORM UNTIL
- [ ] Usar PERFORM VARYING como for loop
- [ ] Anidar PERFORM para recorrer tablas 2D
- [ ] Usar EXIT PERFORM para salida anticipada

## 📚 Recursos

- [GnuCOBOL PERFORM Statement](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#PERFORM)
- [IBM COBOL PERFORM Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-perform-statement)
