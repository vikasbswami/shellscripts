#!/bin/bash
cmd=(whiptail --separate-output --checklist "Select apps to install:\n(Use ARROWs, TAB, SPACE and ENTER keys)" 22 56 10)
options=(
1 "VMWare" off
2 "Virtual Box" off
3 "Google Chrome" off
4 "Filezilla Client" off
5 "Git" off
6 "Atom Code Editor" off
7 "MS Visual Studio Code" off
8 "Anydesk" off
9 "VLC Player" off
10 "GParted" off
11 "Gimp" off
12 "Inkscape" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

checknet() {
echo "Checking Internet connectivity..."
if [[ `ping -q -c 1 -W 1 www.googel.com >> /dev/null` ]]
then
	echo "OK"
else
	echo "No Internet"
	exit
fi
}
clear

checknet()

for choice in $choices
do
	case $choice in
	1)
		echo "vmware"
		;;
	2)
		echo "virtualbox"
		;;
	3)
		echo "chrome"
		;;
	4)
		echo "filezilla"
		;;
	5)
		echo "git"
		;;
	6)
		echo "atom"
		;;
	7)
		echo "ms code"
		;;
	8)
		echo "anydesk"
		;;
	9)
		echo "vlc player"
		;;
	10)
		echo "gparted"
		;;
	11)
		echo "gimp"
		;;
	12)
		echo "inkscape"
		;;
	esac
done
