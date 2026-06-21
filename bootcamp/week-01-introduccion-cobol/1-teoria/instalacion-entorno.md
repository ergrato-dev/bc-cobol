# Instalación del Entorno (Docker)

## 🎯 Objetivos

- Verificar Docker y Docker Compose instalados
- Construir el entorno COBOL con `docker compose`
- Entrar al contenedor y ejecutar el primer comando COBOL

> ⚠️ **IMPORTANTE**: Docker es la **única** vía de ejecución aceptada en este bootcamp. No instalar GnuCOBOL localmente.

---

## 1. Prerrequisitos

### Verificar Docker

```bash
docker --version
# Docker version 27.5.0 o superior
```

Si no tienes Docker instalado:

**Fedora 41+**
```bash
sudo dnf install docker-ce docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Cierra sesión y vuelve a entrar
```

**Ubuntu 24.04+**
```bash
sudo apt install docker.io docker-compose-v2
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

**macOS / Windows**: [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Verificar Docker Compose

```bash
docker compose version
# Docker Compose version v2.32.0 o superior
```

---

## 2. Construir el Entorno

Desde la raíz del repositorio:

```bash
cd bc-cobol
docker compose up --build -d
```

Esto:
1. Construye la imagen `bc-cobol:latest` (Fedora 41 + GnuCOBOL 3.2+)
2. Crea el contenedor `bc-cobol-dev` listo para desarrollo
3. Levanta `bc-cobol-db` (PostgreSQL 16) para semanas futuras
4. Crea volúmenes para datos persistentes

```bash
# Verificar que los contenedores están corriendo
docker compose ps

# Deberías ver:
# NAME              STATUS
# bc-cobol-dev      Up
# bc-cobol-db       Up (healthy)
```

---

## 3. Entrar al Contenedor

```bash
docker compose exec cobol bash
```

Verás el prompt del contenedor:

```
============================================
  Bootcamp COBOL Zero to Hero
  GnuCOBOL: GnuCOBOL 3.2.0
============================================

Comandos útiles:
  cobc -x -free programa.cbl  → compilar
  ./programa                   → ejecutar
  cobc -x -Wall programa.cbl   → compilar con warnings
  bash test.sh                 → ejecutar pruebas

[cobol@cobol-dev workspace]$
```

---

## 4. Primer Comando COBOL

Dentro del contenedor, verifica que GnuCOBOL funcione:

```bash
cobc --version | head -1
# GnuCOBOL 3.2.0
```

Explora los flags del compilador:

```bash
cobc --help | head -30
```

Flags principales que usaremos:

| Flag | Significado |
|------|-------------|
| `-x` | Construir ejecutable |
| `-free` | Formato libre (sin columnas fijas) |
| `-Wall` | Mostrar todos los warnings |
| `-o ARCHIVO` | Nombre del archivo de salida |
| `-c` | Solo compilar, no enlazar |
| `-m` | Compilar como módulo/subprograma |

---

## 5. Navegar el Repositorio dentro del Contenedor

```bash
# El directorio del host está montado en /workspace
ls /workspace

# Ver la estructura del bootcamp
ls bootcamp/

# Ir a la semana 1
cd bootcamp/week-01-introduccion-cobol
ls
# 0-assets  1-teoria  2-practicas  3-proyecto  4-recursos  5-glosario  README.md
```

---

## 6. Flujo de Trabajo Diario

```bash
# 1. Iniciar Docker (si no está corriendo)
docker compose up -d

# 2. Entrar al contenedor
docker compose exec cobol bash

# 3. Navegar a la semana actual
cd bootcamp/week-01-introduccion-cobol

# 4. Editar código en VS Code (en el host)
#    Los cambios se reflejan instantáneamente en el contenedor

# 5. Compilar y ejecutar (dentro del contenedor)
cobc -x -free hola.cbl
./hola

# 6. Salir del contenedor
exit

# 7. Detener servicios al terminar
docker compose down
```

---

## 🐛 Problemas Comunes

### "Cannot connect to Docker daemon"
Docker no está corriendo. Inícialo:
```bash
sudo systemctl start docker
```

### "Permission denied" al ejecutar docker
Tu usuario no está en el grupo `docker`:
```bash
sudo usermod -aG docker $USER
# Cierra sesión y vuelve a entrar
```

### El contenedor no inicia
```bash
docker compose logs cobol
docker compose logs db
```

### "No space left on device"
```bash
docker system prune -a
```

---

## ✅ Checklist

- [ ] Docker y Docker Compose instalados y verificados
- [ ] `docker compose up --build -d` ejecutado sin errores
- [ ] `docker compose exec cobol bash` funciona
- [ ] `cobc --version` muestra GnuCOBOL 3.2+
- [ ] Puedo navegar a `bootcamp/week-01-introduccion-cobol`

## 📚 Recursos

- [Guía Docker completa](../../../docs/docker-setup.md)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [GnuCOBOL Installation Guide](https://gnucobol.sourceforge.io/)
