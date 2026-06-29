{ config, pkgs, ... }:

{
  # 1. Core NixOS Native Neovim Configuration
  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
  };

  # 2. Companion Tooling & Dependencies (Moved from extraPackages to global system profile)
  environment.systemPackages = with pkgs; [
    # --- Essentials ---
    ripgrep
    fd
    fzf
    wl-clipboard
    unzip
    
    # --- LSPs & Formatters ---
    lua-language-server
    nil
    nixpkgs-fmt
    nodejs_22
    
    # --- Build Tools for Mason/Treesitter ---
    gcc
    gnumake
    cargo 
  ];

  # 3. Nix Linker-Loader (Unpatched FHS Mason Binary Core Bridge)
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      glibc
      gcc.cc.lib
      libgcc.lib
      zlib
      zstd
      fuse3
      expat
      openssl
      curl
      nss
      icu
      util-linux
      libsysprof-capture
    ];
  };

  # 4. Hjem Live-Symlink Mirroring
  hjem.users.tbear = {
    # Recursively symlinks your entire local nvim config directory live from your repository folder
    files.".config/nvim".source = ../configs/nvim; 
  };
}