# COPYBOOKS — Reutilización de Código

## 🎯 Objetivos

- Crear COPYBOOKS (.cpy) para compartir estructuras de datos
- Incluir COPYBOOKS con COPY
- Usar REPLACE para personalizar copias
- Organizar una librería de COPYBOOKS reutilizables

---

## 1. ¿Qué es un COPYBOOK?

Un COPYBOOK es un archivo externo que contiene código COBOL (generalmente definiciones de datos) que se incluye en tiempo de compilación con la sentencia COPY.

```
copybooks/
├── clientes.cpy       # Layout de cliente
├── cuentas.cpy        # Layout de cuenta
├── errores.cpy        # Códigos de error
└── fechas.cpy         # Rutinas de validación de fechas
```

---

## 2. Sintaxis de COPY

```cobol
       COPY "copybooks/clientes.cpy".
```

Esto **inserta** el contenido del archivo en el punto exacto donde aparece COPY.

### Ejemplo

**copybooks/cliente.cpy:**

```cobol
       01  REG-CLIENTE.
           05 CLI-ID          PIC 9(05).
           05 CLI-NOMBRE      PIC X(30).
           05 CLI-APELLIDO    PIC X(30).
           05 CLI-SALDO       PIC S9(07)V99.
```

**Programa principal:**

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "copybooks/cliente.cpy".
      *> ↑ El compilador inserta el contenido aquí
```

---

## 3. COPY en Distintas Secciones

```cobol
      *> En FILE SECTION
       FILE SECTION.
       FD  ARCHIVO-CLIENTES.
       COPY "copybooks/cliente.cpy".
       
      *> En WORKING-STORAGE
       WORKING-STORAGE SECTION.
       COPY "copybooks/cliente-ws.cpy".
       
      *> En LINKAGE SECTION
       LINKAGE SECTION.
       COPY "copybooks/cliente.cpy".
```

---

## 4. REPLACE — Personalizar COPY

REPLACE cambia partes del COPYBOOK durante la inclusión:

```cobol
      *> Reemplaza un prefijo
       COPY "copybooks/cliente.cpy"
           REPLACING ==CLI-== BY ==EMP-==.
      *> CLI-ID → EMP-ID, CLI-NOMBRE → EMP-NOMBRE, etc.
```

### Múltiples reemplazos

```cobol
       COPY "copybooks/registro.cpy"
           REPLACING ==:PREF:== BY ==WS-==
                     ==:TAG:==  BY ==CLIENTE==.
```

### COPYBOOK con marcadores

**copybooks/registro.cpy:**

```cobol
       01  :PREF::-:TAG:-ID         PIC 9(05).
           05 :PREF::-:TAG:-NOMBRE   PIC X(30).
           05 :PREF::-:TAG:-SALDO    PIC S9(07)V99.
```

Uso:

```cobol
      *> Para clientes
       COPY "copybooks/registro.cpy"
           REPLACING ==:PREF:== BY ==WS-==
                     ==:TAG:==  BY ==CLI==.
      *> Resultado: WS-CLI-ID, WS-CLI-NOMBRE, WS-CLI-SALDO
       
      *> Para empleados
       COPY "copybooks/registro.cpy"
           REPLACING ==:PREF:== BY ==WS-==
                     ==:TAG:==  BY ==EMP==.
      *> Resultado: WS-EMP-ID, WS-EMP-NOMBRE, WS-EMP-SALDO
```

---

## 5. COPYBOOK para Códigos de Error

**copybooks/errores.cpy:**

```cobol
       01  WS-CODIGO-ERROR    PIC X(02).
           88 ERROR-OK        VALUE "00".
           88 ERROR-EOF       VALUE "10".
           88 ERROR-NO-FILE   VALUE "35".
           88 ERROR-DUP       VALUE "22".
           88 ERROR-NOT-FOUND VALUE "23".
```

Uso en cualquier programa:

```cobol
       WORKING-STORAGE SECTION.
       COPY "copybooks/errores.cpy".
```

---

## 6. COPYBOOK para FILE STATUS Reutilizable

**copybooks/file-status.cpy:**

```cobol
       01  WS-FS-ARCHIVO     PIC X(02).
           88 FS-OK          VALUE "00".
           88 FS-EOF         VALUE "10".
           88 FS-NO-FILE     VALUE "35".
```

Uso con REPLACE:

```cobol
       COPY "copybooks/file-status.cpy"
           REPLACING ==ARCHIVO== BY ==CLIENTES==.
      *> WS-FS-CLIENTES, FS-CLIENTES-OK, FS-CLIENTES-EOF
```

---

## 7. Organización de COPYBOOKS

```
/workspace/copybooks/              ← Directorio compartido
├── layouts/
│   ├── cliente.cpy
│   ├── cuenta.cpy
│   └── transaccion.cpy
├── status/
│   ├── file-status.cpy
│   └── errores.cpy
├── calculos/
│   └── formulas.cpy
└── validacion/
    ├── fechas.cpy
    └── montos.cpy
```

Compilar incluyendo el directorio de copybooks:

```bash
cobc -x -free -I copybooks programa.cbl
```

---

## ✅ Checklist

- [ ] Crear COPYBOOK con definiciones de datos
- [ ] Incluir con COPY en FILE SECTION, WORKING-STORAGE o LINKAGE
- [ ] Usar REPLACE para personalizar prefijos/nombres
- [ ] Crear COPYBOOKS de códigos de error y file status
- [ ] Compilar con `-I directorio` para resolver rutas

## 📚 Recursos

- [GnuCOBOL COPY Statement](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#COPY)
- [IBM COBOL COPY Reference](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=statements-copy-statement)
