#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKDIR="$(dirname ${SCRIPT_DIR})"

REPOSITORY=cravler/ssh-agent
PUSH_IMAGE=NO
ADD_TAGS=NO
BUILD=dev

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
    --build=*)
        BUILD="${i#*=}"
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
    shift

    FLAGS=""
    if [ "buildx" = "${CMD}" ]; then
        FLAGS="--output type=tar,dest=/tmp/ssh-agent.${TAG}"
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
        --pull ${FLAGS} --no-cache --rm \
        -f ${WORKDIR}/Dockerfile \
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
            du -hs /tmp/ssh-agent.${TAG}
            tar -tf /tmp/ssh-agent.${TAG} | awk -F/ '{print $1}' | uniq
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

build_docker_image latest ${BUILD}
