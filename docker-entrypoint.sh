#!/bin/bash
set -e

: ${PHP5_DATE_TIMEZONE:=Europe/London}
: ${PHP5_FPM_MAX_EXECUTION_TIME:=30}
: ${PHP5_FPM_MAX_INPUT_TIME:=60}
: ${PHP5_FPM_MEMORY_LIMIT:=128M}
: ${PHP5_FPM_LOG_LEVEL:=notice}
: ${PHP5_FPM_LISTEN:=9000}
: ${PHP5_FPM_USER:=0}
: ${PHP5_FPM_GROUP:=0}

# Common config edit function
set_config() {
    _dir="$1"
    _key="$2"
    _value="$3"
    # Do a loop so sed can scale with number of files/options
    for i in $(find $_dir -type f); do
        sed -ri "s|\S*($_key\s+=).*|\1 $_value|g" $i
    done
}

# Apply default or user specified options to config files
set_config "$CONF_DIR_PHP5_CLI" 'date.timezone' "$PHP5_DATE_TIMEZONE"
set_config "$CONF_DIR_PHP5_FPM" 'date.timezone' "$PHP5_DATE_TIMEZONE"
set_config "$CONF_DIR_PHP5_FPM" 'max_execution_time' "$PHP5_FPM_MAX_EXECUTION_TIME"
set_config "$CONF_DIR_PHP5_FPM" 'max_input_time' "$PHP5_FPM_MAX_INPUT_TIME"
set_config "$CONF_DIR_PHP5_FPM" 'memory_limit' "$PHP5_FPM_MEMORY_LIMIT"
set_config "$CONF_DIR_PHP5_FPM" 'log_level' "$PHP5_FPM_LOG_LEVEL"
set_config "$CONF_DIR_PHP5_FPM" 'listen' "$PHP5_FPM_LISTEN"

# Replace php-fpm user and group
sed -i "s/user = www-data/user = $PHP5_FPM_USER/g" "$CONF_DIR_PHP5_FPM/pool.d/www.conf"
sed -i "s/group = www-data/group = $PHP5_FPM_GROUP/g" "$CONF_DIR_PHP5_FPM/pool.d/www.conf"

exec "$@"