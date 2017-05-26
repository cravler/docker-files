#!/bin/bash

for env in `printenv | grep "${PHP_ALIAS}_"`; do
    IFS== read name value <<< "$env"
    export ${name/"${PHP_ALIAS}_"/PHP_}=$value
done
