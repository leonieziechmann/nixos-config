{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    unstable.typst
    texliveFull
  ];
}
