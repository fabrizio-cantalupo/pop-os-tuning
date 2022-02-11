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

	echo "System updated! The reverse script will run now."
	clear
	sleep 2s
}

debloat () {
	echo "Installing uninstalled software"
	sleep 1s

    sudo apt-get install geary gedit gnome-calendar gnome-contacts gnome-weather pop-shop flatpak \
	libreoffice-writer libreoffice-draw libreoffice-calc libreoffice-base -y
}

gaming () {
	echo "Removing gaming software"
	sleep 1s

	# Uninstall gaming software
	sudo apt-get autoremove --purge python3-pip lutris heroic discord steam openjdk-17-jre winehq-stable -y
	cd ~/ && rm -rf protonup
	cd ~/ && rm winehq.key

	# Uninstall FeralInteractive Gamemode
	sudo apt-get autoremove --purge meson libsystemd-dev pkg-config ninja-build git libdbus-1-dev libinih-dev build-essential -y # Dependencies
	cd ~/ && rm -rf gamemode

	# Uninstall Xanmod kernel
	sudo apt-get remove linux-xanmod -y

	# Remove Wine's repo
	if [ $dist = 'Focal' ]; then
		sudo add-apt-repository --remove 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
	fi

	if [ $dist = 'Impish' ]; then
		sudo add-apt-repository --remove 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main'
	fi
}

software () {
	echo "Uninstalling recommended software"
	sudo apt-get remove micro pluma kitty ssh -y
}

end () {
	echo "Reverse script ended! Read the docs for more informations."
	sleep 1s
	xdg-open https://github.com/fabrizio-cantalupo/pop-os-tuning
}

detect_os
upgrade
debloat
gaming
software
end

exit 0
