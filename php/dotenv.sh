#!/bin/bash

RAW=0
OVERRIDE=0
ENV_FILE=$1

for i in "$@"; do
case $i in
    --raw)
        RAW=1
        shift
    ;;
    --override)
        OVERRIDE=1
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

format() {
    grep -v '^#' $1 | sed '/^[[:space:]]*$/d'
}

render() {
    eval "echo \"$(sed 's/\"/\\\"/g' $1)\""
}

if [ -f $ENV_FILE ]; then
    if [ 0 == $RAW ]; then
        if [[ -v DOTENV_VARS ]]; then
            DOTENV_VARS=("${DOTENV_VARS}")
        else
            DOTENV_VARS=()
        fi

        ENV=()

        IFS=$'\n'
        for env in $(format $ENV_FILE); do
            IFS== read name value <<< "$env"

            CONTAINS=$(IFS=, ; echo "${DOTENV_VARS[*]}")

            if [ 0 == $OVERRIDE ] && [[ -v "$name" ]] && [[ ! ",${CONTAINS}," =~ ",${name}," ]]; then
                continue
            fi

            if [[ ! ",${CONTAINS}," =~ ",${name}," ]]; then
                DOTENV_VARS=("${DOTENV_VARS[@]}" "${name}")
            fi

            ENV=("${ENV[@]}" "${env}")
        done

        SOURCE=$(echo "${ENV[*]}")

        source <(echo "$SOURCE")
        render <(echo "$SOURCE")

        echo DOTENV_VARS=$(IFS=, ; echo "${DOTENV_VARS[*]}")
    else
        format $ENV_FILE
    fi
fi
