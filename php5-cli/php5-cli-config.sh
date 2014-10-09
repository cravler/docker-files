#!/bin/bash

set -e

: ${PHP5_DATE_TIMEZONE:=Europe/London}; export PHP5_DATE_TIMEZONE

# Apply default or user specified options to config files
/.cravler/php5-set-config.sh "$CONF_DIR_PHP5_CLI" 'date.timezone' "$PHP5_DATE_TIMEZONE"
