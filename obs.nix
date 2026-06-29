{ config, pkgs, ... }:

{
  # 1. Enable the system-level OBS Studio program module
  # This creates a unified wrapper so OBS seamlessly finds its plugins.
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs            # Essential for screen/window capture on Wayland
      obs-vaapi         # Hardware-accelerated encoding using AMD's VA-API
      obs-vkcapture
    ];
  };

  # 2. Kernel modules required for the OBS Virtual Camera feature
  boot = {
    # Loads the Video4Linux2 loopback driver on boot
    kernelModules = [ "v4l2loopback" ];

    # Provides the actual kernel module package matching your current kernel
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    # Optional: Configure the virtual camera behavior (device name, exclusive caps, etc.)
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera"
    '';
  };

  # 3. Ensure essential Wayland screen sharing portals are available
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  # 4. Optional user packages for game capture utilities
  environment.systemPackages = with pkgs; [
    obs-cli # Companion CLI tools for game capture launching
  ];
}
