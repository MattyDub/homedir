#!/bin/bash -x

function backup {
   export SRC_DIR=$1

   if [ -e $SRC_DIR ]; then
      export AWAY_DIR=$SRC_DIR.homedir.backup
      while [ -e $AWAY_DIR ]; do
          export TIMESTAMP=$(date "+%Y%m%d%H%M%S")
          export AWAY_DIR=$AWAY_DIR.$TIMESTAMP
      done
      echo "Backing up existing $SRC_DIR to $AWAY_DIR"
      mv $SRC_DIR $AWAY_DIR
   fi
}

#TODO: can't have trailing slash here; can we fix that?
backup ~/bin
cp -r ./bin ~/bin