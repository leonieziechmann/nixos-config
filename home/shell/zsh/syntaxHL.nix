{ config, lib, pkgs, ... }: {
  imports = [
    ./zinit.nix
  ];

  options = {
    zsh.syntaxHighlighting = lib.mkEnableOption "highlight zsh prompt";
  };

  config = lib.mkIf config.zsh.syntaxHighlighting {
    programs.zsh = {
      zinit.plugins = [
        {
          name = "zsh-users/zsh-syntax-highlighting";
          ice = "wait'0' lucid atpull'zinit creinstall -q'";
        }
      ];

      initExtra = ''
        source ~/zsh/catppuccin-syntax-hl-mocha.zsh
      '';
    };

    home.file."./zsh/catppuccin-syntax-hl-mocha.zsh".source = 
      pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "zsh-syntax-highlighting";
        rev = "dbb1ec9";
        sha256 = "sha256-0B7g0J6+ZCoe1eErsSEmqO0aNOBi+FB+///vXnuiels";
      } + "/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";
  };
}
