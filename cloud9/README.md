# How to use this image:

    docker run -it --rm -p 8181:8181 -v `pwd`:/workspace cravler/cloud9 \
    cloud9 [<options>]

or add to ~/.bashrc

    cloud9() {
        mkdir -p ~/.c9
        set -o noclobber
        { > ~/.c9/user.settings ; } &> /dev/null
        docker run -it --rm -p 8181:8181 \
        -v `pwd`:/workspace \
        -v ~/.c9/user.settings:/root/.c9/user.settings \
        cravler/cloud9 \
        cloud9 $@
    }

and just run

    cloud9 [<options>]
