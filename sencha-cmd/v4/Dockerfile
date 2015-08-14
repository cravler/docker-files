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

ENV PATH ${PATH}:/opt/Sencha/Cmd/4.0.5.87

RUN \

# Install Sencha-CMD
    wget -O sencha-cmd.zip http://cdn.sencha.com/cmd/4.0.5.87/SenchaCmd-4.0.5.87-linux-x64.run.zip && \
    unzip sencha-cmd.zip && rm sencha-cmd.zip && chmod +x SenchaCmd-4.0.5.87-linux-x64.run && \
    mkdir -p /opt/Sencha/Cmd && mv SenchaCmd-4.0.5.87-linux-x64.run /opt/Sencha/Cmd && \
    /opt/Sencha/Cmd/SenchaCmd-4.0.5.87-linux-x64.run --prefix /opt --mode unattended  && \
    rm /opt/Sencha/Cmd/SenchaCmd-4.0.5.87-linux-x64.run

VOLUME [/var/www]
WORKDIR /var/www

CMD ["bash"]
