#!/bin/bash

. /.cravler/php5-cli-config.sh
. /.cravler/php5-fpm-config.sh

if [[ "$@" == "$1" ]]; then
    . <(echo "$@")
else
    . <(echo $(/.cravler/args2str.sh "$@"))
fi