#!/bin/bash

FILE=$1
PDF="${FILE%.*}.pdf"

if [ -z "$FILE" ]; then
    echo "Usage: typst-live <file.typ>"
    exit 1
fi

# 1. Start the compiler in the background
typst watch "$FILE" &
COMPILER_PID=$!

# 2. Open Zathura (Zathura watches the PDF automatically)
zathura "$PDF" &
ZATHURA_PID=$!

# 3. Optional: Hyprland tiling logic
# This waits a moment for windows to open then tiles them
sleep 0.5
hyprctl dispatch layoutmsg swapwithmaster

# Cleanup background processes on exit
trap "kill $COMPILER_PID $ZATHURA_PID" EXIT
wait
