function gitnrs --description 'Stage, commit, push, and rebuild NixOS'
    echo "⚡ Staging files..."
    git add .

    echo "📝 Committing changes..."
    git commit -m "simple update"

    echo "🚀 Pushing to remote repository..."
    git push

    if type -q nrs
        echo "❄️ Triggering NixOS Rebuild (nrs)..."
        nrs
    else
        echo "⚠️ Warning: 'nrs' function not found in environment. Skipping rebuild."
    end
end
