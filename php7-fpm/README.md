#How to use this image:

    sudo docker run --name some-php7-fpm --link some-nginx:nginx -d cravler/php7-fpm

The following environment variables are also honored for configuring your PHP-FPM instance:

- -e `PHP7_DATE_TIMEZONE=...` (defaults to $TZ=UTC)
- -e `PHP7_FPM_MAX_EXECUTION_TIME=...` (defaults to 30)
- -e `PHP7_FPM_MAX_INPUT_TIME=...` (defaults to 60)
- -e `PHP7_FPM_MEMORY_LIMIT=...` (defaults to 128M)
- -e `PHP7_FPM_LOG_LEVEL=...` (defaults to notice, available: alert, error, warning, notice, debug)
- -e `PHP7_FPM_LISTEN=...` (defaults to 9000)
- -e `PHP7_FPM_USER=...` (defaults to 0)
- -e `PHP7_FPM_GROUP=...` (defaults to 0)
