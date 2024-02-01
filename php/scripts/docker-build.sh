#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKDIR="$(dirname ${SCRIPT_DIR})"

REPOSITORY=cravler/php
PUSH_IMAGE=NO
ADD_TAGS=NO

CMD=""
PLATFORM=""

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
    --platform=*)
        CMD="buildx"
        PLATFORM="${i#*=}"
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

if [ "buildx" = "${CMD}" ]; then
    docker run --rm --privileged tonistiigi/binfmt --install all
    docker buildx create --use --name my-builder
fi

build_docker_image() {
    TAG=$1
    PULL=$2
    shift 2

    FLAGS=""
    if [ "buildx" = "${CMD}" ]; then
        FLAGS="--output type=tar,dest=/tmp/php.${TAG}"
        if [ "YES" = "${PUSH_IMAGE}" ]; then
            FLAGS="--push"
        fi
        FLAGS="${FLAGS} --platform ${PLATFORM}"
    fi

    TAGS=""
    if [ "YES" = "${ADD_TAGS}" ]; then
        for ADD_TAG in $@; do
            TAGS="${TAGS} -t ${REPOSITORY}:${ADD_TAG}"
        done
    fi

    docker ${CMD} build \
        ${PULL} ${FLAGS} --no-cache --rm \
        -f ${WORKDIR}/Dockerfile.${TAG} \
        -t ${REPOSITORY}:${TAG} \
        ${TAGS} \
        "${WORKDIR}"

    echo ""
    echo "IMAGE: ${REPOSITORY}:${TAG}"
    if [ ! -z "${TAGS}" ]; then
        DELIM=""
        printf "TAGS: "
        for ADD_TAG in $@; do
            printf "%s" "${DELIM}${ADD_TAG}"
            DELIM=", "
        done
        echo ""
    fi
    echo ""

    if [ "buildx" = "${CMD}" ]; then
        if [ "YES" = "${PUSH_IMAGE}" ]; then
            docker buildx imagetools inspect ${REPOSITORY}:${TAG}
        else
            du -hs /tmp/php.${TAG}
            tar -tf /tmp/php.${TAG} | awk -F/ '{print $1}' | uniq
            echo ""
        fi
    else
        if [ "YES" = "${PUSH_IMAGE}" ]; then
            docker push ${REPOSITORY}:${TAG}
            if [ "YES" = "${ADD_TAGS}" ]; then
                for ADD_TAG in $@; do
                    docker push ${REPOSITORY}:${ADD_TAG}
                done
            fi
        fi
    fi
}

echo ""
echo "BUILDING: ${REPOSITORY}"
echo ""

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
#build_docker_image 7.4-cli    --pull    7-cli 7.4 7
#build_docker_image 7.4-fpm    ""        7-fpm

build_docker_image 8.0-cli    --pull    8.0
build_docker_image 8.0-fpm    ""
build_docker_image 8.1-cli    --pull    8.1
build_docker_image 8.1-fpm    ""
build_docker_image 8.2-cli    --pull    8.2
build_docker_image 8.2-fpm    ""
build_docker_image 8.3-cli    --pull    8-cli cli 8.3 8 latest
build_docker_image 8.3-fpm    ""        8-fpm fpm
