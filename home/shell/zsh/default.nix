{lib, ...}: {
  imports = [
    ./zinit.nix
    ./p10k.nix
    ./fzf.nix
    ./completion.nix
    ./history.nix
    ./syntaxHL.nix
    ./zoxide.nix
  ];

  zsh = {
    enableP10k = lib.mkDefault true;
    p10kInstantPrompt = lib.mkDefault true;
    fzf-tab = lib.mkDefault true;
    completions = lib.mkDefault true;
    leanHistory = lib.mkDefault true;
    syntaxHighlighting = lib.mkDefault true;
  };

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
