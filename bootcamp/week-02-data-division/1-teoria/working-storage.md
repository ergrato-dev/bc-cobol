# WORKING-STORAGE SECTION y Otras Secciones

## 🎯 Objetivos

- Dominar WORKING-STORAGE como espacio principal de variables de trabajo
- Conocer FILE SECTION y LINKAGE SECTION (vistazo previo)
- Organizar variables con estructura profesional

---

## 1. WORKING-STORAGE SECTION

Es la sección principal de DATA DIVISION. Aquí se declaran todas las **variables de trabajo** del programa: contadores, acumuladores, buffers, campos de edición, tablas pequeñas.

```cobol
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
      *> Variables independientes (77-level)
       77  WS-PROGRAMA-FIN   PIC X(01) VALUE "N".
           88 FIN-EJECUCION  VALUE "S".
       
      *> Registros de trabajo (01-level)
       01  WS-FECHA-HOY.
           05 WS-ANO         PIC 9(04).
           05 WS-MES         PIC 9(02).
           05 WS-DIA         PIC 9(02).
       
      *> Campos de edición para pantalla
       01  WS-SALDO-EDIT     PIC $$,$$9.99.
       01  WS-CANT-EDIT      PIC ZZ,ZZ9.
```

### Variables que NO van en WORKING-STORAGE

- **Registros de archivos** → FILE SECTION (FD)
- **Parámetros de subprogramas** → LINKAGE SECTION
- **Archivos de sort temporales** → FILE SECTION (SD)

---

## 2. Organización Profesional de WORKING-STORAGE

Agrupa variables lógicamente con comentarios:

```cobol
       WORKING-STORAGE SECTION.
       
      *> === SWITCHES E INDICADORES ===
       01  SW-EOF          PIC X(01) VALUE "N".
           88 EOF-SI       VALUE "S".
           88 EOF-NO       VALUE "N".
       
      *> === CONTADORES Y ACUMULADORES ===
       01  WS-CONTADOR-REG    PIC 9(07) USAGE COMP VALUE ZEROS.
       01  WS-TOTAL-SALDOS    PIC S9(09)V99 USAGE COMP-3 VALUE ZEROS.
       
      *> === CAMPOS DE FECHA ===
       01  WS-FECHA-ACTUAL.
           05 WS-ANO-ACT      PIC 9(04).
           05 WS-MES-ACT      PIC 9(02).
           05 WS-DIA-ACT      PIC 9(02).
       
      *> === CAMPOS DE EDICIÓN (PANTALLA/REPORTE) ===
       01  WS-SALDO-EDIT      PIC $$,$$9.99.
       01  WS-FECHA-EDIT      PIC 99/99/9999.
       
      *> === MENSAJES Y LITERALES ===
       01  WS-MENSAJE-ERROR   PIC X(60) VALUE SPACES.
       01  WS-LINEA-SEP       PIC X(50) VALUE ALL "=".
```

---

## 3. FILE SECTION (vistazo previo)

Define el layout de los registros en archivos. Se usa FD (File Description).

```cobol
       DATA DIVISION.
       FILE SECTION.
       
       FD  CLIENTES-FILE.
       01  CLIENTE-REG.
           05 CLI-ID           PIC 9(05).
           05 CLI-NOMBRE       PIC X(30).
           05 CLI-SALDO        PIC S9(07)V99.
       
       FD  REPORTE-FILE.
       01  REPORTE-REG         PIC X(132).
```

| Elemento | Descripción |
|----------|-------------|
| `FD` | File Description: asocia un archivo del SELECT con su estructura |
| `01` bajo FD | Registro del archivo (puede tener múltiples layouts con REDEFINES) |

> 📝 Lo veremos en detalle en la Semana 04 (Archivos Secuenciales).

---

## 4. LINKAGE SECTION (vistazo previo)

Define parámetros que se reciben de un programa llamador (CALL). Permite pasar datos entre programas.

```cobol
       DATA DIVISION.
       LINKAGE SECTION.
       01  LK-PARAM-ENTRADA.
           05 LK-ID          PIC 9(05).
           05 LK-OPERACION   PIC X(01).
       
       01  LK-PARAM-SALIDA.
           05 LK-NOMBRE      PIC X(30).
           05 LK-SALDO       PIC S9(07)V99.
```

| Característica | Descripción |
|---------------|-------------|
| No tiene VALUE | Los parámetros vienen del llamador |
| Debe coincidir | Con el USING del PROCEDURE DIVISION |
| Sin FD ni SD | Solo variables de paso de parámetros |

> 📝 Lo veremos en detalle en la Semana 08 (Subprogramas).

---

## 5. Reglas de Orden en DATA DIVISION

```cobol
       DATA DIVISION.
       
       FILE SECTION.           *> Primero: archivos (FD, SD)
       FD  ARCHIVO-ENTRADA...
       
       WORKING-STORAGE SECTION.*> Segundo: variables de trabajo
       77  WS-VARIABLE...
       01  WS-REGISTRO...
       
       LINKAGE SECTION.        *> Tercero: parámetros (si es subprograma)
       01  LK-PARAMETROS...
```

---

## 6. Scope y Visibilidad

Las variables en WORKING-STORAGE son **globales** dentro del programa. Conservan su valor entre PERFORM a menos que se modifiquen explícitamente.

```cobol
       WORKING-STORAGE SECTION.
       01  WS-CONTADOR    PIC 9(03) VALUE ZEROS.   *> Global
       
       PROCEDURE DIVISION.
       MAIN.
           PERFORM 1000-CONTAR 3 TIMES.            *> Llama 3 veces
           DISPLAY "Total: " WS-CONTADOR.           *> 003
           STOP RUN.
       
       1000-CONTAR.
           ADD 1 TO WS-CONTADOR.                    *> Conserva valor
           DISPLAY WS-CONTADOR.                     *> 1, 2, 3
```

---

## ✅ Checklist

- [ ] Organizar WORKING-STORAGE en secciones lógicas con comentarios
- [ ] Declarar al menos: switches, contadores, campos de edición, mensajes
- [ ] Identificar qué va en FILE SECTION vs WORKING-STORAGE
- [ ] Comprender que LINKAGE SECTION es para parámetros (futuro)
- [ ] Verificar el orden correcto de secciones en DATA DIVISION

## 📚 Recursos

- [GnuCOBOL DATA DIVISION](https://gnucobol.sourceforge.io/HTML/gnucobpg.html#DATA-DIVISION)
- [IBM COBOL WORKING-STORAGE](https://www.ibm.com/docs/en/cobol-zos/6.3?topic=division-working-storage-section)
