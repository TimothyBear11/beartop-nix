#!/usr/bin/env fish

# 1. Selection
set -l selection (printf "ambxst\ncaelestia\ndms\nnoctalia\nnoctaliav5\nwayle" | fuzzel --dmenu -p "Select Shell: " | string trim)
if test -z "$selection"
    exit 0
end

# 2. Robust Kill Logic 
# Instead of guessing binary names, we kill anything that 'looks' like a shell
pkill -9 -f quickshell
pkill -9 -f wayle
pkill -9 -f noctalia

# 3. Launch Logic
switch $selection
    case ambxst
        setsid ambxst >/dev/null 2>&1 &
    case caelestia
        setsid caelestia-shell -d >/dev/null 2>&1 &
    case dms
        setsid dms run >/dev/null 2>&1 &
    case noctalia
        setsid noctalia-shell >/dev/null 2>&1 &
    case noctaliav5
        setsid noctalia >/dev/null 2>&1 &
    case wayle
        setsid wayle shell >/dev/null 2>&1 &
        sleep 0.5
        setsid wayle panel start >/dev/null 2>&1 &
end

exit 0
