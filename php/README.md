# Supported tags and respective `Dockerfile` links

- 7.1-cli, 7-cli, cli, 7.1, 7, latest [(Dockerfile.7.1-cli)](https://github.com/cravler/docker-files/tree/master/php/Dockerfile.7.1-cli)
- 7.1-fpm, 7-fpm, fpm [(Dockerfile.7.1-fpm)](https://github.com/cravler/docker-files/tree/master/php/Dockerfile.7.1-fpm)
- 7.0-cli, 7.0 [(Dockerfile.7.0-cli)](https://github.com/cravler/docker-files/tree/master/php/Dockerfile.7.0-cli)
- 7.0-fpm [(Dockerfile.7.0-fpm)](https://github.com/cravler/docker-files/tree/master/php/Dockerfile.7.0-fpm)
- 5.6-cli, 5-cli, 5.6, 5 [(Dockerfile.5.6-cli)](https://github.com/cravler/docker-files/tree/master/php/Dockerfile.5.6-cli)
- 5.6-fpm, 5-fpm [(Dockerfile.5.6-fpm)](https://github.com/cravler/docker-files/tree/master/php/Dockerfile.5.6-fpm)

# How to use CLI image

    docker run --rm cravler/php php -r 'echo "Hello CLI!\n";'

or

    docker run -it --rm cravler/php composer
    
# How to use FPM image

    docker run --name php-fpm --link nginx:nginx -d cravler/php:fpm

# Environment variables

The following environment variables are also honored for configuring your PHP-CLI instance:

- -e `PHP_DATE_TIMEZONE=...` (defaults to $TZ=UTC)
- -e `COMPOSER_GITHUB_OAUTH=...` (defaults to '')

The following environment variables are also honored for configuring your PHP-FPM instance:

- -e `PHP_DATE_TIMEZONE=...` (defaults to $TZ=UTC)
- -e `PHP_FPM_MAX_EXECUTION_TIME=...` (defaults to 30)
- -e `PHP_FPM_MAX_INPUT_TIME=...` (defaults to 60)
- -e `PHP_FPM_MEMORY_LIMIT=...` (defaults to 128M)
- -e `PHP_FPM_LOG_LEVEL=...` (defaults to notice, available: alert, error, warning, notice, debug)
- -e `PHP_FPM_LISTEN=...` (defaults to 9000)
- -e `PHP_FPM_USER=...` (defaults to 0)
- -e `PHP_FPM_GROUP=...` (defaults to 0)