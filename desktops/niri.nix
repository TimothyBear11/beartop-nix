{ config, pkgs, inputs, ... }:

{
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };

  hjem.users.tbear = {
    xdg.config.files = {
      # --- Root Niri Mappings ---
      "niri/config.kdl"      = { source = ../configs/niri/config.kdl;      clobber = true; };
      "niri/startup.kdl"     = { source = ../configs/niri/startup.kdl;     clobber = true; };     
      "niri/binds.kdl"       = { source = ../configs/niri/binds.kdl;       clobber = true; };
      "niri/env.kdl"         = { source = ../configs/niri/env.kdl;         clobber = true; };
      "niri/input.kdl"       = { source = ../configs/niri/input.kdl;       clobber = true; };
      "niri/layout.kdl"      = { source = ../configs/niri/layout.kdl;      clobber = true; };
      "niri/output.kdl"      = { source = ../configs/niri/output.kdl;      clobber = true; };
      "niri/noctalia.kdl"    = { source = ../configs/niri/noctalia.kdl;    clobber = true; };
      "niri/winlayrules.kdl" = { source = ../configs/niri/winlayrules.kdl; clobber = true; };

          };
  };
}
