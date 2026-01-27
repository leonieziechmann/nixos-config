{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./theme.nix
    ./nvim.nix
    ./shell
    ./alacritty
    ./git.nix
    ./tmux
    ./gtk
    ./lf
    ./typesetting
  ];

  nixpkgs = {
    overlays = [inputs.nur.overlays.default];
    config.allowUnfree = true;
  };

  theme = "rose-pine";

  home.packages = with pkgs; [
    darktable
    signal-desktop
    jq
  ];
}
