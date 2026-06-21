# Organización de Archivos Secuenciales

## 🎯 Objetivos

- Diferenciar los tipos de organización secuencial
- Elegir la organización correcta para cada caso
- Comprender la estructura de registros en archivos secuenciales

---

## 1. Tipos de Organización Secuencial

| Organización | Descripción | Formato |
|-------------|-------------|---------|
| `LINE SEQUENTIAL` | Archivo de texto con saltos de línea | Cada línea = 1 registro |
| `RECORD SEQUENTIAL` | Archivo binario con registros de largo fijo | Sin delimitadores |
| `SEQUENTIAL` | Equivalente a RECORD SEQUENTIAL en GnuCOBOL | Binario |

---

## 2. LINE SEQUENTIAL (Archivos de Texto)

Es el tipo más común en este bootcamp. Cada registro termina con un salto de línea (`\n`).

```cobol
       SELECT CLIENTES-FILE
           ASSIGN TO "clientes.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
```

### Características

- ✅ Legible con cualquier editor de texto
- ✅ Fácil de crear y modificar manualmente
- ✅ Ideal para importar/exportar datos (CSV-like)
- ⚠️ Largo de registro variable (hasta el salto de línea)
- ⚠️ No permite acceso aleatorio (siempre secuencial)

### Ejemplo de archivo LINE SEQUENTIAL

```
00001Juan Perez              00001500000
00002Maria Garcia             00002500000
00003Carlos Lopez             00001000075
```

Cada línea es un registro. El programa define el layout con FD:

```cobol
       FD  CLIENTES-FILE.
       01  CLI-REG.
           05 CLI-ID            PIC 9(05).
           05 CLI-NOMBRE        PIC X(25).
           05 CLI-SALDO         PIC 9(09)V99.
```

---

## 3. RECORD SEQUENTIAL (Binario de Largo Fijo)

Almacena registros sin delimitadores. Útil para datos binarios (COMP-3, COMP).

```cobol
       SELECT MAESTRO-FILE
           ASSIGN TO "maestro.bin"
           ORGANIZATION IS RECORD SEQUENTIAL.
```

### Características

- ✅ Tamaño de registro fijo y predecible
- ✅ Más rápido para procesamiento masivo
- ✅ Compatible con USAGE COMP-3 y COMP
- ❌ No legible con editor de texto
- ❌ Más difícil de depurar

```cobol
       FD  MAESTRO-FILE.
       01  MAE-REG.
           05 MAE-ID           PIC 9(05) USAGE COMP.
           05 MAE-NOMBRE       PIC X(30).
           05 MAE-SALDO        PIC S9(09)V99 USAGE COMP-3.
      *> Registro: 2 + 30 + 5 = 37 bytes fijos
```

---

## 4. Comparativa

| Característica | LINE SEQUENTIAL | RECORD SEQUENTIAL |
|---------------|-----------------|-------------------|
| Legible por humanos | ✅ Sí | ❌ No |
| Largo de registro | Variable | Fijo |
| Velocidad | Media | Alta |
| Acceso aleatorio | ❌ No | ❌ No |
| USAGE COMP-3 | ❌ No compatible | ✅ Sí |
| Creación manual | ✅ Sí | ❌ No |
| Uso típico | CSV, logs, reportes | Datos maestros, archivos legacy |

---

## 5. Estructura de un Archivo y su FD

La FD (File Description) en DATA DIVISION define el layout de cada registro:

```cobol
       DATA DIVISION.
       FILE SECTION.
       
       FD  CLIENTES-FILE
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 39 CHARACTERS
           DATA RECORD IS CLI-REG.
       
       01  CLI-REG.
           05 CLI-ID            PIC 9(05).
           05 CLI-NOMBRE        PIC X(25).
           05 CLI-SALDO         PIC 9(09)V99.
```

| Cláusula FD | Obligatorio | Descripción |
|-------------|-------------|-------------|
| `LABEL RECORDS` | ❌ | STANDARD u OMITTED |
| `RECORD CONTAINS` | ❌ | Tamaño del registro (informativo) |
| `DATA RECORD` | ❌ | Nombre del registro 01 |

> 📝 En GnuCOBOL, la mayoría de las cláusulas FD son opcionales. El mínimo es `FD nombre-archivo.` seguido del `01 registro.`

---

## 6. Múltiples Layouts con REDEFINES

Un mismo archivo puede leerse con diferentes formatos según el tipo de registro:

```cobol
       FD  TRANSACCIONES-FILE.
       01  TRANS-REG             PIC X(50).
       
      *> Layouts alternativos del mismo buffer
       01  TRANS-DEPOSITO REDEFINES TRANS-REG.
           05 DEP-TIPO          PIC X(01).
           05 DEP-CUENTA        PIC 9(05).
           05 DEP-MONTO         PIC 9(07)V99.
           05 FILLER            PIC X(37).
       
       01  TRANS-RETIRO REDEFINES TRANS-REG.
           05 RET-TIPO          PIC X(01).
           05 RET-CUENTA        PIC 9(05).
           05 RET-MONTO         PIC 9(07)V99.
           05 FILLER            PIC X(37).
```

---

## ✅ Checklist

- [ ] Elegir LINE SEQUENTIAL para archivos de texto
- [ ] Elegir RECORD SEQUENTIAL para datos binarios con COMP-3
- [ ] Declarar FD con el layout del registro
- [ ] Diseñar el PIC de cada campo según su contenido real
- [ ] Usar REDEFINES para layouts alternativos del mismo archivo

## 📚 Recursos

- [GnuCOBOL File Organization](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#File-organization)
- [IBM COBOL File Organization Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=files-file-organization)
