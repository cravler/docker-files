#!/bin/bash

set -e

: ${PHP_DATE_TIMEZONE:=}; export PHP_DATE_TIMEZONE
: ${COMPOSER_GITHUB_OAUTH:=}; export COMPOSER_GITHUB_OAUTH

# Apply default or user specified options to config files
if [[ -z "$PHP_DATE_TIMEZONE" ]]; then
    PHP_DATE_TIMEZONE="$TZ"
fi
/.cravler/php-set-config.sh "$CONF_DIR_PHP_CLI" 'date.timezone' "$PHP_DATE_TIMEZONE"

# Composer config
if [[ ! -z "$COMPOSER_GITHUB_OAUTH" ]]; then
    composer config -g -q github-oauth.github.com "$COMPOSER_GITHUB_OAUTH"
fi
