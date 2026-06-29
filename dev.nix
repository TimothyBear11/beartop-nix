{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # -- Languages --
    python3
    go
    nixd

    # -- IDEs --

    vscodium
    jetbrains.pycharm-oss
    zed-editor
    positron-bin
    helix
    antigravity

    # -- Productivity --
    direnv
    lazygit
    bat
    eza
    jq
    devtoolbox
    file
    fzf
    ripgrep

  ];
}
