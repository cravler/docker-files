FROM node:0.10
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Common environment variables
ENV BOWER_ALLOW_ROOT true

RUN \
    npm install -g bower && \
    mkdir -p /root/.config/configstore && \
    echo "optOut: true" > /root/.config/configstore/insight-bower.yml

VOLUME ["/var/www"]
WORKDIR /var/www

CMD ["bash"]