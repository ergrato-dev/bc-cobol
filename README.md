# ![Bootcamp COBOL Zero to Hero](./assets/bootcamp-header.svg)

[![License CC BY-NC-SA 4.0](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey.svg)](./LICENSE) [![14 Semanas](https://img.shields.io/badge/semanas-14-yellow.svg)](#) [![140 Horas](https://img.shields.io/badge/horas-140-orange.svg)](#) [![COBOL](https://img.shields.io/badge/COBOL-0D47A1?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0yIDJoMjB2MjBIMnptMiAyaDE2djE2SDR6bTIgMmgxMnYxMkg2em0yIDJoOHY4SDh6Ii8+PC9zdmc+&logoColor=white)](#)

[![English Version](https://img.shields.io/badge/%F0%9F%87%BA%F0%9F%87%B8_English-0969DA?style=for-the-badge&logoColor=white)](./README_EN.md)

---

## 📋 Descripción

Bootcamp intensivo de **14 semanas (~3.5 meses)** enfocado en el dominio de **COBOL** y desarrollo de sistemas empresariales. Diseñado para llevar a estudiantes de cero a **Desarrollador COBOL Junior**, con énfasis en procesamiento batch, manejo de archivos, SQL embebido y sistemas de misión crítica.

### 🎯 Objetivos

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

### 🏦 ¿Por qué COBOL?

> **COBOL mueve el mundo financiero** — El 95% de transacciones ATM y el 80% de transacciones financieras pasan por COBOL.

COBOL sigue siendo el lenguaje dominante en banca, seguros, gobierno y mainframes. Este bootcamp usa **GnuCOBOL** (open source, compatible con estándares) para que cualquier persona pueda aprender sin necesidad de un mainframe costoso.

---

## 🗓️ Estructura del Bootcamp

| Etapa | Semanas | Horas | Temas Principales |
|-------|---------|-------|-------------------|
| **Fundamentos** | 1-3 | 30h | Introducción, DATA DIVISION, PROCEDURE DIVISION |
| **Procesamiento** | 4-7 | 40h | Archivos secuenciales, indexados, tablas, strings |
| **Modularización** | 8-9 | 20h | Subprogramas, COPYBOOKS, reutilización |
| **Batch** | 10-12 | 30h | Reportes, SORT/MERGE, SQL embebido |
| **Producción** | 13-14 | 20h | CICS, proyecto final |

**Total: 14 semanas** | **140 horas** de formación intensiva (10h/semana)

> ⚠️ **Duración flexible**: La cantidad de semanas depende del logro de los objetivos de aprendizaje. Los recursos y ejercicios se ajustan según las necesidades de cada grupo, no según un conteo fijo predeterminado. Algunos grupos pueden necesitar más o menos semanas.

---

## 📚 Contenido por Semana

Cada semana incluye:

```
bootcamp/week-XX-tema_principal/
├── README.md                 # Descripción y objetivos
├── rubrica-evaluacion.md     # Criterios de evaluación
├── 0-assets/                 # Diagramas y recursos visuales
├── 1-teoria/                 # Material teórico
├── 2-practicas/              # Ejercicios guiados
├── 3-proyecto/               # Proyecto semanal
├── 4-recursos/               # Recursos adicionales
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/               # Términos clave
```

### 🔑 Componentes Clave

- 📖 **Teoría**: Conceptos fundamentales con ejemplos del mundo real
- 💻 **Práctica**: Ejercicios progresivos con código comentado para descomentar
- 📝 **Evaluación**: Evidencias de conocimiento, desempeño y producto
- 🎓 **Recursos**: Glosarios, referencias y material complementario

---

## 🛠️ Stack Tecnológico

| Tecnología | Versión | Uso |
|-----------|---------|-----|
| Docker | **27.5+** | Entorno de ejecución (OBLIGATORIO) |
| Docker Compose | **2.32+** | Orquestación de servicios |
| GnuCOBOL | **3.2+** | Compilador COBOL (en contenedor) |
| PostgreSQL | **16+** | Base de datos para SQL embebido (servicio) |
| bash/sh | **5.2+** | Scripts de compilación y testing |
| Git | **2.47+** | Control de versiones |
| VS Code | **1.96+** | Editor recomendado |

**Entorno de desarrollo**: Docker + docker compose (❌ NO instalar GnuCOBOL localmente)
**Compilador**: GnuCOBOL (cobc) con flags `-free` — dentro del contenedor

---

## 🚀 Inicio Rápido

### Prerrequisitos

- **Docker** y **Docker Compose** instalados
- **Git** para control de versiones
- **VS Code** (recomendado) con extensión COBOL

### 1. Clonar el Repositorio

```bash
git clone https://github.com/ergrato-dev/bc-cobol.git
cd bc-cobol
```

### 2. Instalar Extensiones de VS Code

```bash
code .
# Las extensiones recomendadas aparecerán automáticamente
# Ctrl+Shift+P → "Extensions: Show Recommended Extensions"
```

### 3. Construir y Levantar el Entorno Docker

```bash
docker compose up --build -d
```

### 4. Entrar al Contenedor COBOL

```bash
docker compose exec cobol bash
```

### 5. Navegar a la Semana Actual

```bash
cd bootcamp/week-01-introduccion-cobol
cobc -x -free hola.cbl
./hola
```

> 📖 Guía Docker completa: [docs/docker-setup.md](docs/docker-setup.md)

---

## 📊 Metodología de Aprendizaje

### Estrategias Didácticas

- 🎯 **Aprendizaje Basado en Proyectos (ABP)**
- 🧩 **Práctica Deliberada**
- 🔄 **Code Challenges**
- 👥 **Code Review entre pares**
- 🎮 **Live Coding con GnuCOBOL**

### Distribución del Tiempo (10h/semana)

- **Teoría**: 2.5-3 horas
- **Prácticas**: 4-5 horas
- **Proyecto**: 2.5-3 horas

### Evaluación

Cada semana incluye tres tipos de evidencias:

1. **Conocimiento 🧠** (30%): Cuestionarios y evaluaciones teóricas
2. **Desempeño 💪** (40%): Ejercicios prácticos en clase
3. **Producto 📦** (30%): Entregables evaluables (proyectos funcionales)

**Criterio de aprobación**: Mínimo 70% en cada tipo de evidencia

---

## 📆 Detalle de Semanas

| Sem | Tema | Objetivo Principal |
|-----|------|--------------------|
| 01 | Introducción a COBOL | Historia, GnuCOBOL, estructura de 4 divisiones, Hola Mundo |
| 02 | DATA DIVISION | PICTURE, USAGE, VALUE, tipos de datos, 01-49 |
| 03 | PROCEDURE DIVISION | MOVE, COMPUTE, IF/EVALUATE, PERFORM básico |
| 04 | Archivos Secuenciales | OPEN, READ, WRITE, CLOSE, FILE STATUS |
| 05 | Archivos Indexados | INDEXED, ACCESS MODE, START, DELETE, REWRITE |
| 06 | Tablas y Arrays | OCCURS, INDEXED BY, SEARCH, SEARCH ALL |
| 07 | Manipulación de Strings | STRING, UNSTRING, INSPECT, referencia/modificación |
| 08 | Subprogramas y COPYBOOKS | CALL, LINKAGE SECTION, parámetros, COPY |
| 09 | Reportes Profesionales | WRITE BEFORE/AFTER, control de página, encabezados |
| 10 | SORT y MERGE | Ordenamiento de archivos, fusión, archivos temporales |
| 11 | SQL Embebido | EXEC SQL, cursores, transacciones ACID |
| 12 | JCL Fundamentos | JOB, EXEC, DD, procedimientos catalogados |
| 13 | CICS Fundamentos | Transacciones, MAPS, pseudo-conversación |
| 14 | Proyecto Final | Sistema bancario: batch + online + SQL |

---

## 📞 Soporte

- 💬 **Discussions**: [GitHub Discussions](https://github.com/ergrato-dev/bc-cobol/discussions)
- 🐛 **Issues**: [GitHub Issues](https://github.com/ergrato-dev/bc-cobol/issues)

---

## ⚠️ Exención de Responsabilidad

Este repositorio es un recurso **educativo** creado con fines de aprendizaje. Al utilizarlo, aceptas los siguientes términos:

- **Solo fines educativos**: El contenido, los ejemplos de código y los proyectos están diseñados exclusivamente para la enseñanza y el aprendizaje.
- **Sin garantías**: El material se proporciona **"tal cual"**, sin garantías de ningún tipo.
- **Código en producción**: Los ejemplos son ilustrativos. Antes de usarlos en entornos productivos, debes realizar revisiones de seguridad y adaptación a tu contexto.
- **Limitación de responsabilidad**: Los autores y contribuidores no se responsabilizan por pérdidas de datos, daños directos o indirectos derivados del uso de este material.

---

## 📄 Licencia

Este proyecto está bajo la licencia **[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)**.

**Puedes:** compartir y adaptar el material, crear forks educativos.
**No puedes:** usar este material con fines comerciales.
**Debes:** dar crédito apropiado y distribuir adaptaciones bajo la misma licencia.

---

## 🏆 Agradecimientos

- [GnuCOBOL](https://gnucobol.sourceforge.io/) - Compilador COBOL open source
- [COBOL Programming Course](https://github.com/openmainframeproject/cobol-programming-course) - Open Mainframe Project
- [IBM COBOL Documentation](https://www.ibm.com/docs/en/cobol-zos) - Referencia oficial
- Comunidad COBOL - Por mantener vivo el lenguaje

---

## 📚 Documentación Adicional

- [🤖 Instrucciones de Copilot](.github/copilot-instructions.md)
- [📜 Código de Conducta](CODE_OF_CONDUCT.md)
- [🔒 Política de Seguridad](SECURITY.md)

---

**🎓 Bootcamp COBOL - Zero to Hero**
*De cero a desarrollador COBOL junior*

[Comenzar Semana 1](bootcamp/week-01-introduccion-cobol) · [Ver Documentación](docs) · [Reportar Issue](https://github.com/ergrato-dev/bc-cobol/issues)
