#!/bin/bash

# cat5-dl.sh by Robbie Ferguson, https://baldnerd.com/
# v1.0 - August 15, 2019

# User configuration

  # Which folder would you like to save to? No trailing slash.
  folder="$HOME/Videos/Category5 Technology TV"

  # Chosen Mode: 0 = all episodes, 1 = only most recent
  mode=1

  # Pick a feed URL at https://category5.tv/subscribe/
  feed=http://category5.tv/feed/technology/hd/

# End of user configuration


curl=$(which curl)
if [[ $curl == '' ]]; then
  apt=$(which apt)
  if [[ $apt == '' ]]; then
    yum install curl
  else
    apt update
    apt install curl
  fi
fi

if [[ ! -e $folder ]]; then
  mkdir -p "$folder"
fi
cd "$folder"
echo "Saving to $folder"
sleep 1
echo ""
if [ "$mode" == "0" ]; then
  $curl -s -L $feed | awk '/enclosure/{system("wget -nc "$2);}' FS=\"
elif [ "$mode" == "1" ]; then
  $curl -s -L $feed | awk '/enclosure/{system("wget -nc "$2);exit}' FS=\"
else
  echo "Invalid mode specified. Please edit $0."
fi
