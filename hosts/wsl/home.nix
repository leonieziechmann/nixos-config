# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  outputs,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [outputs.homeModules.default];

  home = {
    username = "xayah";
    homeDirectory = "/home/xayah";
    stateVersion = "23.05";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.shellAliases = {
    hm-update = "home-manager switch --flake ~/nixos-config/.#xayah@wsl";
    update = "sudo nixos-rebuild switch --impure --flake ~/nixos-config/.#wsl";
  };

  home.packages = with pkgs; [
  ];
}
