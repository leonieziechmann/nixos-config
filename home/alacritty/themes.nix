{
  config,
  lib,
  ...
}: {
  config.programs.alacritty.settings = lib.mkMerge [
    (lib.mkIf (config.theme == "catppuccin") {
      import = [./themes/catppuccin-mocha.toml];
    })

    (lib.mkIf (config.theme == "rose-pine") {
      import = [./themes/rose-pine.toml];
    })
  ];
}
