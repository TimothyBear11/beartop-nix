function music-play
    set -l aqua (set_color 7FFFD4)
    set -l res (set_color normal)

    if test -S /tmp/mpvsocket
        # Seek to start of track and force unpause
        echo '{ "command": ["seek", 0, "absolute"] }' | socat - /tmp/mpvsocket > /dev/null
        echo '{ "command": ["set_property", "pause", false] }' | socat - /tmp/mpvsocket > /dev/null
        echo -e "  $aqua󰐊 $res Restarting Track..."
        music-peek
    end
end
