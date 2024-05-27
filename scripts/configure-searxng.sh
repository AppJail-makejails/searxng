#!/bin/sh

# Environment:
# - SEARXNG_DEBUG
# - SEARXNG_PORT
# - SEARXNG_BIND_ADDRESS
# - SEARXNG_SECRET
# - SEARXNG_BASE_URL
# - SEARXNG_REDIS_URL

. /scripts/lib.subr

sysrc searxng_env="SEARXNG_SETTINGS_PATH=/usr/local/etc/searxng.yml" > /dev/null

if [ -n "${SEARXNG_DEBUG}" ]; then
	info "Configuring general.debug -> ${SEARXNG_DEBUG}"
	sysrc searxng_env+="SEARXNG_DEBUG=${SEARXNG_DEBUG}" > /dev/null
fi

if [ -n "${SEARXNG_PORT}" ]; then
	info "Configuring server.port -> ${SEARXNG_PORT}"
	sysrc searxng_env+="SEARXNG_PORT=${SEARXNG_PORT}" > /dev/null
fi

if [ -n "${SEARXNG_BIND_ADDRESS}" ]; then
	info "Configuring server.bind_address -> ${SEARXNG_BIND_ADDRESS}"
	sysrc searxng_env+="SEARXNG_BIND_ADDRESS=${SEARXNG_BIND_ADDRESS}" > /dev/null
fi

if [ -n "${SEARXNG_SECRET}" ]; then
	info "Configuring server.secret_key -> ${SEARXNG_SECRET}"
	sysrc searxng_env+="SEARXNG_SECRET=${SEARXNG_SECRET}" > /dev/null
fi

if [ -n "${SEARXNG_BASE_URL}" ]; then
	info "Configuring server.base_url -> ${SEARXNG_BASE_URL}"
	sysrc searxng_env+="SEARXNG_BASE_URL=${SEARXNG_BASE_URL}" > /dev/null
fi

if [ -n "${SEARXNG_REDIS_URL}" ]; then
	info "Configuring redis.url -> ${SEARXNG_REDIS_URL}"
	sysrc searxng_env+="SEARXNG_REDIS_URL=${SEARXNG_REDIS_URL}" > /dev/null
fi
