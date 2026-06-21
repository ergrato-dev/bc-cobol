# ENVIRONMENT DIVISION — Configuración de Archivos

## 🎯 Objetivos

- Configurar la ENVIRONMENT DIVISION para trabajar con archivos
- Usar SELECT y ASSIGN para asociar archivos lógicos con físicos
- Comprender las secciones de ENVIRONMENT DIVISION

---

## 1. Estructura de ENVIRONMENT DIVISION

La ENVIRONMENT DIVISION es la segunda división del programa. Define el entorno de hardware y los archivos que usará el programa.

```cobol
       ENVIRONMENT DIVISION.
       
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. LINUX.
       OBJECT-COMPUTER. LINUX.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT archivo-logico
               ASSIGN TO "archivo-fisico"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS variable-status.
```

| Sección | Propósito |
|---------|-----------|
| `CONFIGURATION SECTION` | Identifica la computadora fuente y objeto (informativo) |
| `INPUT-OUTPUT SECTION` | Declara los archivos del programa |
| `FILE-CONTROL` | Párrafo dentro de INPUT-OUTPUT donde se definen los SELECT |

---

## 2. CONFIGURATION SECTION

Es informativa y opcional en GnuCOBOL, pero buena práctica incluirla:

```cobol
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. LINUX.
       OBJECT-COMPUTER. LINUX.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.      *> Para usar coma decimal
```

| Cláusula | Significado |
|----------|-------------|
| `SOURCE-COMPUTER` | Computadora donde se compila |
| `OBJECT-COMPUTER` | Computadora donde se ejecuta |
| `SPECIAL-NAMES` | Configuraciones regionales (decimal, moneda) |

---

## 3. INPUT-OUTPUT SECTION — FILE-CONTROL

Aquí se declaran todos los archivos del programa. Cada archivo requiere un `SELECT`:

```cobol
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CLIENTES-FILE
               ASSIGN TO "clientes.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-CLIENTES.
```

### Estructura de un SELECT

```cobol
       SELECT nombre-logico
           ASSIGN TO [DISK | PRINTER | "ruta/archivo"]
           ORGANIZATION IS [SEQUENTIAL | LINE SEQUENTIAL | INDEXED | RELATIVE]
           ACCESS MODE IS [SEQUENTIAL | RANDOM | DYNAMIC]   *> Para INDEXED
           FILE STATUS IS variable-status-2bytes.
```

| Elemento | Obligatorio | Descripción |
|----------|-------------|-------------|
| Nombre lógico | ✅ Sí | Nombre interno del archivo en el programa |
| `ASSIGN TO` | ✅ Sí | Ruta del archivo físico (puede ser literal o variable) |
| `ORGANIZATION` | ✅ Sí | Tipo de organización del archivo |
| `ACCESS MODE` | ❌ No | Modo de acceso (solo para INDEXED/RELATIVE) |
| `FILE STATUS` | ⭐ Recomendado | Variable de 2 bytes para control de errores |

---

## 4. Nombre Lógico vs Nombre Físico

```cobol
       FILE-CONTROL.
           SELECT ARCHIVO-CLIENTES          *> Nombre lógico (interno)
               ASSIGN TO "data/clientes.dat" *> Nombre físico (archivo en disco)
               ORGANIZATION IS LINE SEQUENTIAL.
```

- **Nombre lógico**: se usa en OPEN, READ, WRITE, CLOSE
- **Nombre físico**: ruta real del archivo en el sistema

```cobol
       PROCEDURE DIVISION.
           OPEN INPUT ARCHIVO-CLIENTES.     *> Usa nombre lógico
           READ ARCHIVO-CLIENTES...         *> Usa nombre lógico
           CLOSE ARCHIVO-CLIENTES.          *> Usa nombre lógico
```

### ASSIGN dinámico (aceptar ruta en runtime)

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-RUTA-ARCHIVO   PIC X(50) VALUE SPACES.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARCHIVO ASSIGN TO WS-RUTA-ARCHIVO
               ORGANIZATION IS LINE SEQUENTIAL.
       
       PROCEDURE DIVISION.
           DISPLAY "Ruta del archivo: " WITH NO ADVANCING.
           ACCEPT WS-RUTA-ARCHIVO.
           OPEN INPUT ARCHIVO.
```

---

## 5. Múltiples Archivos

Un programa puede trabajar con varios archivos simultáneamente:

```cobol
       FILE-CONTROL.
           SELECT ENTRADA-FILE
               ASSIGN TO "entrada.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ENT.
       
           SELECT SALIDA-FILE
               ASSIGN TO "salida.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-SAL.
       
           SELECT ERRORES-FILE
               ASSIGN TO "errores.log"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-ERR.
```

---

## 6. Buenas Prácticas

1. ✅ Siempre declarar `FILE STATUS` para cada archivo
2. ✅ Usar nombres lógicos descriptivos (con sufijo `-FILE` o `-ARCHIVO`)
3. ✅ Las rutas relativas son relativas al directorio de ejecución
4. ✅ Mantener los archivos de datos en subdirectorio `data/`
5. ❌ No usar rutas absolutas hardcodeadas (problemas de portabilidad)

```cobol
      *> ✅ Recomendado: variables de entorno o parámetros
       01  WS-DATA-DIR     PIC X(20) VALUE "data/".
       01  WS-ARCHIVO-ENT  PIC X(50).
       
           STRING WS-DATA-DIR DELIMITED BY SIZE
                  "clientes.dat" DELIMITED BY SIZE
                  INTO WS-ARCHIVO-ENT.
```

---

## ✅ Checklist

- [ ] Escribir ENVIRONMENT DIVISION con CONFIGURATION e INPUT-OUTPUT
- [ ] Declarar al menos un archivo con SELECT/ASSIGN
- [ ] Usar ORGANIZATION IS LINE SEQUENTIAL para archivos de texto
- [ ] Declarar FILE STATUS para cada archivo
- [ ] Diferenciar nombre lógico (SELECT) de nombre físico (ASSIGN)

## 📚 Recursos

- [GnuCOBOL ENVIRONMENT DIVISION](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#ENVIRONMENT)
- [IBM COBOL FILE-CONTROL](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=division-file-control-paragraph)
