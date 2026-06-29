#!/usr/bin/env fish
# The Cleaner: Nothing else, just destruction.

pkill -9 -f quickshell
pkill -9 -f noctalia
pkill -9 -f wayle

# Small pause to let the Wayland socket finalize the death of those processes
sleep 0.5
exit 0
