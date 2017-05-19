#!/bin/bash

. /.cravler/php-cli-config.sh
. /.cravler/php-fpm-config.sh

if [[ "$@" == "$1" ]]; then
    . <(echo "$@")
else
    . <(echo $(/.cravler/args2str.sh "$@"))
fi