# Verbos de Archivo: OPEN, READ, WRITE, CLOSE

## 🎯 Objetivos

- Abrir archivos con OPEN en el modo correcto
- Leer registros con READ y manejar fin de archivo
- Escribir registros con WRITE
- Cerrar archivos con CLOSE al terminar

---

## 1. OPEN — Abrir Archivo

Antes de leer o escribir, el archivo debe abrirse con OPEN indicando el modo:

```cobol
       OPEN modo nombre-archivo.
```

| Modo | Significado | Permite |
|------|-------------|---------|
| `INPUT` | Solo lectura | READ |
| `OUTPUT` | Solo escritura (crea/sobrescribe) | WRITE |
| `EXTEND` | Agregar al final (append) | WRITE |
| `I-O` | Lectura y escritura | READ, REWRITE, DELETE |

```cobol
      *> Leer un archivo existente
           OPEN INPUT CLIENTES-FILE.
       
      *> Crear nuevo archivo de salida
           OPEN OUTPUT REPORTE-FILE.
       
      *> Agregar registros al final
           OPEN EXTEND BITACORA-FILE.
       
      *> Leer y modificar (solo INDEXED/RELATIVE)
           OPEN I-O MAESTRO-FILE.
```

> ⚠️ OPEN OUTPUT **sobrescribe** el archivo si ya existe. Para agregar, usa EXTEND.

---

## 2. READ — Leer Registro

```cobol
       READ nombre-archivo [NEXT] [INTO variable]
           AT END sentencias...
           NOT AT END sentencias...
       END-READ.
```

### Lectura secuencial simple

```cobol
           READ CLIENTES-FILE
               AT END
                   DISPLAY "Fin del archivo"
               NOT AT END
                   DISPLAY "Leido: " CLI-REG
           END-READ.
```

### Patrón: leer todo el archivo

```cobol
           PERFORM UNTIL WS-EOF
               READ CLIENTES-FILE
                   AT END
                       SET EOF-SI TO TRUE
                   NOT AT END
                       PERFORM 2000-PROCESAR-REGISTRO
               END-READ
           END-PERFORM.
```

| Cláusula | Significado |
|----------|-------------|
| `AT END` | Se ejecuta al llegar al final del archivo |
| `NOT AT END` | Se ejecuta si se leyó un registro exitosamente |
| `NEXT` | Lee el siguiente registro (opcional, es el default) |
| `INTO variable` | Copia el registro leído en una variable de WORKING-STORAGE |

### READ INTO (copia en WORKING-STORAGE)

```cobol
           READ CLIENTES-FILE INTO WS-CLIENTE
               AT END ...
           END-READ.
      *> WS-CLIENTE contiene una copia independiente del registro
```

---

## 3. WRITE — Escribir Registro

```cobol
       WRITE nombre-registro [FROM variable]
           [BEFORE|AFTER ADVANCING n LINES]
       END-WRITE.
```

> ⚠️ WRITE usa el **nombre del registro** (nivel 01 del FD), no el nombre del archivo.

```cobol
      *> Escribir el registro del FD
           WRITE REPORTE-REG.
       
      *> Escribir desde una variable de WORKING-STORAGE
           WRITE REPORTE-REG FROM WS-LINEA.
       
      *> Escribir con salto de línea (reportes)
           WRITE REPORTE-REG AFTER ADVANCING 1 LINE.
```

### Antes de escribir, llena los campos del registro

```cobol
      *> 1. Llenar los campos del registro
           MOVE 12345 TO CLI-ID.
           MOVE "Nuevo Cliente" TO CLI-NOMBRE.
           MOVE 5000.00 TO CLI-SALDO.
       
      *> 2. Escribir el registro
           WRITE CLI-REG.
```

---

## 4. CLOSE — Cerrar Archivo

Siempre cierra los archivos al terminar para liberar recursos y asegurar que los datos se escriban en disco:

```cobol
           CLOSE CLIENTES-FILE.
           CLOSE REPORTE-FILE.
```

Puedes cerrar varios a la vez:

```cobol
           CLOSE CLIENTES-FILE
                 REPORTE-FILE
                 BITACORA-FILE.
```

---

## 5. Programa Completo: Lectura y Copia

```cobol
       >>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPIADOR.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ENTRADA-FILE ASSIGN TO "entrada.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
           SELECT SALIDA-FILE ASSIGN TO "salida.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-SAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD  ENTRADA-FILE.
       01  ENT-REG          PIC X(80).
       
       FD  SALIDA-FILE.
       01  SAL-REG          PIC X(80).
       
       WORKING-STORAGE SECTION.
       01  WS-FS-ENT         PIC X(02).
           88 ENT-OK         VALUE "00".
           88 ENT-EOF        VALUE "10".
       01  WS-FS-SAL         PIC X(02).
           88 SAL-OK         VALUE "00".
       01  WS-CONT           PIC 9(05) VALUE ZEROS.
       
       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT ENTRADA-FILE.
           OPEN OUTPUT SALIDA-FILE.
           
           PERFORM UNTIL ENT-EOF
               READ ENTRADA-FILE
                   AT END SET ENT-EOF TO TRUE
                   NOT AT END
                       WRITE SAL-REG FROM ENT-REG
                       ADD 1 TO WS-CONT
               END-READ
           END-PERFORM.
           
           CLOSE ENTRADA-FILE.
           CLOSE SALIDA-FILE.
           
           DISPLAY "Registros copiados: " WS-CONT.
           STOP RUN.
```

---

## ✅ Checklist

- [ ] Abrir archivo con OPEN INPUT (lectura) u OPEN OUTPUT (escritura)
- [ ] Leer registros con READ ... AT END ... NOT AT END
- [ ] Escribir con WRITE (nombre del registro 01 del FD)
- [ ] Cerrar archivos con CLOSE al final del programa
- [ ] Manejar FILE STATUS en todas las operaciones

## 📚 Recursos

- [GnuCOBOL File I/O](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#File-I_002fO)
- [IBM COBOL OPEN Statement](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-open-statement)
