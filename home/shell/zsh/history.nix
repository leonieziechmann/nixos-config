{
  config,
  lib,
  ...
}: {
  options = {
    zsh.leanHistory = lib.mkEnableOption "zsh history without dups";
  };

  config = lib.mkIf config.zsh.leanHistory {
    programs.zsh = {
      history = {
        size = 5000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreSpace = true;
        ignoreAllDups = true;
        ignoreDups = true;
        share = true;
      };

      initExtra = ''
        setopt appendhistory
        setopt hist_save_no_dups
        setopt hist_find_no_dups
      '';
    };
  };
}
