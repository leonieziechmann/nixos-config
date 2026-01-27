{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
    ./themes/catppuccin.nix
    ./themes/rose-pine.nix
  ];

  config = mkMerge [
    (mkIf (config.theme == "catppuccin") {
      gtk-theme.catppuccin = true;
    })

    (mkIf (config.theme == "rose-pine") {
      gtk-theme.rose-pine = true;
    })

    {
      gtk.enable = true;

      home.packages = [pkgs.gnome-tweaks];
    }
  ];
}
