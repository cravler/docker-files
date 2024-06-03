# How to use this image:

Generate SSH key, if it doesn't exist yet

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Start `ssh-agent`

```sh
docker run -d --restart always \
    --env SSH_ADD=/id_ed25519 \
    --env SSH_PASS=IfYouUsePassphrase \
    --name ssh-agent cravler/ssh-agent
```

Add your SSH private key to the `ssh-agent`

```sh
docker cp $HOME/.ssh/id_ed25519 ssh-agent:/id_ed25519
docker restart ssh-agent
```

Check that key added

```sh
docker run -it --rm \
    --volumes-from ssh-agent \
    cravler/ssh-agent ssh-add -L
```
