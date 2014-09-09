FROM ubuntu:14.04
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Common environment variables
ENV CONF_DIR_PHP5_FPM /etc/php5/fpm
ENV CONF_DIR_PHP5_CLI /etc/php5/cli

# All our dependencies, in alphabetical order (to ease maintenance)
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        php5-cli \
        php5-curl \
        php5-fpm \
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
    curl -sS http://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \

# Find config files and edit
    find "$CONF_DIR_PHP5_FPM" -type f -exec sed -ri ' \
        s|(error_log\s+=).*|\1 /proc/self/fd/2|g; \
        s|\S*(daemonize\s+=).*|\1 no|g; \
    ' '{}' ';'

VOLUME ["/var/www"]
WORKDIR /var/www

ADD docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
CMD php5-fpm -R