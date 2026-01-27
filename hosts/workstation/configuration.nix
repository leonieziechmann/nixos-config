{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xayah = {
    isNormalUser = true;
    description = "xayah";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = [];
  };

  # Packages and programs
  environment.systemPackages = with pkgs; [
    bottles
    wine
    wine64
    winetricks
    winePackages.fonts
    winePackages.stableFull
    (lutris.override {
      extraPkgs = _: [
      ];
    })
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.05";

  # Gaming settings
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
}
