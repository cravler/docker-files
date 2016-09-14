#How to use this image:

    docker run -it --rm -v $HOME:$HOME -w `pwd` cravler/sencha-cmd sencha [<options>]

or add to ~/.bashrc

    sencha() {
        a="$@"
        if [ -z "$a" ]; then
            a='-i';
        fi
        docker run -it --rm -v $HOME:$HOME -w `pwd` cravler/sencha-cmd sencha $a
    }
    export -f sencha

and just run

    sencha [<options>]
