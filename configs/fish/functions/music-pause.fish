function music-pause
    set -l aqua (set_color 7FFFD4)
    set -l blood (set_color 880000)
    set -l res (set_color normal)

    if test -S /tmp/mpvsocket
        # Cycle the pause property
        echo '{ "command": ["cycle", "pause"] }' | socat - /tmp/mpvsocket > /dev/null
        echo -e "  $aqua󰏤 $res$blood Pause Toggled"
    else
        echo "  $blood󰝛 Music engine is offline."
    end
end
