CHECK_AGREEMENT=0

# This function presents the user with information regarding the install and then confirms whether or not they want to continue
perform_checks(){
	echo "packages required for install:"
	echo "git"
	echo "make"
	echo "dkms (optional, but recommended)"
	echo "kernel headers for "$(uname -r)""
	echo "do you understand? (y/n)"
	read CHECK_AGREEMENT

	if [ "$CHECK_AGREEMENT" = "y" ] || [ "$CHECK_AGREEMENT" = "Y" ]; then
		return 0
	fi

	return 1
}

# Installs msi-ec
install_module(){
	perform_checks

	if [ "$?" -eq 1 ]; then
		echo "Please read the messages provided to you"
		exit
	fi

	# Changes to the /tmp directory to automatically clean up when rebooting
	cd /tmp

	# Clones BeardOverflow's msi-ec repository from github
	git clone https://github.com/BeardOverflow/msi-ec
	cd msi-ec

	make dkms-install

	# Checks whether or not dkms failed
	if [ "$?" -ne 0 ]; then
		echo "dkms unavailable, resorting to \"make\""
		make install
		# Checkes whether or not make failed
		if [ "$?" -ne 0 ]; then
			echo "Failed to install module with \"make\""
			return 1
		fi
	fi

	echo "Installed MSI-EC module, a reboot is required to finalize"
	echo "Reboot? (y\n)"
	read CHECK_AGREEMENT

	if [ "$CHECK_AGREEMENT" = "y" ] || [ "$CHECK_AGREEMENT" = "Y" ]; then
		echo "Rebooting.."
		reboot
	fi

	echo "Not rebooting"
	return 0
}
