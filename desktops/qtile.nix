{
  config,
  pkgs,
  lib,
  ...
}: let
  qtileWrapped = pkgs.python3Packages.qtile.override {
    extraPackages = with pkgs.python3Packages; [
      qtile-extras
      dbus-next
      pulsectl-asyncio
      psutil
    ];
  };
  qtileSession = qtileWrapped.overrideAttrs (oldAttrs: {
    doCheck = false;
    doInstallCheck = false;
  });
in {
  # 1. Register Qtile Natively as a Wayland Compositor Session
  services.displayManager.sessionPackages = [ qtileSession ];

  # 2. Inject your required backends and utilities globally
  environment.systemPackages = with pkgs; [
    qtileSession # Add Qtile to the system PATH so SDDM can find `qtile start`
    fuzzel
    brightnessctl
    pamixer
    kanshi
    swaybg
    cava
    mypy
    pyright
    wallust
  ];

  # 3. Map your complete configuration assets using Hjem
  hjem.users.tbear = {
    xdg.config.files = {
      # Core Python Config Mapping
      "qtile/config.py" = {
        source = ../configs/qtile/config.py;
        clobber = true;
      };

      # Executable Initialization Script
      "qtile/autostart.sh" = {
        source = ../configs/qtile/autostart.sh;
        executable = true; # Marks it +x so Qtile can spawn it on login
        clobber = true;
      };

      # 🖥️ Kanshi Display Profile Configuration
      "kanshi/config" = {
        source = ../configs/qtile/kanshi/config;
        clobber = true;
      };
    };
  };
}
