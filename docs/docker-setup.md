# 🐳 Docker Setup — bc-cobol Bootcamp

> **Docker es la ÚNICA vía de ejecución aceptada en este bootcamp.**
> No se requiere ni se recomienda instalar GnuCOBOL localmente.
> Esto garantiza entorno idéntico para todos los estudiantes (instructores, compañeros, CI/CD).

## 📋 Prerrequisitos

- **Docker 27.5+** instalado
- **Docker Compose 2.32+** instalado (incluido en Docker Desktop, o `docker compose` plugin)
- **Git** para clonar el repositorio
- **VS Code** (recomendado) con extensión COBOL

### Verificar instalación

```bash
docker --version
# Docker version 27.5+

docker compose version
# Docker Compose version v2.32+
```

---

## 🚀 Inicio Rápido

### 1. Clonar el repositorio

```bash
git clone https://github.com/ergrato-dev/bc-cobol.git
cd bc-cobol
```

### 2. (Opcional) Copiar variables de entorno

```bash
cp .env.example .env
```

### 3. Construir y levantar los servicios

```bash
docker compose up --build -d
```

Esto:
- Construye la imagen `bc-cobol:latest` (Fedora 41 + GnuCOBOL 3.2+)
- Crea el contenedor `bc-cobol-dev` con bash interactivo
- Levanta `bc-cobol-db` (PostgreSQL 16) para SQL embebido
- Crea volúmenes persistentes para datos y salidas

### 4. Entrar al entorno COBOL

```bash
docker compose exec cobol bash
```

Verás:
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
```

---

## 📂 Estructura en el Contenedor

```
/workspace/                 ← Raíz del bootcamp (montada desde host)
├── bootcamp/               ← Semanas del bootcamp
├── data/                   ← Datos persistentes (volumen)
├── output/                 ← Salidas persistentes (volumen)
├── copybooks/              ← COPYBOOKS compartidos
├── Dockerfile
├── docker-compose.yml
└── ...
```

El directorio del host está montado en `/workspace` dentro del contenedor. Cualquier cambio que hagas en tu editor local se refleja instantáneamente en el contenedor.

---

## 🔧 Compilar y Ejecutar Programas

Dentro del contenedor (`docker compose exec cobol bash`):

```bash
# Ir a la semana actual
cd bootcamp/week-01-introduccion-cobol

# Compilar (formato libre)
cobc -x -free -o hola hola.cbl

# Ejecutar
./hola
```

También puedes ejecutar directamente sin entrar al contenedor:

```bash
docker compose exec cobol bash -c "cd bootcamp/week-01-introduccion-cobol && cobc -x -free hola.cbl && ./hola"
```

O usar el script `cobol-run.sh` (ver abajo).

---

## 🗄️ Base de Datos (Semanas 11+)

PostgreSQL está disponible en el servicio `db`:

```bash
# Conectarse a la BD desde el contenedor COBOL
docker compose exec cobol psql -h db -U cobol -d bootcamp

# Ver tablas
bootcamp=# \dt

# Ver datos
bootcamp=# SELECT * FROM CLIENTES;
```

La BD se inicializa automáticamente con `docker/db/init.sql`.

---

## 📊 Comandos Docker Útiles

| Comando | Descripción |
|---------|-------------|
| `docker compose up --build -d` | Construir e iniciar servicios en background |
| `docker compose exec cobol bash` | Entrar al contenedor COBOL |
| `docker compose exec db psql -U cobol -d bootcamp` | Entrar a PostgreSQL |
| `docker compose logs -f cobol` | Ver logs del contenedor COBOL |
| `docker compose down` | Detener servicios |
| `docker compose down -v` | Detener y eliminar volúmenes (⚠️ pierdes datos) |
| `docker compose restart cobol` | Reiniciar contenedor COBOL |
| `docker compose build --no-cache` | Reconstruir imagen desde cero |

---

## 🔄 Actualizar la Imagen

Si se modifica el `Dockerfile` (nuevas dependencias):

```bash
docker compose build --no-cache
docker compose up -d
```

---

## 🐛 Solución de Problemas

### El contenedor no inicia

```bash
docker compose logs cobol
docker compose logs db
```

### Error de permisos en archivos COBOL

Los archivos se montan desde el host. Si hay problemas:

```bash
# Dentro del contenedor
chmod +x test.sh
```

### PostgreSQL no responde

```bash
docker compose restart db
# Esperar a que esté healthy
docker compose ps
```

### "No space left on device"

Limpiar recursos Docker no usados:

```bash
docker system prune -a
```

---

## ⚠️ Importante

- **NO** instalar GnuCOBOL localmente — usa Docker
- **NO** modificar archivos directamente en `/workspace/data/` (son volúmenes)
- Los datos de PostgreSQL se persisten en el volumen `bc-cobol-postgres` a menos que ejecutes `docker compose down -v`
