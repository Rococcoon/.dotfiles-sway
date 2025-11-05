#!/bin/bash
BAT=$(cat /sys/class/power_supply/BAT0/capacity)
TIME=$(date +" %Y-%m-%d | %H:%M:%S ")
echo " $BAT% | $TIME "
