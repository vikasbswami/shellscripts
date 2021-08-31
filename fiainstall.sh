#!/bin/bash
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

mkdir -p fia_temp
cd fia_temp
sudo whoami >>/dev/null
clear

checknet() {
	tput setaf 3
	echo "Checking Internet connectivity..."
	wget -q --tries=10 --timeout=20 -O - http://google.com >>/dev/null
	if [[ $? -eq 0 ]]; then
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
	echo "Installing VMWare Player..."
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
	wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0" https://www.vmware.com/go/getplayer-linux
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
	sudo apt install virtualbox-6.1
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
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
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

checknet
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
