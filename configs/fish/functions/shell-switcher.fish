#!/usr/bin/env fish

# 1. Fuzzel Selection
set -l selection (printf "ambxst\ncaelestia\ndms\nnoctalia\nnoctaliav5\nwayle" | fuzzel --dmenu -p "Select Shell: " | string trim)
if test -z "$selection"
    exit 0
end

# 2. Update state
echo "$selection" >/home/tbear/.config/hypr/.active_shell

# 3. Call the Killer (Wait for it to finish)
/run/current-system/sw/bin/fish /home/tbear/configs/fish/functions/shell-kill.fish

# 4. Call the Launcher
/run/current-system/sw/bin/fish /home/tbear/configs/fish/functions/shell-launch.fish
