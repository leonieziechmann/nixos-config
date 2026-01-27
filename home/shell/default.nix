{config, ...}: let
  cfg = config.home;
in {
  imports = [
    ./zsh
    ./direnv.nix
  ];

  programs = {
    zsh.shellAliases = cfg.shellAliases;
    bash.shellAliases = cfg.shellAliases;
    fish.shellAliases = cfg.shellAliases;
  };

  home.shellAliases = {
    c = "clear";

    ls = "ls --color";
    la = "ls -la --color";

    nvimdiff = "nvim -d";
  };
}
