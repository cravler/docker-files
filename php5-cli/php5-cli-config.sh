#!/bin/bash

set -e

: ${PHP5_DATE_TIMEZONE:=}; export PHP5_DATE_TIMEZONE
: ${COMPOSER_GITHUB_OAUTH:=}; export COMPOSER_GITHUB_OAUTH

# Apply default or user specified options to config files
if [[ -z "$PHP5_DATE_TIMEZONE" ]]; then
    PHP5_DATE_TIMEZONE="$TZ"
fi
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_CLI" 'date.timezone' "$PHP5_DATE_TIMEZONE"

# Composer config
if [[ ! -z "$COMPOSER_GITHUB_OAUTH" ]]; then
    composer config -g -q github-oauth.github.com "$COMPOSER_GITHUB_OAUTH"
fi