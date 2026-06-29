{ config, pkgs, inputs, ... }:

{
  # 1. Install the core flake binary and underlying hardware/font runtime packages
  environment.systemPackages = [
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
    pkgs.brightnessctl     # Brightness sliders
    pkgs.ddcutil           # External display brightness controls
    pkgs.libqalculate      # Powering the calculator utility (`qalc`)
    pkgs.lm_sensors        # Hardware temperatures (`sensors`)
    pkgs.swappy            # Screenshot editing utility
    pkgs.cava
    
    # Fonts required by the reference layout
    pkgs.rubik
    pkgs.material-symbols
  ];

  # 2. Let Hjem map the system configuration files natively
  hjem.users.tbear = {
    # 1. Main Caelestia Layout Engine Configuration (Swapped to mutable xdg.config.files object format)
    xdg.config.files."caelestia/shell.json" = {
      clobber = true;
      text = ''
        {
          "enabled": true,
          "appearance": {
            "deformScale": 1,
            "font": {
              "family": {
                "clock": "Rubik",
                "material": "Material Symbols Rounded",
                "mono": "ComicShannsMono Nerd Font",
                "sans": "Rubik"
              }
            },
            "transparency": { "enabled": true, "base": 0.85, "layers": 0.4 }
          },
          "general": {
            "logo": "caelestia",
            "showOverFullscreen": false,
            "apps": {
              "terminal": ["kitty"],
              "audio": ["pavucontrol"]
            }
          },
          "background": {
            "enabled": true,
            "desktopClock": {
              "enabled": true,
              "scale": 1.0,
              "position": "top-right",
              "shadow": { "enabled": true, "opacity": 0.7, "blur": 0.4 }
            },
            "visualiser": {
              "enabled": true,
              "blur": false,
              "autoHide": false,
              "rounding": 1,
              "spacing": 1
            }
          },
          "bar": {
            "persistent": true,
            "showOnHover": false,
            "entries": [
              { "id": "logo", "enabled": true },
              { "id": "workspaces", "enabled": true },
              { "id": "spacer", "enabled": true },
              { "id": "activeWindow", "enabled": true },
              { "id": "spacer", "enabled": true },
              { "id": "tray", "enabled": true },
              { "id": "clock", "enabled": true },
              { "id": "statusIcons", "enabled": true },
              { "id": "power", "enabled": true }
            ],
            "workspaces": {
              "activeIndicator": true,
              "activeLabel": "󰮯",
              "occupiedLabel": "󰮯",
              "label": "  ",
              "perMonitorWorkspaces": true,
              "shown": 3,
              "showWindows": true
            },
            "clock": {
              "background": false,
              "showDate": false,
              "showIcon": true
            }
          },
          "services": {
            "audioIncrement": 0.05,
            "brightnessIncrement": 0.05,
            "useTwelveHourClock": true,
            "smartScheme": true,
            "visualiserBars": 45
          },
          "paths": {
            "mediaGif": "root:/assets/bongocat.gif",
            "sessionGif": "root:/assets/kurukuru.gif",
            "noNotifsPic": "root:/assets/dino.png",
            "lockNoNotifsPic": "root:/assets/dino.png",
            "wallpaperDir": "~/nix/Pictures/Wallpapers",
            "lyricsDir": "~/Music/lyrics"
          }
        }
      '';
    };

    # 2. Ensure CAVA drops straight into your standard PipeWire sound graph
    xdg.config.files."cava/config".text = ''
      [input]
      method = pipewire
      source = auto
    '';
  };
} 
