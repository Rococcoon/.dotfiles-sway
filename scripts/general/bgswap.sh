#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.dotfiles-sway/wallpapers/cats/autumn/"

# File to store the index of the last used wallpaper (the state file)
STATE_FILE="$HOME/.cache/sway_wallpaper_index"

# --- 1. Get the list of wallpapers (Robustly) ---
WALLPAPERS=()
while IFS= read -r file; do
    # Only include regular files
    [ -f "$file" ] && WALLPAPERS+=("$file")
done < <(find "$WALLPAPER_DIR" -type f | sort)

NUM_WALLPAPERS=${#WALLPAPERS[@]}

if [ "$NUM_WALLPAPERS" -eq 0 ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR. Check path and contents."
    exit 1
fi

# --- 2. Determine the index of the next wallpaper ---

# Read the index of the *LAST DISPLAYED* wallpaper. 
LAST_INDEX=$(cat "$STATE_FILE" 2>/dev/null)

# If the file is empty or invalid, initialize LAST_INDEX to the index 
# *just before* the start (i.e., the last image's index).
if ! [[ "$LAST_INDEX" =~ ^[0-9]+$ ]] || [ "$LAST_INDEX" -ge "$NUM_WALLPAPERS" ]; then
    # Set the starting index to the index of the last element in the list.
    # When incremented, it will correctly wrap to 0 (the first image).
    LAST_INDEX=$((NUM_WALLPAPERS - 1))
fi

# Calculate the index of the NEXT wallpaper: (last index + 1) % N
# This ensures a clean 0 to N-1 cycle, then back to 0.
CURRENT_INDEX=$(((LAST_INDEX + 1) % NUM_WALLPAPERS))

# --- 3. Set the new background ---
CURRENT_WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"

# Set the new background correctly in Sway
swaymsg output "*" bg "$CURRENT_WALLPAPER" fill

# --- 4. Save the current index for the next run ---
echo "$CURRENT_INDEX" > "$STATE_FILE"

echo "Background changed to: $CURRENT_WALLPAPER (Index: $CURRENT_INDEX)"
