function music-prev
    # Send the skip-back command to the mpv socket
    echo '{ "command": ["playlist-prev"] }' | socat - /tmp/mpvsocket > /dev/null

    # Short sleep to let the metadata update before peeking
    sleep 0.5
    music-peek
end
