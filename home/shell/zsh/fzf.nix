{ config, lib, ... }: {
  imports = [ ./zinit.nix ];

  options = {
    zsh.fzf-tab = lib.mkEnableOption "fzf tab extension";
  };

  config = lib.mkIf config.zsh.fzf-tab {
    programs.fzf.enable = true;

    programs.zsh = {
      zinit.plugins = [
        {
          name = "Aloxaf/fzf-tab";
          ice = "wait'0' lucid atpull'zinit creinstall -q'";
        }
      ];
      initExtra = ''
        zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:accept'
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      '';
    };
  };
}
