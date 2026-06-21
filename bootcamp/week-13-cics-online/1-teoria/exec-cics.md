# EXEC CICS — Comandos Básicos

## 🎯 Objetivos

- Escribir comandos CICS con EXEC CICS ... END-EXEC
- Enviar y recibir datos de pantalla
- Manejar errores con RESP y RESP2
- Comprender la diferencia con COBOL batch

---

## 1. Sintaxis de EXEC CICS

```cobol
       EXEC CICS
           comando opcion(valor) opcion(valor) ...
       END-EXEC.
```

| Comando | Propósito |
|---------|-----------|
| `SEND TEXT` | Enviar texto simple a la terminal |
| `SEND MAP` | Enviar pantalla formateada (BMS map) |
| `RECEIVE MAP` | Recibir datos ingresados por el usuario |
| `READ FILE` | Leer registro de archivo VSAM |
| `WRITE FILE` | Escribir registro en archivo VSAM |
| `DELETE FILE` | Eliminar registro de archivo VSAM |
| `REWRITE FILE` | Actualizar registro VSAM |
| `RETURN` | Terminar transacción y pasar control |
| `LINK` | Llamar a otro programa CICS |
| `STARTBR` | Iniciar navegación (browse) en archivo |
| `READNEXT` | Leer siguiente registro en navegación |

---

## 2. SEND TEXT — Mensaje Simple

```cobol
       01  WS-MENSAJE    PIC X(50) VALUE "Bienvenido al sistema bancario".
       
           EXEC CICS SEND TEXT
               FROM(WS-MENSAJE)
               LENGTH(50)
               ERASE
           END-EXEC.
```

| Opción | Significado |
|--------|-------------|
| `FROM` | Variable que contiene el texto |
| `LENGTH` | Longitud del texto a enviar |
| `ERASE` | Limpiar pantalla antes de mostrar |

---

## 3. SEND MAP — Pantalla Formateada

Envía un MAP (pantalla con campos definidos) al terminal:

```cobol
           EXEC CICS SEND MAP
               MAP("PANTALLA")
               MAPSET("BANCO")
               ERASE
           END-EXEC.
```

| Opción | Significado |
|--------|-------------|
| `MAP` | Nombre del mapa (definido en BMS) |
| `MAPSET` | Conjunto de mapas (librería BMS) |
| `FROM` | Datos para inicializar campos del mapa |
| `ERASE` | Limpiar pantalla anterior |

---

## 4. RECEIVE MAP — Leer Datos del Usuario

```cobol
           EXEC CICS RECEIVE MAP
               MAP("PANTALLA")
               MAPSET("BANCO")
               INTO(WS-DATOS-PANTALLA)
               RESP(WS-CICS-RESP)
           END-EXEC.
```

| Opción | Significado |
|--------|-------------|
| `INTO` | Variable donde se reciben los datos |
| `RESP` | Código de respuesta (0=OK) |
| `MAP` | Nombre del mapa recibido |

---

## 5. RESP y RESP2 — Manejo de Errores

```cobol
       01  WS-CICS-RESP    PIC S9(08) USAGE COMP.
           88 CICS-OK       VALUE DFHRESP(NORMAL).
           88 CICS-MAPFAIL  VALUE DFHRESP(MAPFAIL).
           88 CICS-NOTFND   VALUE DFHRESP(NOTFND).
       
           EXEC CICS READ FILE("CUENTAS")
               INTO(WS-CUENTA)
               RIDFLD(WS-ID-CUENTA)
               RESP(WS-CICS-RESP)
           END-EXEC.
           
           EVALUATE TRUE
               WHEN CICS-OK
                   CONTINUE
               WHEN CICS-NOTFND
                   DISPLAY "Registro no encontrado"
               WHEN OTHER
                   DISPLAY "Error CICS: " WS-CICS-RESP
           END-EVALUATE.
```

### RESP Comunes

| DFHRESP | Significado |
|---------|-------------|
| `NORMAL` | Operación exitosa |
| `NOTFND` | Registro no encontrado |
| `MAPFAIL` | No se recibieron datos del mapa |
| `DUPREC` | Registro duplicado |
| `NOSPACE` | Sin espacio en archivo |
| `SYSIDERR` | Error de sistema |

---

## 6. Comparativa: Batch vs CICS

```cobol
      *> ============ BATCH ============
           DISPLAY "Ingrese ID:".
           ACCEPT WS-ID.
           OPEN INPUT CLIENTES.
           READ CLIENTES ...
           DISPLAY CLI-NOMBRE.
           CLOSE CLIENTES.
       
      *> ============ CICS ============
           EXEC CICS SEND MAP("MENU") MAPSET("BANCO") ERASE END-EXEC.
           EXEC CICS RECEIVE MAP("MENU") MAPSET("BANCO")
               INTO(WS-DATOS) END-EXEC.
           EXEC CICS READ FILE("CLIENTES")
               INTO(WS-CLIENTE) RIDFLD(WS-ID) END-EXEC.
           EXEC CICS SEND MAP("RESULT") MAPSET("BANCO")
               FROM(WS-CLIENTE) END-EXEC.
```

---

## ✅ Checklist

- [ ] Usar EXEC CICS SEND TEXT para mensajes simples
- [ ] Usar EXEC CICS RECEIVE MAP para leer entrada
- [ ] Verificar RESP después de cada comando CICS
- [ ] Simular EXEC CICS con DISPLAY/ACCEPT en Linux

## 📚 Recursos

- [IBM CICS Command Reference](https://www.ibm.com/docs/en/cics-ts/6.1?topic=reference-cics-commands)
- [IBM CICS Application Programming](https://www.ibm.com/docs/en/cics-ts/6.1?topic=programming-cics-application)
