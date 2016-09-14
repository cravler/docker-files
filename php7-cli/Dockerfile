FROM ubuntu:16.04
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Common environment variables
ENV TZ UTC
ENV COMPOSER_HOME /.composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV CONF_DIR_PHP7_CLI /etc/php/7.0/cli
ENV PATH ${COMPOSER_HOME}/bin:${PATH}:${COMPOSER_HOME}/vendor/bin

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
        php7.0-xml \
        php7.0-zip \
        vim && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["$COMPOSER_HOME", "/var/www"]
WORKDIR /var/www

ADD sed.sh /.cravler/sed.sh
ADD php7-set-config.sh /.cravler/php7-set-config.sh
ADD php7-cli-config.sh /.cravler/php7-cli-config.sh
ADD docker-entrypoint.sh /.cravler/entrypoint.sh
ADD composer.sh /usr/local/bin/composer

ENTRYPOINT ["/.cravler/entrypoint.sh"]

CMD ["php", "-v"]
