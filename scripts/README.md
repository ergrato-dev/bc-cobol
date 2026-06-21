# 🔄 Auto-commit Scripts

Scripts para automatizar commits en el repositorio del bootcamp COBOL.

## 📋 Archivos

| Archivo | Descripción |
|---------|-------------|
| `autocommit.sh` | Script principal de auto-commit |
| `install-autocommit.sh` | Instalador del timer systemd (Fedora) |
| `logs/` | Directorio de logs (auto-generado) |

## 🚀 Instalación

```bash
# Dar permisos de ejecución
chmod +x scripts/*.sh

# Instalar con intervalo por defecto (30 minutos)
./scripts/install-autocommit.sh install

# Instalar con intervalo personalizado
./scripts/install-autocommit.sh install 1h
./scripts/install-autocommit.sh install 15min
```

## 📊 Comandos Útiles

```bash
./scripts/install-autocommit.sh status    # Ver estado
./scripts/install-autocommit.sh run       # Ejecutar manualmente
./scripts/install-autocommit.sh uninstall # Desinstalar
```

## 🏷️ Formato de Commits

Conventional commits en inglés:

```
type(scope): what

What: description
For: purpose
Impact: effect

Auto-committed by bc-cobol autocommit script
```

### Tipos Detectados

| Tipo | Condición |
|------|-----------|
| `feat` | Archivos en `2-practicas/`, `3-proyecto/`, `*.cbl`, `*.cob` |
| `docs` | Archivos en `1-teoria/`, `4-recursos/`, `5-glosario/`, `*.md` |
| `fix` | Archivos con "fix", "bug", "error" en nombre |
| `chore` | Archivos de configuración, `scripts/` |
| `ci` | Archivos en `.github/` |
| `refactor` | Archivos con "refactor" en nombre |

### Scope Detectado

- `week-XX` - Cambios en una semana específica
- `docs` - Cambios en `docs/`
- `scripts` - Cambios en `scripts/`
- `assets` - Cambios en `assets/`
- `github` - Cambios en `.github/`
