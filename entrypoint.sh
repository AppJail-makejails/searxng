#!/bin/sh

. /lib.subr

set -e

python_version=`printf "%s" "${PYVER}" | sed -Ee 's/([0-9])([0-9]+)/\1.\2/'`

create_user

if [ ! -s "${__SEARXNG_CONFIG_PATH}/settings.yml" ]; then
    cp -a /templates/settings.template.yml "${__SEARXNG_CONFIG_PATH}/settings.yml"
    sed -E -i "" \
        -e "s/ultrasecretkey/$(head -c 24 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9')/g" \
        "${__SEARXNG_CONFIG_PATH}/settings.yml"
fi

change_owner "${__SEARXNG_CONFIG_PATH}" "${__SEARXNG_DATA_PATH}"

# ENVs aliases. Just for compatibility with upstream.
# See also: https://github.com/searxng/searxng/issues/5934
case "${SEARXNG_PORT:-}" in
    '') ;;
    *[!0-9]*)
        unset SEARXNG_PORT
        ;;
    *)
        export GRANIAN_PORT="$SEARXNG_PORT"
        ;;
esac

exec su-exec noroot granian searx.webapp:app
