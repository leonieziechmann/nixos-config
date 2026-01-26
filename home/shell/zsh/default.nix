{ lib, pkgs, config, ... }: {
  imports = [
    ./zinit.nix
    ./p10k.nix
    ./fzf.nix
    ./completion.nix
    ./history.nix
    ./syntaxHL.nix
    ./zoxide.nix
  ];

  zsh.enableP10k = lib.mkDefault true;
  zsh.p10kInstantPrompt = lib.mkDefault true;
  zsh.fzf-tab = lib.mkDefault true;
  zsh.completions = lib.mkDefault true;
  zsh.leanHistory = lib.mkDefault true;
  zsh.syntaxHighlighting = lib.mkDefault true;

  programs.zsh = {
    enable = true;
    zinit.enable = true;

    defaultKeymap = "viins";

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
