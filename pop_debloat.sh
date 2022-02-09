#!/usr/bin/bash
detect_os ()
{
	if [[ ( -z "${os}" ) && ( -z "${dist}" ) ]]; then
    	if [ -e /etc/lsb-release ]; then
      	. /etc/lsb-release

        os=${DISTRIB_ID}
        dist=${DISTRIB_CODENAME}
  		fi
  	fi

    # remove spaces from variables
	os="${os// /}"
 	dist="${dist// /}"

  	echo "Your distribution is $os/$dist."

  	if [ "$os" != "Pop" ] && [ "$dist" != "Impish"] && [ "$dist" != "Focal" ]; then
			unknownos
  	fi
}

unkownos () {
	echo "Ops! Wrong OS! This script was intented to used with Pop_OS! 20.04 LTS or 21.10."
	exit 1
}

upgrade () {
	echo "Updating system"
	sleep 1s

	sudo apt-get update
	sudo apt-get upgrade -y
	
	echo "System updated! The script will run now."
	sleep 2s
	clear
}

# Adding 32bit arch
sudo dpkg --add-architecture i386

# Detecting video card
echo "Write here your graphic card manufactor ('amd', 'nvidia' or 'intel')"
read graphic
clear

debloat () {
	echo "Uninstalling bloats"
	sleep 1s

    sudo apt-get autoremove --purge geary gedit gnome-calendar gnome-contacts gnome-weather libreoffice-* -y
# 	sudo apt-get remove pop-shop -y
# 	sudo flatpak remove --all -y 
# 	sudo apt-get remove flatpak -y
}

if [ $graphic = "amd" ]; then
	driver () {
			echo "Installing AMD drivers"
			sudo add-apt-repository ppa:kisak/kisak-mesa -y
			sudo apt-get update
			sudo apt-get install libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 -y
			clear
	}
fi

gaming () {
	echo "Tuning Pop_OS for gaming"
	sleep 1s

	sudo apt-get install steam discord openjdk-17-jre -y

	echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
	sudo apt-get update && sudo apt-get install linux-xanmod -y

	#if [ $graphic = 'amd' ]; then
		#sudo printf "RADV_PERFTEST=aco" >> /etc/environment
	#fi

	# Installing Wine
	wget -nc https://dl.winehq.org/wine-builds/winehq.key
	sudo apt-key add winehq.key # apt-key is deprecated but still working, have to update this

	if [ $dist = 'Focal' ]; then
		sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
	fi

	if [ $dist = 'Impish' ]; then
		sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main'
	fi

	sudo apt-get update
	sudo apt-get install --install-recommends winehq-stable

	# Installing Lutris
	sudo apt-get install lutris -y

	# Install FeralInteractive Gamemode
	sudo apt-get install meson libsystemd-dev pkg-config ninja-build git libdbus-1-dev libinih-dev build-essential -y # Dependencies

	cd ~/ && git clone https://github.com/FeralInteractive/gamemode.git && cd gamemode # cloning repo
	git checkout 1.6.1 # omit to build the master branch
	./bootstrap.sh # building

	# Installing protonup
	sudo apt-get install python3-pip -y
	cd ~/ && git clone https://github.com/AUNaseef/protonup && cd protonup
	python3 setup.py install --user
	protonup -d "~/.steam/root/compatibilitytools.d/"
	protonup

	# Installing Heroic
	bash <(wget -O- https://raw.githubusercontent.com/Heroic-Games-Launcher/HeroicGamesLauncher/main/madrepo.sh)
	sudo apt-get install heroic -y
}

software () {
	echo "Installing reccomended software"
	sudo apt-get install micro pluma gnome-tweaks kitty ssh -y

# 	QEMU:
# 	sudo apt-get install qemu-kvm qemu virt-manager virt-viewer -y

# 	Oh my ZSH script:
# 	sudo apt-get install zsh -y
#	cd ~/ && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
#	sh install.sh
# 	chsh -s $(which zsh)
}

end () {
	echo "Script ended! Read the docs for more informations."
	sleep 1s
	xdg-open https://github.com/fabrizio-cantalupo/pop-os-tuning
}

detect_os
upgrade
debloat
driver
gaming
software
end

exit 0
