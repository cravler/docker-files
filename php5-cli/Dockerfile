FROM ubuntu:14.04
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Common environment variables
ENV TZ UTC
ENV COMPOSER_HOME /.composer
ENV CONF_DIR_PHP5_CLI /etc/php5/cli
ENV PATH ${PATH}:/.composer/vendor/bin

# All our dependencies, in alphabetical order (to ease maintenance)
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        php5-cli \
        php5-curl \
        php5-gd \
        php5-imagick \
        php5-intl \
        php5-json \
        php5-ldap \
        php5-mcrypt \
        php5-mhash \
        php5-mysql \
        php5-pgsql \
        php5-sqlite && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/* && \

# Install composer
    curl -sS http://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

VOLUME ["/.composer", "/var/www"]
WORKDIR /var/www

ADD sed.sh /.cravler/sed.sh
ADD php5-set-config.sh /.cravler/php5-set-config.sh
ADD php5-cli-config.sh /.cravler/php5-cli-config.sh
ADD docker-entrypoint.sh /.cravler/entrypoint.sh

ENTRYPOINT ["/.cravler/entrypoint.sh"]

CMD ["php", "-v"]