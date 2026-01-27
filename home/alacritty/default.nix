{pkgs, ...}: {
  imports = [
    ./themes.nix
  ];

  programs.alacritty = {
    enable = true;

    settings = let
      terminal_font = "SauceCodePro Nerd Font";
    in {
      env.TERM = "xterm-256color";

      font = {
        size = 14;
        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };

        normal = {
          family = terminal_font;
          style = "regular";
        };
        italic = {
          family = terminal_font;
          style = "italic";
        };
        bold = {
          family = terminal_font;
          style = "bold";
        };
      };

      mouse.bindings = [
        {
          action = "PasteSelection";
          mouse = "Middle";
        }
      ];

      selection.semantic_escape_chars = ",|`|:\"' ()[]{}<>";

      shell.program = "${pkgs.zsh}/bin/zsh";

      window = {
        decorations = "full";
        dynamic_title = true;
        startup_mode = "maximized";

        dimensions = {
          columns = 160;
          lines = 80;
        };

        padding = {
          x = 4;
          y = 4;
        };
      };
    };
  };
}
