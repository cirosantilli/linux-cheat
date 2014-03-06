Website: <https://www.softcover.io>

Open Source components: <https://github.com/softcover>

Manual: <http://manual.softcover.io/book>

Ubuntu dependencies install:

    sudo apt-get install calibre default-jre imagemagick texlive-latex-base 
    # Texlive 2013
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar xjf install-tl-unx.tar.gz
    cd install-tl-*
    echo i | sudo ./install-tl
    echo '
    # Texlive
    export PATH=$PATH:/usr/local/texlive/2013/bin/i386-linux
    export MANPATH=$MANPATH:/usr/local/texlive/2013/texmf-dist/doc/man
    export INFOPATH=$INFOPATH:/usr/local/texlive/2013/texmf-dist/doc/info
    ' >> ~/.profile
