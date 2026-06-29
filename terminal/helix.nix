{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.helix ];

  hjem.users.tbear = {
    xdg.config.files."helix/config.toml" = {
      clobber = true;
      text = ''
        theme = "noctalia"

        [editor]
        line-number = "relative"
        mouse = true
        cursorline = true

        [editor.cursor-shape]
        insert = "bar"
        normal = "block"
        select = "underline"

        # 🚀 TRUE FIXED CLIPBOARD SHORTCUTS
        [keys.normal]
        "space" = { p = "paste_clipboard_after", P = "paste_clipboard_before", y = "yank_to_clipboard" }
      '';
    };
  };
}
