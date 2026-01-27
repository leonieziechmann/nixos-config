{
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    ./themes/catppuccin.nix
    ./themes/rose-pine.nix
  ];

  config = mkMerge [
    (mkIf (config.theme == "catppuccin") {
      tmux-theme.catppuccin = true;
    })

    (mkIf (config.theme == "rose-pine") {
      tmux-theme.rose-pine = true;
    })
  ];
}
