#!/bin/bash

FILES=()
VERBOSE=0

for i in "$@"; do
case $i in
    --file=*)
        FILES=("${FILES[@]}" "${i#*=}")
        shift
    ;;
    --verbose)
        VERBOSE=1
        shift
    ;;
    *)
        # unknown option
    ;;
esac
done

render_template() {
    eval "echo \"$(cat $1)\""
}

dotenv_export() {
    ENV_FILE=$1
    ENV=$(/.cravler/dotenv.sh $ENV_FILE)
    if [ -n "$ENV" ]; then
        if [ 1 == $VERBOSE ]; then
            echo ""
            echo "\`$ENV_FILE\` file exist. Exporting values...";
        fi
        set -o allexport
        source <(echo "$ENV")
        set +o allexport
    fi
}

NEWLINE=0
for FILE in "${FILES[@]}"; do
    file=$(render_template <(echo "$FILE"))
    dotenv_export $file
    if [ -f $file ]; then
        NEWLINE=1
    fi
done

if [[ 1 == $VERBOSE && 1 == $NEWLINE ]]; then
    echo ""
fi
