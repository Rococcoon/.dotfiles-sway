#!/bin/bash

# Get the filename from the first argument, default to 'recording.mp4' if empty
FILENAME="${1:-recording.mp4}"

# Add .mp4 extension if the user didn't provide one
if [[ ! "$FILENAME" == *.mp4 ]]; then
    FILENAME="$FILENAME.mp4"
fi

DEVICE="alsa_input.usb-Plantronics_Poly_BT600_395d8a0f07f64121a53d666c53c0b4a2-00.pro-input-0"

echo "Starting recording: $FILENAME"
echo "Using Audio: BT600"
echo "Press Ctrl+C to stop..."

wf-recorder --audio="$DEVICE" -f "$FILENAME"
