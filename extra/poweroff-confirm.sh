#!/bin/bash

# Display a confirmation dialog
zenity --question --title="Power Off Confirmation" --text="Are you sure you want to power off?" --width=300

# Check the exit status of the zenity command
if [ $? -eq 0 ]; then
	# If the user clicked "Yes", power off the system
	systemctl poweroff
fi
