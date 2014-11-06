#How to use this image:

    sudo docker run -i -t --rm -v /src/webapp:/var/www cravler/sencha-cmd sencha [options]

or add to ~/.bashrc

    sencha() {
        p=`pwd`
        a="$@"
        if [ -z "$a" ]; then
            a='-i';
        fi
        sudo docker run -i -t --rm -v "$p":/var/www cravler/sencha-cmd sencha $a
    }

and just run

    sencha
