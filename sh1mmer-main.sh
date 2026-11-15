#!/bin/bash
#ts was made in 30 minutes btw
# v1 will be more polished
# also lots of skidding
credits() {
  echo "mercuryworkshop: og sh1mmer"
  echo "quicksilver by: emerwyi (idk discord bruh)"
  echo "emudhroll by: katie"
  echo "shimboot and pivot root shit by: ading2210 on github (idk discord bruh)"
}
quicksilver() {
  echo "quicksilver: unenrollment for under v143"
  read -p "continue? [Y/n] (case sensitive because why not [make Y UPPERCASE])" continue
  case "$continue" in
  [Y]) : ;;
  *) sleep 0 ;; #do nothing code
  esac
  vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"
  crossystem disable_dev_request=1 || :
  crossystem disable_dev_request=1 # grunt weirdness according to sh1mmer
  #feel free to flame my ass but what does || : mean
  reboot
  sleep infinity
}
xpivot_root() {
  read -p "enter partition to pivot" partition
  mount $partition /newroot
  mkdir /newroot
  echo "i aint checking if ts partition is encrypted until v1 bro"
  #bind mount /dev/console to show systemd boot msgs
  # all according to shimboots plant... get it... deltarune refrence... no? ok
  if [ -f "/bin/frecon-lite" ]; then 
    rm -f /dev/console
    touch /dev/console #this has to be a regular file otherwise the system crashes afterwards
    mount -o bind "$TTY1" /dev/console
  fi
  mount
  local base_mounts="/sys /proc /dev"
  for mnt in $base_mounts; do
    # $mnt is a full path (leading '/'), so no '/' joiner
    mkdir -p "/newroot$mnt"
    mount -n -o move "$mnt" "/newroot$mnt"
  done
  echo "switching root and shit"
  mkdir -p /newroot/sh1mmer2
  pivot_root /newroot /newroot/bootloader
  exec /sbin/init
}
emhudroll() {
  echo "shimboot and emhudroll wont exist until v1 is released :("
}
shimboot() {
  echo "shimboot wont exist until v1 is released"
}
menu() {
  echo "1. quicksilver"
  echo "2. pivot_root"
  echo "3. UNRELEASED: emhudroll"
  echo "4. UNRELEASED: shimboot"
  echo "5. credits"
  read -p "-->  " select
  case "$select" in
  [1])  quicksilver ;;
  [2])  xpivot_root ;;
  [3])  emhudroll ;;
  [4])  shimboot ;;
  [5])  credits ;;
  *)  echo "invalid option joe" ;;
  esac
}
notice() {
  echo "ts was made under 30 minutes and not alot of polish is here"
  echo "and also lots of skidding :3"
  read -p "press ENTER to continue"
  clear
  menu
}
notice
