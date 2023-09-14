#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKDIR="$(dirname $SCRIPT_DIR)"

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
    #$SCRIPT_DIR/generate.sh --repository=$REPOSITORY 5.6
    #$SCRIPT_DIR/generate.sh --repository=$REPOSITORY 7.0
    #$SCRIPT_DIR/generate.sh --repository=$REPOSITORY 7.1
    #$SCRIPT_DIR/generate.sh --repository=$REPOSITORY 7.2
    #$SCRIPT_DIR/generate.sh --repository=$REPOSITORY 7.3
    #$SCRIPT_DIR/generate.sh --repository=$REPOSITORY 7.4

    $SCRIPT_DIR/generate.sh --repository=$REPOSITORY 8.0
    $SCRIPT_DIR/generate.sh --repository=$REPOSITORY 8.1
    $SCRIPT_DIR/generate.sh --repository=$REPOSITORY 8.2
else
    PHP_VERSION=$1

    # CLI
    cat $WORKDIR/templates/base > $WORKDIR/Dockerfile.$PHP_VERSION-cli
    cat $WORKDIR/templates/ppa >> $WORKDIR/Dockerfile.$PHP_VERSION-cli
    cat $WORKDIR/templates/$PHP_VERSION-cli >> $WORKDIR/Dockerfile.$PHP_VERSION-cli

    # FPM
    #if [[ $1 == '5.6' ]]; then
    #    PHP_FPM=$(<$WORKDIR/templates/$PHP_VERSION-fpm)
    #fi

    render_template $WORKDIR/templates/fpm > $WORKDIR/Dockerfile.$PHP_VERSION-fpm

    echo "GENERATED: $REPOSITORY:$PHP_VERSION"
fi
