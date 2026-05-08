#!/bin/sh



SCRIPT_DIR=$(dirname "$0")
MSI_DIR="/sys/devices/platform/msi-ec"
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

# Bringing in the install.sh functions
. "$SCRIPT_DIR/install.sh"

# Loading the msi-ec module
modprobe msi_ec

# Checks whether or not it has failed to load the module
if [ "$?" -ne 0 ]; then
	# If the MSI-EC directory exists, then assume the user is testing and continue
	if [ -d "$MSI_DIR" ]; then
		echo "Testing/Debug mode"
	else
		install_prompt
		if [ "$?" -ne 0 ]; then
			echo "Installation did not happen, use of this script is to be avoided until installed."
			exit 1
		fi
		echo "Sucessfully installed MSI-EC"
	fi
fi

# Bringing in the control.sh functions
. "$SCRIPT_DIR/control.sh"



echo "Welcome to msi_ectl"

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
