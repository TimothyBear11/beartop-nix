#!/bin/bash
# Mango autostart script

set +e

# Import environment for systemd
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

# Start xdg-desktop-portal backends
# (Main portal can't auto-start via systemd because graphical-session.target is inactive)
/usr/libexec/xdg-desktop-portal-gtk >/dev/null 2>&1 &
/usr/libexec/xdg-desktop-portal-wlr >/dev/null 2>&1 &
sleep 1
/usr/libexec/xdg-desktop-portal >/dev/null 2>&1 &

# Set GTK dark mode preference (for modern GTK4/libadwaita apps)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Start Gnome Keyring Daemon
gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &

# Start Tray Applets and Clipboard
nm-applet &
kdeconnect-indicator &
wl-paste --watch cliphist store &

# Noctalia shell (your preferred launcher/panel)
noctalia-shell &

# Audio idle inhibitor - prevents screen sleep when audio is playing
# Perfect for streaming to prevent screen lock/sleep
~/.config/mango/bin/audio-idle-inhibit.sh &
