{ config, lib, pkgs, ... }: {
  imports = [ ./zinit.nix ];

  options = {
    zsh.completions = lib.mkEnableOption "better zsh completions";
  };

  config = lib.mkIf config.zsh.completions {
    programs.zsh = {
      zinit.plugins = [
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
          dir = "share/zsh-completions";
          ice = "wait'0' lucid atpull'zinit creinstall -q'";
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          dir = "share/zsh-autosuggestions";
          ice = "wait'0' lucid atpull'zinit creinstall -q'";
        }
      ];
      enableCompletion = false;

      initExtra = ''
        autoload -Uz compinit
        if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
          compinit -C
        else
          compinit
        fi

        bindkey '^p' history-serach-backward
        bindkey '^n' history-search-forward
        bindkey '^y' autosuggest-accept

        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
      '';
    };
  };
}
