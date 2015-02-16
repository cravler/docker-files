#!/bin/bash

_dir="$1"
_key="$2"
_value="$3"
# Do a loop so sed can scale with number of files/options
for i in $(find $_dir -type f); do
    /.cravler/sed.sh -r "s|\S*($_key\s+=).*|\1 $_value|g" $i
done
