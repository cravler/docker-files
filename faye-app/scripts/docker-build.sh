#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKDIR="$(dirname ${SCRIPT_DIR})"

REPOSITORY=cravler/faye-app
PUSH_IMAGE=NO
ADD_TAGS=NO
VERSION=latest
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
    --version=*)
          VERSION="${i#*=}"
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

if [ "latest" = "${VERSION}" ]; then
    # npm view faye-app version --no-update-notifier
    VERSION="$(wget -qO- https://registry.npmjs.org/faye-app/latest | sed -nE 's/^.*"version":"([^\"]*)".*$/\1/p')"
fi

if [ "buildx" = "${CMD}" ]; then
    docker run --rm --privileged tonistiigi/binfmt --install all
    docker buildx create --use --name my-builder
fi

build_docker_image() {
    DOCKER_FILE=$1
    TAG=$2
    PULL=$3
    shift 3

    FLAGS=""
    if [ "buildx" = "${CMD}" ]; then
        FLAGS="--output type=tar,dest=/tmp/faye-app.${TAG}"
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
        --build-arg VERSION="${VERSION}" \
        --build-arg BUILD="${BUILD}" \
        -f ${WORKDIR}/${DOCKER_FILE} \
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
            du -hs /tmp/faye-app.${TAG}
            tar -tf /tmp/faye-app.${TAG} | awk -F/ '{print $1}' | uniq
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

if [ "dev" = "${VERSION}" ]; then
    build_docker_image Dockerfile.dev dev
else
    build_docker_image Dockerfile latest --pull ${VERSION} ${VERSION}-${BUILD}
fi
