# How to use this image:

Start `ssh-agent`

    docker run -d --restart always \
    --env SSH_ADD=/id_rsa \
    --name ssh-agent cravler/ssh-agent

Add your SSH private key to the `ssh-agent`

    docker cp $HOME/.ssh/id_rsa ssh-agent:/id_rsa
    docker restart ssh-agent

Check that key added

    docker run -it --rm \
    --volumes-from ssh-agent \
    cravler/ssh-agent ssh-add -L
