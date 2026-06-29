function music-next
    # Send the skip command to the mpv socket
    echo '{ "command": ["playlist-next"] }' | socat - /tmp/mpvsocket > /dev/null

    # Short sleep to let the metadata update before peeking
    sleep 0.5
    music-peek
end
