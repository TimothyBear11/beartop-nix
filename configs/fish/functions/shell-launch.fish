#!/usr/bin/env fish
# The Launcher: Pure creation.

set -l selection (cat /home/tbear/.config/hypr/.active_shell)

switch $selection
    case ambxst
        setsid ambxst >/dev/null 2>&1 &
    case caelestia
        setsid caelestia shell >/dev/null 2>&1 &
    case dms
        setsid dms run >/dev/null 2>&1 &
    case noctalia
        noctalia-shell >/dev/null 2>&1 &
    case noctaliav5
        noctalia >/dev/null 2>&1 &
    case wayle
        setsid wayle panel start >/dev/null 2>&1 &
end
