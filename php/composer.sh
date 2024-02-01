#!/bin/sh

set -e

mkdir -p ${COMPOSER_HOME}/bin
if [ ! -e ${COMPOSER_HOME}/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | php -- --quiet --install-dir=${COMPOSER_HOME}/bin --filename=composer
fi
export PATH=${PATH}

composer $@
