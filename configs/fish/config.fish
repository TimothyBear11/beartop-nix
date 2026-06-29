### ENVIRONMENT VARIABLES ###

# Standardize paths without redefining HOME
fish_add_path "$HOME/.local/bin"

# Wayland & Performance variables
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORM wayland
set -gx SDL_VIDEODRIVER wayland
set -gx HSA_OVERRIDE_GFX_VERSION 10.3.0

### INTERACTIVE SETTINGS ###
if status is-interactive
    # Disable default greeting
    set -g fish_greeting ""

    # --- Tool Initializations ---
    # Initialize Zoxide (smarter cd)
    if type -q zoxide
        zoxide init fish | source
    end

    # Initialize Direnv (automatic env loading)
    if type -q direnv
        direnv hook fish | source
    end

    # --- Fastfetch (System Info) ---
    if type -q fastfetch
        fastfetch --config "$HOME/nix/configs/fastfetch/empty_config.jsonc" \
            --logo "$HOME/nix/Pictures/newlogo1.png" \
            --logo-type auto \
            --logo-width 35 \
            --logo-height 20
    end

    # --- Load Custom Functions ---
    set -p fish_function_path $HOME/nix/configs/fish/functions_extra

    # --- Git Abbreviations ---
    abbr -a gs 'git status'
    abbr -a ga 'git add .'
    abbr -a gc 'git commit -m "'
    abbr -a gp 'git push'
    abbr -a gd 'git diff'
    abbr -a gds 'git diff --staged'
    abbr -a gl 'git pull --rebase'
    abbr -a gco 'git checkout'
    abbr -a gb 'git branch -vv'
    abbr -a gcm 'git checkout main'
    abbr -a gundo 'git reset --soft HEAD~1'

    # --- Aliases ---
    alias vim='nvim'
    alias vi='nvim'

    # Modern ls replacement (eza)
    if type -q eza
        alias ls='eza --icons --group-directories-first'
        alias ll='eza -l --icons --group-directories-first'
        alias tree='eza --tree --icons'
    end

    # Quick navigation
    alias d='cd ~'
    alias dl='cd ~/Downloads'
    alias dt='cd ~/Documents'
    alias proj='cd ~/projects'
    alias reboot="sudo reboot"
    alias poweroff="sudo poweroff"

    # --- Marchborn Guardian Tide Palette ---
    # Using 'set -g' (global) instead of 'set -u' (universal)
    # This prevents Fish 4.3 from trying to write to the read-only nix store.
    set -g tide_left_prompt_frame_color 34424A # Muted Slate
    set -g tide_character_color 7FFFD4 # Aquamarine (Success)
    set -g tide_character_color_failure FF4D4D # Bloodstone (Failure)
    set -g tide_os_color 7FFFD4 # Aquamarine
    set -g tide_context_color_root FF4D4D # Bloodstone
    set -g tide_context_color_user D3E0E2 # Icy White
    set -g tide_pwd_color_dirs 7FFFD4 # Aquamarine
    set -g tide_pwd_color_anchors 7FFFD4 # Bold Aquamarine
    set -g tide_git_color_branch FFD700 # Gold
end

# Load envman if it exists
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
