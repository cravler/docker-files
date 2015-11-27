#!/bin/bash

USERNAME=${USERNAME:-$(pwgen -s 12 1)}
PASSWORD=${PASSWORD:-$(pwgen -s 12 1)}

echo "$USERNAME:$PASSWORD" > /etc/rsyncd.secrets
chmod 0400 /etc/rsyncd.secrets

[ -f /etc/rsyncd.conf ] || cat <<EOF > /etc/rsyncd.conf
pid file = /var/run/rsyncd.pid
log file = /dev/stdout
timeout = 300
max connections = 10
[data]
    uid = root
    gid = root
    hosts allow = *
    read only = false
    path = ${VOLUME:-/volume}
    auth users = $USERNAME
    secrets file = /etc/rsyncd.secrets
EOF

echo ""
echo "========================================================"
echo "    You can now connect to this Rsync server using:"
echo "    USERNAME: $USERNAME"
echo "    PASSWORD: $PASSWORD"
echo "========================================================"
echo ""

exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"
