# How to use this image:

    docker run -it --rm -v $HOME:$HOME -w `pwd` cravler/compass [<options>]

or add to ~/.bashrc

    compass() {
        docker run -it --rm -v $HOME:$HOME -w `pwd` cravler/compass $@
    }

and just run

    compass [<options>]
