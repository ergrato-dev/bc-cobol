# DD Statement — Data Definition

## 🎯 Objetivos

- Asociar archivos físicos a programas con DD
- Configurar DISP, SPACE y DCB
- Usar SYSOUT para salida del sistema
- Crear y referenciar datasets

---

## 1. Estructura del DD

```jcl
//DDNAME   DD   DSN=DATASET.NAME,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(10,5)),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)
```

| Parámetro | Significado |
|-----------|-------------|
| `DDNAME` | Nombre lógico (coincide con SELECT en COBOL) |
| `DSN=` | Dataset name (archivo físico) |
| `DISP=` | Disposición del dataset |
| `SPACE=` | Asignación de espacio en disco |
| `DCB=` | Data Control Block (formato del archivo) |

---

## 2. DSN — Dataset Name

Identifica el archivo en el sistema:

```jcl
//ENTRADA  DD   DSN=NOMINA.MAESTRO.DATOS,DISP=SHR
//SALIDA   DD   DSN=NOMINA.REPORTE.MENSUAL,DISP=(NEW,CATLG)
//TEMP     DD   DSN=&&TEMP,DISP=(NEW,PASS)       *> Temporal
```

### Tipos especiales

| DSN | Significado |
|-----|-------------|
| `&&TEMP` | Dataset temporal (existe solo durante el job) |
| `SYSOUT=*` | Salida del sistema (spool de impresión) |
| `NULLFILE` | Descartar datos (como /dev/null) |

---

## 3. DISP — Disposición del Dataset

Controla qué pasa con el dataset al inicio y al final del step:

```jcl
//ARCHIVO  DD   DSN=DATOS.MAESTRO,DISP=(status-inicio,status-fin,accion-error)
```

### Status de inicio (al OPEN)

| Valor | Significado |
|-------|-------------|
| `NEW` | Crear dataset nuevo (no debe existir) |
| `OLD` | Dataset existente, acceso exclusivo |
| `SHR` | Dataset existente, acceso compartido |
| `MOD` | Agregar al final (append) |

### Status de fin (al CLOSE normal)

| Valor | Significado |
|-------|-------------|
| `CATLG` | Guardar y catalogar |
| `KEEP` | Guardar sin catalogar |
| `DELETE` | Eliminar |
| `PASS` | Pasar al siguiente step |

### Acción en error (al CLOSE anormal)

| Valor | Significado |
|-------|-------------|
| `DELETE` | Eliminar |
| `KEEP` | Conservar |

### Ejemplos

```jcl
      *> Archivo nuevo, guardar si OK, borrar si error
//NUEVO    DD   DSN=DATOS.OUT,DISP=(NEW,CATLG,DELETE)
       
      *> Archivo existente, solo lectura
//MAESTRO  DD   DSN=DATOS.MAESTRO,DISP=SHR
       
      *> Modificar archivo existente
//BITACORA DD   DSN=DATOS.LOG,DISP=MOD
       
      *> Temporal entre steps
//PASO     DD   DSN=&&TEMP,DISP=(NEW,PASS)
```

---

## 4. SPACE — Asignación de Espacio

```jcl
//ARCHIVO  DD   DSN=DATOS.GRANDE,DISP=(NEW,CATLG),
//             SPACE=(TRK,(100,50,10),RLSE)
```

| Parámetro | Significado |
|-----------|-------------|
| `TRK` | Unidad: tracks (cilindros=CYL, bytes= nichts) |
| `100` | Espacio primario (tracks) |
| `50` | Espacio secundario (tracks, si se llena) |
| `10` | Directorios (para PDS) |
| `RLSE` | Liberar espacio no usado al cerrar |

---

## 5. DCB — Data Control Block

Define el formato del archivo:

```jcl
//ARCHIVO  DD   DSN=DATOS.FIJO,DISP=(NEW,CATLG),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)
```

| Parámetro | Significado | Ejemplo |
|-----------|-------------|---------|
| `RECFM=` | Record Format | FB (Fixed Block) |
| `LRECL=` | Logical Record Length | 80 |
| `BLKSIZE=` | Block Size | 800 (10 registros) |

### RECFM Comunes

| RECFM | Significado |
|-------|-------------|
| `FB` | Fixed Block (todos los registros igual largo) |
| `VB` | Variable Block (registros de largo variable) |
| `FBA` | Fixed Block con carácter de control ASA |
| `U` | Undefined |

---

## 6. SYSOUT — Salida del Sistema

```jcl
//REPORTE  DD   SYSOUT=*
//LOG      DD   SYSOUT=A
```

- `SYSOUT=*` → Salida estándar del sistema
- `SYSOUT=A` → Clase de salida A

---

## 7. Correspondencia COBOL ↔ JCL

### En JCL

```jcl
//CLIENTES DD   DSN=DATOS.CLIENTES,DISP=SHR
//REPORTE  DD   DSN=DATOS.REPORTE,DISP=(NEW,CATLG)
```

### En COBOL

```cobol
       FILE-CONTROL.
           SELECT CLIENTES ASSIGN TO CLIENTES.
           SELECT REPORTE  ASSIGN TO REPORTE.
```

El DDNAME en JCL (CLIENTES) coincide con el nombre usado en SELECT ... ASSIGN TO.

---

## ✅ Checklist

- [ ] Asociar archivo con DD DSN=
- [ ] Configurar DISP según ciclo de vida del dataset
- [ ] Usar SPACE para archivos nuevos
- [ ] Hacer coincidir DDNAME con SELECT ... ASSIGN TO en COBOL

## 📚 Recursos

- [IBM JCL DD Statement](https://www.ibm.com/docs/en/zos/2.5?topic=statements-dd)
- [IBM JCL DISP Parameter](https://www.ibm.com/docs/en/zos/2.5?topic=statements-dd-disp-parameter)
