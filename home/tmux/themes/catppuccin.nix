{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    tmux-theme.catppuccin = lib.mkEnableOption "catppuccin theme";
  };

  config = lib.mkIf config.tmux-theme.catppuccin {
    programs.tmux.plugins = [
      pkgs.tmuxPlugins.catppuccin
    ];
  };
}
