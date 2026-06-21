# 📚 Documentación del Bootcamp

Esta carpeta contiene documentación general que aplica a todo el bootcamp.

## 📋 Índice

| Documento | Descripción |
|-----------|-------------|
| [docker-setup.md](docker-setup.md) | 🐳 Configuración del entorno Docker (ÚNICA vía de ejecución) |
| [stack-versions.md](stack-versions.md) | Versiones oficiales de todas las tecnologías |
| [dependency-security-policy.md](dependency-security-policy.md) | 🔒 Política de seguridad y dependencias |

## 🐳 Entorno de Desarrollo

Este bootcamp usa **Docker** como entorno **obligatorio** de desarrollo:

- ✅ Entorno idéntico para todos los estudiantes e instructores
- ✅ Sin instalaciones locales — solo Docker y Docker Compose requeridos
- ✅ GnuCOBOL 3.2+ preinstalado en la imagen
- ✅ PostgreSQL 16+ como servicio en el compose
- ✅ Volúmenes persistentes para datos y salidas

> ⚠️ **IMPORTANTE**: Docker es la **única** vía de ejecución aceptada.
> No instalar GnuCOBOL localmente. No usar compiladores del sistema.

### Requisitos

- Docker 27.5+
- Docker Compose 2.32+
- Git 2.47+
- VS Code con extensión COBOL

### Inicio Rápido

```bash
# Clonar repositorio
git clone https://github.com/ergrato-dev/bc-cobol.git
cd bc-cobol

# Construir y levantar servicios
docker compose up --build -d

# Entrar al entorno COBOL
docker compose exec cobol bash

# Dentro del contenedor, ir a una semana y compilar
cd bootcamp/week-01-introduccion-cobol
cobc -x -free hola.cbl
./hola
```

Ver [docker-setup.md](docker-setup.md) para la guía completa.

## 📦 Stack Tecnológico

| Categoría | Tecnologías |
|-----------|-------------|
| **Entorno** | Docker 27.5+, Docker Compose 2.32+ |
| **Compilador** | GnuCOBOL 3.2+ (en contenedor) |
| **Base de Datos** | PostgreSQL 16+ (servicio Docker) |
| **Testing** | Scripts bash, diff (en contenedor) |
| **Editor** | VS Code + extensión COBOL |
| **Control de Versiones** | Git 2.47+ |

Ver [stack-versions.md](stack-versions.md) para versiones detalladas.

## 🔗 Enlaces Útiles

- [GnuCOBOL Documentation](https://gnucobol.sourceforge.io/)
- [IBM COBOL Language Reference](https://www.ibm.com/docs/en/cobol-zos)
- [COBOL Programming Course (Open Mainframe Project)](https://github.com/openmainframeproject/cobol-programming-course)
- [ISO COBOL 2023](https://www.iso.org/standard/74527.html)
