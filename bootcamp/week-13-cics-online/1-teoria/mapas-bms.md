# MAPS y BMS — Basic Mapping Support

## 🎯 Objetivos

- Comprender el concepto de MAPS en CICS
- Definir campos de entrada y salida en un MAP
- Usar BMS para diseño de pantalla
- Simular MAPS con pantallas de texto COBOL

---

## 1. ¿Qué es un MAP?

Un MAP es la definición de una pantalla 3270. Define qué campos se muestran (salida) y cuáles aceptan entrada del usuario.

```
┌──────────────────────────────────────┐
│  SISTEMA BANCARIO        HH:MM:SS    │ ← Campo de salida (literal)
│                                      │
│  Cuenta: [________]                  │ ← Campo de entrada (input)
│  Nombre: Juan Perez                  │ ← Campo de salida (datos)
│  Saldo:  $ 15,000.50                 │ ← Campo de salida (datos)
│                                      │
│  F3=Salir                            │ ← PF key
└──────────────────────────────────────┘
```

---

## 2. BMS (Basic Mapping Support)

BMS es el lenguaje para definir mapas. Genera:

- **Mapa físico** (DSECT): layout de memoria con los campos
- **Mapa simbólico** (COPYBOOK): definiciones COBOL para acceder a los campos

### Ejemplo de definición BMS (ensamblador)

```
MAP001  DFHMSD TYPE=MAP,MODE=INOUT,CTRL=FREEKB,LANG=COBOL
TITULO  DFHMDF POS=(1,20),LENGTH=30,ATTR=PROT
        DFHMDF POS=(3,1),LENGTH=08,ATTR=NORM
        DFHMDF POS=(3,10),LENGTH=20,ATTR=UNPROT,IC
        DFHMSD TYPE=FINAL
```

Esto genera un COPYBOOK que en COBOL se usa así:

```cobol
      *> COPYBOOK generado por BMS
       01  MAP001I.               *> Input del mapa
           05 CUENTAI      PIC X(08).   *> Campo de entrada
       
       01  MAP001O.               *> Output del mapa
           05 FILLER       PIC X(80).   *> Atributos
           05 TITULOO      PIC X(30).
           05 CUENTAO      PIC X(08).
```

---

## 3. SEND MAP (Mostrar Pantalla)

```cobol
      *> Enviar mapa al terminal
           EXEC CICS SEND MAP
               MAP("CONSULTA")
               MAPSET("BANCO")
               FROM(MAP001O)
               ERASE
           END-EXEC.
```

### Inicializar campos de salida antes de SEND

```cobol
           MOVE "SISTEMA BANCARIO" TO TITULOO.
           MOVE WS-CUENTA TO CUENTAO.
       
           EXEC CICS SEND MAP("CONSULTA") MAPSET("BANCO")
               FROM(MAP001O) ERASE END-EXEC.
```

---

## 4. RECEIVE MAP (Leer Entrada)

```cobol
           EXEC CICS RECEIVE MAP
               MAP("CONSULTA")
               MAPSET("BANCO")
               INTO(MAP001I)
               RESP(WS-CICS-RESP)
           END-EXEC.
       
           IF CICS-OK
               MOVE CUENTAI TO WS-NUM-CUENTA
           END-IF.
```

### Atención: El usuario puede no ingresar datos

```cobol
           IF CICS-MAPFAIL
               MOVE ZEROS TO WS-NUM-CUENTA   *> Valor default
           END-IF.
```

---

## 5. Atributos de Campo

| Atributo | Significado |
|----------|-------------|
| `PROT` | Protegido (solo lectura, no modificable) |
| `UNPROT` | No protegido (el usuario puede escribir) |
| `NUM` | Solo dígitos numéricos |
| `BRT` | Brillante (highlight) |
| `NORM` | Intensidad normal |
| `DRK` | Oscuro (no visible) |
| `IC` | Insertar cursor aquí |

---

## 6. Simulación en Linux

Como no tenemos BMS ni terminal 3270, simulamos con DISPLAY y líneas de caracteres:

```cobol
      *> Simulación de SEND MAP
       ENVIAR-PANTALLA.
           DISPLAY "╔══════════════════════════════════════╗".
           DISPLAY "║     SISTEMA BANCARIO               ║".
           DISPLAY "╠══════════════════════════════════════╣".
           DISPLAY "║                                      ║".
           MOVE SPACES TO WS-LINEA-PANTALLA.
           STRING "║ Cuenta: " WS-CUENTA-EDIT
               INTO WS-LINEA-PANTALLA.
           DISPLAY WS-LINEA-PANTALLA.
           DISPLAY "║ Nombre: " WS-NOMBRE.
           DISPLAY "║ Saldo : " WS-SALDO-EDIT.
           DISPLAY "╚══════════════════════════════════════╝".
       
      *> Simulación de RECEIVE MAP
       RECIBIR-DATOS.
           DISPLAY " ".
           DISPLAY "Ingrese numero de cuenta: " WITH NO ADVANCING.
           ACCEPT WS-CUENTA.
```

---

## ✅ Checklist

- [ ] Comprender la estructura de un MAP: campos de entrada y salida
- [ ] Simular SEND MAP con DISPLAY formateado
- [ ] Simular RECEIVE MAP con ACCEPT
- [ ] Mantener campos protegidos (solo lectura) vs no protegidos

## 📚 Recursos

- [IBM CICS BMS Reference](https://www.ibm.com/docs/en/cics-ts/6.1?topic=programming-basic-mapping-support)
- [IBM 3270 Data Stream](https://www.ibm.com/docs/en/cics-ts/6.1?topic=displays-3270-data-streams)
