#!/bin/bash
#
# Script to connect to a specific Wi-Fi network using iwctl (iwd client).
# It dynamically detects the active wireless interface (wlanX or wlx...)
# by filtering out the likely internal adapter (wlan0) and prioritizing
# the external USB adapter (wlan1, wlx...).

# --- Configuration ---
TARGET_SSID="Pixel_7954"

# --- 1. Dynamic Interface Detection ---
echo "Searching for available wireless interfaces..."

# Use a single, robust command to find the USB adapter interface (wlan1, wlx...).
# 1. List all interfaces starting with 'wl' (wlan, wlp, wlx).
# 2. Exclude 'wlan0' to ensure we select the USB adapter.
# 3. Take the first result, which should be wlan1 or wlx...
TARGET_IFACE=$(ip link show | awk '/wlan|wlp|wlx/ {print $2}' | tr -d ':' | grep -v 'wlan0' | head -n 1)


# Final check for interface
if [ -z "$TARGET_IFACE" ]; then
    echo "ERROR: Could not find any suitable wireless interface (wlan1 or wlx...)."
    echo "Please ensure your USB adapter is plugged in and the 'iwd' service is running."
    exit 1
fi

echo "✅ Found wireless interface: $TARGET_IFACE"
echo "--------------------------------------------------------"

# --- 2. Execute Required iwd (iwctl) Commands ---

# Disconnect existing connections on standard and target interfaces
# 2>/dev/null suppresses "Not connected" errors, keeping the output clean.
# We keep wlan0 disconnect just in case it's connected, but only disconnect $TARGET_IFACE
# explicitly for the USB adapter, as the wlan1 explicit disconnect was removed.
echo "1. Disconnecting existing connections (wlan0 and $TARGET_IFACE)..."
iwctl station wlan0 disconnect 2>/dev/null
iwctl station "$TARGET_IFACE" disconnect 2>/dev/null

# Scan
echo "2. Starting scan for networks on $TARGET_IFACE. This may take a few seconds..."
iwctl station "$TARGET_IFACE" scan
# Wait 5 seconds for the scan results to populate before attempting connection
sleep 5

# Connect
echo "3. Attempting to connect to $TARGET_SSID on $TARGET_IFACE..."
# If the password is not already stored in iwd, this command will prompt you for it.
iwctl station "$TARGET_IFACE" connect "$TARGET_SSID"

# Wait for connection to establish before showing status
echo "Waiting 3 seconds for connection to establish..."
sleep 3

# Show Status
echo "4. Showing final connection status for $TARGET_IFACE:"
iwctl station "$TARGET_IFACE" show

echo "--------------------------------------------------------"
echo "Script finished."
