#!/usr/bin/env fish

set -l selection (printf "ambxst\ncaelestia\ndms\nnoctalia\nnoctaliav5\nwayle" | fuzzel --dmenu -p "Select Shell: " | string trim)
if test -z "$selection"
    exit 0
end

# 1. Kill old ones
pkill -9 quickshell
pkill -9 -x wayle
pkill -9 -x noctalia

# 2. Update state file
echo "$selection" >/home/tbear/.config/hypr/.active_shell

# 3. DIRECT LAUNCH (Bypass reload for the shell itself)
switch "$selection"
    case ambxst
        hyprctl dispatch exec ambxst
    case caelestia
        hyprctl dispatch exec "caelestia-shell -d"
    case dms
        hyprctl dispatch exec "dms run"
    case wayle
        hyprctl dispatch exec "wayle panel start"
    case noctalia
        hyprctl dispatch exec noctalia-shell
    case noctaliav5
        hyprctl dispatch exec noctalia
end
