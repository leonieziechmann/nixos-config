{
  pkgs,
  nixos-wsl,
  ...
}: {
  imports = [
    nixos-wsl.nixosModules.default
    {
      system.stateVersion = "24.05";
      wsl.enable = true;
    }
    ./hardware-configuration.nix
    ../../modules
  ];

  wsl = {
    enable = true;
    defaultUser = "xayah";
  };

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  users.users.xayah = {
    isNormalUser = true;
    description = "xayah";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  programs.zsh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    dconf
    xclip
    gnumake
  ];

  system.stateVersion = "24.05";
}
