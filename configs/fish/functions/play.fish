function play
    set -l index_file ~/nix/configs/guardian/playlists.txt
    set -l entry (grep "^$argv[1]|" $index_file | tail -n 1)

    if test -z "$entry"
        echo "Playlist '$argv[1]' not found."
        return 1
    end

    set -l url (string split '|' $entry)[2]

    tmux kill-session -t music 2>/dev/null
    pkill mpv 2>/dev/null

    # Use a direct exec approach which is safer for URLs
    tmux new-session -d -s music "mpv --no-video --force-window=no --shuffle --input-ipc-server=/tmp/mpvsocket '$url'"

    echo "󰎈 Guardian Music Engine: Shuffling '$argv[1]'..."
end
