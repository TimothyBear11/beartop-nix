{ config, pkgs, inputs, ... }:

{
   environment.systemPackages = with pkgs; [
    gnome-shell-extensions
    gnome-tweaks
    gnome-shell
    gnome-sudoku
    gnome-weather
    gnome-control-center
    gnome-monitor-config
    gnomeExtensions.forge
    gnomeExtensions.gsconnect
    gnomeExtensions.desktop-clock
    gnomeExtensions.dash-to-panel
  ]; 
}
