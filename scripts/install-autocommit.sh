#!/bin/bash
# ============================================
# INSTALL-AUTOCOMMIT - Timer systemd para bc-cobol
# ============================================

set -euo pipefail

SERVICE_NAME="bc-cobol-autocommit"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AUTOCOMMIT_SCRIPT="$SCRIPT_DIR/autocommit.sh"

usage() {
    echo "Uso: $0 {install|uninstall|status|run} [intervalo]"
    echo ""
    echo "Comandos:"
    echo "  install [intervalo]  Instalar timer systemd (default: 30min)"
    echo "  uninstall           Desinstalar timer systemd"
    echo "  status              Ver estado del timer"
    echo "  run                 Ejecutar autocommit manualmente"
    echo ""
    echo "Intervalos: 15min, 30min, 1h, 2h, 4h"
    exit 1
}

parse_interval() {
    case "${1:-30min}" in
        15min) echo "15m" ;;
        30min) echo "30m" ;;
        1h)    echo "1h" ;;
        2h)    echo "2h" ;;
        4h)    echo "4h" ;;
        *)     echo "30m" ;;
    esac
}

install() {
    local interval
    interval=$(parse_interval "$1")

    mkdir -p "$HOME/.config/systemd/user"

    # Crear archivo .service
    cat > "$HOME/.config/systemd/user/${SERVICE_NAME}.service" << EOF
[Unit]
Description=Auto-commit script for bc-cobol bootcamp

[Service]
Type=oneshot
ExecStart=/bin/bash "$AUTOCOMMIT_SCRIPT"
WorkingDirectory=$REPO_ROOT
StandardOutput=append:${REPO_ROOT}/scripts/logs/systemd.log
StandardError=append:${REPO_ROOT}/scripts/logs/systemd.log
EOF

    # Crear archivo .timer
    cat > "$HOME/.config/systemd/user/${SERVICE_NAME}.timer" << EOF
[Unit]
Description=Auto-commit timer for bc-cobol bootcamp

[Timer]
OnUnitActiveSec=${interval}
OnBootSec=60

[Install]
WantedBy=timers.target
EOF

    systemctl --user daemon-reload
    systemctl --user enable --now "${SERVICE_NAME}.timer"
    echo "✅ Timer instalado: intervalo cada ${interval}"
}

uninstall() {
    systemctl --user stop "${SERVICE_NAME}.timer" 2>/dev/null || true
    systemctl --user disable "${SERVICE_NAME}.timer" 2>/dev/null || true
    rm -f "$HOME/.config/systemd/user/${SERVICE_NAME}.service"
    rm -f "$HOME/.config/systemd/user/${SERVICE_NAME}.timer"
    systemctl --user daemon-reload
    echo "✅ Timer desinstalado"
}

status() {
    systemctl --user status "${SERVICE_NAME}.timer" 2>/dev/null || echo "Timer no instalado"
}

run() {
    echo "Ejecutando autocommit..."
    bash "$AUTOCOMMIT_SCRIPT"
}

[ $# -eq 0 ] && usage
case "$1" in
    install)   install "${2:-}" ;;
    uninstall) uninstall ;;
    status)    status ;;
    run)       run ;;
    *)         usage ;;
esac
