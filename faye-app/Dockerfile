ARG VERSION=latest
ARG BUILD=dev

FROM node:18-alpine

ARG VERSION
ARG BUILD

LABEL maintainer "Sergei Vizel <http://github.com/cravler>"

RUN \
# Install Faye-App
    npm install -g faye-app@${VERSION} && \
    mkdir -p /var/www && \
\
# Install dependencies
    apk add --update \
        bash \
    && \
    rm -rf /var/cache/apk/* && \
\
# Set version \
    cd /usr/local/lib/node_modules/faye-app && \
    sed -i -E "s/\"version\": \"(.*)\"/\"version\": \"\1-${BUILD}\"/g" package.json

WORKDIR /var/www

CMD faye-app
