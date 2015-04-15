FROM node:0.10
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Install Cloud9 IDE
RUN git clone https://github.com/c9/core.git /cloud9 && \
    /cloud9/scripts/install-sdk.sh && \

# Fix Cloud9 IDE
    find='var isLocalhost = host == "localhost" || host == "127.0.0.1";' && \
    replace='var isLocalhost = true;' && \
    sed -i "s/$find/$replace/g" /cloud9/configs/standalone.js && \

    find='var workspaceDir = path.resolve(__dirname + "\/..\/");' && \
    replace='var workspaceDir = "\/workspace";' && \
    sed -i "s/$find/$replace/g" /cloud9/settings/standalone.js

VOLUME ["/workspace"]
WORKDIR /workspace

ADD cloud9.sh /usr/bin/cloud9

EXPOSE 8181
CMD cloud9
