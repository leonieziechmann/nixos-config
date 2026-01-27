{lib, ...}: let
  themes = [
    "catppuccin"
    "rose-pine"
  ];
in {
  options.theme = lib.mkOption {
    type = lib.types.enum themes;
    default = "rose-pine";
    description = "System wide theme.";
  };
}
