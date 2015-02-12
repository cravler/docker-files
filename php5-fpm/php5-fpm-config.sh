#!/bin/bash

set -e

: ${PHP5_FPM_MAX_EXECUTION_TIME:=30}; export PHP5_FPM_MAX_EXECUTION_TIME
: ${PHP5_FPM_MAX_INPUT_TIME:=60}; export PHP5_FPM_MAX_INPUT_TIME
: ${PHP5_FPM_MEMORY_LIMIT:=128M}; export PHP5_FPM_MEMORY_LIMIT
: ${PHP5_FPM_LOG_LEVEL:=notice}; export PHP5_FPM_LOG_LEVEL
: ${PHP5_FPM_LISTEN:=9000}; export PHP5_FPM_LISTEN
: ${PHP5_FPM_USER:=0}; export PHP5_FPM_USER
: ${PHP5_FPM_GROUP:=0}; export PHP5_FPM_GROUP

# Apply default or user specified options to config files
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_FPM" 'date.timezone' "$PHP5_DATE_TIMEZONE"
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_FPM" 'max_execution_time' "$PHP5_FPM_MAX_EXECUTION_TIME"
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_FPM" 'max_input_time' "$PHP5_FPM_MAX_INPUT_TIME"
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_FPM" 'memory_limit' "$PHP5_FPM_MEMORY_LIMIT"
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_FPM" 'log_level' "$PHP5_FPM_LOG_LEVEL"
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_FPM" 'listen' "$PHP5_FPM_LISTEN"

# Replace php-fpm user and group
cat "$CONF_DIR_PHP5_FPM/pool.d/www.conf" | sed "s/user = www-data/user = $PHP5_FPM_USER/g" | tee "$CONF_DIR_PHP5_FPM/pool.d/www.conf" > /dev/null
cat "$CONF_DIR_PHP5_FPM/pool.d/www.conf" | sed "s/group = www-data/group = $PHP5_FPM_GROUP/g" | tee "$CONF_DIR_PHP5_FPM/pool.d/www.conf" > /dev/null

# Add env vars to PHP-FPM configuration file
/.cravler/php5-fpm-set-env.sh COMPOSER_HOME
