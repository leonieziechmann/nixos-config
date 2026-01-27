{ config, lib, pkgs, ... }:
let
  cfg = config.programs.zsh.zinit;

  zinitPluginStr = plugin:
    let
      isLocal = plugin.src != null;
      localPath = if plugin.dir != null
        then "${plugin.src}/${plugin.dir}"
        else "${plugin.src}";

      target = if isLocal then localPath
        else if plugin.snippet != null then plugin.snippet
        else plugin.name;

      loadType = if plugin.snippet != null then "snippet" else "light";

      nixIce = if isLocal then " id-as'${plugin.name}' run-atpull" else "";
      finalIce = if plugin.ice != "" || nixIce != ""
        then "zinit ice ${plugin.ice}${nixIce}"
        else "";
    in
    ''
      ${finalIce}
      zinit ${loadType} "${target}"
    '';

  lazyExecStr = command:
    let
      id = "lazy-" + (builtins.hashString "sha256" command);
    in
    ''
      zinit ice wait"0" lucid id-as"${id}" atload'eval "$(${command})"'
      zinit snippet /dev/null
    '';
in
{
  options.programs.zsh.zinit = {
    enable = lib.mkEnableOption "zinit - a flexible and fast zsh plugin manager";
    package = lib.mkPackageOption pkgs "zinit" { nullable = true; };

    plugins = lib.mkOption {
      type = with lib.types; listOf (submodule {
        options = {
          name = lib.mkOption {
            type = str;
            description = "The plugin name (e.g., zsh-users/zsh-autosuggestions).";
          };
          src = lib.mkOption {
            type = nullOr path;
            default = null;
            description = "Path to the plugin source (usually fetched via pkgs.fetchFromGitHub).";
          };
          dir = lib.mkOption {
            type = nullOr str;
            default = null;
            description = "Sub-directory within the source (useful for pkgs.* which use share/)";
          };
          ice = lib.mkOption {
            type = str;
            default = "";
            description = "Zinit ice modifiers.";
          };
          snippet = lib.mkOption {
            type = nullOr str;
            default = null;
            description = "URL (or local path) for a snippet.";
          };
        };
      });
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
