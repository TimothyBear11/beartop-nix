{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    
  };

  environment.systemPackages = with pkgs; [
    pyprland
  ];

  hjem.users.tbear = {
    # Clean, explicit configuration asset mappings with working clobber keys
    xdg.config.files = {
      "pypr/pyprland.toml"   = { source = ../configs/hypr/pyprland.toml;   clobber = true; };
      "hypr/autostart.lua"   = { source = ../configs/hypr/autostart.lua;   clobber = true; };
      "hypr/binds.lua"       = { source = ../configs/hypr/binds.lua;       clobber = true; };
      "hypr/env.lua"         = { source = ../configs/hypr/env.lua;         clobber = true; };
      "hypr/hyprland.lua"    = { source = ../configs/hypr/hyprland.lua;    clobber = true; };
      "hypr/inputs.lua"      = { source = ../configs/hypr/inputs.lua;      clobber = true; };
      "hypr/layout.lua"      = { source = ../configs/hypr/layout.lua;      clobber = true; };
      "hypr/layrules.lua"    = { source = ../configs/hypr/layrules.lua;    clobber = true; };
      "hypr/monitors.lua"    = { source = ../configs/hypr/monitors.lua;    clobber = true; };
      "hypr/permissions.lua" = { source = ../configs/hypr/permissions.lua; clobber = true; };
      "hypr/winrules.lua"    = { source = ../configs/hypr/winrules.lua;    clobber = true; };
    };
  };
}
