FLAG=0
STATE=0
PREVIEW_FLAG=0
# This function presents the user with each file (representing an attribute) from the msi-ec module's directory that can be toggled with
# on/off and then asks them whether they want to turn it on (1) or turn it off (0)
userload(){
	# Iterates over the msi-ec directory
	for file in /sys/devices/platform/msi-ec/*; do
		# Checks if we are iterating over a file
		if [ -f "$file" ]; then
			STATE=$(cat "$file")
			# Checks whether or not it's toggleable
			if [ "$STATE" = "on" ] || [ "$STATE" = "off" ]; then
				echo "$(basename "$file") (current state is "$STATE"): "
				read FLAG
				# Input sanitization
				if [ "$FLAG" -ge "0" ] && [ "$FLAG" -le "1" ]; then
					echo "$FLAG" > "$file"
				fi
			fi
		fi
	done
}
preview_files(){
	# Iterates over the msi-ec directory
	for file in /sys/devices/platform/msi-ec/*; do
		# Checks if we are iterating over a file
		if [ -f "$file" ]; then
			# Printing out the filename and the current state
			echo "$(basename "$file"): $(cat "$file")\n"
		fi
	done
} # added these comments
