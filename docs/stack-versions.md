# 📦 Stack Tecnológico - Versiones

## Versiones Oficiales

| Tecnología | Versión | Rol |
|-----------|---------|-----|
| **Docker** | 27.5+ | Entorno de ejecución (OBLIGATORIO) |
| **Docker Compose** | 2.32+ | Orquestación de servicios |
| **GnuCOBOL** | 3.2+ | Compilador COBOL (dentro de contenedor) |
| **PostgreSQL** | 16+ | Base de datos para SQL embebido (servicio) |
| **bash** | 5.2+ | Scripts de compilación y testing |
| **Git** | 2.47+ | Control de versiones |
| **VS Code** | 1.96+ | Editor recomendado |

## Instalación de Prerrequisitos

### Docker + Docker Compose

**Fedora 41+**
```bash
sudo dnf install docker-ce docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Cerrar sesión y volver a entrar
```

**Ubuntu 24.04+**
```bash
sudo apt install docker.io docker-compose-v2
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

**macOS / Windows**
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Verificación

```bash
docker --version        # Docker version 27.5+
docker compose version  # Docker Compose version v2.32+
```

> ⚠️ **NO instalar GnuCOBOL localmente.** El compilador está dentro de la imagen Docker y se usa exclusivamente desde el contenedor.

## Construir el Entorno

```bash
cd bc-cobol
docker compose up --build -d
docker compose exec cobol bash

# Dentro del contenedor:
cobc --version
# GnuCOBOL 3.2.0 or higher expected
```

## Compatibilidad

- **Formato**: Se usa `>>SOURCE FORMAT IS FREE` para eliminar restricciones de columnas
- **Estándar**: COBOL 85 con extensiones COBOL 2002
- **SQL Embebido**: PostgreSQL con `esqlOC` o compilador con soporte SQL
- **JCL**: Simulado con scripts bash (no requiere mainframe real)
- **CICS**: Simulado con CICS-compatible open source o explicación conceptual
