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
 evelyn :3  /home/sudih/sh1mmer-but-its-only-shit-i-care-about # cat sh1mmer_main.sh
#!/bin/bash
#ts was NOT made in 30 minutes
# the first version was not v0.95
# v0.95 IS OUT :D
# v1 will be more polished
# also lots of skidding
if ! ls /mnt 2>&1 >/dev/null; then
   mkdir /mnt
fi
#the above checks if /mnt exists and creates it
#this will be useful for things like mounting stateful and mounting partitions

#COLORS
red="\e[0;31m"
green="\e[0;32m"
yellow="\e[0;33m"
blue="\e[0;34m"
purple="\e[0;35m"
cyan="\e[1;36m"
boldred="\e[1;31m"
boldgreen="\e[1;32m"
boldyellow="\e[1;33m"
boldgreen="\e[1;34m"
boldpurple="\e[1;35m"
pink="\x1b[38;5;5m"
reset="\e[0m"

colorecho() {
	color="$1"
	text="$2"
	echo -e "${1}$2$reset"
}
credits() {
  printf "$green"
  echo "mercuryworkshop: og sh1mmer and sh1mmer payloads except ones with a credit here"
  echo "DAUB by crosbreaker found by hannah"
  echo "quicksilver by: emerwyi (idk discord bruh)"
  echo "emudhroll by: katie"
  echo "shimboot and pivot root shit by: ading2210 on github (idk discord bruh)"
  echo "kristine for helping with an error"
  echo "sudoh/evelyn: coding ts, kristine helped me with one error"
  echo "sudoh is a skid bro :whale: (yes im calling myself a skid)"
  echo "crossystem: having esex with 13 year old while crossystem was 17"
  printf "$reset"
}
runpayload() {
	payload="$1"
	$payload
	if [[ "$?" == "0" ]]; then
	 colorecho "$green" "TASK COMPLETED SUCCESSFULLY"
	 read -p "press enter to continue >  "
	elif [[ "$?" == "1" ]]; then
	 colorecho "$red" "TASK FAILED"
	 read -p "press enter to continue >  "
	else
	 colorecho "$blue" echo "TASK COMPLETED WITH EXIT CODE $?"
	 read -p "press enter to continue >  "
	fi  
}
#skidded from sh1mmer
get_largest_blockdev() {
	local largest size dev_name tmp_size remo
	size=0
	for blockdev in /sys/block/*; do
		dev_name="${blockdev##*/}"
		echo "$dev_name" | grep -q '^\(loop\|ram\)' && continue
		tmp_size=$(cat "$blockdev"/size)
		remo=$(cat "$blockdev"/removable)
		if [ "$tmp_size" -gt "$size" ] && [ "${remo:-0}" -eq 0 ]; then
			largest="/dev/$dev_name"
			size="$tmp_size"
		fi
	done
	echo "$largest"
}
quicksilver() {
  colorecho "$blue" "quicksilver: unenrollment for under v143"
  read -p "continue? [Y/n]  " continue
  case "$continue" in
  [yY]) : ;;
  *) sleep 0 ;; #do nothing code
  esac
  vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"
  read -p "reboot or no [Y/n]  " reboot
  case "$reboot" in
  [yY]) reboot ;;
  *) ;;
  esac
}
testpayload() {
  colorecho "$pink" "hello"
  return 2
}
touchdevmode() {
	crosdev=$(get_largest_blockdev)
	if [[ "$crosdev" == "" ]]; then
	 colorecho "$yellow" "no chrome os dev device found"
	 return 1
	fi
	colorecho "$purple" "this bypasses the 5 minute wait upon entering developer mode"
    colorecho "$purple" "DETECTED CHROME OS DEVICE: $crosdev"
	read -p "continue? [Y/n]  " touchdevmode
	case "$touchdevmode" in
	[yY]) sleep 0 ;;
	*) echo "ABORT" && return 1 ;;
	esac
	if [[ "$drive" == *"mmcblk" ]]; then
	 p="${drive}p"
	else
	 p="$drive"
	fi
	mkfs.ext4 "${p}1"
	mount "${p}1" /mnt
	touch /mnt/.developer_mode
	umount "${p}1"
	echo "finished"
}
daub() {
    crosdev=$(get_largest_blockdev)
    if [[ "$crosdev" == "" ]]; then
      colorecho "$yellow" "no chrome os dev device found"
      return 1
    fi
	if [[ "$drive" == *"mmcblk" ]]; then
	 p="${drive}p"
	else
	 p="$drive"
	fi
    colorecho "$blue" "This script DISABLES updates on chrome os by deleting the update partitions!"
    colorecho "$blue" "detected crosdev $drive"
	read -p "continue? [Y/n]  " daub
	case "$daub" in
	[yY]) : ;;
	*)  echo "ABORT" && return 0;;
	esac
	fdisk "${p}" <<EOF
d
4
d
5
w
EOF
    colorecho "$blue" "want to wipe stateful to prevent loops?"
    read -p "wipe stateful? [Y/n]  " wipestateful
    case "$wipestateful" in
      [yY]) mkfs.ext4 "${p}1" ;;
      *) echo "alr" ;;
    esac
}
statewipe() {
	crosdev=$(get_largest_blockdev)
     if [[ "$crosdev" == "" ]]; then
      colorecho "$yellow" "no chrome os dev device found"
      return 1
    fi
	if [[ "$drive" == *"mmcblk" ]]; then
	 p="${drive}p"
	else
	 p="$drive"
	fi	
	colorecho "$blue" "this will wipe stateful are you sure about this? [Y/n]"
	colorecho "$blue" "detected cros device $crosdev"
    read -p ">  " statewipe
    case "$statewipe" in
    [yY]) : ;;
    *) echo "ABORT" && return 1;
    esac
    mkfs.ext4 "${p}1"
    colorecho "$green" "done!"
}
usbandaltfw() {
	crossystem dev_boot_usb=1
	crossystem dev_boot_legacy=1
	crossystem dev_boot_altfw=1
}
setgbb() {
	colorecho "$blue" "make sure you run disable wp payload first if wp isnt disabled :D"
	colorecho "$blue" "reccomended gbb flags a0b1"
	read -p "enter gbb flags 0x" flags
	/usr/share/vboot/bin/set_gbb_flags.sh 0x${flags}
}
reboot2() {
    printf "$green"
	credits
	printf "$reset"
	echo "rebooting in 5 seconds"
	sleep 5s
	reboot
}
disablewp() {
	colorecho "$blue" "make sure you physically to disable wp/use suzy q cable to disable wp before you run ts"
	read -p "are you sure about ts (you are idk why im prompting you tbh) [Y/n]" wpdisable
	case "$wpdisable" in
	[yY]) sleep 0 ;;
	*) echo "ABORT" && return 0 ;;
	esac
	flashrom --wp-disable
}
xpivot_root() {
  colorecho "$blue" "INFO: ts is being deleted for shimboot utils in v1"
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
shimboot() {
  echo "shimboot utils wont exist until v1 is released"
}
menu() {
  printf "$cyan"
  echo "X19fIF8gIF9fXyAgX19fXyAgX18gX18gIF9fIF9fX19fX18gCi8gX198IHx8IFwgXC8gLyAgXC8gIHwgIFwvICB8X18gLyBfIFwKXF9fIFwgX18gfD4gIDx8IHxcL3wgfCB8XC98IHx8XyBcICAgLwp8X19fL198fF8vXy9cX1xffCAgfF98X3wgIHxffF9fXy9ffF9c"  | base64 -d
  printf "$reset"
  echo ""
#!/bin/bash
#ts was NOT made in 30 minutes
# the first version was not v0.95
# v0.95 IS OUT :D
# v1 will be more polished
# also lots of skidding
if ! ls /mnt 2>&1 >/dev/null; then
   mkdir /mnt
fi
#the above checks if /mnt exists and creates it
#this will be useful for things like mounting stateful and mounting partitions

#COLORS
red="\e[0;31m"
green="\e[0;32m"
yellow="\e[0;33m"
blue="\e[0;34m"
purple="\e[0;35m"
cyan="\e[1;36m"
boldred="\e[1;31m"
boldgreen="\e[1;32m"
boldyellow="\e[1;33m"
boldgreen="\e[1;34m"
boldpurple="\e[1;35m"
pink="\x1b[38;5;5m"
reset="\e[0m"

colorecho() {
	color="$1"
	text="$2"
	echo -e "${1}$2$reset"
}
credits() {
  printf "$green"
  echo "mercuryworkshop: og sh1mmer and sh1mmer payloads except ones with a credit here"
  echo "DAUB by crosbreaker found by hannah"
  echo "quicksilver by: emerwyi (idk discord bruh)"
  echo "emudhroll by: katie"
  echo "shimboot and pivot root shit by: ading2210 on github (idk discord bruh)"
  echo "kristine for helping with an error"
  echo "sudoh/evelyn: coding ts, kristine helped me with one error"
  echo "sudoh is a skid bro :whale: (yes im calling myself a skid)"
  echo "crossystem: having esex with 13 year old while crossystem was 17"
  printf "$reset"
}
runpayload() {
	payload="$1"
	$payload
	if [[ "$?" == "0" ]]; then
	 colorecho "$green" "TASK COMPLETED SUCCESSFULLY"
	 read -p "press enter to continue >  "
	elif [[ "$?" == "1" ]]; then
	 colorecho "$red" "TASK FAILED"
	 read -p "press enter to continue >  "
	else
	 colorecho "$blue" echo "TASK COMPLETED WITH EXIT CODE $?"
	 read -p "press enter to continue >  "
	fi  
}
#skidded from sh1mmer
get_largest_blockdev() {
	local largest size dev_name tmp_size remo
	size=0
	for blockdev in /sys/block/*; do
		dev_name="${blockdev##*/}"
		echo "$dev_name" | grep -q '^\(loop\|ram\)' && continue
		tmp_size=$(cat "$blockdev"/size)
		remo=$(cat "$blockdev"/removable)
		if [ "$tmp_size" -gt "$size" ] && [ "${remo:-0}" -eq 0 ]; then
			largest="/dev/$dev_name"
			size="$tmp_size"
		fi
	done
	echo "$largest"
}
quicksilver() {
  colorecho "$blue" "quicksilver: unenrollment for under v143"
  read -p "continue? [Y/n]  " continue
  case "$continue" in
  [yY]) : ;;
  *) sleep 0 ;; #do nothing code
  esac
  vpd -i RW_VPD -s re_enrollment_key="$(hexdump -e '1/1 "%02x"' -v -n 32 /dev/urandom)"
  read -p "reboot or no [Y/n]  " reboot
  case "$reboot" in
  [yY]) reboot ;;
  *) ;;
  esac
}
testpayload() {
  colorecho "$pink" "hello"
  return 2
}
touchdevmode() {
	crosdev=$(get_largest_blockdev)
	if [[ "$crosdev" == "" ]]; then
	 colorecho "$yellow" "no chrome os dev device found"
	 return 1
	fi
	colorecho "$purple" "this bypasses the 5 minute wait upon entering developer mode"
    colorecho "$purple" "DETECTED CHROME OS DEVICE: $crosdev"
	read -p "continue? [Y/n]  " touchdevmode
	case "$touchdevmode" in
	[yY]) sleep 0 ;;
	*) echo "ABORT" && return 1 ;;
	esac
	if [[ "$drive" == *"mmcblk" ]]; then
	 p="${drive}p"
	else
	 p="$drive"
	fi
	mkfs.ext4 "${p}1"
	mount "${p}1" /mnt
	touch /mnt/.developer_mode
	umount "${p}1"
	echo "finished"
}
daub() {
    crosdev=$(get_largest_blockdev)
    if [[ "$crosdev" == "" ]]; then
      colorecho "$yellow" "no chrome os dev device found"
      return 1
    fi
	if [[ "$drive" == *"mmcblk" ]]; then
	 p="${drive}p"
	else
	 p="$drive"
	fi
    colorecho "$blue" "This script DISABLES updates on chrome os by deleting the update partitions!"
    colorecho "$blue" "detected crosdev $drive"
	read -p "continue? [Y/n]  " daub
	case "$daub" in
	[yY]) : ;;
	*)  echo "ABORT" && return 0;;
	esac
	fdisk "${p}" <<EOF
d
4
d
5
w
EOF
    colorecho "$blue" "want to wipe stateful to prevent loops?"
    read -p "wipe stateful? [Y/n]  " wipestateful
    case "$wipestateful" in
      [yY]) mkfs.ext4 "${p}1" ;;
      *) echo "alr" ;;
    esac
}
statewipe() {
	crosdev=$(get_largest_blockdev)
     if [[ "$crosdev" == "" ]]; then
      colorecho "$yellow" "no chrome os dev device found"
      return 1
    fi
	if [[ "$drive" == *"mmcblk" ]]; then
	 p="${drive}p"
	else
	 p="$drive"
	fi	
	colorecho "$blue" "this will wipe stateful are you sure about this? [Y/n]"
	colorecho "$blue" "detected cros device $crosdev"
    read -p ">  " statewipe
    case "$statewipe" in
    [yY]) : ;;
    *) echo "ABORT" && return 1;
    esac
    mkfs.ext4 "${p}1"
    colorecho "$green" "done!"
}
usbandaltfw() {
	crossystem dev_boot_usb=1
	crossystem dev_boot_legacy=1
	crossystem dev_boot_altfw=1
}
setgbb() {
	colorecho "$blue" "make sure you run disable wp payload first if wp isnt disabled :D"
	colorecho "$blue" "reccomended gbb flags a0b1"
	read -p "enter gbb flags 0x" flags
	/usr/share/vboot/bin/set_gbb_flags.sh 0x${flags}
}
reboot2() {
    printf "$green"
	credits
	printf "$reset"
	echo "rebooting in 5 seconds"
	sleep 5s
	reboot
}
disablewp() {
	colorecho "$blue" "make sure you physically to disable wp/use suzy q cable to disable wp before you run ts"
	read -p "are you sure about ts (you are idk why im prompting you tbh) [Y/n]" wpdisable
	case "$wpdisable" in
	[yY]) sleep 0 ;;
	*) echo "ABORT" && return 0 ;;
	esac
	flashrom --wp-disable
}
xpivot_root() {
  colorecho "$blue" "INFO: ts is being deleted for shimboot utils in v1"
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
shimboot() {
  echo "shimboot utils wont exist until v1 is released"
}
menu() {
  printf "$cyan"
  echo "X19fIF8gIF9fXyAgX19fXyAgX18gX18gIF9fIF9fX19fX18gCi8gX198IHx8IFwgXC8gLyAgXC8gIHwgIFwvICB8X18gLyBfIFwKXF9fIFwgX18gfD4gIDx8IHxcL3wgfCB8XC98IHx8XyBcICAgLwp8X19fL198fF8vXy9cX1xffCAgfF98X3wgIHxffF9fXy9ffF9c"  | base64 -d
  printf "$reset"
  echo ""
  colorecho "$blue" "(1) quicksilver"
  colorecho "$blue" "(2) pivot_root"
  colorecho "$blue" "(3) UNRELEASED: shimboot alpine utils"
  colorecho "$blue" "(4) credits"
  colorecho "$blue" "(5) skip 5 minute dev mode wait"
  colorecho "$blue" "(6) enable usbandaltfw"
  colorecho "$blue" "(7) set gbb flags"
  colorecho "$blue" "(8) disable wp"
  colorecho "$blue"  "(9) daub"
  colorecho "$blue"  "(a) Wipe stateful"
  colorecho "$blue" "(b) bash"
  colorecho "$blue" "(r) reboot"
  read -p ">  " select
  case "$select" in
  [1])  runpayload quicksilver ;;
  [2])  runpayload xpivot_root ;;
  [3])  runpayload shimboot ;;
  [4])  runpayload credits ;;
  [5])  runpayload touchdevmode ;;
  [6])  runpayload usbandaltfw ;;
  [7])  runpayload setgbb ;;
  [8])  runpayload disablewp ;;
  [9])  runpayload daub ;;
  [aA]) runpayload statewipe ;;
  [bB])  runpayload bash ;;
  [rR])  runpayload reboot2 ;;
  [tT])  runpayload testpayload ;;
  *)  read -p "invalid option  " ;;
  esac
}
clear
while true;
do
menu
clear
done
