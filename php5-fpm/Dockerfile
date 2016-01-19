FROM cravler/php5-cli
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Common environment variables
ENV CONF_DIR_PHP5_FPM /etc/php5/fpm

# All our dependencies, in alphabetical order (to ease maintenance)
RUN apt-get update && apt-get install -y --no-install-recommends \
        php5-fpm && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/* && \

# Find config files and edit
    find "$CONF_DIR_PHP5_FPM" -type f -exec sed -ri ' \
        s|(error_log\s+=).*|\1 /proc/self/fd/2|g; \
        s|\S*(daemonize\s+=).*|\1 no|g; \
    ' '{}' ';'

ADD php5-fpm-set-env.sh /.cravler/php5-fpm-set-env.sh
ADD php5-fpm-config.sh /.cravler/php5-fpm-config.sh
ADD docker-entrypoint.sh /.cravler/entrypoint.sh

EXPOSE 9000
CMD ["php5-fpm", "-R"]