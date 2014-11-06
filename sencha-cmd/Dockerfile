FROM ubuntu:14.04
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Common environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV SENCHA_CMD_x64 http://cdn.sencha.com/cmd/5.0.3.324/SenchaCmd-5.0.3.324-linux-x64.run.zip
ENV PATH /opt/Sencha/Cmd/5.0.3.324:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN \

# Install dependencies
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        software-properties-common \
        unzip \
        wget \
        ruby && \

# Install oracle-java8
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && apt-get install -y --no-install-recommends \
        oracle-java8-installer && \

# Remove cache
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer && \

# Install sencha-cmd
    wget -O sencha-cmd-linux-x64.run.zip $SENCHA_CMD_x64 && \
    unzip *.run.zip && rm *.run.zip && chmod +x *.run && \
    mkdir -p /opt/Sencha/Cmd && mv *.run /opt/Sencha/Cmd && \
    /opt/Sencha/Cmd/SenchaCmd-5.0.3.324-linux-x64.run --prefix /opt --mode unattended

VOLUME ["/var/www"]
WORKDIR /var/www

CMD ["bash"]