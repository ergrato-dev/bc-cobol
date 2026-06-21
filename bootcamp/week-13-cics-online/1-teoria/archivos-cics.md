# Archivos en CICS — Operaciones VSAM

## 🎯 Objetivos

- Leer archivos desde CICS (READ, STARTBR, READNEXT)
- Escribir y actualizar registros (WRITE, REWRITE)
- Eliminar registros (DELETE)
- Manejar archivos VSAM en entorno transaccional

---

## 1. Archivos en CICS

En CICS, los archivos son **VSAM** (Virtual Storage Access Method). A diferencia de batch, no se usa OPEN/CLOSE: los archivos ya están abiertos por CICS.

```cobol
      *> Batch: OPEN, READ, CLOSE (secuencial)
      *> CICS:  READ FILE directo (aleatorio por clave)
```

### Declaración en el programa

Los archivos se declaran en FILE-CONTROL igual que en batch, pero CICS los maneja de forma diferente:

```cobol
       FILE-CONTROL.
           SELECT CUENTAS ASSIGN TO CUENTAS
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS CTA-ID
               FILE STATUS IS WS-FS-CTA.
```

---

## 2. READ FILE — Lectura Directa por Clave

```cobol
           EXEC CICS READ FILE("CUENTAS")
               INTO(WS-CUENTA-REG)
               RIDFLD(WS-ID-CUENTA)
               RESP(WS-CICS-RESP)
           END-EXEC.
           
           IF CICS-OK
               DISPLAY "Nombre: " CTA-NOMBRE
           END-IF.
           IF CICS-NOTFND
               DISPLAY "Cuenta no encontrada"
           END-IF.
```

### Opciones de READ FILE

| Opción | Significado |
|--------|-------------|
| `INTO` | Variable donde se copia el registro |
| `SET` | Puntero al registro (más rápido) |
| `RIDFLD` | Record Identification Field (clave) |
| `UPDATE` | Leer con intención de modificar (luego REWRITE) |

---

## 3. READ con UPDATE + REWRITE

```cobol
      *> Leer con intención de modificar
           EXEC CICS READ FILE("CUENTAS")
               INTO(WS-CUENTA-REG)
               RIDFLD(WS-ID-CUENTA)
               UPDATE
               RESP(WS-CICS-RESP)
           END-EXEC.
       
      *> Modificar datos
           IF CICS-OK
               COMPUTE CTA-SALDO = CTA-SALDO - WS-MONTO.
       
      *> Regrabar desde la variable modificada
               EXEC CICS REWRITE FILE("CUENTAS")
                   FROM(WS-CUENTA-REG)
                   RESP(WS-CICS-RESP)
               END-EXEC.
           END-IF.
```

> ⚠️ UPDATE bloquea el registro. Otros usuarios no pueden modificarlo hasta que hagas REWRITE o UNLOCK.

---

## 4. WRITE FILE — Insertar Nuevo Registro

```cobol
           MOVE WS-NUEVO-ID TO CTA-ID.
           MOVE WS-NOMBRE TO CTA-NOMBRE.
           MOVE ZEROS TO CTA-SALDO.
       
           EXEC CICS WRITE FILE("CUENTAS")
               FROM(WS-CUENTA-REG)
               RIDFLD(CTA-ID)
               RESP(WS-CICS-RESP)
           END-EXEC.
           
           IF CICS-DUPREC
               DISPLAY "ERROR: Cuenta ya existe"
           END-IF.
```

---

## 5. DELETE FILE — Eliminar Registro

```cobol
           EXEC CICS DELETE FILE("CUENTAS")
               RIDFLD(WS-ID-ELIMINAR)
               RESP(WS-CICS-RESP)
           END-EXEC.
```

---

## 6. STARTBR / READNEXT — Navegación Secuencial

Para recorrer varios registros en orden (browse):

```cobol
      *> Iniciar navegación desde ID 100
           MOVE 100 TO WS-ID.
           EXEC CICS STARTBR FILE("CUENTAS")
               RIDFLD(WS-ID)
               RESP(WS-CICS-RESP)
           END-EXEC.
       
      *> Leer siguiente
           PERFORM UNTIL WS-CICS-RESP = DFHRESP(ENDFILE)
               EXEC CICS READNEXT FILE("CUENTAS")
                   INTO(WS-CUENTA-REG)
                   RIDFLD(WS-ID)
                   RESP(WS-CICS-RESP)
               END-EXEC
               IF CICS-OK
                   DISPLAY WS-ID " " CTA-NOMBRE
               END-IF
           END-PERFORM.
       
      *> Finalizar navegación
           EXEC CICS ENDBR FILE("CUENTAS") END-EXEC.
```

---

## 7. Simulación en Linux

En nuestro entorno, los archivos indexados de COBOL simulan el acceso VSAM:

```cobol
      *> Simulación de READ FILE ... RIDFLD
           OPEN I-O CUENTAS.
           READ CUENTAS KEY IS WS-ID
               INVALID KEY DISPLAY "No encontrado"
               NOT INVALID KEY DISPLAY CTA-NOMBRE
           END-READ.
       
      *> Simulación de STARTBR + READNEXT
           START CUENTAS KEY IS GREATER THAN WS-ID
               INVALID KEY ...
               NOT INVALID KEY
                   PERFORM UNTIL EOF
                       READ CUENTAS NEXT RECORD ...
                   END-PERFORM
           END-START.
```

---

## ✅ Checklist

- [ ] Leer registro con EXEC CICS READ FILE ... RIDFLD
- [ ] Usar UPDATE para leer con intención de modificar
- [ ] Insertar con WRITE FILE y manejar DUPREC
- [ ] Navegar con STARTBR + READNEXT + ENDBR
- [ ] Simular con archivos indexados COBOL

## 📚 Recursos

- [IBM CICS File Operations](https://www.ibm.com/docs/en/cics-ts/6.1?topic=programming-file-control)
- [IBM CICS READ Command](https://www.ibm.com/docs/en/cics-ts/6.1?topic=commands-read)
