ARG ALPINE_VERSION=3.20

FROM alpine:${ALPINE_VERSION}

LABEL maintainer "Sergei Vizel <http://github.com/cravler>"

# Common environment variables
ENV SOCKET_DIR /.ssh
ENV SSH_DIR /root/.ssh
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/agent

RUN \
    apk add --update openssh && \
    rm -rf /var/cache/apk/*

COPY askpass.sh /ssh-askpass.sh
COPY run.sh /ssh-agent.sh

VOLUME ["$SSH_DIR", "$SOCKET_DIR"]

CMD ["/ssh-agent.sh"]
