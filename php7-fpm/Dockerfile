FROM cravler/php7-cli
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Common environment variables
ENV CONF_DIR_PHP7_FPM /etc/php/7.0/fpm

# All our dependencies, in alphabetical order (to ease maintenance)
RUN apt-get update && apt-get install -y --no-install-recommends \
        php7.0-fpm && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/* && \

# Configure php-fpm
    mkdir /run/php && \
    ln -s /usr/sbin/php-fpm7.0 /usr/sbin/php7-fpm && \

# Find config files and edit
    find "$CONF_DIR_PHP7_FPM" -type f -exec sed -ri ' \
        s|(error_log\s+=).*|\1 /proc/self/fd/2|g; \
        s|\S*(daemonize\s+=).*|\1 no|g; \
    ' '{}' ';'

ADD php7-fpm-set-env.sh /.cravler/php7-fpm-set-env.sh
ADD php7-fpm-config.sh /.cravler/php7-fpm-config.sh
ADD docker-entrypoint.sh /.cravler/entrypoint.sh

EXPOSE 9000
CMD ["php7-fpm", "-R"]