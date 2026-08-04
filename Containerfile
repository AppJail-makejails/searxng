ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE}

ARG VERSION="unknown"
ARG PYVER
ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="SearxNG" \
    org.opencontainers.image.description="Free internet metasearch engine" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/searxng" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/searxng" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    pkg update; \
    pkg install -y py${PYVER}-searxng-devel py${PYVER}-granian; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

ENV PYVER=${PYVER}

ENV __SEARXNG_CONFIG_PATH="/usr/local/etc/searxng" \
    __SEARXNG_DATA_PATH="/var/cache/searxng"

ENV __SEARXNG_VERSION="$VERSION" \
    __SEARXNG_SETTINGS_PATH="$__SEARXNG_CONFIG_PATH/settings.yml" \
    GRANIAN_PROCESS_NAME="searxng" \
    GRANIAN_INTERFACE="wsgi" \
    GRANIAN_HOST="0.0.0.0" \
    GRANIAN_PORT="8080" \
    GRANIAN_WEBSOCKETS="false" \
    GRANIAN_BLOCKING_THREADS="4" \
    GRANIAN_WORKERS_KILL_TIMEOUT="30s" \
    GRANIAN_BLOCKING_THREADS_IDLE_TIMEOUT="5m"

ENV SEARXNG_SETTINGS_PATH=$__SEARXNG_SETTINGS_PATH

VOLUME $__SEARXNG_CONFIG_PATH
VOLUME $__SEARXNG_DATA_PATH

RUN mkdir -p "$__SEARXNG_CONFIG_PATH" \
        "$__SEARXNG_DATA_PATH" \
        /templates

COPY settings.template.yml /templates

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
