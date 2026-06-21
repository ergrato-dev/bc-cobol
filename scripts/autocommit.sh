#!/bin/bash
# ============================================
# AUTOCOMMIT - bc-cobol Bootcamp
# Conventional Commits en inglés
# ============================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "$(dirname "$(readlink -f "$0")")/..")"
cd "$REPO_ROOT"

LOG_DIR="$REPO_ROOT/scripts/logs"
LOG_FILE="$LOG_DIR/autocommit.log"
MAX_LOG_SIZE=$((1024 * 1024)) # 1MB

mkdir -p "$LOG_DIR"

# Rotar log si excede tamaño máximo
if [ -f "$LOG_FILE" ] && [ "$(stat -c%s "$LOG_FILE" 2>/dev/null || echo 0)" -gt "$MAX_LOG_SIZE" ]; then
    mv "$LOG_FILE" "${LOG_FILE}.old"
fi

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"; }

# Verificar que estamos en un repo git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    log "ERROR: No es un repositorio git"
    exit 1
fi

# Obtener archivos modificados
CHANGED=$(git status --porcelain | grep -v '^?' | awk '{print $2}' || true)

if [ -z "$CHANGED" ]; then
    log "No hay cambios para commit"
    exit 0
fi

# Detectar tipo de commit
DETECT_TYPE() {
    local files="$1"
    if echo "$files" | grep -qE '(practicas|proyecto|\.cbl$|\.cob$|\.cpy$)'; then
        echo "feat"
    elif echo "$files" | grep -qE '(fix|bug|error)'; then
        echo "fix"
    elif echo "$files" | grep -qE '(test|\.sh$)'; then
        echo "test"
    elif echo "$files" | grep -qE '(refactor)'; then
        echo "refactor"
    elif echo "$files" | grep -qE '(\.github/)'; then
        echo "ci"
    elif echo "$files" | grep -qE '(teoria|recursos|glosario|\.md$)'; then
        echo "docs"
    else
        echo "chore"
    fi
}

# Detectar scope
DETECT_SCOPE() {
    local files="$1"
    if echo "$files" | grep -qE 'bootcamp/week-[0-9]+'; then
        echo "$files" | grep -oE 'week-[0-9]+' | head -1
    elif echo "$files" | grep -q '^docs/'; then
        echo "docs"
    elif echo "$files" | grep -q '^scripts/'; then
        echo "scripts"
    elif echo "$files" | grep -q '^assets/'; then
        echo "assets"
    elif echo "$files" | grep -q '^.github/'; then
        echo "github"
    else
        echo "root"
    fi
}

TYPE=$(DETECT_TYPE "$CHANGED")
SCOPE=$(DETECT_SCOPE "$CHANGED")
COUNT=$(echo "$CHANGED" | wc -l)

# Construir mensaje
COMMIT_MSG="${TYPE}(${SCOPE}): update ${COUNT} files

What: update ${COUNT} files
For: content maintenance
Impact: students get updated materials

Auto-committed by bc-cobol autocommit script"

# Agregar y commit
git add -A
if git commit -m "$COMMIT_MSG" >> "$LOG_FILE" 2>&1; then
    log "Commit: ${TYPE}(${SCOPE}) - ${COUNT} files"
    # Intentar push
    git push >> "$LOG_FILE" 2>&1 && log "Push exitoso" || log "Push fallido (commit local guardado)"
else
    log "ERROR: Commit falló"
    exit 1
fi
