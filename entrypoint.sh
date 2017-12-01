#!/bin/sh
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- /var/database/*/usr/bin "$@"
fi

exec "$@"