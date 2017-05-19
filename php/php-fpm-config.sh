#!/bin/bash

set -e

: ${PHP_FPM_MAX_EXECUTION_TIME:=30}; export PHP_FPM_MAX_EXECUTION_TIME
: ${PHP_FPM_MAX_INPUT_TIME:=60}; export PHP_FPM_MAX_INPUT_TIME
: ${PHP_FPM_MEMORY_LIMIT:=128M}; export PHP_FPM_MEMORY_LIMIT
: ${PHP_FPM_LOG_LEVEL:=notice}; export PHP_FPM_LOG_LEVEL
: ${PHP_FPM_LISTEN:=9000}; export PHP_FPM_LISTEN
: ${PHP_FPM_USER:=0}; export PHP_FPM_USER
: ${PHP_FPM_GROUP:=0}; export PHP_FPM_GROUP

# Apply default or user specified options to config files
/.cravler/php-set-config.sh "$CONF_DIR_PHP_FPM" 'date.timezone' "$PHP_DATE_TIMEZONE"
/.cravler/php-set-config.sh "$CONF_DIR_PHP_FPM" 'max_execution_time' "$PHP_FPM_MAX_EXECUTION_TIME"
/.cravler/php-set-config.sh "$CONF_DIR_PHP_FPM" 'max_input_time' "$PHP_FPM_MAX_INPUT_TIME"
/.cravler/php-set-config.sh "$CONF_DIR_PHP_FPM" 'memory_limit' "$PHP_FPM_MEMORY_LIMIT"
/.cravler/php-set-config.sh "$CONF_DIR_PHP_FPM" 'log_level' "$PHP_FPM_LOG_LEVEL"
/.cravler/php-set-config.sh "$CONF_DIR_PHP_FPM" 'listen' "$PHP_FPM_LISTEN"

# Replace php-fpm user and group
/.cravler/sed.sh "s/user = www-data/user = $PHP_FPM_USER/g" "$CONF_DIR_PHP_FPM/pool.d/www.conf"
/.cravler/sed.sh "s/group = www-data/group = $PHP_FPM_GROUP/g" "$CONF_DIR_PHP_FPM/pool.d/www.conf"

# Add env vars to PHP-FPM configuration file
/.cravler/php-fpm-set-env.sh COMPOSER_HOME
