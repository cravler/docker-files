#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKDIR="$(dirname $SCRIPT_DIR)"

DIND_NAME="dind_$$"
PUSH_IMAGE=NO

for i in "$@"; do
case $i in
    --push)
        PUSH_IMAGE=YES
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

docker run \
    -d \
    --privileged \
    --name ${DIND_NAME} \
    -v ${HOME}/.docker/config.json:/root/.docker/config.json \
    -v ${WORKDIR}:/mnt/repo \
    -w /mnt/repo \
    docker:dind

docker exec \
    -t \
    ${DIND_NAME} \
    sh -c "apk update && apk upgrade && apk add bash"

docker exec \
    -t \
    ${DIND_NAME} \
    sh -c "while ( ! docker ps -q &> /dev/null ); do echo '.'; sleep 1; done"

docker exec \
    -t \
    -e DOCKER_PUSH=${PUSH_IMAGE} \
    ${DIND_NAME} \
    sh -c "/mnt/repo/hooks/build"

docker exec \
    -t \
    ${DIND_NAME} \
    sh -c "docker images"

docker rm -fv ${DIND_NAME}
