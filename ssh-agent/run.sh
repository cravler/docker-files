#!/bin/sh

export DISPLAY=None
export SSH_ASKPASS=/ssh-askpass.sh

rm -f "${SSH_AUTH_SOCK}"

if [ -f "${SSH_ADD}" ]; then
    `sleep 1 && ssh-add ${SSH_ADD}` &
fi

ssh-agent -a "${SSH_AUTH_SOCK}" -D
