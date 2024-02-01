#!/bin/sh

set -e

JSON=$(composer global show --format=json --no-interaction --available friendsofphp/php-cs-fixer 2>/dev/null)
LATEST=$( echo ${JSON} | grep -o '"versions": \[ "[^"]*' | grep -o '[^"]*$' )

VERSION=""
if [ -e ${COMPOSER_HOME}/vendor/bin/php-cs-fixer ]; then
    JSON=$(composer global show --format=json --no-interaction friendsofphp/php-cs-fixer 2>/dev/null)
    VERSION=$( echo ${JSON} | grep -o '"versions": \[ "[^"]*' | grep -o '[^"]*$' )
fi

if [ "${LATEST}" != "${VERSION}" ]; then
    composer global require --quiet --no-interaction friendsofphp/php-cs-fixer:${LATEST}
fi

${COMPOSER_HOME}/vendor/bin/php-cs-fixer $@
