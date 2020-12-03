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

#add_docker_tag 5.6-cli 5-cli 5.6 5
#add_docker_tag 5.6-fpm 5-fpm
#add_docker_tag 7.0-cli 7.0
#add_docker_tag 7.1-cli 7.1
#add_docker_tag 7.2-cli 7.2

add_docker_tag 7.3-cli 7.3
add_docker_tag 7.4-cli 7-cli 7.4 7
add_docker_tag 7.4-fpm 7-fpm
add_docker_tag 8.0-cli 8-cli cli 8.0 8 latest
add_docker_tag 8.0-fpm 8-fpm fpm
