#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.dotfiles-swayzy/wallpapers/cats/"

# Pick a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set the new background correctly in Sway
swaymsg output "*" bg "$WALLPAPER" fill

echo "Background changed to: $WALLPAPER"
