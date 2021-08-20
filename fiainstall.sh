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

clear

checknet() {
tput setaf 3
echo "Checking Internet connectivity..."
wget -q --tries=10 --timeout=20 -O - http://google.com >> /dev/null
if [[ $? -eq 0 ]]
then
	tput cup 0 34
	tput setaf 2
	echo "[OK!]"
	tput sgr0
else
	tput cup 0 34
	tput setaf 1
	echo "[No Internet. Exiting!]"
	tput sgr0
	exit
fi
}

update() {
	tput cup 1 0
	tput setaf 3
	echo "Updating packages..."
	sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y
	if [[ $? -eq 0 ]]
	then
		tput setaf 2
		echo "[Done!]"
		tput sgr0
	else
		tput setaf 1
		echo "[Update Error. Exiting!]"
		tput sgr0
		exit
	fi
}

checknet
update

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
