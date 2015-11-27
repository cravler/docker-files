#How to use this image:

## Daemon

    docker run -d -p 873:873 -v `pwd`:/volume cravler/rsync

## Sync

    docker run -it --rm -v `pwd`:/volume -e 'RSYNC_PASSWORD=[password]' cravler/rsync rsync /volume/ rsync://[username]@172.17.0.1:873/data

or

    docker run -it --rm -v `pwd`:/volume -e 'RSYNC_PASSWORD=[password]' cravler/rsync rsync rsync://[username]@172.17.0.1:873/data /volume
