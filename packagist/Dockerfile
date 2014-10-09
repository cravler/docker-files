FROM cravler/php5-fpm
MAINTAINER Sergei Vizel <http://github.com/cravler>

# All our dependencies, in alphabetical order (to ease maintenance)
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        mercurial \
        openssh-client \
        subversion && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/*