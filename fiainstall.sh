#!/bin/bash
####################################################################
#  This script installs useful apps. Works well on Ubuntu 20.04 LTS 
#  onwards. Might work on other debian based distros
#
#
#
#AUTHOR : Vikas Swami
#COMPANY : Ubercore Data Labs Private Limted
#WEBSITE : https://ubercore.company

####################################################################

cmd=(whiptail --separate-output --checklist "Select apps to install:\n(Use ARROWs, TAB, SPACE and ENTER keys)" 22 56 10)
options=(
	1 "VMWare Player" off
	2 "VirtualBox" off
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

if [[ $? = 1 ]]; then
	tput setaf 3
	echo "Cancelling..."
	exit
fi

checknet() {
	tput setaf 3
	echo "Checking Internet connectivity..."
	wget -q --tries=10 --timeout=20 -O - http://google.com >>/dev/null
	if [[ $? -eq 0 ]]; then
		tput cuu1
		tput cuf 34
		tput setaf 2
		echo "[OK!]"
		tput sgr0
	else
		tput cuu1
		tput cuf 34
		tput setaf 1
		echo "[No Internet. Exiting!]"
		tput sgr0
		exit
	fi
}

check_snap() {
	tput setaf 3
	echo "Checking Snap..."
	command -v snap &> /dev/null
	if [[ $? -eq 0 ]]; then
		tput cuu1
		tput cuf 17
		tput setaf 2
		echo "[OK!]"
		tput sgr0
		return
	else
		tput setaf 1
		echo "[No Snap Found!]"
		tput sgr0
		echo "Install Snap(y/n)?"
		read snap_choice
		if [[ $snap_choice =~ ^[Yy]$ ]]; then
			tput setaf 3
			echo "Installing Snap..."
			sudo apt update && sudo apt install snapd
			if [[ $? -eq 0 ]]; then
				tput setaf 3
				echo "Installing Snap..."
				tput cuu1
				tput cuf 19
				tput setaf 2
				echo "[Done!]"
				return
			else
				tput setaf 3
				echo "Installing Snap..."
				tput cuu1
				tput cuf 19
				tput setaf 1
				echo "[Failed!]"
				exit
			fi
		else
			tput setaf 3
			echo "Aborted!"
			exit
		fi
	fi
}

update() {
	tput setaf 3
	echo "Updating packages..."
	tput sgr0
	sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Updating packages..."
		tput cuu1
		tput cuf 21
		tput setaf 2
		echo "[Done!]"
		tput sgr0
	else
		tput setaf 3
		echo "Updating packages..."
		tput cuu1
		tput cuf 21
		tput setaf 1
		echo "[Failed. Exiting!]"
		tput sgr0
		exit
	fi
}

install_vmware() {
	tput setaf 3
	echo "Installing Linux headers..."
	update
	sudo apt install build-essential linux-headers-$(uname -r) -y
	if [[ $? -ne 0 ]]; then
		tput setaf 1
		echo "Linux headers cannot be installed."
		tput setaf 3
		echo "Installing VMWare Player..."
		tput cuu1
		tput cuf 28
		tput setaf 1
		echo "[Failed.]"
		return
	fi
	tput setaf 3
	echo "Downloading VMWare Player..."
	wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" -c https://www.vmware.com/go/getplayer-linux
	if [[ $? -eq 0 ]]; then
		chmod +x getplayer-linux
		sudo ./getplayer-linux --required --eulas-agreed
		tput setaf 3
		echo "Installing VMWare Player..."
		tput cuu1
		tput cuf 28
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "VMWare Player cannot be installed."
		tput setaf 3
		echo "Installing VMWare Player..."
		tput cuu1
		tput cuf 28
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_virtualbox() {
	tput setaf 3
	echo "Installing VirtualBox..."
	sudo echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib" | sudo tee /etc/apt/sources.list.d/oracle-vbox.list >>/dev/null
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
	sudo apt update
	sudo apt install -y virtualbox-6.1
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing VirtualBox..."
		tput cuu1
		tput cuf 25
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "VirtualBox cannot be installed."
		tput setaf 3
		echo "Installing VirtualBox..."
		tput cuu1
		tput cuf 28
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_chrome() {
	tput setaf 3
	echo "Downloading Google Chrome..."
	tput init
	wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	if [[ $? -eq 0 ]]; then
		sudo dpkg -i google-chrome-stable_current_amd64.deb
		sudo apt update && sudo apt install -f
		tput setaf 3
		echo "Installing Google Chrome..."
		tput cuu1
		tput cuf 28
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Google Chrome cannot be Installed."
		tput setaf 3
		echo "Installing Google Chrome..."
		tput cuu1
		tput cuf 28
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_filezilla() {
	tput setaf 3
	echo "Installing Filezilla..."
	sudo apt install filezilla
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Filezilla..."
		tput cuu1
		tput cuf 24
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Filezilla cannot be Installed."
		tput setaf 3
		echo "Installing Filezilla..."
		tput cuu1
		tput cuf 24
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_git() {
	tput setaf 3
	echo "Installing Git..."
	sudo apt install git
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Git..."
		tput cuu1
		tput cuf 18
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Git cannot be Installed."
		tput setaf 3
		echo "Installing Git..."
		tput cuu1
		tput cuf 18
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_atom() {
	tput setaf 3
	echo "Installing Atom..."
	sudo snap install atom --classic
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Atom..."
		tput cuu1
		tput cuf 19
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Atom cannot be Installed."
		tput setaf 3
		echo "Installing Atom..."
		tput cuu1
		tput cuf 19
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_vscode() {
	tput setaf 3
	echo "Installing VSCode..."
	sudo snap install code --classic
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing VSCode..."
		tput cuu1
		tput cuf 21
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "VSCode cannot be Installed."
		tput setaf 3
		echo "Installing VSCode..."
		tput cuu1
		tput cuf 21
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_anydesk() {
	tput setaf 3
	echo "Installing Anydesk..."
	sudo echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list >>/dev/null
	wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
	sudo apt update
	sudo apt install anydesk
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Anydesk..."
		tput cuu1
		tput cuf 22
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Anydesk cannot be installed."
		tput setaf 3
		echo "Installing Anydesk..."
		tput cuu1
		tput cuf 22
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_vlc() {
	tput setaf 3
	echo "Installing VLC Player..."
	sudo apt install vlc
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing VLC Player..."
		tput cuu1
		tput cuf 25
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "VLC Player cannot be Installed."
		tput setaf 3
		echo "Installing VLC Player..."
		tput cuu1
		tput cuf 25
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_gparted() {
	tput setaf 3
	echo "Installing Gparted..."
	sudo apt install gparted
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Gparted..."
		tput cuu1
		tput cuf 22
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Gparted cannot be Installed."
		tput setaf 3
		echo "Installing Gparted..."
		tput cuu1
		tput cuf 22
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_gimp() {
	tput setaf 3
	echo "Installing Gimp..."
	sudo apt install gimp
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Gimp..."
		tput cuu1
		tput cuf 19
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Gimp cannot be Installed."
		tput setaf 3
		echo "Installing Gimp..."
		tput cuu1
		tput cuf 19
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

install_inkscape() {
	tput setaf 3
	echo "Installing Inkscape..."
	sudo apt install inkscape
	if [[ $? -eq 0 ]]; then
		tput setaf 3
		echo "Installing Inkscape..."
		tput cuu1
		tput cuf 23
		tput setaf 2
		echo "[Done!]"
		return		
	else
		tput setaf 1
		echo "Inkscape cannot be Installed."
		tput setaf 3
		echo "Installing Inkscape..."
		tput cuu1
		tput cuf 23
		tput setaf 1
		echo "[Failed.]"
		return
	fi
}

mkdir -p fia_temp
cd fia_temp
sudo whoami >>/dev/null
clear

checknet
check_snap
update

for choice in $choices; do
	case $choice in
	1)
		install_vmware
		;;
	2)
		install_virtualbox
		;;
	3)
		install_chrome
		;;
	4)
		install_filezilla
		;;
	5)
		install_git
		;;
	6)
		install_atom
		;;
	7)
		install_code
		;;
	8)
		install_anydesk
		;;
	9)
		install_vlc
		;;
	10)
		install_gparted
		;;
	11)
		install_gimp
		;;
	12)
		install_inkscape
		;;
	esac
done

cd ..
tput setaf 3
echo "Removing temporary files..."
rm -r fia_temp
tput cuu1
tput cuf 28
tput setaf 2
echo "[Done!]"
tput setaf 3
echo "Installation finished. Script will exit now..."
sleep 3
