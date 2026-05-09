#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "You must run the script as root"
	exit 1
fi

SCRIPT_DIR=$(dirname "$0")
MODULE_FLAG=0
INSTALL_CHECK=0

# Loading the msi-ec module
modprobe msi_ec

# Checks whether or not it has failed to load the module
if [ "$?" -ne 0 ]; then
	echo "Failed to load msi-ec module, it may not be installed on your system"
	exit 1
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
