{
  outputs,
  pkgs,
  ...
}: {
  imports = [outputs.homeModules.default];

  home = {
    username = "xayah";
    homeDirectory = "/home/xayah";
    stateVersion = "23.05";
  };

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.shellAliases = {
    hm-update = "home-manager switch --flake ~/nixos-config/.#xayah@nixos";
    update = "sudo nixos-rebuild switch --flake ~/nixos-config/.#nixos";
  };

  home.packages = with pkgs; [
    youtube-music
    discord
    inkscape
    steam
    krita
    musescore
    gnumake
  ];
}
