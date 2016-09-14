#!/bin/bash

MY_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

render_template() {
  eval "echo \"$(cat $1)\""
}

if [[ -z "$1" ]]; then
    $MY_PATH/generate.sh v4
    $MY_PATH/generate.sh v5
    $MY_PATH/generate.sh v6
else
    if [[ $1 == 'v4' || $1 == 'v5' ]]; then
        if [[ $1 == 'v4' ]]; then
            SENCHA_CMD_VERSION="4.0.5.87"
        else
            SENCHA_CMD_VERSION="5.1.3.61"
        fi
        SENCHA_CMD_INSTALLER="SenchaCmd-$SENCHA_CMD_VERSION-linux-x64.run"
        SENCHA_CMD_INSTALLER_OPTIONS="--prefix /opt --mode unattended"
        SENCHA_CMD_PACKAGE="http://cdn.sencha.com/cmd/$SENCHA_CMD_VERSION/$SENCHA_CMD_INSTALLER.zip"
    else
        SENCHA_CMD_VERSION="6.2.0.103"
        SENCHA_CMD_INSTALLER="SenchaCmd-$SENCHA_CMD_VERSION-linux-amd64.sh"
        SENCHA_CMD_INSTALLER_OPTIONS="-q -dir /opt/Sencha/Cmd/$SENCHA_CMD_VERSION"
        SENCHA_CMD_PACKAGE="http://cdn.sencha.com/cmd/$SENCHA_CMD_VERSION/no-jre/$SENCHA_CMD_INSTALLER.zip"

        SENCHA_CMD_COMPASS_PACKAGE="http://github.com/cravler/file-storage/releases/download/_/sencha-cmd-compass.zip"
        SENCHA_CMD_COMPASS_FIX="&& wget -O sencha-compass.zip $SENCHA_CMD_COMPASS_PACKAGE && unzip sencha-compass.zip && rm sencha-compass.zip && mv sencha-compass /opt/Sencha/Cmd/$SENCHA_CMD_VERSION/extensions/sencha-compass"
    fi

    mkdir -p $MY_PATH/$1
    render_template $MY_PATH/Dockerfile.in > $MY_PATH/$1/Dockerfile
fi
