#!/bin/bash

set -e

: ${PHP7_FPM_MAX_EXECUTION_TIME:=30}; export PHP7_FPM_MAX_EXECUTION_TIME
: ${PHP7_FPM_MAX_INPUT_TIME:=60}; export PHP7_FPM_MAX_INPUT_TIME
: ${PHP7_FPM_MEMORY_LIMIT:=128M}; export PHP7_FPM_MEMORY_LIMIT
: ${PHP7_FPM_LOG_LEVEL:=notice}; export PHP7_FPM_LOG_LEVEL
: ${PHP7_FPM_LISTEN:=9000}; export PHP7_FPM_LISTEN
: ${PHP7_FPM_USER:=0}; export PHP7_FPM_USER
: ${PHP7_FPM_GROUP:=0}; export PHP7_FPM_GROUP

# Apply default or user specified options to config files
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_FPM" 'date.timezone' "$PHP7_DATE_TIMEZONE"
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_FPM" 'max_execution_time' "$PHP7_FPM_MAX_EXECUTION_TIME"
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_FPM" 'max_input_time' "$PHP7_FPM_MAX_INPUT_TIME"
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_FPM" 'memory_limit' "$PHP7_FPM_MEMORY_LIMIT"
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_FPM" 'log_level' "$PHP7_FPM_LOG_LEVEL"
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_FPM" 'listen' "$PHP7_FPM_LISTEN"

# Replace php-fpm user and group
/.cravler/sed.sh "s/user = www-data/user = $PHP7_FPM_USER/g" "$CONF_DIR_PHP7_FPM/pool.d/www.conf"
/.cravler/sed.sh "s/group = www-data/group = $PHP7_FPM_GROUP/g" "$CONF_DIR_PHP7_FPM/pool.d/www.conf"

# Add env vars to PHP-FPM configuration file
/.cravler/php7-fpm-set-env.sh COMPOSER_HOME
