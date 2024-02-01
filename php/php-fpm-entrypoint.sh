#!/bin/bash

. /.cravler/php-cli-config.sh
. /.cravler/php-fpm-config.sh

if [[ "$@" == "$1" ]]; then
    CMD=$(echo "$@")
else
    CMD=$(echo $(/.cravler/args2str.sh "$@"))
fi

exec $CMD
