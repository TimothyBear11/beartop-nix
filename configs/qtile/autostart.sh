#!/usr/bin/env bash

# 1. Start the D-Bus session and export it to the environment
dbus-update-activation-environment --systemd --all &

# 4. Force monitor layout IMMEDIATELY
kanshi &
sleep 2 # Give Kanshi 2 full seconds to snap the OMEN to Primary

# 5. Now start the applets that live in the tray
nm-applet &
kdeconnect-indicator &

# 6. Start the Gnome Keyring Daemon
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &

# 7. Start clipboard manager
wl-paste --watch cliphist store &
