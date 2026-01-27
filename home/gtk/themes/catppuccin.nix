{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    gtk-theme.catppuccin = lib.mkEnableOption "catppuccin theme";
  };

  config = lib.mkIf config.gtk-theme.catppuccin {
    gtk = {
      iconTheme = {
        name = "catppuccin";
        package = pkgs.catppuccin-papirus-folders;
      };

      theme = {
        name = "catppuccin";
        package = pkgs.catppuccin-gtk;
      };
    };
  };
}
