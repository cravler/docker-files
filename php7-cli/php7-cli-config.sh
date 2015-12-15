#!/bin/bash

set -e

: ${PHP7_DATE_TIMEZONE:=}; export PHP7_DATE_TIMEZONE
: ${COMPOSER_GITHUB_OAUTH:=}; export COMPOSER_GITHUB_OAUTH

# Apply default or user specified options to config files
if [[ -z "$PHP7_DATE_TIMEZONE" ]]; then
    PHP7_DATE_TIMEZONE="$TZ"
fi
/.cravler/php7-set-config.sh "$CONF_DIR_PHP7_CLI" 'date.timezone' "$PHP7_DATE_TIMEZONE"

# Composer config
if [[ ! -z "$COMPOSER_GITHUB_OAUTH" ]]; then
    composer config -g -q github-oauth.github.com "$COMPOSER_GITHUB_OAUTH"
fi