#!/bin/sh

STR=''
for i in "$@"
do
    case "$i" in
    *\ * )
        case "$i" in
            *\"* )
                STR="$STR '$i'"
                ;;
            *)
                STR="$STR \"$i\""
                ;;
        esac
        ;;
    *)
        STR="$STR $i"
        ;;
    esac
done

echo "$STR"
