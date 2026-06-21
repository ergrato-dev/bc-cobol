# ============================================
# DOCKERFILE - bc-cobol Bootcamp
# Entorno COBOL con GnuCOBOL 3.2+
# Única vía de ejecución aceptada
# ============================================

FROM fedora:41

LABEL org.bootcamp="bc-cobol"
LABEL description="COBOL Zero to Hero - GnuCOBOL development environment"

# Variables de entorno
ENV COBOL_HOME=/workspace \
    COBCFLAGS="-free -Wall" \
    COB_LDFLAGS="" \
    TERM=xterm-256color

# Instalar GnuCOBOL y herramientas
RUN dnf install -y --setopt=tsflags=nodocs \
    gnucobol \
    gnucobol-devel \
    git \
    make \
    gcc \
    bash \
    vim-minimal \
    postgresql \
    postgresql-devel \
    sqlite \
    sqlite-devel \
    libdb-devel \
    && dnf clean all \
    && rm -rf /var/cache/dnf

# Directorio de trabajo
WORKDIR /workspace

# Crear estructura base
RUN mkdir -p /workspace/data /workspace/output /workspace/copybooks

# Verificar instalación
RUN cobc --version && echo "GnuCOBOL instalado correctamente"

# Entrypoint bash interactivo para desarrollo
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "echo '🐘 Bootcamp COBOL Zero to Hero - Entorno listo' && exec bash"]
