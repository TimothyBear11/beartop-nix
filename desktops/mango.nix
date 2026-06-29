{ config, pkgs, ... }:

{
  # 1. Enable the official custom MangoWM Flake system module natively
  programs.mango.enable = true;

  # 2. Map your complete configuration files structure cleanly using Hjem
  hjem.users.tbear = {
    xdg.config.files = {
      # --- Core Layout Grid Mappings ---
      "mango/config.conf"   = { source = ../configs/mango/config.conf;   clobber = true; };
      "mango/bind.conf"     = { source = ../configs/mango/bind.conf;     clobber = true; };
      "mango/env.conf"      = { source = ../configs/mango/env.conf;      clobber = true; };
      "mango/monitor.conf"  = { source = ../configs/mango/monitor.conf;  clobber = true; };
      "mango/noctalia.conf" = { source = ../configs/mango/noctalia.conf; clobber = true; };
      "mango/rule.conf"     = { source = ../configs/mango/rule.conf;     clobber = true; };
      "mango/tag.conf"      = { source = ../configs/mango/tag.conf;      clobber = true; };

      # --- Executable Shell Configurations ---
      "mango/autostart.sh" = {
        source = ../configs/mango/autostart.sh;
        executable = true;
        clobber = true;
      };

      # --- Entire Binary Scripts Subdirectory ---
      "mango/bin" = {
        source = ../configs/mango/bin;
        clobber = true;
      };
    };
  };
}
