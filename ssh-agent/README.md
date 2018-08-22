#How to use this image:

Start `ssh-agent`

    docker run -d --name ssh-agent cravler/ssh-agent

Add your SSH private key to the `ssh-agent`

    docker run -it --rm --volumes-from ssh-agent -v $HOME:$HOME cravler/ssh-agent ssh-add $HOME/.ssh/id_rsa
