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
allowrwmnt() {
	dd of="$1" seek=1127 \
	conv=notrunc count=1 bs=1 2>/dev/null
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
mv -f "shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_main.sh" "oldsh1mmer.sh"
mv -f "shimrootfsmnt/bootstrap/noarch/init_sh1mmer.sh" "oldsh1mmerinit.sh"
cp "$pwd2/sh1mmer_main.sh" "shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_main.sh"
cp "$pwd2/init_sh1mmer.sh" "shimrootfsmnt/bootstrap/noarch/init_sh1mmer.sh"
mkdir -p "$MNT_SH1MMER/root/noarch/sbin/" # half the time this doesn't exist. make it. okay xmb9 ill listen to you
mkdir "shimrootfsmnt/root/noarch/mrchromebox"
mv "shimrootfsmnt/root/noarch/payloads/mrchromebox.sh" "shimrootfsmnt/root/noarch/mrchromebox/mrchromebox.sh"
mv "shimrootfsmnt/root/noarch/payloads/mrchromebox.tar.gz" "shimrootfsmnt/root/noarch/mrchromebox/mrchromebox.tar.gz"
chmod -R +x "shimrootfsmnt" #i mean priism chmods ts so ig i gotta do ts
rm -rf "shimrootfsmnt/root/noarch/payloads"
rm -rf "shimrootfsmnt/root/noarch/usr/sbin/sh1mmer_payload.sh"

echo "hol up lemme unmount ts"
umount "${loop}p1"
echo "you can thank xmb9 for what happened in the background"
echo "99% was xmb9 1% was me"
echo "the part i did was removing unncecassary sh1mmer shit, because im redoing sh1mmer yk"
echo "lemme post ts onto facebook"
sleep 1s
echo "NOOOO"
sleep 1s
echo "#grrmondays"
losetup -d "$loop"
credits
echo "enjoy or not your choice"
exit 0
