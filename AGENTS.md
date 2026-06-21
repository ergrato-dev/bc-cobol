# AGENTS.md - Instrucciones para OpenCode

## Contexto

Este repositorio es un **Bootcamp COBOL Zero to Hero**. Diseñado para que estudiantes aprendan COBOL desde cero hasta nivel de desarrollador junior, usando GnuCOBOL (open source) como compilador principal.

## Stack

- **Entorno de ejecución**: Docker + Docker Compose (ÚNICA vía aceptada)
- **Compilador**: GnuCOBOL 3.2+ (cobc) — dentro del contenedor Docker
- **Editor**: VS Code con extensión COBOL
- **Base de datos para SQL embebido**: PostgreSQL 16+ (servicio Docker)
- **Sistema operativo host**: Linux, macOS o Windows con Docker
- **Control de versiones**: Git

## Idioma

- **Código COBOL**: inglés (nombres de variables, párrafos, divisiones)
- **Comentarios de código**: español (explicativos), inglés (técnicos)
- **Documentación**: español (READMEs, teoría, guías)
- **Commits**: inglés con conventional commits

## Convenciones COBOL

- Columnas 1-6: números de secuencia (opcional en GnuCOBOL)
- Columna 7: indicador (* comentario, - continuación, D debugging)
- Columnas 8-11: Área A (divisiones, secciones, párrafos, 01, 77)
- Columnas 12-72: Área B (sentencias, niveles 02-49)
- Columnas 73-80: área de identificación (opcional)

## Estructura de semanas

Cada semana sigue la estructura:
```
bootcamp/week-XX-tema/
├── README.md               # Objetivos, contenidos, entregables
├── rubrica-evaluacion.md   # Criterios de evaluación
├── 0-assets/               # Diagramas SVG (tema oscuro, sin degradés)
├── 1-teoria/               # Material teórico en markdown
├── 2-practicas/            # Ejercicios guiados (código comentado para descomentar)
├── 3-proyecto/             # Proyecto integrador con TODOs
│   ├── starter/            # Código inicial
│   └── solution/           # SOLO instructores (.gitignore)
├── 4-recursos/
│   ├── ebooks-free/
│   ├── videografia/
│   └── webgrafia/
└── 5-glosario/
    └── README.md
```

## Diseño visual

- Tema oscuro para assets SVG
- Sin degradés, colores sólidos
- Paleta azul corporativo (#1565C0) para COBOL
- Fuentes sans-serif (Inter, Roboto)
- NO ASCII art para diagramas

## Testing COBOL

- Usar scripts shell para compilar y ejecutar programas de prueba **dentro del contenedor Docker**
- Validar salidas con diff contra archivos esperados
- FILE STATUS en cada operación de archivo
- Script `test.sh` en cada proyecto que compile y ejecute casos de prueba
- Ejemplo: `docker compose exec cobol bash -c "cd bootcamp/week-04-archivos-secuenciales/3-proyecto && bash test.sh"`

## Límites de respuesta

- Dividir contenido extenso en múltiples entregas
- No generar respuestas que excedan límites de tokens
- Cada semana se divide por carpetas: teoría → prácticas → proyecto
