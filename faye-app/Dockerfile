FROM node:10

LABEL maintainer "Sergei Vizel <http://github.com/cravler>"

RUN \
    npm install -g faye-app && \
    mkdir -p /var/www

WORKDIR /var/www

CMD faye-app
