FROM alpine:3.8

LABEL maintainer "Sergei Vizel <http://github.com/cravler>"

# Common environment variables
ENV SOCKET_DIR /.ssh
ENV SSH_DIR /root/.ssh
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/agent

RUN \
    apk add --update openssh && \
    rm -rf /var/cache/apk/*

COPY run.sh /ssh-agent.sh

VOLUME ["$SSH_DIR", "$SOCKET_DIR"]

CMD ["/ssh-agent.sh"]
