# CICS Fundamentos — Introducción

## 🎯 Objetivos

- Comprender la arquitectura CICS y su rol en sistemas online
- Diferenciar procesamiento batch vs transaccional
- Identificar los componentes de una región CICS
- Conocer el flujo de una transacción

---

## 1. ¿Qué es CICS?

**CICS** (Customer Information Control System) es un monitor de teleproceso (TP monitor) de IBM. Maneja miles de transacciones online concurrentes desde terminales, cajeros automáticos y aplicaciones web.

```
┌─────────────────────────────────────────┐
│              REGIÓN CICS                │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐ │
│  │ Terminal │  │Programa │  │ Archivos│ │
│  │  3270    │→ │  COBOL  │→ │  VSAM   │ │
│  └─────────┘  └─────────┘  └─────────┘ │
│       ↑                          │      │
│       └────── Respuesta ─────────┘      │
└─────────────────────────────────────────┘
```

---

## 2. Batch vs Online (CICS)

| Característica | Batch (JCL) | Online (CICS) |
|---------------|-------------|---------------|
| Interacción | Sin usuario | Con usuario en tiempo real |
| Volumen | Millones de registros | Una transacción a la vez |
| Tiempo respuesta | Minutos/horas | Sub-segundo |
| Ejecución | Programada (nocturna) | 24/7 continua |
| Datos | Archivos secuenciales | VSAM o DB2 |
| Ejemplo | Cierre contable diario | Consulta de saldo en ATM |

---

## 3. Componentes de CICS

### Región CICS
Un espacio de ejecución que contiene programas, archivos y conexiones.

### Transacción (TRANSID)
Un código de 1-4 caracteres que el usuario ingresa para iniciar una función:

```
TRANSID: CSAL  →  Programa: CONSULTA  →  Pantalla: Consulta de Saldo
TRANSID: CTRA  →  Programa: TRANSFER  →  Pantalla: Transferencia
```

### Programa
El programa COBOL que se ejecuta. En CICS, los programas NO usan STOP RUN ni archivos secuenciales normales.

### Terminal (3270)
Pantalla de mainframe. CICS envía y recibe datos formateados (MAPS).

---

## 4. Flujo de una Transacción CICS

```
1. Usuario ingresa TRANSID en terminal
2. CICS recibe la solicitud
3. CICS busca el programa asociado al TRANSID
4. CICS carga el programa en memoria
5. El programa ejecuta EXEC CICS para:
   - RECEIVE MAP (leer datos del usuario)
   - READ FILE (consultar archivo VSAM)
   - SEND MAP (mostrar respuesta)
6. El programa retorna (RETURN TRANSID)
7. CICS muestra la pantalla al usuario
```

---

## 5. Características Clave

### Programas Reentrantes
Múltiples usuarios comparten la misma copia del programa en memoria. Por eso NO se usa WORKING-STORAGE para datos de usuario.

### Pseudo-Conversación
CICS "recuerda" el estado entre pantallas usando COMMAREA (Communication Area).

### EXEC CICS
En lugar de DISPLAY, ACCEPT, OPEN, READ normales, se usan comandos CICS:

```cobol
      *> En batch:
           DISPLAY "Hola".
           ACCEPT WS-NOMBRE.
       
      *> En CICS:
           EXEC CICS SEND TEXT
               FROM(WS-MENSAJE)
               LENGTH(20)
           END-EXEC.
```

---

## 6. Simulación en el Bootcamp

No tenemos un mainframe real con CICS. En este bootcamp simulamos el comportamiento de CICS con programas COBOL interactivos por terminal:

```cobol
      *> Simulación de EXEC CICS SEND TEXT
           DISPLAY WS-MENSAJE.
       
      *> Simulación de EXEC CICS RECEIVE MAP
           DISPLAY "Ingrese cuenta: " WITH NO ADVANCING.
           ACCEPT WS-CUENTA.
       
      *> Simulación de COMMAREA: variables en WORKING-STORAGE
      *> que mantienen estado entre iteraciones del PERFORM UNTIL
```

---

## ✅ Checklist

- [ ] Explicar la diferencia entre batch y online (CICS)
- [ ] Identificar los componentes de una región CICS
- [ ] Comprender el flujo: terminal → TRANSID → programa → pantalla
- [ ] Conocer que CICS usa EXEC CICS en lugar de verbos COBOL tradicionales

## 📚 Recursos

- [IBM CICS Documentation](https://www.ibm.com/docs/en/cics-ts)
- [CICS Introduction (IBM)](https://www.ibm.com/docs/en/cics-ts/6.1?topic=overview-introduction-cics)
