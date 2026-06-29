function music-peek
    # Guardian OS Colors
    set -l aqua (set_color 7FFFD4)
    set -l blood (set_color 880000)
    set -l res (set_color normal)

    # Check if the music engine is actually running
    if test -S /tmp/mpvsocket
        # Extract Title and Artist using jq
        set -l title (echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | jq -r .data)
        set -l artist (echo '{ "command": ["get_property", "metadata/by-key/artist"] }' | socat - /tmp/mpvsocket | jq -r .data)

        # Handle empty metadata (sometimes streams take a second to populate)
        if test "$title" = "null"; or test -z "$title"
            echo -e "  $aqua󰎈 Status: $res$blood Buffering or no metadata..."
        else
            echo -e "  $aqua󰎈 Now Playing: $res$title"
            echo -e "  $blood󰠃 Artist: $res$artist"
        end
    else
        echo "  $blood󰝛 Music engine (mpv) is offline."
    end
end
