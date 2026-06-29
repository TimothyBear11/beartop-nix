{ config, pkgs, ... }:

{

  imports = [
   ./terminal/fish.nix
   ./terminal/nvim.nix
   ./terminal/kitty.nix
   ./terminal/helix.nix 
   ./terminal/emacs.nix
   ./terminal/fastfetch.nix
  ];


  environment.systemPackages = with pkgs; [
    foot
    kdePackages.konsole
    btop
    starship
    fastfetch
    gh
    eza
    mpv
    mpvScripts.mpris
    ];
}


