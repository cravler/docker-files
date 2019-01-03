#!/bin/bash

MY_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
REPOSITORY=cravler/php
PUSH_IMAGE=NO

for i in "$@"; do
case $i in
    --repository=*)
        REPOSITORY="${i#*=}"
        shift
    ;;
    --push)
        PUSH_IMAGE=YES
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

build_docker_image() {
    TAG=$1
    PULL=$2
    docker build $PULL --no-cache --rm -f $MY_PATH/Dockerfile.$TAG -t $REPOSITORY:$TAG .
    if [ "YES" = "$PUSH_IMAGE" ]; then
        docker push $REPOSITORY:$TAG
    fi
}

build_docker_image 5.6-cli --pull
build_docker_image 5.6-fpm
build_docker_image 7.0-cli --pull
build_docker_image 7.0-fpm
build_docker_image 7.1-cli --pull
build_docker_image 7.1-fpm
build_docker_image 7.2-cli --pull
build_docker_image 7.2-fpm
build_docker_image 7.3-cli --pull
build_docker_image 7.3-fpm
