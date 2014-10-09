#How to use this image:

    docker run --rm cravler/php5-cli php -r 'echo "Hello CLI!\n";'

or

    docker run -i -t --rm cravler/php5-cli composer

The following environment variables are also honored for configuring your PHP-CLI instance:

- -e `PHP5_DATE_TIMEZONE=...` (defaults to Europe/London)
