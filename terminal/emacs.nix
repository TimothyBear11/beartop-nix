{ config, pkgs, ... }:

{
  # 1. Install Emacs with Native Compilation and Wayland support
  environment.systemPackages = [
    # emacs-pgtk provides pure GTK/Wayland support (no XWayland blurriness!)
    pkgs.emacs-pgtk 
  ];

  # 2. Inject environment variables for proper Wayland/XDG handshakes
  environment.variables = {
    # Force Emacs to look in the modern XDG path instead of old ~/.emacs.d
    EMACSDIR = "$HOME/.config/emacs";
  };

  environment.sessionVariables.PATH = [
    "$HOME/.config/emacs/bin"
  ];

  # 3. Map your complete configuration assets using Hjem
  hjem.users.tbear = {
    #xdg.config.files = {
    #  # Your custom Doom deployment settings (where your packages/configs are declared)
    #  "doom/config.el" = { source = ../configs/doom/config.el; clobber = true; };
    #  "doom/init.el"   = { source = ../configs/doom/init.el;   clobber = true; };
    #  "doom/packages.el" = { source = ../configs/doom/packages.el; clobber = true; };
  };
}
