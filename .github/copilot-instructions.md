# 🤖 Instrucciones para GitHub Copilot

## 📋 Contexto del Bootcamp

Este es un **Bootcamp de COBOL Zero to Hero** estructurado para llevar a estudiantes de cero a héroe en desarrollo de sistemas empresariales con COBOL.

### 📊 Datos del Bootcamp

- **Duración**: 14 semanas (~3.5 meses)
- **Dedicación semanal**: 10 horas
- **Total de horas**: ~140 horas
- **Nivel de salida**: Desarrollador COBOL Junior
- **Enfoque**: GnuCOBOL open source, sistemas batch, archivos, SQL embebido
- **Stack**: Docker 27.5+, GnuCOBOL 3.2+ (en contenedor), PostgreSQL 16+ (servicio), bash, Git

---

## 🎯 Objetivos de Aprendizaje

Al finalizar el bootcamp, los estudiantes serán capaces de:

- ✅ Dominar la estructura y sintaxis de COBOL (todas las divisiones)
- ✅ Diseñar layouts de datos profesionales con PICTURE y USAGE
- ✅ Implementar control de flujo con IF/EVALUATE/PERFORM
- ✅ Procesar archivos secuenciales, indexados y relativos
- ✅ Manipular cadenas con STRING/UNSTRING/INSPECT
- ✅ Crear y consumir subprogramas con CALL y LINKAGE SECTION
- ✅ Modularizar código con COPYBOOKS
- ✅ Generar reportes profesionales para sistemas batch
- ✅ Ordenar y fusionar grandes volúmenes de datos con SORT/MERGE
- ✅ Integrar COBOL con bases de datos SQL (embebido)
- ✅ Escribir y ejecutar JCL para jobs batch
- ✅ Comprender fundamentos de CICS para transacciones online
- ✅ Construir un sistema bancario completo como proyecto final

---

## 📚 Estructura del Bootcamp

### Distribución por Etapas

#### **Fundamentos (Semanas 1-3)** - 30 horas

- Historia de COBOL y relevancia actual
- Instalación y configuración de GnuCOBOL
- Estructura de las 4 divisiones
- DATA DIVISION: PICTURE, USAGE, VALUE, niveles 01-49
- WORKING-STORAGE, FILE SECTION, LINKAGE SECTION
- PROCEDURE DIVISION: MOVE, COMPUTE, DISPLAY, ACCEPT
- Control de flujo: IF/ELSE, EVALUATE, PERFORM básico

#### **Procesamiento (Semanas 4-7)** - 40 horas

- Archivos secuenciales: OPEN, READ, WRITE, CLOSE
- FILE STATUS y manejo de errores
- Archivos indexados: ACCESS MODE, START, DELETE, REWRITE
- Archivos relativos: RELATIVE KEY
- Tablas y arrays: OCCURS, INDEXED BY, SEARCH, SEARCH ALL
- Manipulación de strings: STRING, UNSTRING, INSPECT
- Referencia y modificación de datos

#### **Modularización (Semanas 8-9)** - 20 horas

- Subprogramas: CALL, LINKAGE SECTION, USING/BY REFERENCE/BY CONTENT
- Programas anidados: CONTAINS
- COPYBOOKS: COPY, REPLACE
- Gestión de librerías de código reutilizable

#### **Batch (Semanas 10-12)** - 30 horas

- Reportes profesionales: WRITE BEFORE/AFTER, control de página
- SORT y MERGE de archivos
- Integración SQL: EXEC SQL, cursores, transacciones
- JCL: JOB, EXEC, DD, procedimientos

#### **Producción (Semanas 13-14)** - 20 horas

- CICS fundamentos: transacciones, MAPS, pseudo-conversación
- Proyecto final: sistema bancario completo (batch + online)

---

## 🗂️ Estructura de Carpetas

Cada semana sigue esta estructura estándar:

```
bootcamp/week-XX-tema_principal/
├── README.md                 # Descripción y objetivos de la semana
├── rubrica-evaluacion.md     # Criterios de evaluación detallados
├── 0-assets/                 # Imágenes, diagramas y recursos visuales
├── 1-teoria/                 # Material teórico (archivos .md)
├── 2-practicas/              # Ejercicios guiados paso a paso
├── 3-proyecto/               # Proyecto semanal integrador
├── 4-recursos/               # Recursos adicionales
│   ├── ebooks-free/          # Libros electrónicos gratuitos
│   ├── videografia/          # Videos y tutoriales recomendados
│   └── webgrafia/            # Enlaces y documentación
└── 5-glosario/               # Términos clave de la semana (A-Z)
    └── README.md
```

---

## 🎓 Componentes de Cada Semana

### 1. **Teoría** (1-teoria/)

- Archivos markdown con explicaciones conceptuales
- Ejemplos de código COBOL con comentarios claros
- Diagramas y visualizaciones cuando sea necesario
- Referencias a documentación oficial de IBM/GnuCOBOL

### 2. **Prácticas** (2-practicas/)

- Ejercicios guiados paso a paso
- Incremento progresivo de dificultad
- Código comentado para descomentar (NO TODOs)
- Casos de uso del mundo real (bancario, seguros, gobierno)

#### 📋 Formato de Ejercicios

Los ejercicios son **tutoriales guiados**, NO tareas con TODOs. El estudiante aprende descomentando código:

**README.md del ejercicio:**

```markdown
### Paso 1: Crear programa con DATA DIVISION

Explica el concepto con ejemplo:

\`\`\`cobol
       01  WS-REGISTRO.
           05 WS-NOMBRE     PIC X(30).
           05 WS-EDAD       PIC 9(03).
\`\`\`

**Abre `starter/hello.cbl`** y descomenta la sección correspondiente.
```

**starter/hello.cbl:**

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> PASO 1: Definir variables de trabajo
      *> Descomenta las siguientes líneas:
      *01  WS-NOMBRE     PIC X(30).
      *01  WS-EDAD       PIC 9(03).
       PROCEDURE DIVISION.
           DISPLAY "Hola mundo COBOL".
           STOP RUN.
```

> ⚠️ **IMPORTANTE**: Los ejercicios NO tienen carpeta `solution/`. El estudiante aprende descomentando código.

#### ❌ NO usar este formato en ejercicios:

```cobol
      *> ❌ INCORRECTO - Este formato es para PROYECTOS
       01  WS-RESULTADO   PIC X(50).
       PROCEDURE DIVISION.
           MOVE SPACES TO WS-RESULTADO.
      *    TODO: Implementar lógica
           STOP RUN.
```

#### ✅ Usar este formato en ejercicios:

```cobol
      *> ✅ CORRECTO - Código comentado para descomentar
      *> Descomenta las siguientes líneas:
      *01  WS-NOMBRE     PIC X(30).
      *01  WS-EDAD       PIC 9(03).
      *PROCEDURE DIVISION.
      *    DISPLAY "Ingrese su nombre: "
      *    ACCEPT WS-NOMBRE.
      *    DISPLAY "Hola " WS-NOMBRE.
      *    STOP RUN.
```

### 3. **Proyecto** (3-proyecto/)

- Proyecto integrador que consolida lo aprendido
- Código inicial en `starter/` con TODOs
- Carpeta `solution/` oculta (en `.gitignore`) solo para instructores

#### 📋 Formato de Proyecto (con TODOs)

```cobol
      *> PROYECTO: Sistema de Cuentas Bancarias
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANCO.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CUENTAS-FILE ASSIGN TO "cuentas.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD  CUENTAS-FILE.
       01  CUENTA-REG.
           05 CUENTA-ID        PIC 9(05).
           05 CUENTA-NOMBRE    PIC X(30).
           05 CUENTA-SALDO     PIC 9(07)V99.
       
       WORKING-STORAGE SECTION.
       01  WS-CUENTA.
           05 WS-ID            PIC 9(05) VALUE ZEROS.
           05 WS-NOMBRE        PIC X(30) VALUE SPACES.
           05 WS-SALDO         PIC 9(07)V99 VALUE ZEROS.
       01  WS-SALDO-EDIT       PIC Z,ZZZ,ZZ9.99.
       01  WS-OPCION           PIC 9 VALUE ZEROS.
       
       PROCEDURE DIVISION.
       MAIN.
           PERFORM UNTIL WS-OPCION = 9
               DISPLAY "=== SISTEMA BANCARIO ==="
               DISPLAY "1. Consultar saldo"
               DISPLAY "2. Depositar"
               DISPLAY "3. Retirar"
               DISPLAY "9. Salir"
               ACCEPT WS-OPCION
               EVALUATE WS-OPCION
                   WHEN 1
      *                TODO: PERFORM CONSULTAR-SALDO
                       DISPLAY "Opción 1 no implementada"
                   WHEN 2
      *                TODO: PERFORM DEPOSITAR
                       DISPLAY "Opción 2 no implementada"
                   WHEN 3
      *                TODO: PERFORM RETIRAR
                       DISPLAY "Opción 3 no implementada"
               END-EVALUATE
           END-PERFORM.
           STOP RUN.
```

---

## 📝 Convenciones de Código

### Estilo COBOL Moderno

```cobol
      *> ✅ BIEN - Identificadores significativos en inglés
       01  WS-CUSTOMER-RECORD.
           05 WS-CUST-ID           PIC 9(05).
           05 WS-CUST-NAME         PIC X(30).
           05 WS-CUST-BALANCE      PIC S9(07)V99.

      *> ✅ BIEN - FILE STATUS en cada operación
           READ CUSTOMER-FILE
               AT END SET WS-EOF TO TRUE
               NOT AT END PERFORM 2000-PROCESS-RECORD
           END-READ.

      *> ✅ BIEN - EVALUATE para múltiples condiciones
           EVALUATE WS-TRANSACTION-TYPE
               WHEN "D" PERFORM 3000-DEPOSIT
               WHEN "W" PERFORM 3000-WITHDRAW
               WHEN "T" PERFORM 3000-TRANSFER
               WHEN OTHER PERFORM 9000-INVALID-TYPE
           END-EVALUATE.

      *> ❌ MAL - Sin prefijos, nombres no descriptivos
       01  REG.
           05 ID          PIC 9(5).
           05 NOM         PIC X(30).

      *> ❌ MAL - Sin FILE STATUS
           READ CUSTOMER-FILE.
```

### Nomenclatura

- **Variables WORKING-STORAGE**: Prefijo `WS-` (snake-case con guiones)
- **Variables FILE SECTION**: Prefijo del archivo (ej: `CUENTA-`)
- **Variables LINKAGE SECTION**: Prefijo `LK-` o `LS-`
- **Párrafos**: Prefijo numérico opcional (`1000-INICIO`, `2000-PROCESAR`)
- **Nombres de programa**: Mayúsculas, máx 8 caracteres en sistemas legacy
- **Archivos fuente**: `.cbl` o `.cob`
- **COPYBOOKS**: `.cpy` o `.cob`
- **Idioma**: Inglés para código, español para documentación

### Estructura de Programa COBOL

```cobol
      *> PROGRAMA: Sistema de Nómina
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOMINA.
       AUTHOR. EQUIPO-BOOTCAMP.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLEADOS ASSIGN TO "empleados.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-EMP.
       
       DATA DIVISION.
       FILE SECTION.
       FD  EMPLEADOS.
       01  EMP-REG.
           05 EMP-ID        PIC 9(05).
           05 EMP-NOMBRE    PIC X(30).
       
       WORKING-STORAGE SECTION.
       01  WS-FS-EMP        PIC X(02).
           88 WS-EMP-OK     VALUE "00".
           88 WS-EMP-EOF    VALUE "10".
       
       PROCEDURE DIVISION.
       1000-MAIN.
           PERFORM 2000-INICIO
           PERFORM 3000-PROCESO UNTIL WS-EMP-EOF
           PERFORM 9000-FIN
           STOP RUN.
```

---

## 🧪 Testing COBOL

El bootcamp usa scripts shell para testing:

### Estructura de Tests

```bash
# test.sh para cada proyecto
#!/bin/bash
set -e

echo "=== Compilando ==="
cobc -x -o programa programa.cbl

echo "=== Preparando datos ==="
echo "00001Juan Perez          000010000" > test-input.dat

echo "=== Ejecutando ==="
./programa < test-input.dat > test-output.txt

echo "=== Verificando ==="
diff test-output.txt test-expected.txt
echo "✅ Tests pasados"
```

### Convenciones de Testing

- Script `test.sh` en carpeta raíz del proyecto
- Archivos `.dat` para datos de entrada
- Archivos `.expected` para salida esperada
- Verificar con `diff` contra archivos esperados
- FILE STATUS en cada operación de archivo

---

## 🎨 Recursos Visuales

### Formato de Assets

- ✅ **Preferir SVG** para diagramas, arquitecturas y flujos
- ❌ **NO usar ASCII art** para diagramas
- ✅ Tema oscuro, colores sólidos, sin degradés
- ✅ Paleta azul corporativo (#1565C0) para COBOL
- ✅ Fuentes sans-serif (Inter, Roboto)

### Criterio para Assets SVG

- Apoyo visual para comprensión de conceptos
- Diagramas de flujo de archivos: secuencial, indexado, relativo
- Jerarquía de datos: niveles 01-49
- Flujo de proceso batch: JCL → COBOL → archivos
- Arquitectura CICS: regiones, transacciones, programas

---

## 🌐 Idioma y Nomenclatura

### Código y Comentarios Técnicos

- ✅ **Nomenclatura en inglés** (variables, párrafos, divisiones)
- ✅ **Comentarios de código en inglés** (técnicos)
- ✅ Comentarios explicativos pueden estar en español

```cobol
      *> ✅ CORRECTO - código en inglés
       01  WS-CUSTOMER-NAME     PIC X(30).
      *> Get customer record by ID
           PERFORM 2000-GET-CUSTOMER.

      *> ❌ INCORRECTO - español en código
       01  WS-NOMBRE-CLIENTE    PIC X(30).
      *> Obtener registro del cliente
           PERFORM 2000-OBTENER-CLIENTE.
```

### Documentación

- ✅ **Documentación en español** (READMEs, teoría, guías)
- ✅ Explicaciones educativas en español

---

## 🔐 Mejores Prácticas COBOL

### Código Limpio

- Párrafos con una sola responsabilidad
- Nombres descriptivos con prefijos consistentes (WS-, FD-, LK-)
- Usar 88-level para condiciones booleanas
- PERFORM THRU para agrupar párrafos relacionados
- Inicializar variables explícitamente

### Manejo de Archivos

- FILE STATUS en cada operación
- Verificar OPEN exitoso antes de READ/WRITE
- Cerrar archivos en procedimiento de salida
- Usar ORGANIZATION adecuada (SEQUENTIAL, INDEXED, RELATIVE)

### Seguridad

- Validar todos los inputs (ACCEPT, parámetros)
- Verificar permisos antes de abrir archivos
- No hardcodear rutas absolutas
- Manejar SQLCODE en EXEC SQL
- Sanitizar datos antes de EXEC SQL con host variables

### Rendimiento

- Usar SEARCH ALL para tablas ordenadas grandes
- Minimizar I/O con buffers adecuados
- PERFORM VARYING con límites claros
- SORT en memoria cuando sea posible

---

## 📊 Evaluación

Cada semana incluye **tres tipos de evidencias**:

1. **Conocimiento 🧠** (30%): Cuestionarios teóricos sobre conceptos COBOL
2. **Desempeño 💪** (40%): Ejercicios prácticos en clase
3. **Producto 📦** (30%): Proyecto entregable funcional (compila y ejecuta)

### Criterios de Aprobación

- Mínimo **70%** en cada tipo de evidencia
- Código que compila sin errores con `cobc`
- FILE STATUS manejado correctamente
- Script de prueba `test.sh` pasando
- Entrega puntual de proyectos

---

## 🚀 Metodología de Aprendizaje

### Estrategias Didácticas

- **Aprendizaje Basado en Proyectos (ABP)**: Proyectos semanales integradores
- **Práctica Deliberada**: Ejercicios incrementales comentados
- **Code Challenges**: Problemas de procesamiento de archivos y datos
- **Code Review**: Revisión de código entre estudiantes
- **Live Coding**: Sesiones en vivo con GnuCOBOL

### Distribución del Tiempo (10h/semana)

- **Teoría**: 2.5-3 horas
- **Prácticas**: 4-5 horas
- **Proyecto**: 2.5-3 horas

---

## 🤖 Instrucciones para Copilot

Cuando trabajes en este proyecto:

### Límites de Respuesta

1. **Divide respuestas largas**
   - ❌ **NUNCA generar respuestas que superen los límites de tokens**
   - ✅ **SIEMPRE dividir contenido extenso en múltiples entregas**
   - ✅ Crear contenido por secciones, esperar confirmación del usuario
   - ✅ Priorizar calidad sobre cantidad en cada entrega

2. **Estrategia de División**
   - Para semanas completas: dividir por carpetas (teoria → practicas → proyecto)
   - Para archivos grandes: dividir por secciones lógicas
   - Siempre indicar claramente qué parte se entrega y qué falta

### Generación de Código COBOL

1. **Entorno Docker obligatorio**
   - ❌ **NUNCA** generar comandos que asuman GnuCOBOL instalado localmente
   - ✅ **SIEMPRE** ejecutar compilación y pruebas dentro del contenedor Docker
   - ✅ Usar `docker compose exec cobol bash -c "..."` para comandos COBOL
   - ✅ Referenciar `docs/docker-setup.md` para configuración del entorno
   - Razón: Docker es la única vía de ejecución, garantiza entorno idéntico

2. **Usa GnuCOBOL 3.2+ con formato libre**
   - Compilar con `cobc -x -free programa.cbl` (dentro del contenedor)
   - No requiere números de secuencia (columnas 1-6)
   - Usar `*> ` para comentarios en línea
   - Usar `>>SOURCE FORMAT IS FREE` al inicio

3. **Incluir siempre**:
   - Todas las divisiones requeridas
   - FILE STATUS para archivos
   - Manejo de errores con AT END / INVALID KEY
   - Inicialización de variables

4. **Estructura de ejemplo**:
   ```cobol
   >>SOURCE FORMAT IS FREE
   IDENTIFICATION DIVISION.
   PROGRAM-ID. EJEMPLO.
   
   ENVIRONMENT DIVISION.
   INPUT-OUTPUT SECTION.
   FILE-CONTROL.
       SELECT ARCHIVO ASSIGN TO "datos.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
   
   DATA DIVISION.
   FILE SECTION.
   FD  ARCHIVO.
   01  REG-ARCHIVO PIC X(80).
   
   WORKING-STORAGE SECTION.
   01  WS-CONTADOR PIC 9(05) VALUE ZEROS.
   
   PROCEDURE DIVISION.
       OPEN INPUT ARCHIVO
       PERFORM UNTIL EXIT
           READ ARCHIVO AT END EXIT PERFORM END-READ
           ADD 1 TO WS-CONTADOR
       END-PERFORM
       CLOSE ARCHIVO
       DISPLAY "Registros: " WS-CONTADOR
       STOP RUN.
   ```

   Compilar y ejecutar:
   ```bash
   docker compose exec cobol bash -c "cd bootcamp/week-XX-tema && cobc -x -free programa.cbl && ./programa"
   ```

5. **Comenta el código de manera educativa**
   - Explica qué hace cada párrafo
   - Usa comentarios `*> `
   - Señala equivalentes en otros lenguajes cuando sea útil

### Creación de Contenido

1. **Estructura clara y progresiva**
   - De lo simple a lo complejo
   - Conceptos construidos sobre conocimientos previos
   - Cada semana asume dominio de semanas anteriores

2. **Ejemplos del mundo real**
   - Casos bancarios: cuentas, transacciones, balances
   - Casos de seguros: pólizas, reclamos, primas
   - Casos gubernamentales: registros, impuestos, censos

3. **Enfoque moderno**
   - Enfocarse en GnuCOBOL (no dialectos propietarios)
   - Usar características COBOL 85/2002 estándar
   - Preparar para entornos reales mainframe

---

## 📚 Referencias Oficiales

- **GnuCOBOL Documentation**: https://gnucobol.sourceforge.io/
- **IBM COBOL Language Reference**: https://www.ibm.com/docs/en/cobol-zos
- **COBOL Programming Course (Open Mainframe Project)**: https://github.com/openmainframeproject/cobol-programming-course
- **ISO COBOL 2023 Standard**: https://www.iso.org/standard/74527.html
- **DB2 for z/OS COBOL**: https://www.ibm.com/docs/en/db2-for-zos
- **CICS Documentation**: https://www.ibm.com/docs/en/cics-ts

---

## 🔗 Enlaces Importantes

- **Repositorio**: https://github.com/ergrato-dev/bc-cobol
- **Documentación general**: [docs/README.md](docs/README.md)
- **Primera semana**: [bootcamp/week-01-introduccion-cobol/README.md](bootcamp/week-01-introduccion-cobol/README.md)

---

## ✅ Checklist para Nuevas Semanas

Cuando crees contenido para una nueva semana:

- [ ] Crear estructura de carpetas completa
- [ ] README.md con objetivos y estructura
- [ ] rubrica-evaluacion.md con criterios
- [ ] Material teórico en 1-teoria/
- [ ] Ejercicios prácticos en 2-practicas/ con código comentado
- [ ] Proyecto integrador en 3-proyecto/ con TODOs
- [ ] Recursos adicionales en 4-recursos/
- [ ] Glosario de términos COBOL en 5-glosario/
- [ ] Script test.sh para el proyecto
- [ ] Verificar que el código compila con `docker compose exec cobol bash -c "cobc -x -free programa.cbl"`
- [ ] Revisar progresión de dificultad
- [ ] Verificar coherencia con semanas anteriores

---

## 💡 Notas Finales

- **Prioridad**: Claridad sobre brevedad
- **Enfoque**: Aprendizaje práctico sobre teoría abstracta
- **Objetivo**: Preparar desarrolladores COBOL listos para mainframe/banca
- **Filosofía**: GnuCOBOL open source desde el día 1
- **Validación**: Todo código debe compilar con `docker compose exec cobol bash -c "cobc -x -free programa.cbl"`

---

_Última actualización: Junio 2026_
_Versión: 1.0_
