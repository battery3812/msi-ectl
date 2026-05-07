#!/bin/sh



SCRIPT_DIR=$(dirname "$0")
MODULE_FLAG=0
INSTALL_CHECK=0

install_prompt(){
	echo "msi-ec may not be installed, install? (Y\n)"
	read INSTALL_CHECK

	if [ "$INSTALL_CHECK" = "n" ] || [ "$INSTALL_CHECK" = "N" ]; then
		return 1
	fi

	install_module
	if [ "$?" -ne 0 ]; then
		return 1
	fi

	return 0
}

. "$SCRIPT_DIR/install.sh"
modprobe msi_ec

if [ "$?" -ne 0 ]; then
	install_prompt
	if [ "$?" -ne 0 ]; then
		echo "Installation did not happen, use of this script is to be avoided until the module is installed"
		exit
	fi
	echo "Successfully installed msi-ec"
fi

. "$SCRIPT_DIR/control.sh"



echo "welcome to the linux msi center"

echo "msi module: "
read MODULE_FLAG

if [ "$MODULE_FLAG" -eq "0" ]; then
	modprobe -r msi_ec
elif [ "$MODULE_FLAG" -eq "1" ]; then
	userload
fi

echo "Show all file statuses?"
read PREVIEW_FLAG

if [ "$PREVIEW_FLAG" -eq "1" ]; then
	preview_files
fi





echo "that's it for now, thanks for visting!!!"
