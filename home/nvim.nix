{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # Lazy package manager
      unzip
      gnumake

      # Requirements for LSPs
      cargo
      rustc
      gcc

      # Utilities
      xclip
    ];
  };
}
