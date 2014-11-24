#How to use this image:

    sudo docker run -i -t --rm -v `pwd`:/var/www cravler/bower bower <command> [<args>] [<options>]

or add to ~/.bashrc

    bower() {
        a="$@"
        if [ -z "$a" ]; then
            a='help';
        fi
        sudo docker run -i -t --rm -v `pwd`:/var/www cravler/bower bower $a
    }

and just run

    bower <command> [<args>] [<options>]
