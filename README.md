#How to use this image:#

    docker run --name some-php5-fpm --link some-nginx:nginx -d cravler/php5-fpm

The following environment variables are also honored for configuring your PHP-FPM instance:

- -e `PHP5_DATE_TIMEZONE=...` (defaults to Europe/London)
- -e `PHP5_FPM_MAX_EXECUTION_TIME=...` (defaults to 30)
- -e `PHP5_FPM_MAX_INPUT_TIME=...` (defaults to 60)
- -e `PHP5_FPM_MEMORY_LIMIT=...` (defaults to 128M)
- -e `PHP5_FPM_LOG_LEVEL=...` (defaults to notice, available: alert, error, warning, notice, debug)
- -e `PHP5_FPM_LISTEN=...` (defaults to 9000)
- -e `PHP5_FPM_USER=...` (defaults to 0)
- -e `PHP5_FPM_GROUP=...` (defaults to 0)
