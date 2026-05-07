FLAG=0
STATE=0

PREVIEW_FLAG=0


userload(){
	for file in /sys/devices/platform/msi-ec/*; do
		if [ -f "$file" ]; then
			STATE=$(cat "$file")
			if [ "$STATE" = "on" ] || [ "$STATE" = "off" ]; then
				echo "$(basename "$file") (current state is "$STATE"): "
				read FLAG

				if [ "$FLAG" -ge "0" ] && [ "$FLAG" -le "1" ]; then
					echo "$FLAG" > "$file"
				fi
			fi
		fi
	done
}

preview_files(){
	for file in /sys/devices/platform/msi-ec/*; do
		if [ -f "$file" ]; then
			echo "$(basename "$file"): $(cat "$file")\n"
		fi
	done
}
