FROM ubuntu:14.04
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Common environment variables
ENV DEBIAN_FRONTEND noninteractive

RUN \

# Install dependencies
    apt-get update && apt-get install -y --no-install-recommends \
        openjdk-7-jre \
        unzip \
        wget \
        ruby && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH ${PATH}:/opt/Sencha/Cmd/6.2.0.103

RUN \

# Install Sencha-CMD
    wget -O sencha-cmd.zip http://cdn.sencha.com/cmd/6.2.0.103/no-jre/SenchaCmd-6.2.0.103-linux-amd64.sh.zip && \
    unzip sencha-cmd.zip && rm sencha-cmd.zip && chmod +x SenchaCmd-6.2.0.103-linux-amd64.sh && \
    mkdir -p /opt/Sencha/Cmd && mv SenchaCmd-6.2.0.103-linux-amd64.sh /opt/Sencha/Cmd && \
    /opt/Sencha/Cmd/SenchaCmd-6.2.0.103-linux-amd64.sh -q -dir /opt/Sencha/Cmd/6.2.0.103 && wget -O sencha-compass.zip http://github.com/cravler/file-storage/releases/download/_/sencha-cmd-compass.zip && unzip sencha-compass.zip && rm sencha-compass.zip && mv sencha-compass /opt/Sencha/Cmd/6.2.0.103/extensions/sencha-compass && \
    rm /opt/Sencha/Cmd/SenchaCmd-6.2.0.103-linux-amd64.sh

VOLUME ["/var/www"]
WORKDIR /var/www

CMD ["bash"]
