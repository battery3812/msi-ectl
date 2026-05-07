CHECK_AGREEMENT=0

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

install_module(){
	perform_checks

	if [ "$?" -eq 1 ]; then
		echo "Please read the messages provided to you"
		exit
	fi

	cd /tmp
	git clone https://github.com/BeardOverflow/msi-ec
	cd msi-ec

	make dkms-install
	if [ "$?" -ne 0 ]; then
		echo "dkms unavailable, resorting to \"make\""
		make install
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
