function goodnight
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        echo "❌ Not inside a git repository."
        return 1
    end

    cd $repo_root

    echo "🔄 Updating flake inputs…"
    fupdate-safe || return 1

    echo "📦 Staging changes…"
    git add .

    echo "🔧 Rebuilding system…"
    if not sudo nixos-rebuild boot --flake .#nix-den
        echo "❌ Rebuild failed — aborting shutdown."
        return 1
    end

    echo "✅ Rebuild successful."

    if not git diff --quiet --exit-code || not git diff --staged --quiet
        set -l msg "end of night updates"
        if set -q argv[1]
            set msg "$argv"
        end

        echo "📤 Committing and pushing…"
        git commit -m "$msg"
        git push
    else
        echo "ℹ️ No changes to commit."
    end

    echo "Cleaning up Nix"
    nix-clean

    echo "🌙 Shutting down in 10 seconds (Ctrl+C to cancel)…"
    sleep 10
    sudo systemctl poweroff
end
