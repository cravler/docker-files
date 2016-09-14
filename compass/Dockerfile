FROM ruby:alpine
MAINTAINER Sergei Vizel <http://github.com/cravler>

RUN \
    apk add --no-cache --virtual build-base && \
    gem update --system && \
    gem install compass

VOLUME ["/var/www"]
WORKDIR /var/www

ENTRYPOINT ["/usr/local/bundle/bin/compass"]

CMD ["help"]
