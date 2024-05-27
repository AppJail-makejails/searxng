#!/bin/sh

# Environment:
# - SEARXNG_DEBUG
# - SEARXNG_PORT
# - SEARXNG_BIND_ADDRESS (0.0.0.0)
# - SEARXNG_SECRET_KEY
# - SEARXNG_BASE_URL
# - SEARXNG_REDIS_URL

. /scripts/lib.subr

SEARXNG_BIND_ADDRESS="${SEARXNG_BIND_ADDRESS:-0.0.0.0}"

if [ -n "${SEARXNG_DEBUG}" ]; then
	info "Configuring general.debug -> ${SEARXNG_DEBUG}"
	put -t bool -v "${SEARXNG_DEBUG}" general.debug
fi

if [ -n "${SEARXNG_PORT}" ]; then
	info "Configuring server.port -> ${SEARXNG_PORT}"
	put -t int -v "${SEARXNG_PORT}" server.port
fi

info "Configuring server.bind_address -> ${SEARXNG_BIND_ADDRESS}"
put -t string -v "${SEARXNG_BIND_ADDRESS}" server.bind_address

if [ -n "${SEARXNG_SECRET}" ]; then
	info "Configuring server.secret_key -> ${SEARXNG_SECRET_KEY}"
	put -t string -v "${SEARXNG_SECRET_KEY}" server.secret_key
fi

if [ -n "${SEARXNG_BASE_URL}" ]; then
	info "Configuring server.base_url -> ${SEARXNG_BASE_URL}"
	put -t string -v "${SEARXNG_BASE_URL}" server.base_url
fi

if [ -n "${SEARXNG_REDIS_URL}" ]; then
	info "Configuring redis.url -> ${SEARXNG_REDIS_URL}"
	put -t string -v "${SEARXNG_REDIS_URL}" redis.url
fi
