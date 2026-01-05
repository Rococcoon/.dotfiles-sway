#!/bin/bash

# --- Configuration ---
# 1. Define all available themes in an array
THEMES=("cats_autumn" "cats_general" "cats_winter" "floral_dark")

# 2. Define the control file path
THEME_FILE="$HOME/.theme/wallpaper_theme.txt"
# ---------------------

# Read the current theme (or default to the first in the array if file is missing/empty)
CURRENT_THEME=$(< "$THEME_FILE")
if [ -z "$CURRENT_THEME" ]; then
    CURRENT_THEME="${THEMES[0]}"
fi

# Find the index of the current theme
CURRENT_INDEX=-1
for i in "${!THEMES[@]}"; do
   if [[ "${THEMES[$i]}" = "$CURRENT_THEME" ]]; then
       CURRENT_INDEX=$i
       break
   fi
done

# Calculate the next index (circular)
# The % operator handles the wrap-around back to 0
NUM_THEMES=${#THEMES[@]}
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_THEMES ))
NEXT_THEME="${THEMES[$NEXT_INDEX]}"

# Write the new theme to the control file
echo "$NEXT_THEME" > "$THEME_FILE"

# Apply the change by running your wallpaper changing script
~/.dotfiles-sway/scripts/general/bgswap.sh

echo "Theme successfully cycled from $CURRENT_THEME to $NEXT_THEME"
