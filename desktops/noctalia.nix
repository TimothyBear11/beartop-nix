{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # 1. Noctalia v5 (Launches via the 'noctalia' binary)
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # 2. Noctalia v4 'noctalia-shell' (Wrapped to isolate its config folder)
    (writeShellScriptBin "noctalia-shell" ''
      XDG_CONFIG_HOME="$HOME/.config/noctalia4_xdg" exec ${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell "$@"
    '')

    # 3. Noctalia v4 'noctalia-qs' (Wrapped so the engine also respects the isolated config)
    (writeShellScriptBin "noctalia-qs" ''
      XDG_CONFIG_HOME="$HOME/.config/noctalia4_xdg" exec ${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-qs "$@"
    '')
  ];

  hjem.users.tbear = {
    # v5 config (Default path: ~/.config/noctalia) -> palletts
    xdg.config.files."noctalia/palletts/Marchborn.json" = {
      source = ../configs/noctalia/colorschemes/Marchborn/Marchborn.json; 
      clobber = true;
    };

    # v4 config (Isolated path: ~/.config/noctalia4_xdg/noctalia) -> colorschemes
    xdg.config.files."noctalia4_xdg/noctalia/colorschemes/Marchborn/Marchborn.json" = {
      source = ../configs/noctalia/colorschemes/Marchborn/Marchborn.json; 
      clobber = true; 
    };

    # Fuzzel config remains untouched
    xdg.config.files."fuzzel/fuzzel.ini" = {
        source = ../configs/fuzzel/fuzzel.ini;
        clobber = true;
      };
  };
}
