# 🔒 Política de Seguridad y Dependencias

## Regla de Oro

> **Toda operación de archivo debe verificar FILE STATUS. Toda operación SQL debe verificar SQLCODE.**

## Dependencias

Este bootcamp tiene dependencias mínimas por diseño:

### Dependencias del Sistema

- **GnuCOBOL 3.2+**: Compilador principal. Disponible en repositorios oficiales de Fedora y Ubuntu.
- **libcob**: Biblioteca runtime de GnuCOBOL. Se instala automáticamente con el compilador.

### Dependencias Opcionales

- **PostgreSQL 16+**: Solo para semanas 11+ (SQL embebido)
  - `libpq-dev` o `postgresql-devel` para cabeceras de desarrollo
  - `esqlOC` o procesador SQL embebido
- **Docker 27.5+**: Alternativa de entorno aislado
- **SQLite 3.48+**: Para testing rápido sin PostgreSQL

## Auditoría de Seguridad

### Verificar versión de GnuCOBOL

```bash
cobc --version | head -1
# Debe mostrar 3.2 o superior
```

### Verificar dependencias de compilación

```bash
cobc --info | grep -i "built"
# Verificar que incluye soporte necesario
```

## Actualización de Stack

- Revisar new releases de GnuCOBOL en https://gnucobol.sourceforge.io/
- Actualizar antes de iniciar cada cohorte del bootcamp
- Mantener versiones de sistema operativo actualizadas (security patches)

## Reporte de Vulnerabilidades

Ver [SECURITY.md](../SECURITY.md) para el procedimiento completo de reporte de vulnerabilidades.
