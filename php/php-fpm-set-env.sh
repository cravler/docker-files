#!/bin/bash

_env="$1"
if [ "$_env" ]; then
    if [ "$_env" == '__ALL__' ]; then
        for env in `printenv`; do
            IFS== read name value <<< "$env"
            if [ "$value" ]; then
                echo "env[$name] = $value" >> "$CONF_DIR_PHP_FPM/php-fpm.conf"
            fi
        done
    else
        _value=`printenv $_env`
        if [ "$_value" ]; then
            echo "env[$_env] = $_value" >> "$CONF_DIR_PHP_FPM/php-fpm.conf"
        fi
    fi
fi