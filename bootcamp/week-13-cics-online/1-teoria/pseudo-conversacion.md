# Pseudo-Conversación y COMMAREA

## 🎯 Objetivos

- Comprender el concepto de pseudo-conversación
- Mantener estado entre pantallas con COMMAREA
- Implementar flujos multi-pantalla
- Usar RETURN TRANSID para encadenar transacciones

---

## 1. El Problema: CICS No Mantiene Estado

En CICS, cada transacción es independiente. El programa se carga, ejecuta y termina. No hay memoria entre una pantalla y la siguiente.

```
Pantalla 1 (ingresar cuenta) → Programa termina
Pantalla 2 (mostrar saldo)    → Programa se vuelve a cargar desde cero
                               → ¿Cómo sabe qué cuenta mostrar?
```

---

## 2. Solución: COMMAREA

La **COMMAREA** (Communication Area) es un bloque de memoria que CICS pasa entre transacciones. Permite "recordar" datos de una pantalla a otra.

```cobol
       LINKAGE SECTION.
       01  DFHCOMMAREA.
           COPY "COMMAREA.cpy".
```

### COPYBOOK de COMMAREA

```cobol
       01  WS-COMMAREA.
           05 CA-FUNCION       PIC X(01).
               88 CA-PRIMERA-VEZ   VALUE "1".
               88 CA-CONTINUAR     VALUE "2".
           05 CA-CUENTA        PIC 9(05).
           05 CA-NOMBRE        PIC X(30).
           05 CA-SALDO         PIC S9(07)V99.
```

---

## 3. Flujo de Pseudo-Conversación

```
USUARIO → TRANSID → PROGRAMA → RETURN TRANSID('MENU') COMMAREA(...)
  ↑                                                    ↓
  └────────────←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←←┘
  CICS guarda la COMMAREA y se la pasa al programa
  en la siguiente invocación
```

---

## 4. RETURN TRANSID

```cobol
      *> Primera pantalla: solicitar cuenta
           MOVE WS-CUENTA TO DFHCOMMAREA.
           EXEC CICS RETURN
               TRANSID("CSAL")
               COMMAREA(DFHCOMMAREA)
               LENGTH(50)
           END-EXEC.
       
      *> Segunda pantalla: mostrar saldo
      *> (mismo TRANSID, CICS invoca de nuevo el programa)
           IF CA-PRIMERA-VEZ
               MOVE "2" TO CA-FUNCION
               PERFORM 2000-MOSTRAR-MENU
           ELSE
               PERFORM 3000-CONSULTAR-SALDO
           END-IF.
```

---

## 5. Patrón: Programa con Estados

```cobol
       PROCEDURE DIVISION.
           EXEC CICS ADDRESS COMMAREA(WS-COMMAREA) END-EXEC.
           
           EVALUATE CA-FUNCION
               WHEN "1"     *> Estado inicial: mostrar menú
                   PERFORM 1000-MENU-PRINCIPAL
               WHEN "2"     *> Estado: ingresar cuenta
                   PERFORM 2000-CAPTURAR-CUENTA
               WHEN "3"     *> Estado: mostrar saldo
                   PERFORM 3000-MOSTRAR-SALDO
               WHEN "4"     *> Estado: confirmar operación
                   PERFORM 4000-CONFIRMAR
           END-EVALUATE.
```

---

## 6. Simulación en Linux

Sin CICS real, simulamos COMMAREA con variables en WORKING-STORAGE y un loop PERFORM UNTIL:

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Simulación de COMMAREA: estado entre iteraciones
       01  WS-ESTADO         PIC X(01) VALUE "1".
           88 ESTADO-MENU    VALUE "1".
           88 ESTADO-CONSULTA VALUE "2".
           88 ESTADO-RESULT   VALUE "3".
       01  WS-CUENTA         PIC 9(05) VALUE ZEROS.
       01  WS-NOMBRE         PIC X(30) VALUE SPACES.
       
       PROCEDURE DIVISION.
           PERFORM UNTIL WS-SALIR
               EVALUATE TRUE
                   WHEN ESTADO-MENU
                       PERFORM 1000-MOSTRAR-MENU
                   WHEN ESTADO-CONSULTA
                       PERFORM 2000-CAPTURAR-CUENTA
                   WHEN ESTADO-RESULT
                       PERFORM 3000-MOSTRAR-RESULTADO
               END-EVALUATE
           END-PERFORM.
```

La pseudo-conversación se simula con variables de estado que persisten entre iteraciones del loop.

---

## ✅ Checklist

- [ ] Explicar por qué CICS necesita COMMAREA
- [ ] Implementar estados con variable de control
- [ ] Usar RETURN TRANSID para encadenar pantallas
- [ ] Simular pseudo-conversación con PERFORM UNTIL + variable de estado

## 📚 Recursos

- [IBM CICS Pseudo-Conversation](https://www.ibm.com/docs/en/cics-ts/6.1?topic=design-pseudoconversational-transactions)
- [IBM CICS COMMAREA](https://www.ibm.com/docs/en/cics-ts/6.1?topic=programming-communication-area)
