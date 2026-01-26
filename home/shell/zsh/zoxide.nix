{ pkgs, ... }: {
  imports = [ ./zinit.nix ];

  programs.zoxide.enable = true;
  programs.zsh.zinit.lazyCmd = [
    "${pkgs.zoxide}/bin/zoxide init zsh --cmd cd"
  ];
}
