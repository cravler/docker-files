#How to use this image:

    sudo docker run --rm cravler/php5-cli php -r 'echo "Hello CLI!\n";'

or

    sudo docker run -i -t --rm cravler/php5-cli composer

The following environment variables are also honored for configuring your PHP-CLI instance:

- -e `PHP5_DATE_TIMEZONE=...` (defaults to $TZ=UTC)
- -e `COMPOSER_GITHUB_OAUTH=...` (defaults to '')
