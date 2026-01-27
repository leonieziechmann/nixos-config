{...}: {
  imports = [
    ./themes.nix
  ];

  home.shellAliases = {
    tmux-reload = "tmux source ~/.config/tmux/tmux.conf";
  };

  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;

    keyMode = "vi";

    plugins = [];
  };
}
