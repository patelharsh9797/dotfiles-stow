#!/bin/bash

# Path to your wezterm configuration file
# config_file="/mnt/c/Program Files/WezTerm/wezterm.lua"
config_file="/home/harsh/.wezterm.lua"

# Check if the file exists
if [ ! -f "$config_file" ]; then
  echo "WezTerm config file not found at $config_file"
  exit 1
fi

# Display menu with options
echo "Select window decoration style:"
echo "1) NONE - Borderless, no title bar (no resizing/minimizing)"
echo "2) TITLE - Title bar, no resizable border"
echo "3) RESIZE - Resizable border, no title bar"
echo "4) TITLE | RESIZE - Title bar and resizable border (default)"

# Read user choice
read -p "Enter the number of your choice (1-4): " choice

# Set the window_decorations value based on the user choice
case $choice in
1)
  new_value='NONE'
  ;;
2)
  new_value='TITLE'
  ;;
3)
  new_value='RESIZE'
  ;;
4)
  new_value='TITLE | RESIZE'
  ;;
*)
  echo "Invalid choice! Please select a number between 1 and 4."
  exit 1
  ;;
esac

# Update the configuration file
sed -i "s/config.window_decorations = \".*\"/config.window_decorations = \"$new_value\"/" "$config_file"

# Confirm the change
echo "Window decorations set to: $new_value"

# Optionally, restart WezTerm automatically (or ask the user to do it)
echo "Please restart WezTerm for the changes to take effect."
