{ config, lib, pkgs, ... }:
let
  cfg = config.programs.zsh.zinit;

  zinitPluginStr = plugin:
    if builtins.isString plugin then
      "zinit light {$plugin}"
    else
      let
        loadType = if plugin.snippet != null then "snippet" else "light";
        target = if plugin.snippet != null then plugin.snippet else plugin.name;

        iceStr = if plugin.ice != "" then "zinit ice ${plugin.ice}" else "";
      in
        ''
          ${iceStr}
          zinit ${loadType} ${target}
        '';

  lazyExecStr = command:
    ''
      zinit ice wait"0" lucid as"program" from"gh-r" \
        atload'eval "$(${command})"'
      zinit light ajeetdsouza/zoxide
    '';
in
{
  options.programs.zsh.zinit = {
    enable = lib.mkEnableOption "zinit - a flexible and fast zsh plugin manager";
    package = lib.mkPackageOption pkgs "zinit" { nullable = true; };

    plugins = lib.mkOption {
      type = lib.types.listOf (lib.types.coercedTo 
        lib.types.str 
        (plugin: { name = plugin; }) 
        (lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "The plugin name (e.g., zsh-users/zsh-autosuggestions).";
            };
            ice = lib.mkOption {
              type = lib.types.str;
              default = "";
              description = "Zinit ice modifiers (e.g., wait'0a' lucid).";
            };
            snippet = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "URL for a single file snippet (instead of a plugin).";
            };
          };
        })
      );
      default = [ ];
      description = "List of zinit plugins.";
    };

    lazyCmd = lib.mkOption {
      type = with lib.types; listOf str;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

    programs.zsh.initExtraBeforeCompInit = ''
      typeset -gA ZINIT
      ZINIT[COMPLETIONS_DIR]="${config.xdg.cacheHome}/zinit/completions"
      source ${cfg.package}/share/zinit/zinit.zsh
      ${lib.concatMapStringsSep "\n" zinitPluginStr cfg.plugins}
      ${lib.concatMapStringsSep "\n" lazyExecStr cfg.lazyCmd}
      zinit cdreplay -q
    '';
  };
}
