FROM cravler/php:5-fpm

LABEL maintainer "Sergei Vizel <http://github.com/cravler>"

RUN \
\
# All our dependencies, in alphabetical order (to ease maintenance)
    apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        mercurial \
        openssh-client \
        subversion && \
\
# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/*