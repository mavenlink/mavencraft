#!/bin/sh

echo minecraft-repair

echo "mode?"
read line

if [ "$line" = "destroy" ];
then
  echo destroying

  rm -Rf /home/mavencraft/world*
  rm -Rf /usr/share/nginx/html/normal
  rm -Rf /usr/share/nginx/html/scenes

  line="kill"
fi;

if [ "$line" = "kill" ];
then
  echo killing

  pkill -9 -f overviewer || true
  pkill -9 -f java || true
  pkill -9 -f java || true
  pkill -9 -f ruby || true

  rm -Rf /home/mavencraft/running-mavencraft
  rm -Rf /home/mavencraft/running-minecraft
  rm -Rf /home/mavencraft/running-overviewer
fi;

sleep 1
