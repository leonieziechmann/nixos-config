{ pkgs, ... }: {
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;

    commands = {
      mkdirfile = ''
        ''${{
          printf "Directory: "
            read DIR
            mkdir $DIR
        }}
      '';

      extract = ''
        ''${{
          set -f
            case $f in
            *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf $f;;
          *.tar.gz|*.tgz) tar xzvf $f;;
          *.tar.xz|*.txz) tar xJvf $f;;
          *.zip) unzip $f;;
          *.rar) unrar x $f;;
          *.7z) 7z x $f;;
          esac
        }}
      '';

      tar = ''
        ''${{
          set -f
            mkdir $1
            cp -r $fx $1
            tar czf $1.tar.gz $1
            rm -rf $1
        }}
      '';

      zip = ''
        ''${{
          set -f
            mkdir $1
            cp -r $fx $1
            zip -r $1.zip $1
            rm -rf $1
        }}
      '';
    };

    keybindings = {
      "\\\"" = "";
      U = "unselect";
      "<esc>" = "quit";
      dd = "cut";
      D = "delete";
      y = "copy";
      e = "!nvim $f";
      o = "!xdg-open $f";
      p = "paste";
      t = "mkdirfile";
      R = "rename";
      "." = "set hidden!";
      "<enter>" = "!nvim $f";
    };

    settings = {
      preview = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
  };

  # Enable dir change in parent directory
  programs.zsh.initExtra = ''
    LFCD=${./lfcd.sh}
    if [ -f "$LFCD" ]; then
      source "$LFCD"
    fi
  '';

  home.shellAliases = {
    lf = "lfcd";
  };

  home.packages = with pkgs; [
    zip
    unzip
    _7zz
  ];
}
