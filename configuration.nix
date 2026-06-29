{ config, pkgs, ... }:

{
  imports =
    [
      ./apps.nix
      ./desktops.nix
      ./dev.nix
      ./fontsAndNeeds.nix
      ./gaming.nix
      ./hardware-configuration.nix
      ./kernel.nix
      ./terminal.nix
      ./obs.nix 
    ];

  # Bootloader setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking (NetworkManager handles Wi-Fi seamlessly on its own)
  networking.hostName = "beartop";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true; # Disabled to prevent conflicts with NetworkManager

  # Localization & Time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Graphical Services & Desktop Environment
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;

  # Audio Stack (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Core Security & Background Polkit Agent Integration
  security.polkit.enable = true;
  systemd.user.services.polkit-lxqt-authentication-agent = {
    description = "Polkit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/libexec/lxqt-policykit-agent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  
  # User Account Management
  users.users.tbear = {
    isNormalUser = true;
    description = "Timothy Bear";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.fish;
  };

  # Ultra-fast Compressed RAM Swap (Saves NVMe read/write cycles)
  zramSwap.enable = true;

  # Nix Package Manager Configuration
  nix = {
    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };

    # Hardlink identical binaries automatically to optimize NVMe space
    settings.auto-optimise-store = true;
    optimise.automatic = true;

    settings = {
      download-buffer-size = 1073741824; # 1GB
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      
      # Pin global nixpkgs channel registry to local paths for instant offline resolution
      nix-path = [ "nixpkgs=${pkgs.path}" ];
    };
    
  };

  nixpkgs.config.allowUnfree = true;

  # Global Auxiliary Subsystems & Emulators
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.nix-ld.enable = true; # Run unpatched dynamic binaries with ease
  programs.kdeconnect.enable = true;
  programs.fish.enable = true;

  # Custom Distribution Blueprint Branding
  system.nixos.distroName = "GuardianOS";
  system.nixos.distroId = "guardianos";
  system.nixos.label = "Bear-Edition";
  
  system.stateVersion = "25.05"; # Pin original installation deployment lifecycle status
}
