#!/bin/bash

MY_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
REPOSITORY=cravler/php
PUSH_IMAGE=NO
ADD_TAGS=NO

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
    --add-tags)
        ADD_TAGS=YES
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
    shift
    docker build $PULL --no-cache --rm -f $MY_PATH/Dockerfile.$TAG -t $REPOSITORY:$TAG .
    if [ "YES" = "$PUSH_IMAGE" ]; then
        docker push $REPOSITORY:$TAG
    fi
    if [ "YES" = "$ADD_TAGS" ]; then
        for ADD_TAG in $@; do
            docker tag $REPOSITORY:$TAG $REPOSITORY:$ADD_TAG
            if [ "YES" = "$PUSH_IMAGE" ]; then
                docker push $REPOSITORY:$ADD_TAG
            fi
        done
    fi
}

#build_docker_image 5.6-cli    --pull    5-cli 5.6 5
#build_docker_image 5.6-fpm    ""        5-fpm
#build_docker_image 7.0-cli    --pull    7.0
#build_docker_image 7.0-fpm    ""
#build_docker_image 7.1-cli    --pull    7.1
#build_docker_image 7.1-fpm    ""
#build_docker_image 7.2-cli    --pull    7.2
#build_docker_image 7.2-fpm    ""
#build_docker_image 7.3-cli    --pull    7.3
#build_docker_image 7.3-fpm    ""

build_docker_image 7.4-cli    --pull    7-cli 7.4 7
build_docker_image 7.4-fpm    ""        7-fpm
build_docker_image 8.0-cli    --pull    8-cli cli 8.0 8 latest
build_docker_image 8.0-fpm    ""        8-fpm fpm
