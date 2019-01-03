#!/bin/bash

MY_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
REPOSITORY=cravler/php

for i in "$@"; do
case $i in
    --repository=*)
        REPOSITORY="${i#*=}"
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

render_template() {
  eval "echo \"$(cat $1)\""
}

if [[ -z "$1" ]]; then
    $MY_PATH/generate.sh --repository=$REPOSITORY 5.6
    $MY_PATH/generate.sh --repository=$REPOSITORY 7.0
    $MY_PATH/generate.sh --repository=$REPOSITORY 7.1
    $MY_PATH/generate.sh --repository=$REPOSITORY 7.2
    $MY_PATH/generate.sh --repository=$REPOSITORY 7.3
else
    PHP_VERSION=$1

    # CLI
    cat $MY_PATH/templates/base > $MY_PATH/Dockerfile.$PHP_VERSION-cli
    cat $MY_PATH/templates/ppa >> $MY_PATH/Dockerfile.$PHP_VERSION-cli
    cat $MY_PATH/templates/$PHP_VERSION-cli >> $MY_PATH/Dockerfile.$PHP_VERSION-cli

    # FPM
    if [[ $1 == '5.6' ]]; then
        PHP_FPM=$(<$MY_PATH/templates/$PHP_VERSION-fpm)
    fi

    render_template $MY_PATH/templates/fpm > $MY_PATH/Dockerfile.$PHP_VERSION-fpm

    echo "Generated: $REPOSITORY:$PHP_VERSION"
fi
