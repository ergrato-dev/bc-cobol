# FILE STATUS — Control de Errores en Archivos

## 🎯 Objetivos

- Declarar FILE STATUS para cada archivo
- Interpretar los códigos de estado más comunes
- Implementar manejo de errores robusto
- Usar 88-level para condiciones de status

---

## 1. ¿Qué es FILE STATUS?

FILE STATUS es una variable de **2 bytes** que COBOL actualiza después de cada operación de archivo. Indica si la operación fue exitosa o qué error ocurrió.

```cobol
       SELECT ARCHIVO ASSIGN TO "datos.dat"
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-FS-ARCHIVO.
       
       WORKING-STORAGE SECTION.
       01  WS-FS-ARCHIVO   PIC X(02).
           88 ARCHIVO-OK    VALUE "00".
           88 ARCHIVO-EOF   VALUE "10".
```

> ⚠️ **Regla de oro**: Siempre, siempre verifica FILE STATUS después de cada operación de archivo.

---

## 2. Códigos de FILE STATUS

### Códigos comunes para archivos secuenciales

| Código | Significado | Cuándo ocurre |
|--------|-------------|---------------|
| `00` | Operación exitosa | READ/WRITE/OPEN/CLOSE exitoso |
| `10` | Fin de archivo (EOF) | READ cuando no hay más registros |
| `35` | Archivo no encontrado | OPEN INPUT de archivo inexistente |
| `37` | Error de permiso | OPEN sin permisos de lectura/escritura |
| `38` | Archivo cerrado con lock | OPEN de archivo ya abierto |

### Códigos para archivos indexados (vistazo previo)

| Código | Significado |
|--------|-------------|
| `22` | Clave duplicada (WRITE) |
| `23` | Registro no encontrado (READ con KEY) |
| `24` | Límite de claves alternas excedido |

---

## 3. Manejo de FILE STATUS con 88-level

La forma más limpia de manejar FILE STATUS:

```cobol
       01  WS-FS-ENTRADA    PIC X(02).
           88 ENT-OK        VALUE "00".
           88 ENT-EOF       VALUE "10".
           88 ENT-NO-FILE   VALUE "35".
           88 ENT-ERROR     VALUE "37" "38".
       
       01  WS-FS-SALIDA     PIC X(02).
           88 SAL-OK        VALUE "00".
           88 SAL-ERROR     VALUE "35" "37" "38".
```

### Verificar después de OPEN

```cobol
           OPEN INPUT ARCHIVO-ENTRADA.
           IF NOT ENT-OK
               DISPLAY "ERROR: No se pudo abrir archivo"
               DISPLAY "FILE STATUS: " WS-FS-ENTRADA
               STOP RUN
           END-IF.
```

### Verificar en loop de lectura

```cobol
           PERFORM UNTIL ENT-EOF
               READ ARCHIVO-ENTRADA
                   AT END
                       SET ENT-EOF TO TRUE
                   NOT AT END
                       IF ENT-OK
                           PERFORM 2000-PROCESAR
                       ELSE
                           DISPLAY "ERROR lectura: " WS-FS-ENTRADA
                       END-IF
               END-READ
           END-PERFORM.
```

---

## 4. Patrón Robusto de Manejo de Errores

```cobol
       PROCEDURE DIVISION.
       MAIN.
           PERFORM 1000-ABRIR-ARCHIVOS.
           IF ENT-OK AND SAL-OK
               PERFORM 2000-PROCESAR UNTIL ENT-EOF
               PERFORM 9000-CERRAR
           ELSE
               DISPLAY "ERROR: No se pudo abrir archivos"
               DISPLAY "Status entrada: " WS-FS-ENTRADA
               DISPLAY "Status salida : " WS-FS-SALIDA
           END-IF.
           STOP RUN.
       
       1000-ABRIR-ARCHIVOS.
           OPEN INPUT ARCHIVO-ENTRADA.
           IF NOT ENT-OK
               DISPLAY "ERROR abriendo entrada: " WS-FS-ENTRADA
           END-IF.
           OPEN OUTPUT ARCHIVO-SALIDA.
           IF NOT SAL-OK
               DISPLAY "ERROR abriendo salida: " WS-FS-SALIDA
           END-IF.
       
       2000-PROCESAR.
           READ ARCHIVO-ENTRADA
               AT END SET ENT-EOF TO TRUE
               NOT AT END
                   WRITE REG-SALIDA FROM REG-ENTRADA
                   IF NOT SAL-OK
                       DISPLAY "ERROR escribiendo: " WS-FS-SALIDA
                   END-IF
           END-READ.
       
       9000-CERRAR.
           CLOSE ARCHIVO-ENTRADA.
           CLOSE ARCHIVO-SALIDA.
```

---

## 5. Archivo de Entrada No Encontrado

Es el error más común para principiantes. Siempre verifica:

```cobol
           OPEN INPUT ARCHIVO-ENTRADA.
           IF ENT-NO-FILE
               DISPLAY "==================================="
               DISPLAY "ERROR: Archivo no encontrado"
               DISPLAY "Verifique que el archivo exista:"
               DISPLAY "  data/entrada.dat"
               DISPLAY "==================================="
               STOP RUN
           END-IF.
```

---

## 6. Depuración con FILE STATUS

Si el programa falla silenciosamente, muestra el FILE STATUS:

```cobol
           READ ARCHIVO
               AT END
                   DISPLAY "EOF alcanzado"
               NOT AT END
                   IF NOT ARCHIVO-OK
                       DISPLAY "ERROR READ: FS=" WS-FS-ARCHIVO
                   END-IF
           END-READ.
```

---

## ✅ Checklist

- [ ] Declarar FILE STATUS para cada archivo en WORKING-STORAGE
- [ ] Crear 88-level: OK (00), EOF (10), NO-FILE (35)
- [ ] Verificar FILE STATUS después de OPEN
- [ ] Verificar FILE STATUS después de cada READ
- [ ] Verificar FILE STATUS después de cada WRITE
- [ ] Mostrar mensaje claro si el archivo no existe (35)

## 📚 Recursos

- [GnuCOBOL File Status Codes](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#File-Status)
- [IBM COBOL FILE STATUS Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-file-status-values)
