FROM debian:jessie
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends rsync && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/volume"]
WORKDIR /volume
EXPOSE 873

ADD ./daemon.sh /usr/bin/rsync-daemon

CMD ["/usr/bin/rsync-daemon"]