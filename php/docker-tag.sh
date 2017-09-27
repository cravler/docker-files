#!/bin/bash

REPOSITORY=cravler/php
PULL_IMAGE=NO
PUSH_TAGS=NO

for i in "$@"; do
case $i in
    --repository=*)
        REPOSITORY="${i#*=}"
        shift
    ;;
    --pull)
        PULL_IMAGE=YES
        shift
    ;;
    --push)
        PUSH_TAGS=YES
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

add_docker_tag() {
    TAG=$1
    shift
    if [ "YES" = "$PULL_IMAGE" ]; then
        docker pull $REPOSITORY:$TAG
    fi
    ID=$(docker images -q $REPOSITORY:$TAG)
    if [ ! -z "$ID" ]; then
        for ADD_TAG in $@; do
            docker tag $ID $REPOSITORY:$ADD_TAG
            if [ "YES" = "$PUSH_TAGS" ]; then
                docker push $REPOSITORY:$ADD_TAG
            fi
        done
    fi
}

add_docker_tag 7.2-cli 7.2
add_docker_tag 7.1-cli 7-cli cli 7.1 7 latest
add_docker_tag 7.1-fpm 7-fpm fpm
add_docker_tag 7.0-cli 7.0
add_docker_tag 5.6-cli 5-cli 5.6 5
add_docker_tag 5.6-fpm 5-fpm
