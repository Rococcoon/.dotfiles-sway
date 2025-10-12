#!/bin/bash

# --- 1. Define Core Paths ---
# Control file for the current theme
THEME_FILE="$HOME/.theme/wallpaper_theme.txt"

# Read the current theme (e.g., 'autumn', 'winter')
CURRENT_THEME=$(cat "$THEME_FILE" 2>/dev/null)

# Fallback in case the file is missing or empty
if [ -z "$CURRENT_THEME" ]; then
    echo "Warning: No theme found in $THEME_FILE. Using 'autumn' as default."
    CURRENT_THEME="autumn"
fi

# Directory containing wallpapers - NOW CONSTRUCTED using the theme
WALLPAPER_DIR="$HOME/.dotfiles-sway/wallpapers/cats/$CURRENT_THEME/"

# File to store the index of the last used wallpaper (theme-specific state file)
# This ensures each theme remembers its own position.
STATE_FILE="$HOME/.cache/sway_wallpaper_index_$CURRENT_THEME"

# --- 2. Get the list of wallpapers (Robustly) ---
WALLPAPERS=()
# Using find | sort is good, but globbing is often faster for local directories
# and avoids an external process unless subdirectories are needed.
# Let's keep your robust find method, but simplify the list creation:
while IFS= read -r file; do
    [ -f "$file" ] && WALLPAPERS+=("$file")
done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f | sort)

NUM_WALLPAPERS=${#WALLPAPERS[@]}

if [ "$NUM_WALLPAPERS" -eq 0 ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR. Check path and contents."
    exit 1
fi

# --- 3. Determine the index of the next wallpaper ---

# Read the index of the *LAST DISPLAYED* wallpaper. 
# Using a local variable for robustness
LAST_INDEX=$(cat "$STATE_FILE" 2>/dev/null)

# If the file is empty, invalid, or the stored index is out of bounds,
# initialize LAST_INDEX to the index *just before* the start.
if ! [[ "$LAST_INDEX" =~ ^[0-9]+$ ]] || [ "$LAST_INDEX" -ge "$NUM_WALLPAPERS" ]; then
    # Set the starting index to the index of the last element (N-1).
    # When incremented, it will correctly wrap to 0.
    LAST_INDEX=$((NUM_WALLPAPERS - 1))
fi

# Calculate the index of the NEXT wallpaper: (last index + 1) % N
CURRENT_INDEX=$(((LAST_INDEX + 1) % NUM_WALLPAPERS))

# --- 4. Set the new background ---
CURRENT_WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"

# Set the new background correctly in Sway
swaymsg output "*" bg "$CURRENT_WALLPAPER" fill

# --- 5. Save the current index for the next run ---
echo "$CURRENT_INDEX" > "$STATE_FILE"

echo "Theme: $CURRENT_THEME | Background changed to: $CURRENT_WALLPAPER (Index: $CURRENT_INDEX)"
