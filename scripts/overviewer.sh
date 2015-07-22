#!/bin/bash

# makes map and invokes film

#set -e
#set -x

while true;
do
  echo overviewer-start | logger
  FULL_BACKUP=/home/mavencraft/world

  MAP_BASE=/usr/share/nginx
  LAST_MAP=html

  FULL_MAP=$MAP_BASE/$LAST_MAP

  export FULL_BACKUP
  export FULL_MAP

  echo overview-sleep | logger

  if [ -e /home/mavencraft/world/level.dat ];
  then
    sleep 15
    echo 'authentic\nsave-on\nsave-all' | nc -w 1 localhost 25566 2>&1 > /dev/null
    time overviewer.py -p $1 --simple-output --config /home/mavencraft/mavencraft/scripts/overviewerConfig.py 2>&1 | logger -t ov-py
    echo 'authentic\nsay charted' | nc -w 1 localhost 25566 2>&1 > /dev/null
  else
    sleep 30
    echo 'authentic\nsetworldspawn 0 65 0\nsave-on\nsave-all\nvp hideMessages' | nc -w 10 localhost 25566 2>&1 > /dev/null
    echo overviewer-saved | logger
  fi
  echo overviewer-end | logger
done
