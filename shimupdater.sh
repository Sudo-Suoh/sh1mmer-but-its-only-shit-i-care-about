#!/bin/bash
whoami2=$(whoami)
if [[ "$whoami2" != "root" ]]; then
  echo "run with root :)"
  exit 0
fi
echo "welcome to shim updater!"
echo "this tool will update your shxmm3r shim!"
echo "useful for me (sudoh) to develop so I can swap out patches"
echo "and useful for YOU for when you update from v0.95 to v1.00 or potentially other releases :D"
read -p "enter drive in this format [/dev/sdX]  " drive
pwd2=$(pwd)
if [[ "$drive" == *"mmcblk" ]]; then
  p="${drive}p"
else
  p="$drive"
fi
sudo mount ${p}1 shimrootfsmnt
rm -rf shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_main.sh
sudo cp "${pwd2}/sh1mmer_main.sh" "shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_main.sh"
sudo umount ${p}1
