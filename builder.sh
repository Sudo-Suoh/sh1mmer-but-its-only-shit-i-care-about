#!/bin/bash
info() {
  echo "INFO: $1"
}
fail() {
	echo "FAIL with error $1"
}
usage() {
	echo "sudo bash builder.sh /path/to/sh1mmer/shim"
}

credits() {
    echo "CREDITS"
	echo "xmb9: priism builder"
}

whoami2=$(whoami)
shim="$1"
pwd2=$(pwd)
if [[ "$whoami2" != "root" ]]; then
  echo "not running as root escalating privileges"
  sudo su
fi

if [[ "$shim" == "" ]]; then
  echo "insert shim path"
  usage
  exit 1
fi

loop=$(losetup -fP --show "$shim")
mkdir shimrootfsmnt 2>/dev/null 
mount "${loop}p1" shimrootfsmnt
mv -f "shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_main.sh" "bettersh1mmerimo.sh"
cp "$pwd2/sh1mmer_main.sh" "shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_main.sh"
#i aint redoing sh1mmerinit because im too skiddy for ts
mkdir -p "$MNT_SH1MMER/root/noarch/sbin/" # half the time this doesn't exist. make it. okay xmb9 ill listen to you
chmod -R +x "shimrootfsmnt" #i mean priism chmods ts so ig i gotta do ts
echo "you can thank xmb9 for what happened in the background"
echo "hol up lemme unmount ts"
umount "${loop}p1"
echo "lemme post ts onto facebook"
sleep 1s
echo "NOOOO"
sleep 1s
echo "#grrmondays"
losetup -d "$loop"
credits
echo "enjoy or not your choice"
exit 0
