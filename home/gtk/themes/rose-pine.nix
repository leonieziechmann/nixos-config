{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    gtk-theme.rose-pine = lib.mkEnableOption "rose-pine theme";
  };

  config = lib.mkIf config.gtk-theme.rose-pine {
    gtk = {
      iconTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-icon-theme;
      };

      theme = {
        name = "rose-pine";
        package = pkgs.rose-pine-gtk-theme;
      };
    };

    home.pointerCursor = {
      name = "BreezeX-RosePine-Linux";
      gtk.enable = true;
      x11.enable = true;
      size = 32;
      package = pkgs.rose-pine-cursor;
    };
  };
}
