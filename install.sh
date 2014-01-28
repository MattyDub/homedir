#!/bin/bash -x

function backup {
   export SRC=$1

   if [ -e $SRC ]; then
      export AWAY=$SRC.homedir.backup
      while [ -e $AWAY ]; do
          export TIMESTAMP=$(date "+%Y%m%d%H%M%S")
          export AWAY=$AWAY.$TIMESTAMP
      done
      echo "Backing up existing $SRC to $AWAY"
      mv $SRC $AWAY
   fi
}

backup ~/bin
cp -r ./bin ~/bin

backup ~/.emacs
cp -r .emacs ~/.emacs

backup ~/.bashrc
cp .bashrc ~/.bashrc

backup ~/.profile
cp .profile ~/.profile