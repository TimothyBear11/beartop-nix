function music-import
    if test (count $argv) -ne 2
        echo "Usage: music-import <name> <url>"
        return 1
    end
    # Ensure the directory exists in your nix/configs path
    mkdir -p ~/nix/configs/guardian
    echo "$argv[1]|$argv[2]" >>~/nix/configs/guardian/playlists.txt
    echo "󰎈 Music Engine: Imported '$argv[1]' into ~/nix/configs/guardian/playlists.txt"
end
