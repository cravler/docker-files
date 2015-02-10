#!/bin/bash

set -e

: ${PHP5_DATE_TIMEZONE:=Europe/London}; export PHP5_DATE_TIMEZONE
: ${COMPOSER_GITHUB_OAUTH:=}; export COMPOSER_GITHUB_OAUTH

# Apply default or user specified options to config files
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_CLI" 'date.timezone' "$PHP5_DATE_TIMEZONE"

# Composer config
[ ! -z "$COMPOSER_GITHUB_OAUTH" ] && composer config -g github-oauth.github.com "$COMPOSER_GITHUB_OAUTH"