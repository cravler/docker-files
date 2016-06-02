FROM ubuntu:16.04
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Common environment variables
ENV TZ UTC
ENV COMPOSER_HOME /.composer
ENV CONF_DIR_PHP7_CLI /etc/php/7.0/cli
ENV PATH ${PATH}:/.composer/vendor/bin

RUN \

# All our dependencies, in alphabetical order (to ease maintenance)
    apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        netcat \
        php7.0-cli \
        php7.0-curl \
        php7.0-gd \
        php-imagick \
        php7.0-intl \
        php7.0-json \
        php7.0-ldap \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-pgsql \
        php7.0-sqlite3 \
        vim && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/* && \

# Install composer
    curl -sS http://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

VOLUME ["/.composer", "/var/www"]
WORKDIR /var/www

ADD sed.sh /.cravler/sed.sh
ADD php7-set-config.sh /.cravler/php7-set-config.sh
ADD php7-cli-config.sh /.cravler/php7-cli-config.sh
ADD docker-entrypoint.sh /.cravler/entrypoint.sh

ENTRYPOINT ["/.cravler/entrypoint.sh"]

CMD ["php", "-v"]
