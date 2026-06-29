{ pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-edit
    cosmic-term
    cosmic-files
    cosmic-ext-applet-weather
    cosmic-ext-applet-minimon
    cosmic-ext-applet-caffeine
    cosmic-ext-applet-sysinfo
    ];
}
