{ config, pkgs, inputs, ... }:

{
  imports = [
    # Modular Desktop Environments & Compositors
    ./desktops/ambxst.nix
    ./desktops/caelestia.nix
    ./desktops/dms.nix
    ./desktops/noctalia.nix
    ./desktops/hyprland.nix
    ./desktops/niri.nix
    ./desktops/mango.nix
    ./desktops/qtile.nix
    ./desktops/gnome.nix
    ./desktops/cosmic.nix
  ];

  # Core Display Server Settings
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  # Full Desktop Environment Fallback (Using Plasma 6 via SDDM)
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = false;

  services.desktopManager.gnome.enable = true;
  programs.seahorse.enable = false;
    
  programs.dconf.enable = true;

  # XDG Portals Configuration (Strict routing to prevent desktop environment loops)
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = { default = [ "gtk" ]; };
      hyprland = { default = [ "hyprland" "gtk" ]; };
      niri = { default = [ "gnome" "gtk" ]; };
    };
  };

  # Graphical Environment Packages & Desktop Utilities
  environment.systemPackages = with pkgs; [
    xwayland-satellite  # Seamless XWayland integration
    libsForQt5.qt5ct    # Qt5 Theme Configuration
    kdePackages.qt6ct   # Qt6 Theme Configuration (Crucial for Plasma 6 apps under Hyprland)
    wl-clipboard        # Wayland Clipboard engine
    kanshi               # Dynamic display profile manager
    wlr-randr           # Monitor manipulation tool
    grim                # Screenshot tool
    slurp               # Screen region selector
    pavucontrol         # PulseAudio/PipeWire Volume Control GUI
    gnome-keyring       # Secure password/credential storage backend
    networkmanagerapplet # Network tray icon (nm-applet)
    cliphist            # Clipboard history backend
    wayle
    awww
    
    ];

  # Session Variables for Unified Theme Handshakes
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland;xcb";
  };
}
