{ config, lib, pkgs, ... }: {
  imports = [ ./zinit.nix ];

  options = {
    zsh.enableP10k = lib.mkEnableOption "use the p10k zsh theme";
    zsh.p10kInstantPrompt = lib.mkEnableOption "instant prompt";
  };

  config = lib.mkMerge [ 
    (lib.mkIf config.zsh.enableP10k {
      programs.zsh = {
        zinit.plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            dir = "share/zsh-powerlevel10k";
            ice = "depth=1";
          }
        ];
        initExtra = ''
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '';
      };

      home.file.".p10k.zsh".source = ./p10k.zsh;
    })

    (lib.mkIf config.zsh.p10kInstantPrompt {
      programs.zsh.initExtraFirst = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache/}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache/}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';
    })
  ];
}
