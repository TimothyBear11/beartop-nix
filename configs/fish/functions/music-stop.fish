function music-stop
    set -l blood (set_color 880000)
    set -l res (set_color normal)

    if test -S /tmp/mpvsocket
        # Tell mpv to quit cleanly
        echo '{ "command": ["quit"] }' | socat - /tmp/mpvsocket > /dev/null
        rm -f /tmp/mpvsocket
        echo -e "  $blood󰓛 $res Music Engine Stopped."
    else
        # Emergency kill if the socket is dead but the process is hanging
        pkill mpv
        echo -e "  $blood󰓛 $res MPV Process Terminated."
    end
end
