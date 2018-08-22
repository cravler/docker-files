#!/bin/sh

exec /usr/bin/ssh-agent -a "${SSH_AUTH_SOCK}" -D
