FROM node:8

LABEL maintainer "Sergei Vizel <http://github.com/cravler>"

RUN \
    npm install -g faye-app

VOLUME ["/var/www"]
WORKDIR /var/www

CMD faye-app
