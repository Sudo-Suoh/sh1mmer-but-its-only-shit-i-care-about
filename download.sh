#!/bin/bash
read -p "enter board you wanna download a sh1mmer shim for >  " board
wget -q --show-progress https://github.com/crosbreaker/sh1mmer/releases/download/legacy/${board}-legacy.zip
#catzipfile=$(cat "${board}-legacy.zip") got a error for ts
# if [[ "$catzipfile" == ""]]; then
#  echo "invalid zip file check if you typed the board name correctly"
#  exit 1
#else
#  echo "Downloaded Successfully!"
#  echo ":3"
#  echo "#myamazingsummer"
#fi
# probably a way to make ts work but im too skiddy to want to find it :(
echo "Downloaded Shim!"
echo "prebuilt shims made by crosbreaker"
echo "sh1mmer shims by mercury workshop"
echo "shxmm3r by sudoh"
echo "#myamazingsummer"
exit 0
