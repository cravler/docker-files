#!/bin/bash

. /.cravler/php7-cli-config.sh
. /.cravler/php7-fpm-config.sh

if [[ "$@" == "$1" ]]; then
    . <(echo "$@")
else
    . <(echo $(/.cravler/args2str.sh "$@"))
fi