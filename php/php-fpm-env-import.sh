#!/bin/bash

ENV=$(cat $1)

IFS=$'\n'
for env in $ENV; do
    IFS== read name value <<< "$env"
    /.cravler/php-fpm-set-env.sh "$name"
done
