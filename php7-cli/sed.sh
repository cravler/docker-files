#!/bin/bash

regexp=${@: -2:1}
file=${@: -1:1}

case "$1" in
    -*)
        sed $1 "$regexp" $file > $file.$$
        ;;
    *)
        sed "$regexp" $file > $file.$$
        ;;
esac;

cp $file.$$ $file
rm $file.$$