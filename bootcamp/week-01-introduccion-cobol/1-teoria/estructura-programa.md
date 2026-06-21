# Estructura de un Programa COBOL

## 🎯 Objetivos

- Identificar las 4 divisiones de un programa COBOL y su propósito
- Escribir cada división correctamente
- Comprender el flujo de ejecución de un programa COBOL

---

## 1. Las 4 Divisiones

Todo programa COBOL tiene 4 divisiones, siempre en este orden:

```
IDENTIFICATION DIVISION.
ENVIRONMENT DIVISION.
DATA DIVISION.
PROCEDURE DIVISION.
```

Cada división tiene un propósito específico. Es como los capítulos de un documento legal: cada uno cubre un aspecto diferente del programa.

### Analogía con un Restaurante

| División | Analogía | Propósito |
|----------|----------|-----------|
| `IDENTIFICATION` | Nombre del restaurante | Identifica el programa |
| `ENVIRONMENT` | Cocina y equipo | Describe el entorno (archivos) |
| `DATA` | Ingredientes | Define todas las variables y estructuras |
| `PROCEDURE` | Receta | Instrucciones paso a paso |

---

## 2. IDENTIFICATION DIVISION

La más simple. Identifica el programa.

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HOLA.
       AUTHOR. TU-NOMBRE.
       DATE-WRITTEN. 2026-06-20.
```

| Cláusula | Obligatoria | Descripción |
|----------|-------------|-------------|
| `PROGRAM-ID.` | ✅ Sí | Nombre del programa (máx 8 chars en mainframe, flexible en GnuCOBOL) |
| `AUTHOR.` | ❌ No | Nombre del autor |
| `DATE-WRITTEN.` | ❌ No | Fecha de creación |

> 📝 En GnuCOBOL con formato libre, `PROGRAM-ID` puede tener nombres largos. En mainframe real, máximo 8 caracteres.

---

## 3. ENVIRONMENT DIVISION

Describe el entorno donde corre el programa. Opcional si no usas archivos.

```cobol
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. LINUX.
       OBJECT-COMPUTER. LINUX.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARCHIVO-CLIENTES ASSIGN TO "clientes.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
```

| Sección | Propósito |
|---------|-----------|
| `CONFIGURATION SECTION` | Computadora fuente y objeto |
| `INPUT-OUTPUT SECTION` | Declaración de archivos (SELECT/ASSIGN) |
| `FILE-CONTROL` | Asocia nombre lógico con archivo físico |

> 📝 En semana 01 no usaremos archivos. Esta división puede omitirse por ahora.

---

## 4. DATA DIVISION

Define todos los datos del programa. Es la división más importante para el diseño.

```cobol
       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       01  WS-NOMBRE    PIC X(30) VALUE SPACES.
       01  WS-EDAD      PIC 9(03) VALUE ZEROS.
       01  WS-SALDO     PIC 9(07)V99 VALUE ZEROS.
```

| Sección | Propósito |
|---------|-----------|
| `FILE SECTION` | Descripción de registros de archivos (FD) |
| `WORKING-STORAGE SECTION` | Variables de trabajo del programa |
| `LINKAGE SECTION` | Parámetros de subprogramas |

### Niveles de datos (jerarquía)

```cobol
       01  REGISTRO-CLIENTE.          *> Nivel 01: grupo
           05 CLIENTE-ID     PIC 9(05).
           05 CLIENTE-NOMBRE.         *> Nivel 05: subgrupo
               10 PRIMER-NOMBRE PIC X(15).
               10 APELLIDO      PIC X(15).
           05 CLIENTE-SALDO   PIC 9(07)V99.
```

- **01**: Registro completo o grupo principal
- **05, 10, 15...**: Subelementos (la numeración exacta no importa, solo la jerarquía)
- **77**: Variable elemental independiente (sin subordinación)
- **88**: Condición booleana (condition name)

---

## 5. PROCEDURE DIVISION

Contiene las instrucciones ejecutables. Es el "código" real.

```cobol
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "Hola mundo COBOL".
           DISPLAY "Tu turno:".
           ACCEPT WS-NOMBRE.
           DISPLAY "Bienvenido " WS-NOMBRE.
           STOP RUN.
```

### Estructura típica

```cobol
       PROCEDURE DIVISION.
       1000-INICIO.
           PERFORM 2000-PROCESO.
           PERFORM 9000-FINAL.
           STOP RUN.
       
       2000-PROCESO.
           DISPLAY "Procesando...".
       
       9000-FINAL.
           DISPLAY "Programa terminado".
```

- **Párrafos**: Bloques de código con nombre (MAIN, 1000-INICIO, etc.)
- **PERFORM**: Llama a un párrafo y regresa al punto de llamada
- **STOP RUN**: Termina el programa

---

## 6. Programa Mínimo Completo

Con formato libre (`>>SOURCE FORMAT IS FREE`):

```cobol
       >>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MINIMO.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-MENSAJE PIC X(40) VALUE "Mi primer programa COBOL".
       
       PROCEDURE DIVISION.
           DISPLAY WS-MENSAJE.
           STOP RUN.
```

Para compilar y ejecutar:

```bash
docker compose exec cobol bash -c "cd bootcamp/week-01-introduccion-cobol && cobc -x -free minimo.cbl && ./minimo"
```

---

## ✅ Checklist

- [ ] Nombrar las 4 divisiones en orden
- [ ] Explicar el propósito de cada división
- [ ] Escribir un programa COBOL mínimo completo
- [ ] Diferenciar entre nivel 01, 05 y 77
- [ ] Compilar y ejecutar con `cobc -x -free`

## 📚 Recursos

- [GnuCOBOL Program Structure](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#Program-Structure)
- [IBM COBOL Structure](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=structure-cobol-program)
